Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33D254AE69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiFNKdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355512AbiFNKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:33:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1B47ACC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:33:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E8sSrd016107;
        Tue, 14 Jun 2022 10:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JBlQy+ACEc+6Q3+8VDP9gTM03mBrBWFR07wj5D8Ed7s=;
 b=lfSgF0pi6nVxp94Ns8DRfqCtnV66spJVsqVSQun//guJ5/OKT3DjNskVMEUvUmaRxp95
 ykpm+UIw4EV3A4wume6cwfFZJFm/YVjKuc7sf+PoCfl5uVJXWkfG6726SRN2hkPDeWEV
 kQbUvRoOuC8hAJ4RYqkh/gv9Wzw6REs+2vQgmeXzicbGimdmbIU0iff6UJDVYULBHzhB
 semoAQWsXOmuUlGCWbw8VaD/i/abCCYK3yVh6YQvP6hpv0HTJLRehGGCBP5kNT8yKJcX
 6gzpawjcVRZfvblZ0pnP1+rGDjDOlpZZEm1OvYw1Tqm8qAQC5R+fxNgE63jmH0BJXEQB gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktdf4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 10:33:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EAQMGa036168;
        Tue, 14 Jun 2022 10:33:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbqgfrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 10:33:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaudodZAymnZD/tjHMOiEFis6WdPHNJreqIByZCRTMGwiZ25HCg4Njmvn7ebvO4Trn2pr2oZ1WlDwhMQGkzCKfTqS8ZOovfeV6GXfK6fFfIR92eMtkBAgD9x816HSAVLXRokqk7PNGiGQxMBxNzjakK+fIz81KYGvq0k2iEnArdOtMzzcdR/3CTV/48RHkCUMK925Ui/7kihNzQqn2EcqpZFnM6OxyHm1yVskBgMaz2dhYhhzuU1HFGf5SGk72B470sAo1Mgpnbp7WeIAN3lkvIcklGUWtlpsqLVf5692pNfbo30JbQuBjPTTJeGxBAdlVtkH7UIYvBnDqnPkMoNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBlQy+ACEc+6Q3+8VDP9gTM03mBrBWFR07wj5D8Ed7s=;
 b=dqZvrKM8WszDPsQaKvH7sXI9KYcZCWuYR7QCqrZYdfto2Jb9z1dLHfHbWUwJpVFDlAjDviiRB26O66VGrqCmNpXJ5//ctVUNWJu3yyE0PWuqZyxADlTOPC5589694yo8FYQ2nSWUIDXtvFgUSXa0qQa9l0yG/C7irnotqXMGgYDRS4NDA/NfGaMpfAdvQmM6AUHPnUxV3kJnV9eIkpDgdN/7txVk1ueH8DW4Zw1YwW2xvViPqdjd6Chm73J7B76Rgt0CEnWvbStDOwD++3AqHugpUV/EKxkSrjO/VyWA11PM4KgUogOfau8oszlyXCit+qIRmFfA4po4skYv1SuC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBlQy+ACEc+6Q3+8VDP9gTM03mBrBWFR07wj5D8Ed7s=;
 b=Zr1i5XeMKsnk6U26x7NxbVu0Q0Ugo2ulSIQ9a2flWgzUniYWgrqusgvGdZdIAjHIqNH5Nfa2UcKyCnrdEELWEztV0COJKkHTmF4hn3J9Z4WhR1u6HhllKTTAA0XiT4NwLe4ihXTasWAed7W9vrTzoV9sqOXCaul6Gu0rNc8tXCo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 10:33:06 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b842:a301:806d:231e]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b842:a301:806d:231e%7]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 10:33:06 +0000
