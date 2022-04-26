Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E250ED73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiDZATa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiDZAT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:19:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB11240E7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:16:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PL7sB8031495;
        Tue, 26 Apr 2022 00:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EUU8gMiIpfQgDxAbwneYEBltqVW0HuNgWs5990D5h5I=;
 b=qndwiDhsKLTTNflI19jPzCoMViMqB/F6eSad8XABML+h8Wnp8Gv4/1FZRBpOPfobSXsC
 Ispqe6l9Lqd5ZAJM72OalYv7cYnc5bnDf78cLaYsVG8f3H7VSZOzqOGYMZ3MiLiqV70h
 +7f6fQnjQUDVrk7lVR1LaH2S8xILMmgaGbgIolLZvz5a0RfrnDkvdTfNswK/is56abSw
 ejzj/kIE+07i8uNIdDnuGJRTx8eL3V+PzrB+Eu5/QLe76AuIWOMcJjLyE/WcXbSVnAfQ
 F9O7ptoD3pZ+123AYUiHsU9mDyuF8V0uLPFfn9s5DF8PAOebFXaK/wZqAJ2Beargzhud DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jvrg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 00:16:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q0A2ca000826;
        Tue, 26 Apr 2022 00:16:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w3446m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 00:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh3PWxMiFiqhXU5/MfYaVixUXiqQRiI1kevDNPJK4O/+oaEIJmH0kHIfiMBT0QYrvow+2MM7CjbxqpDlEbCT+4Xj2/DbcqQ1bbb5NyZpsW4HVizpFABYBT0/3aDGIQ1n4zvgmSIv+n31j1S0ZtIBYHSrHfs9w6vfvmobz3NhfGPq3968GchTSvMZpqOs4vrlAotwW4Frm3DiCXUnA8XRFP57dIsD54mAMd3+25kX3l+3s9yZY0z7VbubnUUv6MV5Wo8wFkh4wpIWnFnVS48zsbE9ivVLHW8DkpbqJ/TlSiqlxUycRbDREAbP3JCI4Mf/e1G9WJiukPQnB5wShwOf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUU8gMiIpfQgDxAbwneYEBltqVW0HuNgWs5990D5h5I=;
 b=BxMz9We78AJRp2sGluePYV/+qzCRJb0CxteR+sXyxVkTEYM32g0taVHwi4WOOSuUpK572cwR0B12Bn1bf2h8hdBWFfZshAONzzyeExalM57OrwDDcOBxBA8wh/6MNxoVzbqCaTRzI8S39p+zqJ5f74wWZcPJpBFyNI0VNKQ3i4Dd+6g8PYF4I1Ppsy/u+KbY/SZCavqDD/Wd3Uv2yKX2kHQsFmNKFArtnXqvUQRZHtX3RXduznjRmsqwWPTzlg+KkQ+KBVsS0vZrclA0YQMLgqtuet6vl8eb5xkGVPBJEJGjxGwxOXkLk8hZm0ANeQx7UYnpbBccyZIsYiWRycnCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUU8gMiIpfQgDxAbwneYEBltqVW0HuNgWs5990D5h5I=;
 b=lMLTtKIpXH2kAOyXCSboS21B/HBaKm1Khtty27Qk29mXk5O9cItwK3xo3X3Qd/Gte3kmVgwynaHppbwjbJmkEwiDhSOe7lK82OhH+sZI45HRkA4buWCjXm64wHp6wIQCwtgTQEQlIVZFAwQlkBf3nE8sz7GKuxHtGj/LWMQFilc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB5722.namprd10.prod.outlook.com (2603:10b6:510:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 00:16:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 00:16:11 +0000
Message-ID: <1c960c5e-13ef-c9ef-42a1-821e38ae5eb5@oracle.com>
Date:   Mon, 25 Apr 2022 17:16:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] mm: hugetlb: Considering PMD sharing when flushing
 cache/TLBs
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1650810915.git.baolin.wang@linux.alibaba.com>
 <ad5ad7739a0e2d1d2db9f17f0d672313ae63bad6.1650810915.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <ad5ad7739a0e2d1d2db9f17f0d672313ae63bad6.1650810915.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b77fcaa0-78de-4f2b-4116-08da2719f796
