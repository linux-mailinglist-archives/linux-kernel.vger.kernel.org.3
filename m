Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482CE523CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346347AbiEKSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiEKSgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:36:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1651FCEF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:36:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BHFwot010355;
        Wed, 11 May 2022 18:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Oezm3BJ8gLAP0P7yllFDD4mFXWM5+JaqvoWmtCk7vZ0=;
 b=kHU09OXrdPGkA0cfWjbRMNZgL7zHh5j8eSqyegeL6ztAmHa3iv8NQnrST4kxAV04LMXb
 ctBd+ZiiRmKSntoG8sW+M3RXAMoVEXUOzjJaCe2aBQMoy7iLqYHodVw0GTBYc+gtiXjy
 0fTXwZk0zhhV179oC2lHjlmu4cowxYt3QgcZBXW6N6cgD2U0+KmcG6vIVS1ftERkhD4R
 losSBf8drl6cGwSJS2Y3fCSNm6ydlNF6kf1fMpuRjqCZpAgslOm0ioYFPlXftdOS1IPe
 xIPc/peLPqPODBLddGS5oGVemJ6tT26IqI5PR2Z0i3IPK6MPIe0JsVYcYKXcAe7nyJi9 ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6caefb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:36:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BIQUmZ031281;
        Wed, 11 May 2022 18:35:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf74e4re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7DI+SOpMlul2oMOzrijNoMpfWA14wRxnsJw9bo+48c9Ks0I9p6mhFkmjnmAqM3eotgXRbV15xwseub0C6lYs7FMOQXwjEgkligo/mVYzHnX0ETCoZRMvEt+aAwyrByv58qnwdazbIoj89T80oaiJOKyJR6kG6dhWpxt9TsvEvOYUFKjNZ0OD1pO9INNB1jTBYNPMNxQ0c65Hrry/QiQ9tJWlr/bwBgvDdZZ+h63u2EDyYajCBIEMyL5ZuZjMlmbz8qnsBU8TqhwlzGflAGkW/56N4TKprlha1GtFXjN7fTU2FRxwbhvTnv5B7n7Mc2TPoNnc96VIKSZyxax2uD17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oezm3BJ8gLAP0P7yllFDD4mFXWM5+JaqvoWmtCk7vZ0=;
 b=I0jZKmZN0uBsE0Co73S3jxLTfvvZkYqodu2hd7T7qyzeW84jPte9vu23VFMbiTEkESz83WMbCE+tvASdGU4D83m3skIwtft4r2M65rTCG78BoVci4JtDtNWV78005olsRh9p8zcurvqlFg3LQCqxFAD6ZF5XMt37gz+Q5A5J1WDexiaZL9h/2BdOclakJ9NjG2tj01A6MbtdJR3o62I66fVXp/JxWfmqPut8Cq5FTLnGiE7XImepBpkwigSb0j2DpJ8wl0RgjiCHaQYAQWj+hbIASRZc3K+PAboAUi8HOvbamjSn76Wa8Ynq8zVDAoq2pRyMN8HW470SiXzDH/p8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oezm3BJ8gLAP0P7yllFDD4mFXWM5+JaqvoWmtCk7vZ0=;
 b=yO+rj8ykPKeACrxp5t8Ws3T9jHQLLHOhyF/JNr1sky2RXCA9bzUPOlqs3dGAxjGmUiCg7OxQyH65v4cWMXeOGMzRjLgeYbfaliZNuhNGEmWqCJQJF1gaKVJoxufXiChFB0hBGrfUA17umlk1NDWxlPuYFxdE/G5S7tm4tQMZ+rM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 18:35:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%7]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 18:35:57 +0000
