Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D323C53424C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiEYRjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiEYRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:39:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F0AFADF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:39:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PFdSsZ030666;
        Wed, 25 May 2022 17:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bEZImQT6ShBvYCNa1PvT7CFA1/R0Q76nFwXLayCm1GA=;
 b=PXfHD84Zp7JbBWRxO9uxvtzAtWXNxgymXr0dxId2hqxdUf/WTh/tU/2skbr7Dw+DTYta
 Y4u2K9ukCTreXc8W4e2fznhcZPFLlkPRR7My3FSXt3DqebQ6lpDfJcY7vynedL7/N6K3
 G5kxXu/+L5J7m2DmZb+A7sqGoxy1Z/iUulzvql77c685INhnDBkPVGoExzGiVdcX2Vbe
 L+Me7cuJ5aaocX07w2h/LH1mqzDZFAHMJhWWaF//gisq8wYo60MG+EOg6P0vlIkFUaP+
 U/dn+kFOoLyEd8d8ejf0tIZPKkC8/KpjEnx7khATytNUarL6c1G84v9SEuoO6W2yY3Yk KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc2wp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 17:39:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24PHU7MV004163;
        Wed, 25 May 2022 17:39:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wvhwds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 17:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfGoM0JeTUPQPMwVhDxP4M0E7xJNWNeEmUjG9RvkvABHSIbdj7vAjFE4UUYP/qqy9NFNAuq4Iu/HLxR5LdbTY3YfDxj20vcUmJg88SM3jd/cIN30XqIJ/jqaJMTQND6S3azn8akjFtjRPlKod5FvFzIonJH7c1tBT0xB/qAvS/FaezTbUNSriOlhKJoMAdKItL7kTjv3hmjwGdgTBm/h5RqMa/0l30FC9bRQOoOu/DNbUY7OGU4kUHR3pPO+LG0VBSDH7bqavku33Vo0csvxLa49Zu90O44kS46ahvK6at7jKePJ2V95jt3CjpjxjI0RMszzile77h7RTf44V1TsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEZImQT6ShBvYCNa1PvT7CFA1/R0Q76nFwXLayCm1GA=;
 b=jjVAoASTplwjbKONQgJYy62Rf6r2vOMVlfKDfkQ8G01aFVBvkt44Pg66JQotsOXx8ms4Xv0akyRYnrxwsOCu9R4O9Eu33eNyM9eSS5hWSPWzdCj6CN0dV9fAJojmLpZwc0hd1XU3rKBM2nckHC8t1wa6LTvXM9dpp2WwO88v/PVTUq37Oc7FLZYv75AQRwEAleeMrh/afDRExyvGtIepTIX2GAzoa9AmtlSggz2WDlM1IfZ07KWg/BPRifGb8uYmrP6mrgCQ/wnW9DXHPioyaX3900rTPyNV5gHkLNV1iGUkAAoV3ysLt+ItQd9vBs4qJEwYruVRis+CPMG+S5XNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEZImQT6ShBvYCNa1PvT7CFA1/R0Q76nFwXLayCm1GA=;
 b=he1TMrrK3NSpCmVMColW+YmKfW1T6V/qbzATuUZEyHM0MQ2plEOR8Q0SPkFnE6Y7NJn88Qd7Day2juffDhPy/VGIyVlu8ydMJxjFVbkmh/sFkSG80TlH5Qjr8aWylYciVrbIGcVMWYZFr0gWYyazeWYlChFrQXPsL5wijEJcTAw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 17:39:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 17:39:31 +0000
Message-ID: <b5f377cd-b046-5cd9-19e4-5b458eb7b50b@oracle.com>
Date:   Wed, 25 May 2022 10:39:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm/hugetlb: Remove unnecessary
 huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6927dc44-46f3-4b85-2f81-08da3e75865d
