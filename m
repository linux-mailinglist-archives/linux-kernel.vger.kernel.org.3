Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C35A8435
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiHaRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHaRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:23:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E374D21FD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:23:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VGwsGQ008017;
        Wed, 31 Aug 2022 17:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BBFuqBtW0tnyHIyIr6zd3DSZXHkl4sOWZJ3zZRFvRZM=;
 b=gltqYuxg+Jimyp4Y/MARa/vDxD9kERpr9LuH/UnG0oPW1zXLOSil7BpBc9N/V+GOic5z
 j2K6/Ys9G1i9xwae83r9L9YBfzoQbJoe91iR/bAemFPeiXNs83E6/Oe9+pWKmrM3M88q
 f8P15iBUUz1OxFSGGfDrhJ8YVqG9+KyHl9jC7ep3AABgQLmWtypL9f3K0mUq79P3L33g
 RpiqmUt2Jp67LIBSH8uEwPgNVO5AVQCcexkL0hLfb2dYD3i3XggCbu/GoXwAhNbLt0HP
 /Ym5NIYKhDFmVgSLdIGZG/dt2YsCwoplV44qHVvYj/q1M/kF10adSB0FpDglYBS/7ULO YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a229v6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 17:20:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VH5PjM022101;
        Wed, 31 Aug 2022 17:20:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q599jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 17:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv7+k3xQx30Vr3XH8TKToFA4HZ+Zbg4eRrIbBqxb0ZVOFFJjkJtWAzxH3fDnDiQdbowa60OULB2QS2n+D/P4VhA/OViqzWU97dGdDP0JRr1Fys6y7y+thvGsBcyUQUP4sbFQKcwqH7MCqfwUWqZppy38roLrYUnm1VLY3MWbQRPYF+kllvIBSy0iRkrJx0CLpRWJ4rhXbt8uFxK6BPrf1dtgVXTKZgj24HWbbl0Av1ZqNxpKAwt4ivhn8CaRqjL1VhAlhcI0mAOzz2mXVX+op3HZnlpuSBDUJBSt3c7aD7ZxoZNoAv6JpDYpoZ4LQ9WFZOEonLmtI+1trsRtl7tAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBFuqBtW0tnyHIyIr6zd3DSZXHkl4sOWZJ3zZRFvRZM=;
 b=cZR75sXn+iITi66yypIR/jB+nQDDyA8yCAJiWURV6pYeIDb99EcoMGrdd5t7AmSTSszJGAFSy/losMTs+0lA5OO9q/EO/fmlCgLXL3a9/fTGqb0IRgGcFtDac9FkfdzLx1gLOD/axmpNo70WbUp79qrfHXEQP5z4GEDWQkomLttuvZVmI5XIi0PXxjl7r/8Ij8UWMTyXnDCUa9eA8CKkJNagYWmhBYegQREEwlbHe708owmbe1if6hIShtbTEzjHnl09e/zgby5ukdgxW+bnnEMIjbcWEDfkxDLuuDJSUtBeoTchv9StRz0wyPCQcooD26KfoQK+1A7eaoKa4o4OCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBFuqBtW0tnyHIyIr6zd3DSZXHkl4sOWZJ3zZRFvRZM=;
 b=U2dr23Y4ZmXl5DjyBC82B/4VKr+3HluhNmkTmsTTH54AmOGzU7aI6m6q/eGWXJ62m/6XvXZljVHqeyjjlUm/BZnfmB1GDbz3zF1wzLDco1zb0ltaDP26DuNiAdFWsWDvEkh7i8DYQgBxzTyieYSH2JvhoIk3tcQg8DsqV1qopJs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB5099.namprd10.prod.outlook.com (2603:10b6:610:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 17:20:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:20:18 +0000
Message-ID: <943d7b14-4278-0259-cc20-c9c72b7ab085@oracle.com>
Date:   Wed, 31 Aug 2022 12:20:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v11 1/7] crash: move crash_prepare_elf64_headers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-2-eric.devolder@oracle.com>
 <Yw7MhU957+cPQ50/@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yw7MhU957+cPQ50/@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20df6c18-77a8-4f33-5609-08da8b75139c