Message-ID: <17807dce-0894-08b9-d53a-55e3696d6c08@oracle.com>
Date:   Tue, 14 Jun 2022 11:33:01 +0100
Subject: Re: [PATCH v2] mm/page_alloc: minor clean up for
 memmap_init_compound()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220611021352.13529-1-linmiaohe@huawei.com>
 <YqYJ771HRncznTy1@FVFYT0MHHV2J.googleapis.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <YqYJ771HRncznTy1@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dffbf19-94d8-4800-bea3-08da4df144da
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB15669E5A09C32DF03E4DCA99BBAA9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/Ukkdgmax6i3Ryn86zXJzWeZRr7MUr20ARJbJhogzSWz1rPWxrbdnl3xgmrX0e+WBS4kp/S2rPi0wmHwU2RqOOfYsmTmunlXUaCkWLzPYey2g4azrlgYA0NwYxSVp1xGFHEWBwi+ldWnbrpKtWHk5YvGGg+/xqq67k1OCZgkVY6v4MKaouWk80Ov8YT8BGfRP64iZR7xu6ahoGo1q5Qc/SuF1L0RNtJz3wrmWRVqUjXa1N/lUy/W00iBpZzOyZMejjpc4tlueyBl29t2ABUk9A/QUtGgtc3eZk2eRz2EsdPc1A5Pgj6+BN9zMJwtPSZVcRsb/Azz/ZdGhdOOId5qBKla5P1CH0l4JX/me7bv286iANdm09dA5cnXUKojlMb6qPkVKnziNEHfdAxheIvogq01zLqVMTltIDZKTOLQgJKE72FFHgWeA+yKYcLz4JtpuLM89U5+kwvFb4v1/xstqx5PivhuvGUBYbe3L8tLwEl1GF6p9W82yxL0NrONVhp1r5TjXDL7V/DuYROjprEn5zAHEmeLt/nlO3wEeI8zEkPnkiAyFs4FP4tjyF0mOjdTi6HY4cW4/Yn1MOOyJrPCiC7c4HG3E8VC2X+TJY1npZbgUqFs9b5CLwbNOF0OUGuWzd+81NFfmMHolt6p8oynnFsNcHuKQm3wQNxiKWh6n3VZ+D99E7LLnIcR7Ff0EcKA2nHWxnn/ao9A7/xZmOMXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(36756003)(66946007)(6666004)(6486002)(508600001)(8936002)(110136005)(31686004)(2616005)(4326008)(186003)(53546011)(5660300002)(6512007)(26005)(31696002)(66556008)(8676002)(66476007)(86362001)(6506007)(83380400001)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEVzZERORWVheXc2OFVMYnJ2NDUxc3lpbElmaEZIV3NZa05jSWJrQS9oV1Fy?=
 =?utf-8?B?bFZNam90anlhS2xHN1VnK2hBNkV2Um5Fc3cwbkRDWU4wTW42STA1U3RCbXc3?=
 =?utf-8?B?THAxalVNdGNLMFBLYnNGNys5Wk9jQy9QSzFBeHB3QVI2cTZoSGJteUxVU3ZS?=
 =?utf-8?B?YXYwRjhQZnFpUkJGbGRQNzN5YXp2YWZyYWZlUm12alZRZGcwRnJIRyt4Um5O?=
 =?utf-8?B?VGZKVmFoUkN5YVB1dEc0azFmZ3pHaEx4VnU1M3FqUDBJcEZGR3J1MEE3N0p3?=
 =?utf-8?B?dWo2RmNneEtWZ1crMWhFYzMwVkxjUkNkY1FpaXg0dUNMQW50dUtUYUIyZXZr?=
 =?utf-8?B?WlpKK2xxbS82dVd5b0l4cExLL0Z4b2FNVzZEZHFYTytaRWhJVXkyYmU3ajZR?=
 =?utf-8?B?bFhxQy9pQ2QvTFJGTWZSbXBIYVppT0E0ZlptK0c2elB5NG1ub3QveUl5WUty?=
 =?utf-8?B?SnNNYU85ODZlSnY0YllnOFdLS1hGL3kwTFpLQ1RMK3pqakZTbERsbGhwR0o1?=
 =?utf-8?B?N2s4Q3VBamNjZTVkaEtmUTF3VFNCUzhaZWp0K3VYL3htc3ZtaDBzSjF4bTlN?=
 =?utf-8?B?K3J5dXUzOUJnSlM5QzlhZXpqVWVvVnBtWWh1Tk1pd29QZGNlcTZUQlZyYXpU?=
 =?utf-8?B?SkhHUE8yTDRsUE1tOXg5UGR3S3RUd2FXRjA3cFVJR2xVckRGWkNwZE95YnR5?=
 =?utf-8?B?bUxwWnhrNTc3a2MvZnJ3U05JQUZJdHpuWDRwS2JUemNIY1FJOUgwTnNFT2Yy?=
 =?utf-8?B?anpnOVE2aElKN1hBMlFTQS8vbGRMdFc0Nko5RlpnWDE5NE5oSzA5NUpOQ0NN?=
 =?utf-8?B?S0RqekpvRFlSK0lXUDBlMnR1WTlTZVZZRHpveW1Bc3hEbG82OXk0Rm1QbTZJ?=
 =?utf-8?B?enBCRXBCcHVFY1hscTRiSS8zMkdDeVRHSFdvK1A2dGd3MjczZXRGUWZmcjVz?=
 =?utf-8?B?S1dOdFhvbUp0UWRTdk5GTVEreERYdlFGYjd4eDhoOTdDTHJTVDltN3FiSDZM?=
 =?utf-8?B?d2QyYnpUdUg3ckxrUkV4eWNpUHloeXZoektNRzBWSldZNHBwUHY3cDFrQTJB?=
 =?utf-8?B?UWVJNndxSTlGRWJNUHFQOWVRVzJoSWhHbysvR215T2lnZHBSbXllSDFncC9Z?=
 =?utf-8?B?NGpXcktUSnlCeHRNTTE4WkhvZno5SmVqWEdyUUxtN24reHVXZUpKVDZFQ2pr?=
 =?utf-8?B?UzB5V1F2QTQ1MVVIN2xzd3Y4bzltczk4ajRERkQ5QjA2TzlPWjB5eHR0ZEcz?=
 =?utf-8?B?QnJKTGpITThsZkJDVE1wbGdHb3U0UU84ekU3MUdsbWYxMFIvNmNOcjZlUHE3?=
 =?utf-8?B?cmlCN2svOVVpOUFTRXU2N0RVQkhmejRZUnZnOFBsNk9FOC8rdVVPdkFzUDlI?=
 =?utf-8?B?VlJENWc2R3VGSmZ1U2tDc0hPSElhWlg1YjkzY3Mzdkt1UVN0Q2wydzBrV2V3?=
 =?utf-8?B?aldIM21DUDdzL0RWQTJPYWJvdEhqQ1NBc05ENS8vU29JOFJQZHYyRzlXZDA0?=
 =?utf-8?B?amVubElmenV0NXlLcXFFWkM4NEVtYVJWeGVJMXJ2MXZpYUVORGlZVVdoblhC?=
 =?utf-8?B?LzhEZW5LMU5RNVBlNFlVa052RmFjM2dNNGU2WkFwQk95d2I4NnA2RHhXNkZ4?=
 =?utf-8?B?dUs5VFhvMmFkSjVEN3cyYVN1dnVKUHQ3TytMQ3dvVGFheU5zd01weHhWWDIr?=
 =?utf-8?B?Y1ZDTXRGeSt2a2ZDTUNSakhLU0tMYXVjNTFUTUR6WlRscWdkcUhuTHpvd1Iz?=
 =?utf-8?B?Z3pKaTVucUJ0WjBST1VVT0pyUmtLMnMrTkJPOStNdEdGUmFlZlRGYnlmNVRB?=
 =?utf-8?B?SytYL3laREJxTkpOOXBCNFllNFp1cU9YUlpWVXRkMHNkcmVTUzZLc0dibFJu?=
 =?utf-8?B?eWM2UDR6QTdtZnpxZWZkblFLdWFMcThRWi9BYUlZU2g3dlZQbHBRRkZTVWJI?=
 =?utf-8?B?ZUJPcURyNTlvc1FqbkNOaGhSVlBqTnRSeTlrdEtTd29pK3AwdTJjRkZZdDYz?=
 =?utf-8?B?VWhsdUhzVG1CV2Z5bnpwYWg2UktWT2lxb1A4bjZoSzI5Y0hQVnBwdzU2QzJl?=
 =?utf-8?B?c3ozd3BuLzMyOC8vcjRCOW0veldobEY3L2d1cEp0MjZpVGZPMzdzWHVXMXlU?=
 =?utf-8?B?TWFQRXIxOTRFRzhDMXRQeXNTOTMwZmlDUWhOUFJyWUNDMURIYXU4Qy9aOXRy?=
 =?utf-8?B?am1OWHpVZ1NNOFh6bEpTQWF0RFZqZTc1U094RmRvK2hoZmtLckE0RXdybFZ0?=
 =?utf-8?B?S245SDhVak1VTlZYQVFEZW5ockh1WUFuVFlFaGVucm1jT2xCdngrOHQzblRj?=
 =?utf-8?B?WGFWQU9BemxhMURxdDczY2xKN2l2V1d6Qkx1OWRES0NKTUhBMW5STkZVQnF1?=
 =?utf-8?Q?luljmUoNPZhzWb08=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dffbf19-94d8-4800-bea3-08da4df144da
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 10:33:06.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a9fBLhu4PXBZQ0Db6SJamMYIHGGR6BGcLXExhErBulsZAGTW3uDRpb7TVDcAGzItd41hea/7wjHF+Czwdb9YjXUIIM0HFB5Rl3VYBsc2D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140041
X-Proofpoint-GUID: 4W0OiuTZWXw3fnkOlafMztiuMLyAI9dd
X-Proofpoint-ORIG-GUID: 4W0OiuTZWXw3fnkOlafMztiuMLyAI9dd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[was out the past couple days, hence the late response]

