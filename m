Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1B590AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiHLD0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiHLD0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:26:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B529A951;
        Thu, 11 Aug 2022 20:26:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BN5Wpu004258;
        Fri, 12 Aug 2022 03:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eTUGvTol0odCKhRha5xjUECYTQiEfe2Xz2tQtPF120E=;
 b=su73na8J337AMqMnqa5uo42miBwU/seLSKrD3yzrGwGlM6Ij+qzFVdGzmFQ8warGxp+l
 e5c2O2DuoygkKehvmiKxVqjHBS5Ys49SWAYf/Y+BJ812gbPxqWKn/p+jxPQnWPx6nrb7
 wBr7p0v6+9rLvYKsw0wBi9yNofxbEx+zaRIeV9xVNIKko0LSn0im8ISSgEXsHkGYDmfY
 eSKXo6BXrLKQw1M3C3WAjOpWCmxJ9QQcfwt9sMaw6XaDxD9WmhhZBC5yaoj+/t2cyLEs
 fyD4tDKwC1lyMNmUgcFOjyvGE/25fL244Nd/CpZro8y8m5CZkErtHrApnDQ1pywwFhf7 Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq96fwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 03:25:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27BNWWLI005025;
        Fri, 12 Aug 2022 03:25:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqk9hfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 03:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNOGohh0DObh1nvVTZn2ZZt1CTAPLbcKBgYFcv2ahnNcMglgwq+Hl2hWwkbSHWvYTNe3umOWdnb8tMHH1ddOTnE73tj88T26GYbi9YNpjqL0ltiCPL5x/J9jj53fGaR1S4naYrhN9Ok8haYAXt/xXTq2eRjXTSjqrZgG2Avm1vIoYuSgLdQPuofOqY2cEl20CM/Eyl6B+H57140qvNwdvmPMXN/jXpwLCkvNr40QLHhydseYAgErLdZjzv7636RGd9r8U6lUNcM8Tf2Pf+Xr4TZIB0k4zQD4ClpTFfDx4D+2pmG+h3Utg+W6DWKxmV/wOV3QCVwdYUwJ17bLMRhZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTUGvTol0odCKhRha5xjUECYTQiEfe2Xz2tQtPF120E=;
 b=jDfgatxOKOF178La173k13TD8cSxbkpEdZhWNQb2pM2Q8VCphkrZqK3FXywee7JOJmvFjyfcTRmRqu61aRp6v6Vl5wdmYEGpwqoVXDNWeILYt53z8ayGT55HDWTg8zC2HA0pfVtzzgUq0bA16zo5MfN/37yU4K46gNfsGHPtmTANRioJh27JLgqNG5X8ZMrhWITxwoNVeSVQHIF3BavzNa3zLC6MOkgYXuxOiMY4VrsuPcT/p8DKe7uvAQ5RDYY9xsE494cF7BzaXp1Hk2DHmlr+NI9W9PkAs/O8PwZJ2EPNYPZ4xSfwF4DlV25pWMkuPFoqa/fXnXVbspnQtMf1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTUGvTol0odCKhRha5xjUECYTQiEfe2Xz2tQtPF120E=;
 b=eEYag+9DmsBFkYmnq55KQYFCaHIOLASmRj6zOUzKqblz7fnGZ/1Wt7ovVZUvnunlaBRi3Op2xcuJcjeB7Kttp+mb1SoYeH1Qex1DicpvWd4fLF+Z/6+FmyFUDfG0NdTS5op5YIUhI7z2jTOk2CEv3Z6bOV0s9RAZmjzC67MUtbg=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 03:25:50 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::8dee:d667:f326:1d50%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 03:25:50 +0000