X-MS-TrafficTypeDiagnostic: CH0PR10MB5099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfzTO+6/4SGvEfS3wTcH/Yhepd21TWcFDkjmMP/jiU3EFTnvqZ+eBibKu1yGq8kbQgEtOIfGqr7qxeIWJLky8vg+dkTYN0FAOdzierZrhcHGsC5Jlxkay3/EN4U8Z+mPyTu9hWIZk4toeJ/4tpBtlNVdZpLNcCFyjOnzbR4T6c5d5G0iV+Zf5tq5+QkcP+Mzb81zugIGq42hAXVr5kQ8klc56nRzkx8HlYMjMLCwKPdXbugYHw1yJiAsBxC2hI5Y8QHKpk4im7jwkcVMBhrviFuLzxELMLgWKQQGbnbQaDH/ADkvabNiMwjO/veVEc7Ot9Q8TnRmv3b7OQI9MoZ5+9SWDqokksAkTdl0VGkaRg4vNYKUb55jTcD7kVzzrH3LC7eiDOyV6NFNqOOXnGrzlkdG/S/mXDIQxbg/+kp420PYl+EJW6h2RR31s1KzqRsBSA5pVpPoIhaEFUFju5Fm8CLrg8E1jYjS2NSwME+YHGPwQrWTLjGsLCgVfPD6fs6Zf1ha/F+Qw+RgAvHI6YHhUM06zcrslPMGGscLYJa0t952EIkkwl53XoOnDOjjx31AoxbN8EnGZ8rm9amcVsTykcxKnZLOwh9DDh2aHyvCDHQADL8f8pu3a70WhorsdI07V5x/ajf24nGTQ706aHZAGzhVR8sh5jBAI2TwZYBd4184DeY9CMeafk3/br8papmxdwBZjc1xU4BiKCOc/y4FQHP+U0s0r7TI4oUDCY7l2tonp0ApBd3RQkXtLlb9dxf+qTMeLpfJXV12rRYM0nzNOGcC977Y2/1WTmmuxYEbsUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(136003)(376002)(346002)(2906002)(5660300002)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(2616005)(31686004)(36756003)(316002)(6916009)(41300700001)(478600001)(6666004)(6506007)(6512007)(86362001)(53546011)(6486002)(31696002)(7416002)(186003)(107886003)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THhsTXV2aEgwVHdONzhRK2ZkaGRxclZ3Q2N6VWxzMEM0L1dCZzM2ZVlFUnpu?=
 =?utf-8?B?a1k0MmdLVEZ0UUF5U3l4eG9CVTI5L3gwNjR0Mlc1TGxpNDEzMGk1MGFmN3du?=
 =?utf-8?B?NjFCMlAzSEFpaGNUZUVoZTh1NmJkUldNcXpkalc0WTNHRENaZlhWK1duUXV1?=
 =?utf-8?B?ZmNId0pSUUYzQlh4VThpL3d1ZDBhNlRFeGJ0alJvanhCR3ZJdC9HOWpwMW9s?=
 =?utf-8?B?QlZnOUNJTVhYNHNNTGkxY01PVWk4UUF5YjYzVW9WcjhiS0ZuR3ZhMHdFOXNj?=
 =?utf-8?B?NytpSE84bFN4akJ4WVdDUFNqV2p3VVVmQzFHOTJMeldPM3VTVFIzRWtndmd4?=
 =?utf-8?B?QmZaQW0vaFdFbkpsUkN5OVdNczgwTFJQMkJRMGF3Z0Q4bTlTL0w1VWNIM0ZD?=
 =?utf-8?B?L00yWmUvMllPaC8zTU1uM3ZCdnY3QWFCbjUyMWU0aUdKVXVSNllvMHc2bWJO?=
 =?utf-8?B?OWRtTjJCRHJianlRZXJsL3RBSDdHRFoyUy9vaFM3SlV4M1NCWlQ5ejV5L2dh?=
 =?utf-8?B?YVhBOXMxdHdyTnMxVlErUFhQNnMwV2xwcXp2RCtFczNhUzk3dmdzNTVuQllG?=
 =?utf-8?B?d1NINkRtdHlLclZ5NlM4WjNGNXlFSkVzUTBCVzJtdTNmbDhNUk54alN6V3J0?=
 =?utf-8?B?MzNYYkFnNXVzUlJjbzFsdjlNanFPc2l1TlhLMTJ2ekdiS2xjY2t1bTdVK3Vh?=
 =?utf-8?B?QnhZa0ppWlpyV3JIMVcyM29XUGhLS1Vmak9TZVhqTGgzL3ZDR2RvQytCNmpv?=
 =?utf-8?B?aHRVSUFjaC9ZZG1weUsyZ1dDQ2thQ0dYT0h6aDlSbVY1MXQ3UVBKeUFxT0No?=
 =?utf-8?B?RlZhVjFZVTRBTmtsQkU1Rlpxd214T013Mmgya0ZKNkh1RTlCYitDWG90U0Js?=
 =?utf-8?B?NWh4ZmF4bGRyV0F4RUdJQ0YzUmh4KzREZzlSdXd5WW1sbmJDZDJyakpFT2pU?=
 =?utf-8?B?STlSOVBIaDd0TFBVd1MzSWxaV0NBL3IrcG1vUi9KUTFKYTA0RDZ0VEE0MGdT?=
 =?utf-8?B?RmlueXU5MWhiaDhvQ0V6UDlmcVN5UHFUSkZpQzdGM2I2MGZPOU5tck1KUjla?=
 =?utf-8?B?WVcrSXUyM2F0Y3o1bElWdWxDZTE1amJVTkF6RENvd3o0NXRHNkRxZTBaS0V4?=
 =?utf-8?B?VFZPeFl5Q0huWjdFWUs5amJ3MlZuQ1dEMHNxN2trTlBzRjBpQndIOWo3OUhK?=
 =?utf-8?B?THNqd3UzZm9mUnc0K0dHbXJHUzlJMlBENWNkYlFUSS9zZFlKUEY5VTc2ZHVt?=
 =?utf-8?B?NC9FM09uVHZDU1ZYUVIwT09PU3dNUk9lc05uTnVydElWcUhxV2VVNzJPYUlV?=
 =?utf-8?B?a2s3Uk9kKzE3TDU3SlQwamlNV0ZZUDBTbHNEbGZhL2s1Y251WnJVclBCNU51?=
 =?utf-8?B?K1M5eWlnai9wUldrb1U0dkQ0azlEbStqSisrbVIxQ0dSM2l3cTZxR0ZZR2c4?=
 =?utf-8?B?M0Z5dlowaEZQSnlCSUc3Q3E0NllqbXY3RnYwd2UwcFJCUGN2VVgzd1ZVdVZO?=
 =?utf-8?B?czBqSkZuSFZqTTMyck15blFPRkkxUVh1ZkpUbzIwQ2FpZHNKZGwxUTZLQmti?=
 =?utf-8?B?MkxQMjlvajhoVy9SNXpoMmJVZFlnOU5jMDNRWXE5Tk1UdmQ2SlVrdUFCWTFi?=
 =?utf-8?B?NExUaDRkQlpiVjZIU0ZyL25jTTdibElkTE9Wa1g0VmlMbVdVS2lpWjBxRjRi?=
 =?utf-8?B?cUNVbVkydGtkM1ZlWitMcWRLelFVTmdzRXJYVHZra2JWNVRTWHZkS3laSndG?=
 =?utf-8?B?dUpTeVBId0o3ZzYydWxUY01OdXRqdkw4UjJyd2xKQTN1cmNtVHNCSnNJd0l5?=
 =?utf-8?B?Uy9jbWpZS3d3Z2p2bXFlZDBUU3JsQ3V5dVhVYXYvdzB5SVlpR0xBMUVwaFhL?=
 =?utf-8?B?aFNwYW95Ym83WUEwM0MrR1VWOHdMQWpRWTRTR0N6c0dxeHNxZjhWOEZuL3Yy?=
 =?utf-8?B?WmJLNm90dGpkeFQ1MGF3WWo4a0hSb2ZOU0dkL0hIcE8wSFlER0tWZ3ZTTGhC?=
 =?utf-8?B?b2NIU2lqSk9hUjYvSjd3K0h2QnFQUEI3UFIzK3hUYk96M09zRXVMdFJEUFZh?=
 =?utf-8?B?Sk9UcUYrM3EyWFZjc1BDNDRmT29wSjdLQzhZQi9tUEpIckVNWUc5dnl3ZUVG?=
 =?utf-8?B?T3Rubkk2MjBQdmRqVTJreTdzWGIxWmFxSDlBckM3bDJhdjJpak1WQkllT2do?=
 =?utf-8?Q?yf51rKWfSqfJe1yaXXvzjMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df6c18-77a8-4f33-5609-08da8b75139c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 17:20:18.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFXn5p7CwdpQj50zRfxuTVCmiGy3zw3BEdtHfXsATIf3w4R9OEvbkKxdDeO7uqvA/jUlv2VKBH/5NJ1tas2gUBPdj02iN153k5eBleylm9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310083
