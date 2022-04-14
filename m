Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22493501E64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347124AbiDNWeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbiDNWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:33:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E706C55A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:31:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EKYWWm028126;
        Thu, 14 Apr 2022 22:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=400Lb/cMzly1NZGDTL0aYCB6JXR7MYIrEMHrkAXxqCg=;
 b=C6WVNLV/KiG8PmQf7H/tRiYxmHkarkFep+VIQf+nW3lxMmSjl3XIzHsnsN6tm3fQN+gt
 L8Gu+ALzJS4joX32yXcwUBJDWQA5iEnGwQMzZGldBygAuinPARQlJ8nJkhnrd46qH0Mr
 Dct/bUjzfJbAhTeE4lgr++UJOvhujmZZHqKoMlGZHxBBNNo8hCLbyaQnZKo84S3/9Xr7
 15vmeFF1fVjuYrgVHSdyU+8avYvyejX7/Ff+r4nRGwByhg1spIhCPEr5P1Q9dSfwhfgk
 WJTt2M6WHVBZd0GqJxLrXR+qTkEKjrOkMXxrVfR85ynxcBzSpSAQBqpOb4gc+vhJkoqu Lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a5m13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:31:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EMGU9v009302;
        Thu, 14 Apr 2022 22:31:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15daga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3zCGYCIdquM8dLXnMr23LLvtS//sgqLurSudkMnG/11jeW7kXFihq2qJAqFNHJnk6BZFEV1LbCdZNNsPkkFHx3rmJsWYsnR/FQ/FYhW37zouD2nw33IkroYJedkdcnbsyInPzb+bE8+lSdPzHhIS24FpbjU7S5gZ8F/fSqC0EThsiNW2AVVlbysqCiqPshM0DD8Gnl8ZdX06/YfXAiC+VO30f4a5Sr5YjFJQclZWXxsRV36WR83dOPSw3vHqTnISyZCOc9Cy1he4mBvcf46NdCsN/xm2kw/ATCpR/oKwqZMKGat568bRqZv2nO0xNI+HmCEgS2C1xmszNDcQGw6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=400Lb/cMzly1NZGDTL0aYCB6JXR7MYIrEMHrkAXxqCg=;
 b=JuGZfE6KXh1GdQJVUeHOof75HxD00Xum7yQZ/TjVosGQABAlVDlCYo85GtZTMAAk7j73zFUeOCMaoJ7000ajPxtckCetivcAAcKY8x0uqGIt7IEDeX0bPjZ3TFImLtHzAUNMkN4wNAig4JULkqMkFwjvday6/QeDOHhCOXxCvLjomxOMujobLBINAhytFBlebmqZ5cBT0SGERsIGgO28oUiCOMV5rNBza8vX/uQGClOH3mnbzN2NNv2Wfs/mPhzXVN0xE2wW9F6tR6+2QsGVKcEmZLomaoC4ifOFdv32Oz7FGeBuzo5FbRdxvfq2vfsdvYEat0TYdPWu7pprbFS1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=400Lb/cMzly1NZGDTL0aYCB6JXR7MYIrEMHrkAXxqCg=;
 b=gMjnuO7N4ODq1I72OgkN6gLL1OGYcs9aAWU3iW7Fsn30ffZL1muqU0y+hw13U8eD62eC1QgCTmTJ/EkAysBPIpP5955Jo7thbCcDEc5WSQu4bz0enwwyDUL8co6HnIRGH15k9AFK6875Yjid6UxEEpgjrci13h/gFZsmJ5NxPKA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY4PR10MB1429.namprd10.prod.outlook.com (2603:10b6:903:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 22:31:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 22:31:06 +0000
Message-ID: <065b9f37-0d4e-b1de-7f64-f22359875d5b@oracle.com>
Date:   Thu, 14 Apr 2022 17:31:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 6/8] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-7-eric.devolder@oracle.com>
 <YleLfoQcDXnlB/ZW@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YleLfoQcDXnlB/ZW@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf1dbf9-21ba-425f-9088-08da1e667774