On 6/12/22 16:44, Muchun Song wrote:
> On Sat, Jun 11, 2022 at 10:13:52AM +0800, Miaohe Lin wrote:
>> Since commit 5232c63f46fd ("mm: Make compound_pincount always available"),
>> compound_pincount_ptr is stored at first tail page now. So we should call
>> prep_compound_head() after the first tail page is initialized to take
>> advantage of the likelihood of that tail struct page being cached given
>> that we will read them right after in prep_compound_head().
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> v2:
>>   Don't move prep_compound_head() outside loop per Joao.
>> ---
>>  mm/page_alloc.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 4c7d99ee58b4..048df5d78add 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
>>  		set_page_count(page, 0);
>>  
>>  		/*
>> -		 * The first tail page stores compound_mapcount_ptr() and
>> -		 * compound_order() and the second tail page stores
>> -		 * compound_pincount_ptr(). Call prep_compound_head() after
>> -		 * the first and second tail pages have been initialized to
>> -		 * not have the data overwritten.
>> +		 * The first tail page stores compound_mapcount_ptr(),
>> +		 * compound_order() and compound_pincount_ptr(). Call
>> +		 * prep_compound_head() after the first tail page have
>> +		 * been initialized to not have the data overwritten.
>> +		 *
>> +		 * Note the idea to make this right after we initialize
>> +		 * the offending tail pages is trying to take advantage
>> +		 * of the likelihood of those tail struct pages being
>> +		 * cached given that we will read them right after in
>> +		 * prep_compound_head().
>>  		 */
>> -		if (pfn == head_pfn + 2)
>> +		if (unlikely(pfn == head_pfn + 1))
>>  			prep_compound_head(head, order);
> 
> For me it is weird not to put this out of the loop. I saw the reason
> is because of the caching suggested by Joao. But I think this is not
> a hot path and putting it out of the loop may be more intuitive at least
> for me.  Maybe this optimization is unnecessary (maybe I am wrong).