Message-ID: <3ba71030-982b-c98b-78ee-ceca74da3b57@oracle.com>
Date:   Thu, 11 Aug 2022 22:25:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3] scsi: iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <20220802034729.2566787-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220802034729.2566787-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:59::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32df8e28-6cca-42a6-2d04-08da7c125ada
X-MS-TrafficTypeDiagnostic: SN4PR10MB5541:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BTwDijwiP/5xCDwnic1b3wNp1LnR+eKYEadmZtSevhQ24WbYxEJ0VGVFqCTE7brqV038CboG51UI7Mfta7IsfSIkNnYB7xzYK6NjJxGipozIsrmI9C7sNTOpuiq4QSI4RN+Gi2xd8IyOcopEx4jE8J9dSkSCISOH6hcxnIh9txhMYMUcIiGaIOOPpEI67xysAHUCBc63d8hS3e9uYmsXL5PgJt7wavCO6r8BNmcnb3eE0litji5OM4zgh0u83apMRv/IphhocEJh4uO3Y58w1kLIW/6h5iX42TObN/WZ4R/T73RZulCj8Z/4aTsEGQ2j7duZ7IibrZSFPM2DPiRz2Nw7VS9GgKhFnbfLiEWHw5yJ/daD9QzOIoIbEP1iP1SsvrFOWYZw1wTHMTxcV06dvBlo3jCoJ2T8clth2UpkTalNxtpFmqrzaqIjXayKZD1tPgCwF1w2+6jJrh/IITTxLInj+Qx8lSHPi9sXgapO7Qw+CBCHJTHxgo+pQtzYr42vVClXHna2mm8vzx9CijO5JYGhY9wxk4kzH6JSIQ+8Q7OOWB93aUjEMyGnPyc9vu5DXuzfzou0nHqAR+KaJvgx35B4jOQIjqUq/WSJms3BitON/w1HzN0naHk1mQSmWALYN7pWSWNtzOPg0t0zn8TB62FuSNFqzVyF/hZIoDDSFH8lO3iLQUpLEfo7bAinndiZBMiaf5CmsjQfaxj/MHHy9eSDgn4jlb78YmpLUSuHaEfaYhQcO3yrPz9p9aQ0lO81ueJQ44v9jPIZxwdhbxKb/WKf/kpA9xdXswdvp/vlU7QKuJjYT8noxB61QyqbGDD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(136003)(376002)(366004)(2906002)(8936002)(83380400001)(6486002)(38100700002)(110136005)(478600001)(8676002)(66946007)(186003)(2616005)(31696002)(6506007)(66556008)(86362001)(41300700001)(5660300002)(6512007)(26005)(4326008)(31686004)(53546011)(36756003)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJXNkRsTUhJMHBwK0wvUlZlQ09wQ1FiV0hiNFo5QnB3bGRLSi80Z055bXUz?=
 =?utf-8?B?QWtPbHJINnBZRFNvejRIYkVOallXdVBNVFJMZHJJWjQzdXRTczcrMnpJYWxY?=
 =?utf-8?B?TFU4QXBkb2hYMWh0UjNhS1FVNS9hVlhXcGZmVCtheDZ6dVg4NVBYbGhBUFNy?=
 =?utf-8?B?bmVoTG51VHlKYjZLOFpaWWpjYk42T1R4UGY5RUxuQkRuR1lWOGxhUVhCZ1ow?=
 =?utf-8?B?TzJsWjkrSXFsS2F1WmZFS0t3YTlKaEhSU2plNDEzbDRoY3NxYjNqNkRzWnJF?=
 =?utf-8?B?eENMZkRhdlJYMkkwV3o4eHNoS3BEZzcyeXFWR0g2VUJsa1JESi9aMkEzdmcr?=
 =?utf-8?B?U1pvanE0blpzZVhPaU1EUE1kUkM2WjBVaC81cFRFdVJzeHJCT1NkRmc2UkRk?=
 =?utf-8?B?SjV6a2Q1Q21JMy9XTzhZMlZuRTFIeHB6NGNqb2FJem1xRkViNEZqU1F0ME54?=
 =?utf-8?B?am1yWnFXVEZLcUlKdk04QlZNeEVscmlPNW9QVklCaWswY1FMM3JZbExsS1px?=
 =?utf-8?B?VW5Ua3BPWmVka3VHeWdKSUY5MWRJRkJ0V1htU1hXcWtzVlhyVXdDMXVKdnVM?=
 =?utf-8?B?QjNzQnlEenAxY1RQeTluMlY2RkVxc3R0NjZKU3kzdTBXUFh5TmRSdGZoZlRu?=
 =?utf-8?B?bXFOdzgyNGlJNThLWmpRMXpsNDBhc3pDSmZSbFhWZ0MycXNVbHpGMUtIbE1m?=
 =?utf-8?B?QjRSdUl4Nkd5bjg2NFo4cWo5Vmh2bXVWbHhkdk9OVHFodzR1ZjFiTFRycVE4?=
 =?utf-8?B?YUdiVkp6MnB6aVpvUzR3eWdXVXlnYVR6SDJTUXo1cEtiL1Z0aXJjV050RXNw?=
 =?utf-8?B?RWc0ZStBOUtySWNTUUxPZmg3MWRuak9YcjlsUnlTU3oxZmcxbWtHRzdhazRZ?=
 =?utf-8?B?a2wreEs0c3dWa1h5c0tKR2IvMmFvcERtT2IxRTk0b0RLT29mZ3NLRWFtVHRh?=
 =?utf-8?B?cUN3UjkzTzkxRWtMeWwrYm9obXlJaDRMOHQ2WjlyVUY3QlZLcExEcXQvNFdT?=
 =?utf-8?B?Q3VZM3YyYjBHV0I0bldsVlgxRyt1bWZJT2lYYUlmTXFOOGt1eEFORkNPSmdF?=
 =?utf-8?B?SkpRVnNuNTA0eHlRMHZrR2Z4OGRZZlMrZWhXdCs0TjZwRWVwWW0zK21DYUY5?=
 =?utf-8?B?TWF3ZXFzZ3NIU2NCaEMyRVIvVGd5WTFlbjNka2NwR296UWFwWjlBWi9meHpH?=
 =?utf-8?B?bGdUa09waXg4SUl4K3ZYcEt1SWpTV1YzOFZkTmU4c2oyQk1CR1dWR05yODQ1?=
 =?utf-8?B?Ull1cE9wbFdPNWFjWWUwYTN2VkZ5N09BVmVKbU1HbllEcVVpNFZIelFUQjZD?=
 =?utf-8?B?VVRrTEI5MWlPVUs0SVB0b2lVKzBYR2ZpMlM5eE5SZUhLdUZxQ2xVSVkvUjRF?=
 =?utf-8?B?bmNlSGVnTldPZmp5a0daOFhFR3lZTnQ5aDZvYWcvOE9lbURxZTAvSUtJTkF1?=
 =?utf-8?B?WTkyRG9BbG5PSkJtWEkzVkFXOWlLc2JWVzMxMGpaODJ0MG4rdHRaZkYzdDlw?=
 =?utf-8?B?dzB3TlE0am8rTlo5SzRoZm5meVBZN3VqRjUvOHpTNjI2b2xVcllvQ0ppRUZm?=
 =?utf-8?B?bCtDUDlZNlROdzlZWWVOTU11R3dSZ1R1VTlISDM0cUQzNDVYQVNhS1M1VDdw?=
 =?utf-8?B?ZU0vdkhRc1JWOFRnR1hGdVpGZk5ZSmYzaHlobVh3TWRGTE1VSTlzWWd3endO?=
 =?utf-8?B?YXNuR2Z4RTB4NTVaNzR2RWZzNGlYdVl1dUZEaGJ3SlJ1TWYxVmZMd3BOdFJE?=
 =?utf-8?B?c3lrK1orUS9tOUlNL1gydHh4TUQ2SWpLbjkzM2UySHN4Y3ZkVW1Tbk81cG1k?=
 =?utf-8?B?OHh2a2h5U0M1SkRnK0ZOcG5uUFpLR256cWxvSWJ1eU1vejUyVEdIY0FLVGRu?=
 =?utf-8?B?YXBEbWtLbFNvbCtvWE9BVWdLM29sRmxGOFVwa0RmcTNDL3dBK1dBVUdWaUJG?=
 =?utf-8?B?RGp0NWhNZHZpRTE0SEVXSW4raXpPR2I5elJnd2hnZEZMcmFrVG94eDNsbDFQ?=
 =?utf-8?B?eGlsUXhFRU5ocDZyeWNSZy9RajQvRDhSR05ZTHA4NzJtbWtpTmVPQk5vVmhx?=
 =?utf-8?B?T25aSmpQeTNMV1hrQWRlYnArcHN3WGFvVk9Wa1lxQ2dtUHlrK0NNdXo2QW14?=
 =?utf-8?B?UVpMQno2T2FXN0xBYzJuSHQyMWpoSnA0L1NPdWV4UTV2TjhvcE1Sc3o2YjBs?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32df8e28-6cca-42a6-2d04-08da7c125ada
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 03:25:50.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvHVhVH1GAzXl177ZgIlAqbXQ5HlHgjI29mbFZ2AE+5ReoBermuC8gfwdyRwBE8Nug74clpZcvvwEAtPC2yPhfHAdSz/+R2ymIgOgkmXqx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_02,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120009
X-Proofpoint-GUID: 03F_f6XnYYpOeDDUdN6ZrJrqhlt5ex1R
X-Proofpoint-ORIG-GUID: 03F_f6XnYYpOeDDUdN6ZrJrqhlt5ex1R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 10:47 PM, Wenchao Hao wrote:
> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
> for multiple times which should be fixed.
> 
> This patch introduce target_state in iscsi_cls_session to make
> sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
> 
> But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
> Report unbind session event when the target has been removed"). The issue
> is iscsid died for any reason after it send unbind session to kernel, once
> iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
> 
> Now kernel think iscsi_cls_session has already sent an
> ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
> would cause userspace unable to logout. Actually the session is in
> invalid state(it's target_id is INVALID), iscsid should not sync this
> session in it's restart.
> 
> So we need to check session's target state during iscsid restart,
> if session is in unbound state, do not sync this session and perform
> session teardown. It's reasonable because once a session is unbound, we
> can not recover it any more(mainly because it's target id is INVALID)
> 

I think we are ok now. Do you have a link to the userspace parts so
I can make sure we have everything covered now?