X-Proofpoint-GUID: cbBfyG4F-_O7OxVQ_MN4UVo_R1ffNxKW
X-Proofpoint-ORIG-GUID: cbBfyG4F-_O7OxVQ_MN4UVo_R1ffNxKW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/22 21:50, Baoquan He wrote:
> On 08/26/22 at 01:36pm, Eric DeVolder wrote:
>> At the outcome of this patch set, the crash_prepare_elf64_headers()
>> is utilized on both the kexec_file_load and kexec_load paths. As
>> such, need to move this function out of kexec_file.c and into a
>> common location crash_core.c.
>>
>> No functionality change.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> LGTM,
> 
> Baoquan He <bhe@redhat.com>

Thank you! I'll record that as Acked-by, unless you tell me otherwise.
eric

> 
>> ---
>>   kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/kexec_file.c |  99 -------------------------------------------
>>   2 files changed, 100 insertions(+), 99 deletions(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 07b26df453a9..8c8c82386e8d 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>> +#include <linux/kexec.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
>>   }
>>   early_param("crashkernel", parse_crashkernel_dummy);
>>   
>> +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>> +			  void **addr, unsigned long *sz)
>> +{
>> +	Elf64_Ehdr *ehdr;
>> +	Elf64_Phdr *phdr;
>> +	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>> +	unsigned char *buf;
>> +	unsigned int cpu, i;
>> +	unsigned long long notes_addr;
>> +	unsigned long mstart, mend;
>> +
>> +	/* extra phdr for vmcoreinfo ELF note */
>> +	nr_phdr = nr_cpus + 1;
>> +	nr_phdr += mem->nr_ranges;
>> +
>> +	/*
>> +	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
>> +	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
>> +	 * I think this is required by tools like gdb. So same physical
>> +	 * memory will be mapped in two ELF headers. One will contain kernel
>> +	 * text virtual addresses and other will have __va(physical) addresses.
>> +	 */
>> +
>> +	nr_phdr++;
>> +	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
>> +	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>> +
>> +	buf = vzalloc(elf_sz);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	ehdr = (Elf64_Ehdr *)buf;
>> +	phdr = (Elf64_Phdr *)(ehdr + 1);
>> +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
>> +	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
>> +	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
>> +	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
>> +	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
>> +	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
>> +	ehdr->e_type = ET_CORE;
>> +	ehdr->e_machine = ELF_ARCH;
>> +	ehdr->e_version = EV_CURRENT;
>> +	ehdr->e_phoff = sizeof(Elf64_Ehdr);
>> +	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
>> +	ehdr->e_phentsize = sizeof(Elf64_Phdr);
>> +
>> +	/* Prepare one phdr of type PT_NOTE for each present CPU */
>> +	for_each_present_cpu(cpu) {
>> +		phdr->p_type = PT_NOTE;
>> +		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>> +		phdr->p_offset = phdr->p_paddr = notes_addr;
>> +		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
>> +		(ehdr->e_phnum)++;
>> +		phdr++;
>> +	}
>> +
>> +	/* Prepare one PT_NOTE header for vmcoreinfo */
>> +	phdr->p_type = PT_NOTE;
>> +	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
>> +	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
>> +	(ehdr->e_phnum)++;
>> +	phdr++;
>> +
>> +	/* Prepare PT_LOAD type program header for kernel text region */
>> +	if (need_kernel_map) {
>> +		phdr->p_type = PT_LOAD;
>> +		phdr->p_flags = PF_R|PF_W|PF_X;
>> +		phdr->p_vaddr = (unsigned long) _text;
>> +		phdr->p_filesz = phdr->p_memsz = _end - _text;
>> +		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
>> +		ehdr->e_phnum++;
>> +		phdr++;
>> +	}
>> +
>> +	/* Go through all the ranges in mem->ranges[] and prepare phdr */
>> +	for (i = 0; i < mem->nr_ranges; i++) {
>> +		mstart = mem->ranges[i].start;
>> +		mend = mem->ranges[i].end;
>> +
>> +		phdr->p_type = PT_LOAD;
>> +		phdr->p_flags = PF_R|PF_W|PF_X;
>> +		phdr->p_offset  = mstart;
>> +
>> +		phdr->p_paddr = mstart;
>> +		phdr->p_vaddr = (unsigned long) __va(mstart);
>> +		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
>> +		phdr->p_align = 0;
>> +		ehdr->e_phnum++;
>> +		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
>> +			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
>> +			ehdr->e_phnum, phdr->p_offset);
>> +		phdr++;
>> +	}
>> +
>> +	*addr = buf;
>> +	*sz = elf_sz;
>> +	return 0;
>> +}
>> +
>>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>>   			  void *data, size_t data_len)
>>   {
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 1d546dc97c50..8017eeb43036 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -1217,102 +1217,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>>   	mem->nr_ranges++;
>>   	return 0;
>>   }
>> -
>> -int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>> -			  void **addr, unsigned long *sz)
>> -{
>> -	Elf64_Ehdr *ehdr;
>> -	Elf64_Phdr *phdr;
>> -	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>> -	unsigned char *buf;
>> -	unsigned int cpu, i;
>> -	unsigned long long notes_addr;
>> -	unsigned long mstart, mend;
>> -
>> -	/* extra phdr for vmcoreinfo ELF note */
>> -	nr_phdr = nr_cpus + 1;
>> -	nr_phdr += mem->nr_ranges;
>> -
>> -	/*
>> -	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
>> -	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
>> -	 * I think this is required by tools like gdb. So same physical
>> -	 * memory will be mapped in two ELF headers. One will contain kernel
>> -	 * text virtual addresses and other will have __va(physical) addresses.
>> -	 */
>> -
>> -	nr_phdr++;
>> -	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
>> -	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>> -
>> -	buf = vzalloc(elf_sz);
>> -	if (!buf)
>> -		return -ENOMEM;
>> -
>> -	ehdr = (Elf64_Ehdr *)buf;
>> -	phdr = (Elf64_Phdr *)(ehdr + 1);
>> -	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
>> -	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
>> -	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
>> -	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
>> -	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
>> -	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
>> -	ehdr->e_type = ET_CORE;
>> -	ehdr->e_machine = ELF_ARCH;
>> -	ehdr->e_version = EV_CURRENT;
>> -	ehdr->e_phoff = sizeof(Elf64_Ehdr);
>> -	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
>> -	ehdr->e_phentsize = sizeof(Elf64_Phdr);
>> -
>> -	/* Prepare one phdr of type PT_NOTE for each present CPU */
>> -	for_each_present_cpu(cpu) {
>> -		phdr->p_type = PT_NOTE;
>> -		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>> -		phdr->p_offset = phdr->p_paddr = notes_addr;
>> -		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
>> -		(ehdr->e_phnum)++;
>> -		phdr++;
>> -	}
>> -
>> -	/* Prepare one PT_NOTE header for vmcoreinfo */
>> -	phdr->p_type = PT_NOTE;
>> -	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
>> -	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
>> -	(ehdr->e_phnum)++;
>> -	phdr++;
>> -
>> -	/* Prepare PT_LOAD type program header for kernel text region */
>> -	if (need_kernel_map) {
>> -		phdr->p_type = PT_LOAD;
>> -		phdr->p_flags = PF_R|PF_W|PF_X;
>> -		phdr->p_vaddr = (unsigned long) _text;
>> -		phdr->p_filesz = phdr->p_memsz = _end - _text;
>> -		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
>> -		ehdr->e_phnum++;
>> -		phdr++;
>> -	}
>> -
>> -	/* Go through all the ranges in mem->ranges[] and prepare phdr */
>> -	for (i = 0; i < mem->nr_ranges; i++) {
>> -		mstart = mem->ranges[i].start;
>> -		mend = mem->ranges[i].end;
>> -
>> -		phdr->p_type = PT_LOAD;
>> -		phdr->p_flags = PF_R|PF_W|PF_X;
>> -		phdr->p_offset  = mstart;
>> -
>> -		phdr->p_paddr = mstart;
>> -		phdr->p_vaddr = (unsigned long) __va(mstart);
>> -		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
>> -		phdr->p_align = 0;
>> -		ehdr->e_phnum++;
>> -		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
>> -			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
>> -			ehdr->e_phnum, phdr->p_offset);
>> -		phdr++;
>> -	}
>> -
>> -	*addr = buf;
>> -	*sz = elf_sz;
>> -	return 0;
>> -}
>> -- 
>> 2.31.1
>>
> 