X-MS-TrafficTypeDiagnostic: CH0PR10MB5082:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5082ECEFD95B2D20E1FF995EE2D69@CH0PR10MB5082.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vG55rr370x7tynqVYBW/tSxkagCCcobrH9KmlaaWSeagq6oTUL8AZ2zsk5wh+Q8cPSKRjtc60U5Rf4SG7ZBFiW23rnbTc/Vx9YZwq0ZN3uVfJ6iHWvJxuk0UiQO1+b0tTxy2kkwvNgkJo/NjSKeYL1bVvjknrIrZlyYnS2AXndq+KI3uRQcREFk4BAOT63cA03ZYoZFOCvYIedi6NFMdFZgDeO5+7cAcU0sm3UZJ0UJORuvui/4H9DTvGNh+GQ9d1hQwwA1bEg0XC3tWfg/fn6G/eTgtDv7jZcDxqTcQMjhYXettAsLq2AFzHk4d7BbakXNs4A4aPD646aUE8sWxsqLJZA5y7amykL1MaT08NwBPeulr6PKEnfgLyiQRd/JOBtrE1S1sWlX8sstXpDElR+82Cdf+rJcUCWGAHOYgGHakhqUxgExdTP4Odo20Bzy+6rcYZJ7GM9P7WVZg5MH6Hj9e9vgfqed+z6PDJ23MAoEqETw1RhIr8d88k1ZOKD7NwcUuTiFlE0HYxP+3Z2Eq9BovvWv65tMxRANTGLv02GBqhP2sR9KFdB5xV38kcAgDrhJNetXmABaCcY5HmbBZL/EQ/Fgcyl9x9qXztA1f8y98/omSM37zlcHglD0aYxFXhzy19g4MHkZw8wPByJBEk7QF/0nuKRdimeWiFdoVjUn6FnI5OZynNdrJNksDg0p0oghYXzN3pM8BodH8DnsduOCo3iJAtoDX/c5uJFETz7hrT4mzSzUweEL+ipxvy4HmI9KD6JHBO0TMzTuDlutYfZGy+oK0PbV8X1qUEbuRZHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38350700002)(316002)(6486002)(52116002)(26005)(38100700002)(83380400001)(66476007)(2616005)(8936002)(6666004)(44832011)(186003)(2906002)(5660300002)(66556008)(86362001)(66946007)(31696002)(4326008)(8676002)(6512007)(31686004)(53546011)(36756003)(6506007)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJBMEZnS01rSWlEZUMrOVM5TU5ra2NRVThuWS9Yak1XQ21QalZrV3FUaEJ6?=
 =?utf-8?B?a3FkeW1rWUlZeXN3WlE0VHYwY1dLbEFqanZxWnkwN2dlOEs1VGVISFRnRjlF?=
 =?utf-8?B?Z1hZbUtlVmx0a2ViZGFaZjFkSUtVUWg3OXBkUVhYaXR0UTBvdzJxOHZGVDdI?=
 =?utf-8?B?K3ZvWXd2SUVBYXd1dmV6djhvQVlPT2dLVzlxNjM1VHU3Wm0wTXJmemhTQ1pD?=
 =?utf-8?B?Qndlc1lOdnErNDloS3hIZFQ5Q1BwNjYrMmhTVENwMkcxMmJsc3pON21DbDBI?=
 =?utf-8?B?RGNHRytja1RLcGg3eVVzeFcvNjhpM29kTVc0MWtqdlpuZllTeTVnNEI3Yngz?=
 =?utf-8?B?SmI1QUNZTDhBTmVHRThtL0NtVHpsNTVsUmlsQUJiMzRsRlloSnB5b3FoaEZM?=
 =?utf-8?B?djZOSnBzNVFGRDFWYlJVd2hrdzkxSWlTRHFhMGkyN2xtM1RwQjZSWkh4MTVj?=
 =?utf-8?B?cVVJL0tLdGVONHBYQktSMnY4K3VRTVczb0FMQkZRaklnNkZHMmpEZFZ0Mi9D?=
 =?utf-8?B?V2RyeFNVSXhnNkR5WlNmMWcxcFF3VGxXTDdZQnBKSjhGUnFrS3VsbWlLT0JN?=
 =?utf-8?B?WitMUzR6dFVFVVRWdUd0b1NXTit3ZndndGdWYWdGMlRmVkhrU1MxdW55eXNl?=
 =?utf-8?B?Y0tlcEJkYXdPVTV6RndJVzVFVmUyQ1hISHQ2Zll4UkFVZzYwUy9yM3FWVHpO?=
 =?utf-8?B?WHFBc2pIcFdZSHdxNUFDYklQUEdTWmFFYVdYQXl4cDI1dDU4T2tidEVOcFFp?=
 =?utf-8?B?R3dZMlROWEZHWlJFY0NYV2RVR09yZmF2UGNmbGJaQzg0NkZjYndJQzl5cW9i?=
 =?utf-8?B?SGwrQXUrc055TmdpT1BOUHJ0dVZyN3ZYdzBCMW5wZmliZlVJbWhiYWhHL3hB?=
 =?utf-8?B?dTJjMjNpZlRjd01UeUk2TzZsMWNxeW1NVGI4M3Axa1lWVEplbFlwQWZyb0JY?=
 =?utf-8?B?S1Rzem8wMW16YWZXT2NLN1ZMVUFlU2dSRlEvR1VreTdJYmNheFFwTEdCYjF4?=
 =?utf-8?B?VldKUVpNKys0Y0Z4NVI3YXR4SEZjWEZQbHlaVVIwRFBCZ1JuN2JtMEdlQk9C?=
 =?utf-8?B?d3hxTk1PMVliUlpTODg2dm1JbHpvYmpFSVBEYW8zeUVaZjZTODlTYm5GaG5j?=
 =?utf-8?B?QTFSNklHeTJlZkdOL3R6U1BEQVBuVGJ1djl6MVBlTnRIUllxczdlNDJ6R3Jy?=
 =?utf-8?B?cjZjMzVPN0hnNjJ1TTh3SlYzOXg2NDRHZVBOTkRUV0FqMmtLRit0TTRnUjhm?=
 =?utf-8?B?RTlsNndWNytrSjdaN3hZVHFzV0hKSEFHOGI3S2RWRmt1Q1JlQnl6S0hFNzUr?=
 =?utf-8?B?RGUwbTVlRFF4aXdGdlNrWFVmcmducnYrZ2RqVFArYm9qOFpNKytqdFVOdTBO?=
 =?utf-8?B?QWRlam42Z09nakwxOHJReUFtVmRXWjNPSUFFaHE0K2F4WDRKc1hpcTMyV3pQ?=
 =?utf-8?B?SmQ5dnNNVnUvTEJXMjJRTndNZWd5ei96dFlZazVFR2hXLzB2dGFzak5GTjV2?=
 =?utf-8?B?bk1aVUtGeHpMNGFMT3BiWURxWXZqNVhsNVdXWkphNy9qSjlEZFN0amtQMGV1?=
 =?utf-8?B?NitUeGZaRlV1bWFWVXBRanVoRVRMazF2OHlqMndjdnEyRHBXbEdqMlpsTmRr?=
 =?utf-8?B?ZFExUmlKWXV3MWd6Nmc3SDViRUlURGpocC81d0sxTnVYMEZvVmcreS8yNUhr?=
 =?utf-8?B?RlVhdllYY1dKN05LUHBBV2FDU2ExUm5RN3FlbXptbEFWaU4vUFZXUDd5VVlx?=
 =?utf-8?B?bTdMMEh4Ymg0cGR0QlZPNzlxMVFxZFBJdkxOQXVZK3MwNTc2YUgwU3BUTTVn?=
 =?utf-8?B?QmQ1bExOVzhOTm1DYjNKcVpLNDFBMjlhNFphVFBNUEpyZEVZNXBaN3dTWkxK?=
 =?utf-8?B?WXBabFJFMkcyVjVheW1QSHpacjFzOVFmRlU5anBHdUkzRUFsSWtMbkk1bEl6?=
 =?utf-8?B?NlBFaSt4MVRnMDBsUmFES2dIWkFqT2wrRXR4RkZxWEhvZzFoZ0JDVmg2akZk?=
 =?utf-8?B?bWNQM041K2tkR0kwVm0zdFI1aWUySy9pb1R3SWNwV3BhelhmM0xWTjBialVh?=
 =?utf-8?B?TmorR0J5bUR0bmFUZFJVUE92QkZ4Ym1kUHdYMkhNbEcvcDBNeVNnNThXcUFQ?=
 =?utf-8?B?UUNaQ2dCRCtJWUVmS1A4N0JHL0oybXpCSmJ3VkFXYjBtTFkvYm9lSHZUbjc5?=
 =?utf-8?B?cG0wV01WT1RZRjhYNldmS1FyckM1NFJsTlNsSzNIazBtSEZ1eVI2aFJGd1oy?=
 =?utf-8?B?YkxvZTROalQ3SWJDS0FxVkNEelZaVlQxYXZQWDlRanV2T0FTWVJGT0NVb3Uz?=
 =?utf-8?B?djREUit2Um44VTh3N2k2eC9Lb1R6dytsOTgrT2NGQ2dCV01Ia3NYZ0RRRG80?=
 =?utf-8?Q?i7gMWIvj6QbKE5T4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6927dc44-46f3-4b85-2f81-08da3e75865d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 17:39:31.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsNwON7wUicgIbfdV2qyxCoGXbPAVY1QspA4AlqOdohZ79AIb1yVdbiGgAsNcdX/6RhWOU2o0U3ZD61adT38rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-25_04:2022-05-25,2022-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250088
X-Proofpoint-ORIG-GUID: _e7pBtW0YJSTP9P3L1fPlJ9U4fG5DpgR
X-Proofpoint-GUID: _e7pBtW0YJSTP9P3L1fPlJ9U4fG5DpgR
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 03:26, Baolin Wang wrote:
> There is no need to update the hugetlb access flags after just setting the
> hugetlb page table entry by set_huge_pte_at(), since the page table entry
> value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()
> in hugetlb_mcopy_atomic_pte().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks!  I agree that does nothing and should be removed.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7c468ac..3ad49bf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6032,8 +6032,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
>  
> -	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
> -					dst_vma->vm_flags & VM_WRITE);
>  	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
>  
>  	/* No need to invalidate - it was non-present before */


-- 
Mike Kravetz