Message-ID: <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
Date:   Wed, 11 May 2022 11:35:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a36bc9ff-d5ed-4231-bcf5-08da337d16a3
X-MS-TrafficTypeDiagnostic: CO1PR10MB4675:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4675EA1407CF42D456691E0DE2C89@CO1PR10MB4675.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SzKukGktUygWiD9cPloFwBRXlEVdLjGOpQyZ1rpcEdFoOFXLwGe3AUttz0KdI2LhHqKgtfv9F8+LkAxwbJ50MUDmIm2I4XDZ+VWxFC6rUg/NQC+0NQ5Z/vOgnor9TeDlgSnAPL0nlily5KaMjoF29fMdzkJRLC+JgcRu4NIAVZpjxiA/c+7foNLgeOhP0u80IIIjITFDGnt3QZWs+7l3tRrMpBamdMxgfXUJljE1uwmsiMsuQ7ZEmeaRN/y+SrPJa0SxGhHxIQX88zh4sZ/gc9axnTnK9FWZlQWW9VG91LPd6PXK6eA4QN3C3oklqkzgcXi+a9IlE7m9eU9qGkM0p9qi6KrpVCOvf1f2EPJbMdQrZr3dSeXc4cpPaczMk7rdKSn5Qqd6Gwv4UrbITFuq0/mzRzf4CiDHw0aFgEaSem4xK7WyrDURr+x6rx8FgjpELf9Nd6l1o64SIW6h7Y1v6TURNjfkg1PP+Yejnuk/ng9Q9+lQhYRCk8GwhMNfcohv2ooW/nWG8X3CrkDnHQ0Jz8XnxU+9ludMmEyQxeW6jMwhmj3lOWI2givsdFkpu4Ws1V4jlNuOBThUZlyU+Jo2X2y2QFkRD7Qf13pHhvxZThhRaGd1bk61wYA9FmgzlBgb7yU6/d5IcXooEPWwsi8LGotmxXpiCYMPSALffO4kv8UgwJPc/rspd4/1YgBwo3q153ay2qW/F9lgKL2gibI5hl503TXJK/3r1/5pCh61XmAdTBGlK7jKh1NfQoQZIEI87rNOBuwgPiMrDzG7/YnEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(54906003)(8676002)(4326008)(316002)(508600001)(66556008)(31696002)(86362001)(66476007)(66946007)(38100700002)(83380400001)(186003)(52116002)(38350700002)(6512007)(2616005)(6506007)(53546011)(26005)(36756003)(44832011)(5660300002)(31686004)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm50dkdhVDlJclRpUStIZ1lHa3pBQjNiWEhyaVBFTlBHN2hnOTdHa29TdFU1?=
 =?utf-8?B?YStVTW9Xci9aTE0xOHJ5eXdGSXpZM1ZaQW8zb1BaYXZpSUdseDlhLytMbGQy?=
 =?utf-8?B?SzdkS3dLZzNLd0d2SnQzN2IrOGZPaTQ1enNBeFMxS3NSZTc4OEpwQk5NRG5s?=
 =?utf-8?B?eHlkbnVUVGlMaWkvMUNMbzhWazBiUmxweXVBTmgveDRBNmthczNCUzE4NWFY?=
 =?utf-8?B?R3d4eWVDa2xOTzBjSWdDek5hRUlmZlpIeGZOdWI1bitLcjh0VnJ4NjhwckVR?=
 =?utf-8?B?VnRMTUlmdUdqUWd1YUQyWi9KdjZuTGhHbG04VEsycUV3SEdEZEdMVEpGa2Rq?=
 =?utf-8?B?Y2NhU0NXUGtuWUViRDFUbjJnTmRIVERSMzJqVStIaUdWWW1tRnRLWUtwV2o4?=
 =?utf-8?B?eUJkMGNERklWTE9zNzh1Q1R5ZEJZeGc2VG9naXJyTGVjZWRFamdKenBBelBW?=
 =?utf-8?B?dHlXQmt1cWNtZU9vTDJab2ZaVkV0QVdPdmNLc3duUTV3Mmp1c3RpQmtyNGFq?=
 =?utf-8?B?bXlaWFNROGRibEZXTkQ1SGtMdUNwQUpDWC9XUnJUa21RV2FFY2lLUlpWVkg4?=
 =?utf-8?B?Q0JiYnRhdXorL0dmb0VYZzdjYktXRzV5RXNiTW5SRW9pUGdTa0JoeU9JMTV6?=
 =?utf-8?B?UmxJb2o2VFN5YWlSb05kelI0V1FLWVVyZDlXTDVaQWZWakx5cC9RUlJ3eHJW?=
 =?utf-8?B?Vy9mRVZUQTNiaSt1bU9wZFZWaCtqWDVwazNmcnpONldUMTRhUmFSMEpLZTBW?=
 =?utf-8?B?c3I1VkdyZDJXOHJabUoyeWY5U1FmY2dZb1piVFAyVTM3MnlBU3U2WGxjN3U4?=
 =?utf-8?B?V2IyV1ZTVkVSdzBETjVJcndzRjFJaE5QSmM2andoalc2N2VTTTVRdW5JMmN2?=
 =?utf-8?B?SGgvSDRyNnlwLzlEYkxVQ0dDczFUVjlZd2F5WDdZZUxmVlNBQlA5UysyRDhW?=
 =?utf-8?B?RjRVcXpqV2FHUDNpS0dQRHdvQlBpQnNUVllTY1Z2M2pKcUJBZGZTYmQ4MFRW?=
 =?utf-8?B?aUNrK0o2RVkrYVptVm5ydEF1UXNhV216S2tSTktlSzc2MmpKRGV1cmdWbVhq?=
 =?utf-8?B?SWUzOW5oMGxnbVkyb051M2hpK0p5Tk5oOEg1RVBmV2hZMmM3Z3MzNm9MbGpl?=
 =?utf-8?B?VC9UT2ZWelBNUjlpYWxmbkhZWlNCWHZJN2N4Q0o0KzdVZkZtbzcwQ0o0RExF?=
 =?utf-8?B?WXNTSVNad1o0Nk55bUd3TWFLZnBvRFhCUGxlVFVSUzRjQTJ3TG5OTmladTRx?=
 =?utf-8?B?T1BObmRaTllESTUyQUFkNXJ5cHRsaEZNcDJoZ2ZuNmpINFhrMnlLZ21Pcm5v?=
 =?utf-8?B?bktIVzR0bHgyVTA1WXZlUThZd2N6eFZkaWFhbHdGNGdGS0hzZU1qcHRuOEls?=
 =?utf-8?B?bnhENjZYSHd4Z0ttcE9jcVJNanJqR29lUlRsYjVGTGpWSGgzVUtxYWFOZ2J5?=
 =?utf-8?B?Ym45bnd0OCsyOGx2cCtRcGJUVFRETWlSRjhsZ1RYR2dwc2p2dlgvM2VtbklC?=
 =?utf-8?B?ckR1U0ZyU1dTSG9hSjdpaXNzWlFFZWNiY3dVN3M2NGlEazA4bTIreVY5blVS?=
 =?utf-8?B?Qm5ubGR2WXNvWWRzSVdKK3RUbjIySVNGQlRZTDB3RzFDU1hVbnlIV0Z1bHo5?=
 =?utf-8?B?YmtnelJCY2xrd2grWWVHaHVXOTU2V2trZnNYVWNybzdvT0lLalFqTnQyOWFi?=
 =?utf-8?B?aXpQWVhTTmdCZnhhQVAydWYzeEJWVVd2c2NEUHFZdnE3TEtJZUIvQ0ZtK3c3?=
 =?utf-8?B?YVh1TUVid1RjQnFUMDVQb0pHZHdaWVJHRWNuNERiUHQ3SGlxZENDeGxVTzRN?=
 =?utf-8?B?bW51YU1WMkFaMCsxaTBvcUZRWjB3d1VTUGNQQWhFWG1ORjVvSG1SbTBzYWsr?=
 =?utf-8?B?UGlFdUwwNWZkdFlKVU81a2padCtodytCd0wzR2xweTVaazczdkVTY2g1VEwr?=
 =?utf-8?B?VWNYQjdrMWRWai9Ec1liTjAvMWNRYjNZcFlCRXZNK05EUkZiN0djRGx1WENx?=
 =?utf-8?B?SVNmVDhsNXU3a3F3REh2UkRFcUlMMmdPYU9BbHI2KzlBV2pZM1RDN3R5R2Fj?=
 =?utf-8?B?M1F6emNBd05ubnM5VmtoaHdOa3E4NmRWdjNlS0w4b21XMHd1MjBZYWdiS1Za?=
 =?utf-8?B?TVV3RHkzNHNFQnFkRUJBWG9VWGxrQXBTTXhYWnRNL0IwSGh1ZmRaSWtTL0JI?=
 =?utf-8?B?aFZRV3pmWVM2eXBiQkVIaHcyeTc0WEtqY1Q1ZkJJQXl3T0dLUXRvbC85ODlo?=
 =?utf-8?B?NUlCY1RaMW0yRjJ6bGFqcXZLa2hRa2pTYktpY0dPT2xzYnNkZm5Vc0YzNXFC?=
 =?utf-8?B?RDlTSlRicFpJOXlPNmJVQ0VyQStvaEcvTHdrVmxaWFJmM3BvUVlMeWJqV3pV?=
 =?utf-8?Q?6y1jFd/VOGOg0deY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36bc9ff-d5ed-4231-bcf5-08da337d16a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 18:35:57.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C8lB+2qu34hzXpyPwDzVkfW6iGd7gw6C66mu/jIbdV5o8hw8L94IJd6mFFQhSzfAa7jA+XoqZS10D8GuUYSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110081