X-MS-TrafficTypeDiagnostic: PH7PR10MB5722:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB57225B8B05B46FEF3F7ECA39E2FB9@PH7PR10MB5722.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dm31i/D8YT1MnkSl46WnlC2Jyx0D7kigU0UjwN0A3NLFoTU0dYYE/amnijNJVBUGw1kdUBvqRKgPR9gjm9FRZkWWwdEiDOAV3ZU609FmE53zlbOw0srqvR34y+D0cYWepbc4zKtLGjqJZfZGQOAo5Pwbg72HRaShR+5YDfIVbIIBxoY/fw821UTVQuL0zZoVT8VASZtVVSxsnYtLRtwOPcryZTLZ6yWd7BosjBRcfWEDTIjbNxPkWG8AiEZ6yJhndF8o29axldnsaKLGYwicrOTiCaOM1g9II0HqHm6kNaLxUXrrymcDnHVP6F4hrZRzk5dWtScKgZpYY2J7inOPEb9yOZQGQkXi5gKt1/3F5AHOQVgwmy8cyxcM8tC0N23SSyO9kkW2+seZ5vK/czXWRJx6NlPHgxtvQAteokc1hiMWlRAdqJwgXHQqbMNvQ/4+fL5CAf1RMSnLcoDGianJh675CZQf1gX2an1AiiQ06MXprz6Aje6j0HhHwWSfZnYuBHp/9cAgfrgbq8vU77n1NKIdZpfJDC1gyj8hiQoWjdISTB3wiWfM/HT5zt8g/ii2vw+GmZGsq7dpAG2qoVwk34TrY/kjWlMPSJcqBOpnn8Kl8yTyV57A0Qjd8OQ2XBF69fJULKGnoyRuYvLXocp1F3ScSYykA5vqQR11/F9mBcLMuH89WrRYjsXmKkd6gK/ZzDr4ZswJhPz/++AEAMj9VC0PQe3jiVSYBokFPwaz52+OULe79xMtJaBsrNgH3NDnpjnALCz8VDLNHlU+KjW0pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(5660300002)(2616005)(31686004)(36756003)(53546011)(6512007)(8936002)(26005)(38100700002)(6666004)(31696002)(2906002)(52116002)(86362001)(6506007)(44832011)(316002)(8676002)(4326008)(66476007)(83380400001)(66556008)(66946007)(186003)(508600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRPeFcwZmJhbW1QZWlCNXVUSmFRbWVXMGxQd1NaOXBCbnZXYWhBakVaRWo1?=
 =?utf-8?B?MjVBNXh0Njg3Z1VqWmJKQlZhTmxtSFh3WjQwdStwbzI0eFNuMjhaVDNOcE9r?=
 =?utf-8?B?TEorVURkNHNjbm91YzNnU2RFQzMzSTVPcWx1VDZ1TTR3eG52ZjhLQ2Zoc2RS?=
 =?utf-8?B?UVRUQU1QYnpocVhEN294eU1ibnBpNmhDRXdIUnJOeUU2SjhNTDFNSkFyaHpM?=
 =?utf-8?B?b3djMHRuUDB3aiswS0lhbGVhTXJaK0dPSWh6amNtcElhNy9nNnlpckpsRGs2?=
 =?utf-8?B?aDFscXI5ZS9BeU9OK0VoT3htUVZtUHVwUkd4TW9hblByVm9RVEVXQ2ticVFk?=
 =?utf-8?B?OXJxMDQvQ3pmOVZZVk9CNWIrTUxLeWxLU0RNYS80eDkrYWpnTEp2N0FKWVYz?=
 =?utf-8?B?YlpVRldBU0dZZjh2TFFYN2hYNlFBVytJdVdodGhOUGZBMW5WTVQzOU1POHIr?=
 =?utf-8?B?d0lXYWlsRk5ERU0xZTA2bHM0Z1EwQjJoN2R0cHFuRXNVTHJwMjdVT0NIQlN3?=
 =?utf-8?B?TS9MSmJxbFZuVjFoVlBFM1RVeDV1cjd2eVVybmNBT3VXak9hVXhzZG1pc3lk?=
 =?utf-8?B?OVlYNHh2aHNqVjFRMUZlT3U2dGpQQ05BL2hXd2FUWnAzckFCY2QzLzF6QVpZ?=
 =?utf-8?B?VkVINjJlaWtvUlFjUkh0bjhXeXA3MmJ2UFJWaFl3OU40eCtldlN1UXlmTlh3?=
 =?utf-8?B?eGR3L05uNXRUUWllMVRHa21uV1BUVVpxdS96L3NpSFpCSDFFYkxYeVhtUkZ5?=
 =?utf-8?B?SXNRSkhKblRDbmFQQmVxODN1ZmtOdTJXeTBuS0hZTWgvRzVja0Q2MytRci9G?=
 =?utf-8?B?QUVueUV2ejI3VlNBUVZ0Umo3NzBkcGY0dmdNY3FnaW9PdTlJcnltOVo4VWR5?=
 =?utf-8?B?YTVBUzRFbEk5YUJoUld6K3ZXbFlXdHRwSE0vUGwrSUo1Ukh1QUpwUXZKTTR4?=
 =?utf-8?B?MzkwelAzMGcxdWNnNTBOTjd0Zyt1aFBWU295YlZicFZjZjNPRytYWDkxMzZz?=
 =?utf-8?B?R1hFYnBGSWx3THlmM2FBcHUveDZrQkpCQWhoOWMxdUtTTzI3RGRML1dmK0VR?=
 =?utf-8?B?OW9NaDczZEJZaHE0V255aHJ3KzFiU1ZPeHNSMmZUYUpYYWo1R1ZzemVGSmds?=
 =?utf-8?B?SFV3VzgxZG0vUHdNeERRU2JuUXFLQnJ3ZUYrb0NCVmcvd3gvTGNYR2JBUUdk?=
 =?utf-8?B?TWphZnhGcjRHU2R2dnhKSVVxcG1wd2RkNk4rT0ZQTFVIcWdBcjREUUI2Sjhn?=
 =?utf-8?B?UTYrTjNtM3FvelJUTklZM3IySjBLTThHbFhvWnZYcGtHRXZ3R0tzclpCVkcw?=
 =?utf-8?B?Zzc2K2VxWkMwVElXNlZ6K1pPbm9SK0VTMFFkcldrSHhYUFNGaG5kc01RbEtt?=
 =?utf-8?B?c1YvcE4vQ21VVXJEa2hhTkJaRFpyaWN3NHU4YTB0aXNYWmNtZFhzeUJBK1cx?=
 =?utf-8?B?RGpFUTIyTkxWR3YwMmhsUkhsTnBkWlRSMGJLOEJzTTNoY0NtMkFCOWFvRnBr?=
 =?utf-8?B?bGgyTTUvWEtHTmVsbDZCS1FFTmh3S0lNZXorZkxESTYxNUE1NSt6UTFYbUR1?=
 =?utf-8?B?YTVGanczbXUwT3RzSktiLzFXdVhpMXhJRWNTV0JYVkZxVWNFdTh3RE5JQzVF?=
 =?utf-8?B?WmFQakQ2NHNXMmxpYXFpZEkwZ2tGQW50dFBNT3crZ1hmK2lRYVJFVDlYQW5t?=
 =?utf-8?B?RkV5TmV4OEQwSG5NK2laYjlnODFHbkc2VkRjaTJCTzg0VFRFZ2JkcXIwUHJ3?=
 =?utf-8?B?R0FrMGxob3YrRXVnL3YrVGk0SW5jd2JkQmNWZWFnMHVVSmFsc2ovOGUzcTBa?=
 =?utf-8?B?eDdFNDR3eFh1allKQkltSVZIWFAvWDgrdUE1QmVYOUkyVytxVkU0dXZocXlt?=
 =?utf-8?B?ZUNHWFo4a3J1M2g3V21xVEcxcDh3THJPVEVtZERCK3R3Z2djRjc4bTFYYk52?=
 =?utf-8?B?V3Q0UjNVbCtQd2NCcWlha2tSUncrcVFPQXdEd1RSMmh6RzNmbDdwdTI0aHF1?=
 =?utf-8?B?Mk12aU0zRXVhTENVRWY3d2xwc3lwQjhkYlBQVVBmV2lDQnJuQW9tdHVpSjE5?=
 =?utf-8?B?by9SL2lsWVBVN1JFWEtzbVp4bXZKeWRWZnpUTkxTVVVPdE9abW9ZemlLYkw4?=
 =?utf-8?B?c0VMRmIzUW5sL0kxTk9vK0NQSUllUm43K3ovQVY2Y2VpeFFMamVxV2h1SWFw?=
 =?utf-8?B?QndNSlpTS1ZEWkFLT3RJMXZlN3Ywb2JtUjN6STdqM1pRTVluZmNWYVpmbGFu?=
 =?utf-8?B?blNrR1c1VjBlUGgxZzBFSjJrZXpqNGROVjgzdW1BT2hkVVRkVHF6dnY1SFVa?=
 =?utf-8?B?dk5XQ0Vja1huR3lTb3RpU3p4eWYxeXNEQjdNbWxQL0tOL20vaTFMNWUveWJt?=
 =?utf-8?Q?b6kYmA1nzcsCDWOg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77fcaa0-78de-4f2b-4116-08da2719f796
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 00:16:10.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/mHJDbNF85kfc3DaIfGT0BcwvoDPmJ3Z58uvHarNOU3l+7mZ4KqG+XqGG1U4af2jpfh7rc3KB4CGlf8wJKIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5722
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260000
X-Proofpoint-GUID: hkqV5rIUbDn0puHZUVVn0g4MB32PtIMy
X-Proofpoint-ORIG-GUID: hkqV5rIUbDn0puHZUVVn0g4MB32PtIMy
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 07:50, Baolin Wang wrote:
> When moving hugetlb page tables, the cache flushing is called in
> move_page_tables() without considering the shared PMDs, which may
> be cause cache issues on some architectures.
> 
> Thus we should move the hugetlb cache flushing into
> move_hugetlb_page_tables() with considering the shared PMDs ranges,
> calculated by adjust_range_if_pmd_sharing_possible(). Meanwhile also
> expanding the TLBs flushing range in case of shared PMDs.
> 
> Note this is discovered via code inspection, and did not meet a real
> problem in practice so far.
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 17 +++++++++++++++--
>  mm/mremap.c  |  2 +-
>  2 files changed, 16 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1945dfb..d3a6094 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4937,10 +4937,17 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	unsigned long old_addr_copy;
>  	pte_t *src_pte, *dst_pte;
>  	struct mmu_notifier_range range;
> +	bool shared_pmd = false;
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
>  				old_end);
>  	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
> +	/*
> +	 * In case of shared PMDs, we should cover the maximum possible
> +	 * range.
> +	 */
> +	flush_cache_range(vma, range.start, range.end);
> +
>  	mmu_notifier_invalidate_range_start(&range);
>  	/* Prevent race with file truncation */
>  	i_mmap_lock_write(mapping);
> @@ -4957,8 +4964,10 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		 */
>  		old_addr_copy = old_addr;
>  
> -		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
> +		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte)) {
> +			shared_pmd = true;
>  			continue;
> +		}
>  
>  		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
>  		if (!dst_pte)
> @@ -4966,7 +4975,11 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  
>  		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte);
>  	}
> -	flush_tlb_range(vma, old_end - len, old_end);
> +
> +	if (shared_pmd)
> +		flush_tlb_range(vma, range.start, range.end);
> +	else
> +		flush_tlb_range(vma, old_end - len, old_end);
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
>  
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 98f50e6..0970025 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -490,12 +490,12 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  		return 0;
>  
>  	old_end = old_addr + len;
> -	flush_cache_range(vma, old_addr, old_end);
>  
>  	if (is_vm_hugetlb_page(vma))
>  		return move_hugetlb_page_tables(vma, new_vma, old_addr,
>  						new_addr, len);
>  
> +	flush_cache_range(vma, old_addr, old_end);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
>  				old_addr, old_end);
>  	mmu_notifier_invalidate_range_start(&range);

