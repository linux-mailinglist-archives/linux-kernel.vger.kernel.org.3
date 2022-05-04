Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEC5192C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiEDA1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEDA1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6170D1A82A;
        Tue,  3 May 2022 17:23:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LIGjm026258;
        Wed, 4 May 2022 00:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6teSvwVvMYZd62OVjNNwENRqKPLP2Tpr1LirLWyLxtE=;
 b=UxEI4vKCiFa6S/q29RcHh1IiIzKPWBaBzaY40CXaKon7N1jzo7EGMeLS39ZIymZXbD15
 nlxoFfDsj4FJg2TQTdAXFpora6a9CHGbPMQ/jWbQl1oVojiZaFfboE5QD6SyvYVrUqik
 Zi9pggH7CGE5EpTtM4rr/EquLt5Yi0D+bKIdkpjZApNXiqQKeyy0VkUijy6P7wDAVoBO
 dRczvivpMupWGNbHWUWNjckTh4EDvQ7dIpbMCBEcztLm3580pgi3Ka+WnsxNJ6geKPSC
 Mjq6n0NKDjQoEAtZi0BPscYPrffFUZ1axOKQTL0JNggP0ukPlA2I5QOM0uMNTdWBk11v Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc717p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:23:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2440GUiq003358;
        Wed, 4 May 2022 00:23:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9fdtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHHzFiuVonOEzK0Dx16hgOIE7wxMzuzA55dfy9ENlfcqDNSwtgUUorlT8he0276U/ACC09tMUPAXT74EfGEcDSL8D2JRlxLENz4hj77l+hKMDjxr99CPbhkJaSWGne6vJc/WV4LDsnrFb6qirvZrFc4tMPcsLoHIQJT0tXoAr/KXBlp3QhxzNh3TDYDm/pUPIAJmvxlIAx6RWpagmeLmP5XPf4zobN3npX1P+LVeJ4JV6lFA35WIEz0CmGO1WESt0UrBY1S03/y9Nv3WeRCZruaAPdYJQGGHFqBXS2mOsXrW2nkH1YYS8KU/rbYIApVVjp1wWeVnHKTW4bfLruY8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6teSvwVvMYZd62OVjNNwENRqKPLP2Tpr1LirLWyLxtE=;
 b=gOZPBrL5KR5qJGdT47LMH0n8FNSk8gFxFWc+36sGL2gxL8m57GaAEYJ7KWcB7s8VaS6ffZj84CX+26sCgH4esnwxuDk29Q2SBrued8HWGfm6IXIsZBVVup2x93aMqup7VEcP9119PJyKZX1OO5Ct/UBtTlRt8sWFJQ3dU3QRSZdd9BfccNz0iniMPceUcmRex93pAQlUnidOFfz6Zn3MEzJ5KJ2VH5e+kp4LA+BI6aBbJJSxdIBBCC7jS7f07qnqHnXYpDEqRMKwpxtlyYbmqWgsy9HrBeIQwfXg43fwOtXEaokdEakuchR+0AXzx2JDCfI2DMsscTLaMIxy/zT/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6teSvwVvMYZd62OVjNNwENRqKPLP2Tpr1LirLWyLxtE=;
 b=QzM/aXzNSEihId8pAf95A3nU5Jq98m67NdFWnIqXbub9lNZuZq9Wl9SZhr24pUZmDBC2FWtmM9cf6SOjREXnLOV81aP9Lh24/y19LVnYmdQ9tRvhi4pXaKDITEuLwqxsmoZx7EY3qUbgABxkmdro1mHe0yKJif+N/0ivCvsq2ac=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2950.namprd10.prod.outlook.com (2603:10b6:a03:8b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 4 May
 2022 00:23:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:23:39 +0000
Message-ID: <3d040faf-7fc1-80a6-c584-aafeff27af18@oracle.com>
Date:   Tue, 3 May 2022 17:23:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 2/4] mm: memory_hotplug: override memmap_on_memory when
 hugetlb_free_vmemmap=on
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220429121816.37541-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:303:2b::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a43dca32-91ad-4d8b-a8b5-08da2d64567c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2950:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2950C77B5FE99CACAC0AD69AE2C39@BYAPR10MB2950.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25L4vQy3VvGR1zB3jvnkSiurOwtTJn0N16xuM1aAUYFd20uQY6fxG5NfIU/U2u8nfXYO42XTdsjV8OlN7+Vs0Ih1XHKsAwCGC8+qKOHYFzZm1vz51/woZ3DVEgOeP7KBX7UFe+yQmE6JaD2HH9ppLuUgIrpEKqBePtfhGjvSAA/kc7z+tlwHp/yCzn8w4ZJ5Z9PDrhIwPuxAIlCBTEbnsC4EoXMXYx7+3TWq9AhrCHX3JuzY0iLrv0EywnM32zTUx4fyffWckzOYAgyI3Tu5adYZ7BOkm5HjMFa2ewu8IjWvOnj4Pezk2ckmMu6aORxD0VUplYJrc68IUwuJnbmUec888d2MtHoKnqyzg//FV2kev3mAqQ4/YcdnYkJBlhI1w5gSqMjrEURD7iEXgB+FxvZ3/D16F2B22ySG3aRQdFuKgT7Tp8RtikhykPnXV1TWlYkUhw10mbxgjPGpjchZGZbCuB8R7QeqJi9CryBEF/KuJnP75Ay2NxPnWQODbxvXK/R71ket+xrtZ4TYrlHbvnKaRIxkzWod9GN+4RDgfrNtjSVOr5VfH5pfHHHGbHIru+pu+klNShyJcIPhRJcoXR6xzF9XShfJIEvDML+bolxcNpvEUxJrhw71zjO+ORCbLQqQcjRGXi423PAr+vQHUb5nH6yzHhKbeZvjq7pqksBVBbAWn7dJuKvm6elc2LnZ6QpfcGz4NFK52Q5kz4y03NVVHQUxucn7ohZ4f+0PFFfzy+5KOT5Lr30UaM/qJ8RyxmhMDtNrlsYCG+QS38I0mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(5660300002)(66556008)(66946007)(8676002)(508600001)(6486002)(53546011)(186003)(4326008)(6512007)(86362001)(2616005)(26005)(31696002)(44832011)(6506007)(66476007)(7416002)(52116002)(38100700002)(38350700002)(2906002)(31686004)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJvajdXWE80V0tUM0xRS2ZoOFd3cTN5dzlSS2dOdmxLdmpWNDkzODJWUEdk?=
 =?utf-8?B?N1R0K0NFN3NSNThzT1k3YkxqVW9kM3llcGlhRmprWUg1Z3A5MUxmTXMvakp5?=
 =?utf-8?B?TWZ4TEpZelZtQTN4YmJ1MEtSc0c1R1UrclEyTjRBWjJyeEoxUnhiZmc3OWcv?=
 =?utf-8?B?VFFXMkFPLzlFTmtRMEE3MUxZK1RaeUc0QjlPSFNsTlQvNlZEUmhrV3g0a1Rm?=
 =?utf-8?B?QUs3L3FDcEgxNnI5TlF2QmF2bVZzSUhuNGErS2JUekZCdm5xcjNwZDN2aFRk?=
 =?utf-8?B?OVliNHlyWDdOdk14UnorKy9MNWJaYkJYS3NlWGxZWnhBZForVmE1VTg2dUFi?=
 =?utf-8?B?QWFMb1pIY21GSnpVZXMvYTVIeUJtcndWQnVpbXNMcUoxRkZncTJJTUloeDN3?=
 =?utf-8?B?RGxFMUkzWXFrR0pWaXdjUnZYL2dzdDFpK3R2OTMxRXpUUlZWZEY1NXliR0sv?=
 =?utf-8?B?Y1BCeVM2Q21kWHlmN09UMWEvRTFiblF2V2Z1bjh6SGdwRW52b0xKZXkvTU42?=
 =?utf-8?B?WHRrTG05YWppMVU4Vmt0RCt2T1BDdlZMOXNrWVVEcjkzMTdBN0dtQ0NHZzVm?=
 =?utf-8?B?V283bE1XSXpTb2VMK3JiajFzS0Q1T0VaZHo3aHE1bndwY3BJeFhZVVVQeVl0?=
 =?utf-8?B?QmxjaitHeEVzRTBQR2dFOENkNTZrVE1TS1BPYUU2Y093L09KZzNlSVJGMTRC?=
 =?utf-8?B?YVJrem9IbElNYkM3SnpiNDgrRmZvbWkvSHNWdzc3NHQ4QkM0dzdLK0NhQlhM?=
 =?utf-8?B?N0Z5UFV0RllqMVN4OUY1OC9ZY1gzNWJVSmRsR2ZReVM4TzgveFkxSjFweTlN?=
 =?utf-8?B?SERwelNsQTRtK3NOczY3Z3Y1cXdaU2prVW5UYU9MaGdjSThXeTB1ZEo4Z2Vu?=
 =?utf-8?B?Y29GREtGMEJvaWxDRkZ6SGwxd3FnY2JIRzZWSHpGYlRDbHNkaTdHcmVEZnJs?=
 =?utf-8?B?Z01wcTAxVFZSWlJEZGw5OGg1TXlsVFVPelkxSTI1TFI5K2hxYm9Ba3VmTHdx?=
 =?utf-8?B?QURiVGVWeTgyd2ppY0VWSzVhQ2JHNENiem5ZMVhTMS9OYXNaSDAwc0xZV2RS?=
 =?utf-8?B?RWZsWlIxUmdOQ25ybHF0UGRKdVdYeUl0UkozU0c0WU44VGVwUHFJZHRlc0VX?=
 =?utf-8?B?S0k3WUVDTnQ5SFN4NzdCbndyTFpYd0NoSU1aSnJvMUl1WnlmbU9rdWpOVmVt?=
 =?utf-8?B?ZWdkT3l2WDMvMm44MEM1K1RLSmRKVy93NUFvNk55ZVUxb2x1U3dBWUlTWnAz?=
 =?utf-8?B?OFBBODNLSEdieFprMktDdFFXbWllOGtUVzAvOUFETEZ0Y0YraitGVnlhaGor?=
 =?utf-8?B?MWsvcXkwWG9jYTA5dWwwaGM1aVE5Q1hVM09BSkd4T3o5blZoai9WZ2JIelcz?=
 =?utf-8?B?Y0J6THRsaGdkYmlqZzFYWmNTNVQweVZ2OHkzVTRyM2tWblRkNkJXSThwd3VB?=
 =?utf-8?B?cmhqcFNaQTVaU3pnV1ZrTCs1RGhBc0xhVFNGeHJmZlhDVXZnMk4yYzkvZUJB?=
 =?utf-8?B?aXJaVmRVdEM3Q2FvQ1hFT3dhbUdvaTd3VnppSlFIRXFudXE4VENLOUtPMkVT?=
 =?utf-8?B?V2JXdlN2YVdlOTV1L1BqbVpOMHZmK3RjNy8yNTFJU3hNeUl3c21ONlM0RDBF?=
 =?utf-8?B?aUxNUzB0UE5lM1ZKQjJRQkN2TERIb0cydW5TdHp3OUFKby9aUWxsTkdlY0Z6?=
 =?utf-8?B?VlRzZDJiQzkveGEyQUw5a1hZWVdwMStBbmhML3ZvZW9FMElMSFN2T1hHK2Fs?=
 =?utf-8?B?ekFncTcybTZwVTFXdlBOU3B2NnV5QlJUVncrbEg2L0o3eGw1RVRORG14amla?=
 =?utf-8?B?RDFERkZHNFJFSDFycFdOeTdXbTRhbXNDMnRqRnV4REp6aG1YZzhNR1NZL2hu?=
 =?utf-8?B?RUZWTlVadnlpTDRlc0EySXdBbTFKMmlpVzZlVjFpbFc0RVdhUEdKM2E0R3NK?=
 =?utf-8?B?VkprR1UvZi95RnBKZ0tQUkVCUlpNK3JvTE81S0hqSTZMTWVBTHlSMFlmOHZ0?=
 =?utf-8?B?Q1N0Wjlta3ZzWVc4MWlnOVpKTHd2a2FTOEFialpjWS91QzRXYVNveUUyTnFj?=
 =?utf-8?B?bFRmbHVYeGx6R3RnQTFzWXNpNGdXNk5pSVNOUG1QNmpFc0hRYVhIYnZ3cjhR?=
 =?utf-8?B?QlFvK0g2MmpmRmk4cUpaemdGQU9NSytMSUJTMjB3WVpTVEF4TVhycnhDNTJ2?=
 =?utf-8?B?UDNnZWdZK0JzYVdVMnE5a2lueEttZ1hscU1Gd0NINlBmUVN0KzVrTlYycGc4?=
 =?utf-8?B?aldUdlhaa0VTQlJUYXhJc1BCRjZYTGE5RUF2b1B4QnBITnhBaldQVmlvVy9X?=
 =?utf-8?B?NjVuS3F6eEFrWlZFMnFwNW9naHIwQk8yRkR2bForVWRmQTNsaWxwa29kV3Fs?=
 =?utf-8?Q?kICJGzZJ7FUisBKs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43dca32-91ad-4d8b-a8b5-08da2d64567c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 00:23:39.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wfkAEDCeREfQRUWnjDmrCQsn+6kl41me4NAT5rM1hdecWFKl4c1XWbKER15eUW7c/Uydshc9+jR0rFx9TdSIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2950
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040000
X-Proofpoint-GUID: oKaLT4JvhFrQcWJyzrlc_DletfQ5Xc3F
X-Proofpoint-ORIG-GUID: oKaLT4JvhFrQcWJyzrlc_DletfQ5Xc3F
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 05:18, Muchun Song wrote:
> When "hugetlb_free_vmemmap=on" and "memory_hotplug.memmap_on_memory"
> are both passed to boot cmdline, the variable of "memmap_on_memory"
> will be set to 1 even if the vmemmap pages will not be allocated from
> the hotadded memory since the former takes precedence over the latter.