X-Proofpoint-ORIG-GUID: f3U7EkcZnDHMIJ191mb_g6mND-tWQiqR
X-Proofpoint-GUID: f3U7EkcZnDHMIJ191mb_g6mND-tWQiqR
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 08:19, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> If memory_failure() fails to grab page refcount on a hugetlb page
> because it's busy, it returns without setting PG_hwpoison on it.
> This not only loses a chance of error containment, but breaks the rule
> that action_result() should be called only when memory_failure() do
> any of handling work (even if that's just setting PG_hwpoison).
> This inconsistency could harm code maintainability.
> 
> So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.
> 
> Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/mm.h  | 1 +
>  mm/memory-failure.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d446e834a3e5..04de0c3e4f9f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3187,6 +3187,7 @@ enum mf_flags {
>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
>  	MF_UNPOISON = 1 << 4,
> +	MF_NO_RETRY = 1 << 5,
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 6a28d020a4da..e3269b991016 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1526,7 +1526,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  			count_increased = true;
>  	} else {
>  		ret = -EBUSY;
> -		goto out;
> +		if (!(flags & MF_NO_RETRY))
> +			goto out;
>  	}

Hi Naoya,

We are in the else block because !HPageFreed() and !HPageMigratable().
IIUC, this likely means the page is isolated.  One common reason for isolation
is migration.  So, the page could be isolated and on a list for migration.

I took a quick look at the hugetlb migration code and did not see any checks
for PageHWPoison after a hugetlb page is isolated.  I could have missed
something?  If there are no checks, we will read the PageHWPoison page
in kernel mode while copying to the migration target.

Is this an issue?  Is is something we need to be concerned with?  Memory
errors can happen at any time, and gracefully handling them is best effort.
-- 
Mike Kravetz

>  
>  	if (TestSetPageHWPoison(head)) {
> @@ -1556,7 +1557,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	struct page *p = pfn_to_page(pfn);
>  	struct page *head;
>  	unsigned long page_flags;
> -	bool retry = true;
>  
>  	*hugetlb = 1;
>  retry:
> @@ -1572,8 +1572,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		}
>  		return res;
>  	} else if (res == -EBUSY) {
> -		if (retry) {
> -			retry = false;
> +		if (!(flags & MF_NO_RETRY)) {
> +			flags |= MF_NO_RETRY;
>  			goto retry;
>  		}
>  		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);


