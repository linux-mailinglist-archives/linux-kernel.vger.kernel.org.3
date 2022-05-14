Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD45272EB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiENQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiENQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:30:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F42CE2C;
        Sat, 14 May 2022 09:30:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24EFXSRm012287;
        Sat, 14 May 2022 16:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ov1bHXiCb8Wip9l7Zdf67mGy3mt7u1fpoYF7jhaSO5c=;
 b=yEAdasmi/d2c+1JPHg8VPazO1ht8E2du5SGkLEi3kHMJDKPlMHDE6KdYMloyc4jUFFEX
 WMnPnfkEI0FuiWF6dyh3UOjSlnnLMnQj7fE2oNIv5RFD/crTCN558a1ouZAPz7VnFOJn
 pYW9Q8G1cYxPUejNuQhepBwcGgnA53EbAPu4BaVlbL6b4UhFVfWOBZEP/tX8D0KzOv1W
 caKuC60Kfo79T9Y31bxt86VPW7CGldcRp2msIiDwZ0FqZzL+Xc3/bTJUhK4Mqj+u2UZ0
 ud8FYzcoUqSol5APOC7jFCYuL2a37sM+N+THbkwxkIrmDWx0hxJ0DbiMMmvJnEOY8Wtv cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytgjq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 16:30:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24EGM64x026630;
        Sat, 14 May 2022 16:30:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v0d4kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 16:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6gKgmABrYzOnzqO99oA+VqQzMHdp0w/67+XrzLlyJpD2F9Hr81HjMdV0Q/+zJxxr8f24h3JM2Ng1dZjVTXWcJIIEoQ99Uezz2+0W0TRzAjugKJ97QmLYodgf3GrEo4ad60+n6JP5DxWVaw5qxkW5rK0yFvZj2XyIHyCnRIqutE51PtTmzRBebEuuN1ZEOG3bCEuVvCdqFsSvvuw+zztxIXkvOLMv7GeLTU1Utexa0FcSGNKvfRwNpSIUvvDTEVgZE51niaqifPUyNGIZV4xOhicLzFfwAaG79gZ8Vn/hYdzjd/GiPtIcYdNV28ZjlTO4wTCbaMHnC6s6nacFxvzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov1bHXiCb8Wip9l7Zdf67mGy3mt7u1fpoYF7jhaSO5c=;
 b=c+8SZBPh66XfGhSPTBCLQkXAJAIeN5mmU98WNeBO8Qi+wUu208HwoExby3OpKSAqBPQHUC8/5MNILzC3izcl9m+O0+H0vqrGfJK8ugeqgRoVp2P8yhezI0OJ2nM8OSJDP0TCySEV/BvxZWlD58sLV3paIw5Ei3GxcuT6Z1/J4oVaPTj+WFJRAjX23i3eWcw8bGMmHU4oZRrmX1pudMiHuxKSBxbHOJxdY6T3q36ZzHhU8NKxLT7ulabY12/l32eSxla1DlsyxXJi8xfBtZJfKPYEQnbG+akuPrq0aMmMV4jsCMgaLb0yk9uoycMi+Oy6jirx/mqYE76MHgokb5XOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov1bHXiCb8Wip9l7Zdf67mGy3mt7u1fpoYF7jhaSO5c=;
 b=KE8YrLJjJ2mRfBWNCgjO54dYTFaaWjRzj6Jk9TuGXK1lwrAvH/NVMQTNqCgVnkJGFSasiPjCG/oWXyOBSXVRzygULuxfnUgWUTrcXQ5QfzQn0E0Yk6xVbOWGQnXkGhvtnDf731LMeVN4t5VbAafP82HDI2KiE2Q3VufI4K1lkW0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3178.namprd10.prod.outlook.com (2603:10b6:5:1a7::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.16; Sat, 14 May 2022 16:30:08 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sat, 14 May 2022
 16:30:07 +0000
Message-ID: <64f16117-beb1-def1-5017-c5006c362070@oracle.com>
Date:   Sat, 14 May 2022 11:30:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] scsi: target: fixup incorrect use of 'cpumask_t'
Content-Language: en-US
To:     mingzhe.zou@easystack.cn, torvalds@linux-foundation.org,
        zgrieee@gmail.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, dongsheng.yang@easystack.cn,
        zoumingzhe@qq.com