I had to read that sentence a few times before understanding what it was
trying to say.  Not insisting, but how about this instead:

Freeing HugeTLB vmemmap pages is not compatible with allocating memmap on
hot added memory. If "hugetlb_free_vmemmap=on" and
memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
freeing hugetlb pages takes precedence.  However, the global variable
memmap_on_memory will still be set to 1, even though we will not try to
allocate memmap on hot added memory.

Not sure if that is more clear or not.

> In the next patch, we want to enable or disable the feature of freeing
> vmemmap pages of HugeTLB via sysctl.  We need a way to know if the
> feature of memory_hotplug.memmap_on_memory is enabled when enabling
> the feature of freeing vmemmap pages since those two features are not
> compatible, however, the variable of "memmap_on_memory" cannot indicate
> this nowadays.  Do not set "memmap_on_memory" to 1 when both parameters
> are passed to cmdline, in this case, "memmap_on_memory" could indicate
> if this feature is enabled by the users.
> 
> Also introduce mhp_memmap_on_memory() helper to move the definition of
> "memmap_on_memory" to the scope of CONFIG_MHP_MEMMAP_ON_MEMORY.  In the
> next patch, mhp_memmap_on_memory() will also be exported to be used in
> hugetlb_vmemmap.c.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memory_hotplug.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)