So, depending on your setup, this might actually sit in the boot path. Yes, it is at
bringup/teardown of new memory, so it does not sit in a 'hot path' and struct pages are
cold. But it is part of a function that initialiazes a whole DIMM worth of struct pages.
And PMEM dimms can be denser than RAM ones IIRC. In my case we usually have 128G PMEM
DIMMs in our servers.

> And it will be consistent with prep_compound_page() (at least it does
> not do the similar optimization) if we drop this optimization.
> 
> Hi Joao,
> 
> I am wondering is it a significant optimization for zone device memory?
> I found this code existed from the 1st version you introduced. 

Not quite. It did not existed in the RFC. As a matter of fact the very first
version was totally ignoring anything cache related (i.e. just calling
prep_compound_page() in the loop for all struct pages after all the struct pages were
inited) until Dan suggested I fix that part because people in the past have spent time
optimizing it.

> So
> I suspect maybe you have some numbers, would you like to share with us?
> 

128G DIMMs /with struct pages placed in DRAM/ with 2M page size used to take around
250-400ms. Now once you placed the struct pages in PMEM those numbers go up to 4 secs all
the way up to 8secs (there's a lot of high variance). Now imagine 12 dimms and those
numbers can get in the ranges of 3 - 4.8secs for DRAM-struct-pages, and with
PMEM-struct-pages to more than 48secs.

Note that initializing as compound pages brought those numbers closer in the middle
of the interval given that we need to do more work other than just initializing the
raw struct page. With DRAM struct pages with the vmemmap deduplication trick (which is now
default used) these got decreased down to 80-110ms per DIMM. But I actually got started
with numbers in the order of ~180-190ms per pmem DIMM (ignore cache effects). I should
note that I haven't measured /exactly/ the benefit of prep_compound_head() early calling.
But the other numbers help gauging the cache effects in this path.

Earlier (in v1) I merely expressed a minor concern. /Maybe/ this matters or maybe the cost
of prep_compound_head() outweighs the cache-miss avoidance of the succeeding two tail page
cache-lines per 2M page. Well, now it's one tail page. Nonetheless, I would expect that
this is part of the testing the submitter performs, given that this is not one of those
'no functional change' patches as written in v1 commit message :( Should that be the case,
then let's go with v1 as that certainly brings consistency with prep_compound_page().