X-MS-TrafficTypeDiagnostic: CY4PR10MB1429:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB142966E6D131D840F9A3B47297EF9@CY4PR10MB1429.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGxGKgCteLUP0AgWo7O2B5Idd8NEvRFbKJrUqzUZ/RQjUUZ4FyX1djKRpQ5FIqQ91/rPyiyRSbrTqEOSykOlwMT1jbZWVINoiOwgN78unK5Vwtl5s9NePtVWQS9EY9plxeeoSfH8GZ/lIWbQKVchMyKF7EgD30Wy9v0phPqWMfDOwvlwJ1efpApY+KfO3DasyRi98069NSudkCenvj3uJbg6VXF/k+pkwlttIX2JEe3RImstpFz4QgneQYUXIXHIUkFT8sstc6A53kInRGITqTvn+i48uGkCY7NGpGXRQIjYiPT6wbY3Lacw7DhgassivyiCvjFjbIU1NfqtCbhTM4HE0W/ONtJK6+ejz1tLshO0ZLIR/SL/K2U7VQNXPkr0NMXoOmbDwOUJJ5o2LTryPQlRY3i5u0eLqa2m6mysq123KiT1w71+22ZFQzrf3w8Qb9TFDlIoAtPD3UHC4RnejQJohZwm0PZkTwJpD+8OftLjVpRoVGIUb6UlnKNc5prIEYznPhLNpdp5pSiO5+eaT+gugrXei3LWr3aTK+9Y3oFt9q8jngc5GeyZb0V7BNPQeZ/D8kzJpiI5mhZjDAnRdun/oU4E8ueoPncwLjDxKw3M+BcEbCe/JhdFYLHV7s2AKtJ3SFqQ/gnm7foHOiwOkrSu7Arrs0xvGPrbCFYLNC5xom2wx8mwMGFpAhPfa0BTuewUq+XkVBNtCkjvO8nYDX+YCt4gEf6d3zsgJD6hXMsBIDj5K5SxmqVbAj2m6WA0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(4326008)(8676002)(508600001)(36756003)(66476007)(53546011)(38100700002)(6506007)(6486002)(2616005)(31696002)(86362001)(8936002)(186003)(83380400001)(107886003)(6666004)(5660300002)(7416002)(2906002)(6512007)(6916009)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REMyTXRGM2p6bXRDVVJ3citOUXlTSENicGUvZ3lOTGlCais4Zm56bExBTEZK?=
 =?utf-8?B?VUNCdWlYdnFkVHViRXFtdFhMa1VCampWeUdCb0NDNlZuSkRnYnZMd1dHVWxS?=
 =?utf-8?B?V21aZjFqMVlzcXBaM05WTGxLYW9YTStQcGsvS2NldGxPQ1AvT0ZiYjc2Vmdn?=
 =?utf-8?B?cmJQQk5IVWNlY013bVExQ3RRS3lCSjZvZU9TdEtLMDhkd0FuTFhPY1FJU3Nw?=
 =?utf-8?B?c1k3NnhrZ1FoY2lWQm40UU5Zd2VpL2wzVGVEcEZmQ3MwWHd5VkRMRktNR2x6?=
 =?utf-8?B?VUFPTnZ1RGhjKzlEZmFhVG8zRWhsc1h5Z2ZiU1ByZjF4OGZXRDNjTkh2UDdQ?=
 =?utf-8?B?WU1DOWxyWnVaeWN5NXBiV3RrT05LK3NQeWczaUxuWVBOSmhmNWVDSVI4emxX?=
 =?utf-8?B?WEgva1V4L2ZxbHM5ZXZNcEJGeitGYm8yajkxM3NrWkdSZ1YzNTVKVFFocnFn?=
 =?utf-8?B?NERiWk5jZlhEei9SRUExL2xadS9ybFBMK1pXaCtlcmNUM1l1Mnh0ZzVBL3dG?=
 =?utf-8?B?N2NPMU14dEttWHJ0TFQ5d0VvMDBOSTErSzJTWlJTUFQrQmhHTndNNEIrdmRP?=
 =?utf-8?B?MURCK2c0U0lRRjh0T1NvN2szN1VHaE0xVHVuTW1ISlJWTWJ6ajlTREx2cmZZ?=
 =?utf-8?B?Zi9UODA1NlN6dE9EY2c3VEZlSlNoakYvUVVqUzdtV2NaQnVhbGNZSVFuVGps?=
 =?utf-8?B?cDB1MjZxVUZISGZ5YThPR1lsSmZTaVl4bDJvLy9kYnBOTVVXMlMrT0M3cW00?=
 =?utf-8?B?NU8yTHRYNGRlMjNyWnpPcnVDRVJkdm42YW9BRVpSV2s1K09kMy9MbE9lenVG?=
 =?utf-8?B?bElDY3JnUmhYRnMybU1lTGlha3Y4MzU4bFJ3WGUyaDZ6WlIwK2J4TTNRcEF5?=
 =?utf-8?B?RzdzQ2VkZ0YzS2lONzVkeGxQSHFadXhDSitLQUUrWWxpZjRSRWJVZjNkWS9R?=
 =?utf-8?B?dENuWHFZb1pWaUluYXdDcG5kRVBxakgzVk1ORFF6K3JTYjF6dGZScGNqMUZ2?=
 =?utf-8?B?ZmdZS040cjNhTFNFVit6VkR4TjNwU3gzd3J4emZNM21oNVZ6SDkvYkZNSHFG?=
 =?utf-8?B?a3NSM2c2REFFZklTRCtCbytaTHVhOEp2dGdkWGpXb3BWUFFXQXBhWVNjK2dn?=
 =?utf-8?B?WjdmWlhXRnBrbXRlNXozUHpNTXNZMkZaWlhFbFplUWtiL0Q2YnBlNHEyOFNi?=
 =?utf-8?B?bTN4UWRmVTc0YnJsa3BrdWFBSEI3b3Brc0hPbktWK0FYVGxTOTgyMUNhUHdX?=
 =?utf-8?B?UlNRMjBGR2ZmUllSWUpZbytPeGR0QSt3SzhQbS9HeDVsRUZVeVFGTTRpOFZ1?=
 =?utf-8?B?djMvK1FIc05iNFRkZjl5aFA4MnNSV0N4aDhOc3A5RGtsNGd4c0UrbE0rNGgx?=
 =?utf-8?B?d2tENFp4a1ZxVFlJYmJ1c0dIRlQxRExhRmdnaW1iUTFiTTQvanJSOXVOUCtF?=
 =?utf-8?B?WFM3RnNEalh2ZmgzblRmM0FuV0FsL1VYbEFDT2tXb2pKSy9Mb2dwZ2hJanhl?=
 =?utf-8?B?QW5kdTB5R2FUVWJkeFNGcmtQZDQvbUJrUEFyZTgyK0w0aU9rYWMvY0p3eHgx?=
 =?utf-8?B?b0tncDd3L2IzYzZ5dk5iTVJ5Y2Y5WHRBN1l3NUp0d3Y3WWhNSklreUhZRnl6?=
 =?utf-8?B?ZmhVbnlSdjBjOFlaWGJxK3BSdzAvdGF3d2NEZW9QS1ZPNG1SN2FpOTF3ME92?=
 =?utf-8?B?V3Iwbjc0d3FDT0ZBcnpjaThiOTdvUksrVnFLVGxQbEUraWwrVlAxR1dQN3lN?=
 =?utf-8?B?clplZ0pXcXQxZFdqeFNZakVtL25SS09Rc1NucWVlV0RXRGJXa2FkcUYrTDc3?=
 =?utf-8?B?NFg2WW5ocVJwalFjVFlqODhzWGNRZ2NpS3pJSGU1NVhTbHc3aUhUamhyMEsw?=
 =?utf-8?B?eHBNTjljb0hDZ1EwSEJFamFqTS91ZEo0RlFBU05rTUMxN2NWVEdXZzRHRTgw?=
 =?utf-8?B?L3ltaXEzalE4MGMxd1U3dG85NS85em5rclR3am5OakNpaXFhK2dIcVZ4Tndh?=
 =?utf-8?B?YUVDR1IwWi85RXhjMTJ4WU1rSUd5dG45eU9QNE1CeUljZVZ0OUVndEtja0tr?=
 =?utf-8?B?WldHTXNML0cvdmladTJQdFVlYVQwYzZtTWVCVFRQVWxkM1Q4alB1elJDM0ta?=
 =?utf-8?B?cUMzMlVtTEt6T29CU2pZZ3VPUEJERHpObzk5cWl4TndDNm1QRXpPTkVZaTZP?=
 =?utf-8?B?VDNSTSsrWkE1VkRIKzhPYk5Lc3N4ZEkxK2VSOUpIdXZhL1VjTVNYVFJxZlJC?=
 =?utf-8?B?R3dIUmxGNWJzZXN2bFJWWEpoODIvaG80QjVLUU8zSjdIbXgrTFA4dHpvMGVT?=
 =?utf-8?B?VlI2c1I0MHJhK1V0M3FUU3R6WTNYbWt2WmJZNWR4SEZXQjlVN3NMRXpwS284?=
 =?utf-8?Q?+sGFvSruRUJAannS2a27DhNjwj5nWq5tQbQVJT6+gMTYM?=