No issues with the changes,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 111684878fd9..a6101ae402f9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,14 +42,36 @@
>  #include "internal.h"
>  #include "shuffle.h"
>  
> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> +static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
> +{
> +	if (hugetlb_optimize_vmemmap_enabled())
> +		return 0;
> +	return param_set_bool(val, kp);
> +}
> +
> +static const struct kernel_param_ops memmap_on_memory_ops = {
> +	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
> +	.set	= memmap_on_memory_set,
> +	.get	= param_get_bool,
> +};
>  
>  /*
>   * memory_hotplug.memmap_on_memory parameter
>   */
>  static bool memmap_on_memory __ro_after_init;
> -#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> -module_param(memmap_on_memory, bool, 0444);
> +module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
>  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
> +
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return memmap_on_memory;
> +}
> +#else
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  enum {
> @@ -1263,9 +1285,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>  	 *       altmap as an alternative source of memory, and we do not exactly
>  	 *       populate a single PMD.
>  	 */
> -	return memmap_on_memory &&
> -	       !hugetlb_optimize_vmemmap_enabled() &&
> -	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> +	return mhp_memmap_on_memory() &&
>  	       size == memory_block_size_bytes() &&
>  	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
>  	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
> @@ -2083,7 +2103,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
>  	 * the same granularity it was added - a single memory block.
>  	 */
> -	if (memmap_on_memory) {
> +	if (mhp_memmap_on_memory()) {
>  		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
>  						      get_nr_vmemmap_pages_cb);
>  		if (nr_vmemmap_pages) {