References: <20220513062745.3245-1-mingzhe.zou@easystack.cn>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220513062745.3245-1-mingzhe.zou@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:5:3af::11) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8277f5da-ed9c-46b8-4cad-08da35c70203
X-MS-TrafficTypeDiagnostic: DM6PR10MB3178:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3178697756E40B81A35C8459F1CD9@DM6PR10MB3178.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RV6AoKgue2Ic2qlYtZ8H265EIe9q7uf4lw+HtHQm2rfkUFW74tqaz+vOd29B73w99vbHhse1OgDYeotcaaa2+0VEqEHPW8F5yFZXxeXnupqx5Y3bd+oHlSNjbhFwf8gGs6HeHN1FT4pMAMrpdAs1Hmnfmc9XU7GvoclGdH1joAKwtenQkB9rf0aIx8o6NjcH/o+hl5tsYOCc+j5RkyN8gNHBRQuuCqRudV7AEVsy24R8UrAXgu0KV1NskfbbcqyHUruHM+m+bnqjlWI8ml/C1ZITOxqHTkeh+ZRWvsLlnpFSRcPBgHCFW5WDg8KdY8XdjQ6OKdI0xdoOJeCFb3RvOkRZd89ZkAZnm90RFDShXG25lz9F3d/9KXkcF9PovuvfiKkDu/YCwbyno3WKR5jO6O5CwJ5bwE2aekwM4EIqcRT6PS0mwXl6j+HdhsBeIzZ0V6AB7uLVxhdRn1PVzrSL4f23VJoLFI6H6kkqrhHByBpEhzKohkXN0Sk7gNdx713QlWKiMAVsHNx7xVZ/3IpIqXAvrHbta7qt6qt52bXTLZJY2cDQ7zCtz+i0whcxfNIqXcragYHOh8qX68J62aW31AJ78XIkpSNY4Q8S5A6jsqugE7ZaOEPTS3EWg2OGUnU1W+WCp2hkpVw1WuzPit2//WF1bII5noHuouf9OPm+7qzBaC+CTz7IZDEOVjga/8tDytKvezWzEDtpYsVdL+re1mRkJlEPDVQwZy5ubtPBA8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38100700002)(6636002)(8676002)(66556008)(316002)(36756003)(8936002)(2906002)(6486002)(5660300002)(53546011)(6506007)(31696002)(86362001)(26005)(2616005)(186003)(508600001)(83380400001)(6512007)(66476007)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDFNelloK0VaM3piTEVFb1FiOSs1UWFUM2F4Q2ZSRjJRMURiL2JPZDBTRElx?=
 =?utf-8?B?QUdMcTV0RXMvNnBUZ0YrdEs2bi9MdFV6NEJzREIwK0IwZ2ZFOVNlTm1RSHp1?=
 =?utf-8?B?Wk9sNWNsOVhLc1pBTFpmVWVkTk14a3JuQW9VQ0JHb1NiemFEU0VQdWc5bTdS?=
 =?utf-8?B?elkyb0NoQ2N0a2tldnVEcXB0YlFlQXMzMVM5cWVpMHpqUVJaeFJuY3R6WWQ0?=
 =?utf-8?B?aUhETzFWd3Y3NlF4L0ZLMEdjajlzcDJQbVJxQ2tDQXBCNVc3ZTdzWlBwQUtT?=
 =?utf-8?B?bWM0bGVjZXVPa24yZlhpRFh0WnFrVGE4L3BaLytQOEw5RzRFbGtEYk9NU0hD?=
 =?utf-8?B?N283UjFIYTRXVFEvVFN5OGxxMVVWYjlOOFRDSlE1V1pra0VkeUN2cFExby9t?=
 =?utf-8?B?TVRldXhvZ3BuYkg3OWQ3Q0w5dFpxVm9KYnpWUzVTdHdIUlZXajk0Sys3WGhR?=
 =?utf-8?B?MVlsVjFaOEpEQlhZbEFMTS9pWUNvcGFjaVdLT0Q1Q3N3Z2Y4M2MrSnJpenNa?=
 =?utf-8?B?RWdFdHJEbnJ1VkdhRG05VUlnWXhGL0Q3YlRpV1M3M0ZlNjY5WHpNRnFUZ1ZO?=
 =?utf-8?B?RmNyMEQxOHA1RGdQZ1F1aHErTW9NNjBPT0VXYnl6QzRQTW9zL1NkYzE0aFl1?=
 =?utf-8?B?NGJXZ0NNMXU2bWwwemNvODdpMWx1UU5tYStLMG0xejh3ZDFIODlLRXV2VmVk?=
 =?utf-8?B?TUFVMU0zRTBlaVNleExhbzNSZGNndDg1TEZLc05ta0JRWTVjazI0RkRiSXJE?=
 =?utf-8?B?YlhWM0pkckdDdm1BTUNBQkdOUE4yNUZDNUF1VGlCVytWWjhidDRQbFVVUTdo?=
 =?utf-8?B?SW16TXF2TW5US0JSRnorZElXcWs0UnByWFgweHNzb2JFa3lUV2JRcDRhTE1H?=
 =?utf-8?B?UzRyNGpsMzFvdDNZMGtiWmpIeU1TRmMvZFdJeEN3RG50eDdJRG9Ocmk0MlBR?=
 =?utf-8?B?ZEhTZTdUS0lzSjhPSG5PUm13L1duV1VkRzhMQ1I1VnFFRUYzZW5ESGNHTmNs?=
 =?utf-8?B?b01LVHU3VnhVdUV4ZzlnN2YydkJqaS90VzZRTVd0V3pybDAzQms2YVlDeVhW?=
 =?utf-8?B?c1Z4c240bGJ3YXh1bkVsNG53dUo3UTJJZVBSc3Q3ZDRWT3g0TDVhZk9ZY1hN?=
 =?utf-8?B?a0Nvcm5xSkV5cThXajdRa3dkVk81aG5nQ3pKeHltV2laK2F5NUJQeFV3R1Fn?=
 =?utf-8?B?NXJYVDlKbGZHQUhDMHBPUXFnc2FCY0IxUWlxY0RzL1VlUkpubGNRZUhiYnRV?=
 =?utf-8?B?MmJUeXlPYmFPTElPSG5ZOUF3V05FRG85YkF4TDdtaDlKK1BjTjFHRjlSUTlM?=
 =?utf-8?B?TWtBWGU5Z0tWK0dDbXRNT0NEVnpreVVFMHQyc2JaYjh0d1dCaE81RVNtNjdP?=
 =?utf-8?B?QmpuRWhDWjQ4eXVnNVRjeFhlK1pSNVY2VU0zdVZCNUttL1EwN3VUSk5yZWE3?=
 =?utf-8?B?SFF4bjR1NzhmM3ZMOHpDSHFlRWxHbER6Vy9BdjBQY2tic1JSb2pmdmlFRHdp?=
 =?utf-8?B?QndBTFlDSnBlTTFia2QyUDBpS1pTUUZja0hkbUpNa3EvcW55K0xmaGJKSzVq?=
 =?utf-8?B?YWRveDFmcjBmTWljOTFTR0VwamtRMi9za2FsU0cvK0NZb1ZFcmpodktMQmpW?=
 =?utf-8?B?TDc3WEFwcFAvbHU1R2NLTGI0cWdybEdEZDhtWFRCSVkzOGFvUDR2YVdINUJz?=
 =?utf-8?B?U084NHhtNnN3alM1czVIa1VwbUgwMjc4NXhQZ2dmSDFCZ0c4ZWNHN0NOY0Ey?=
 =?utf-8?B?NTRDenJMcXNyNy9ma2tyUnNvb3RHMnkvT1Y0OGhYUE5ncUpxditJa0lob293?=
 =?utf-8?B?V2kvWkszdlFYODJudW5yQ0htWTVkWjJNMjNtZmZhUEVoZjZpdE9IVXA3ZWFD?=
 =?utf-8?B?a3RpSWp3VngvclN0MFU3bm9uTDh1ZmUwYzB3TngzaU5UZUlIVTVYU2VzSnVx?=
 =?utf-8?B?UnJEUCs1SGkwL085YzFQQUk4M3lMczlkTU54eDBqWTlITjRGS2lkay9qR3Zn?=
 =?utf-8?B?UmRNcjNFaU95aWQvemFEQUZiZk9vOHRReWNKQy94T05EcWc5Y2RkaXoxZFFu?=
 =?utf-8?B?QUdVeHIyWm9LNklsWnNTWUJ2UFh6Nnh1TGVPRUtybWRSdExjL2UxaHZRTzlk?=
 =?utf-8?B?b2pMNzd6Wnk5YzVhSzI4WSs2VHYvdjdXa1FXcCtGUlJkQ0YzcFVrV0ZteEhx?=
 =?utf-8?B?T0trZHhLZXpybkIvbHNPZHdhcFlhY1pYN3N2SllzR0pVNHlnM3c2aWE5SVIz?=
 =?utf-8?B?V0VTa3NjVndYNEpZblZSejlHemhIZlRvcUF2TTl5RWhsMXcyM0twSlZsb3Vi?=
 =?utf-8?B?SkFVVjJDVjROdFlXQUtReXBxVXAvdk5Halc1VFc3R1dhdHBqVlMvUVYvTTQ4?=
 =?utf-8?Q?9yYkVsXSGRQsdPGE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277f5da-ed9c-46b8-4cad-08da35c70203
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 16:30:07.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en6cXhNJxqRMoSpoYXBOAFF/2pBxkx83RAkbMnJfd9FWLQFEv6ZrAnN3OKGYKNFwLRnltxOQWzUQnR3Hg3O+vjY6qiHsRTqOAPgV9lnQZPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3178
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-14_02:2022-05-13,2022-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205140087
X-Proofpoint-GUID: X9h4nG8q8LyzgYJzdpK40L0Db0Jd-Wt5
X-Proofpoint-ORIG-GUID: X9h4nG8q8LyzgYJzdpK40L0Db0Jd-Wt5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 1:27 AM, mingzhe.zou@easystack.cn wrote:
> From: mingzhe <mingzhe.zou@easystack.cn>
> 
> In commit d72d827f2f26, I used 'cpumask_t' incorrectly.
> ```
> void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
> {
>         int ord, cpu;
>         cpumask_t conn_allowed_cpumask;
>         ......
> }
> 
> static ssize_t lio_target_wwn_cpus_allowed_list_store(
>                struct config_item *item, const char *page, size_t count)
> {
>         int ret;
>         char *orig;
>         cpumask_t new_allowed_cpumask;
>         ......
> }
> ```
> 
> So, that the correct pattern should be as follows:
> ```
> cpumask_var_t mask;
> 
> if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> return -ENOMEM;
> ... use 'mask' here as a  ...
> free_cpumask_var(mask);
> ```
> 