X-MS-Exchange-AntiSpam-MessageData-1: MASrbY6NzfxX9w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf1dbf9-21ba-425f-9088-08da1e667774
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 22:31:06.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyUJMjK2tgNus9h+KXiR2mZhRBLRQeUR2LxJeYE6byl6IBwlutZSyfz7cCXRufExzyTrL3NZVjMFJIZ+zd2DMGsGvNFmc8Ps9I8HX09nn0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1429
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140116
X-Proofpoint-GUID: lAkV1kybXGze07tpWppC5TDabQ1HIetr
X-Proofpoint-ORIG-GUID: lAkV1kybXGze07tpWppC5TDabQ1HIetr
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 21:48, Baoquan He wrote:
> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
>> still in the for_each_present_cpu() list when within the
>> crash_hotplug_handler(). Thus the CPU must be explicitly excluded
>> when building the new list of CPUs.
>>
>> This change identifies in crash_hotplug_handler() the CPU to be
>> excluded, and the check for excluding the CPU in
>> crash_prepare_elf64_headers().
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
> 
> This patch is updated, the old ack should be removed. It looks better to
> put the offlinecpu assignment here.
ok

> 
> Ack it again.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
thanks!
eric

> 
>> ---
>>   kernel/crash_core.c | 9 +++++++++
>>   kernel/kexec_file.c | 5 +++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index ecf746243ab2..036243b1f252 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -521,6 +521,15 @@ static void crash_hotplug_handler(unsigned int hp_action,
>>   		/* Flag to differentiate between normal load and hotplug */
>>   		kexec_crash_image->hotplug_event = true;
>>   
>> +		/*
>> +		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
>> +		 * this callback, the CPU is still in the for_each_present_cpu()
>> +		 * list. Must explicitly look to exclude this CPU when building
>> +		 * new list.
>> +		 */
>> +		kexec_crash_image->offlinecpu =
>> +			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ? cpu : ~0U;
>> +
>>   		/* Now invoke arch-specific update handler */
>>   		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>>   
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 94a459209111..9d5c4eea0179 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>>   
>>   	/* Prepare one phdr of type PT_NOTE for each present CPU */
>>   	for_each_present_cpu(cpu) {
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +		/* Skip the soon-to-be offlined cpu */
>> +		if (image->hotplug_event && (cpu == image->offlinecpu))
>> +			continue;
>> +#endif
>>   		phdr->p_type = PT_NOTE;
>>   		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>>   		phdr->p_offset = phdr->p_paddr = notes_addr;
>> -- 
>> 2.27.0
>>
> 