Add a:

Fixes: d72d827f2f26 ("scsi: target: Add iscsi/cpus_allowed_list in configfs")

to make it easier for people to pick up.


> Reported-by: Test Bot <zgrieee@gmail.com>
> Signed-off-by: mingzhe <mingzhe.zou@easystack.cn>
> ---
>  drivers/target/iscsi/iscsi_target.c          | 32 ++++++++++++++------
>  drivers/target/iscsi/iscsi_target_configfs.c | 20 ++++++++----
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 6fe6a6bab3f4..3f9f5b8879fe 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -3596,10 +3596,7 @@ static int iscsit_send_reject(
>  void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
>  {
>  	int ord, cpu;
> -	cpumask_t conn_allowed_cpumask;
> -
> -	cpumask_and(&conn_allowed_cpumask, iscsit_global->allowed_cpumask,
> -		    cpu_online_mask);
> +	cpumask_var_t conn_allowed_cpumask;
>  
>  	/*
>  	 * bitmap_id is assigned from iscsit_global->ts_bitmap from
> @@ -3609,13 +3606,28 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
>  	 * iSCSI connection's RX/TX threads will be scheduled to
>  	 * execute upon.
>  	 */
> -	cpumask_clear(conn->conn_cpumask);
> -	ord = conn->bitmap_id % cpumask_weight(&conn_allowed_cpumask);
> -	for_each_cpu(cpu, &conn_allowed_cpumask) {
> -		if (ord-- == 0) {
> -			cpumask_set_cpu(cpu, conn->conn_cpumask);
> -			return;
> +	if (!alloc_cpumask_var(&conn_allowed_cpumask, GFP_KERNEL)) {

Do a zalloc_cpumask_var to make sure it's all initialized.


> +		ord = conn->bitmap_id % cpumask_weight(cpu_online_mask);
> +		for_each_online_cpu(cpu) {
> +			if (ord-- == 0) {
> +				cpumask_set_cpu(cpu, conn->conn_cpumask);
> +				return;
> +			}
> +		}
> +	} else {
> +		cpumask_and(conn_allowed_cpumask, iscsit_global->allowed_cpumask,
> +			cpu_online_mask);
> +
> +		cpumask_clear(conn->conn_cpumask);
> +		ord = conn->bitmap_id % cpumask_weight(conn_allowed_cpumask);
> +		for_each_cpu(cpu, conn_allowed_cpumask) {
> +			if (ord-- == 0) {
> +				cpumask_set_cpu(cpu, conn->conn_cpumask);
> +				free_cpumask_var(conn_allowed_cpumask);
> +				return;
> +			}
>  		}
> +		free_cpumask_var(conn_allowed_cpumask);
>  	}
>  	/*
>  	 * This should never be reached..
> diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
> index 0cedcfe207b5..ae9319934cd0 100644
> --- a/drivers/target/iscsi/iscsi_target_configfs.c
> +++ b/drivers/target/iscsi/iscsi_target_configfs.c
> @@ -1139,20 +1139,28 @@ static ssize_t lio_target_wwn_cpus_allowed_list_store(
>  {
>  	int ret;
>  	char *orig;
> -	cpumask_t new_allowed_cpumask;
> +	cpumask_var_t new_allowed_cpumask;
> +
> +	if (!alloc_cpumask_var(&new_allowed_cpumask, GFP_KERNEL))
> +		return -ENOMEM;

You can do zalloc_cpumask_var and then drop the clear call below.

>  
>  	orig = kstrdup(page, GFP_KERNEL);
> -	if (!orig)
> +	if (!orig) {
> +		free_cpumask_var(new_allowed_cpumask);
>  		return -ENOMEM;

Just add a goto at the bottom before free_cpumask_var then have this
and the other failure path use it. Make sure to also fix up the
return code (set count to -ENOMEM/ret or use ret at the bottom and
set count to ret).


> +	}
>  
> -	cpumask_clear(&new_allowed_cpumask);
> -	ret = cpulist_parse(orig, &new_allowed_cpumask);
> +	cpumask_clear(new_allowed_cpumask);
> +	ret = cpulist_parse(orig, new_allowed_cpumask);
>  
>  	kfree(orig);
> -	if (ret != 0)
> +	if (ret != 0) {
> +		free_cpumask_var(new_allowed_cpumask);
>  		return ret;
> +	}
>  
> -	cpumask_copy(iscsit_global->allowed_cpumask, &new_allowed_cpumask);
> +	cpumask_copy(iscsit_global->allowed_cpumask, new_allowed_cpumask);
> +	free_cpumask_var(new_allowed_cpumask);
>  	return count;
>  }
>  

