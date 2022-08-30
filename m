Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CEA5A689E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiH3QpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiH3QpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:45:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6C17E2C;
        Tue, 30 Aug 2022 09:45:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGhQ5o009124;
        Tue, 30 Aug 2022 16:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=p1/9OdMJkHKBjNVsPJ6bd2AUK4eNIxF24jClluphnsY=;
 b=jiBxv1sJMiTBNfHnA6fKVg7onLm+Qr8lKvbyHdsmjbuOGW9utWByP24Y7vNaZ5h5rCZe
 6YiH+PNZd5NEchd9/U56uivGqhaEfPPxEOAZdacojKyt4l1az5EYhpGpVTFOHz55SLch
 O0A2YunM+VTAIF03iJx21MNw/YefW2KmVi4OSK+AbkSyZjWQwoRiIttjOLPjnST6AiS0
 sTWNJ9XKgtInC/BzE/uEN2l8qwcSXavRYJDDO1cy9WDVOOhjBjYfqckq7gwjbwtcndr0
 XFp5AVX15yXjBesWy/HkJfJw7sZWCwqkT1ZEMjbRoQ/Czuywjzect5CYqKJG6pTDLkpg 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt6wgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:44:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UEPrLD009503;
        Tue, 30 Aug 2022 16:44:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q45p0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGtG5KXHHI3hk8Xs0oMh0bpZPu5hPvKih3ItNRXiUb385EK2Z3K8OFv0gklLwog2DQr1xmvtEaWnSojIuvHr5hFEVCaIKG7AwP2pNkRPx4jvPAiSz81nTUMpbB/STUfu4NqajCI1kDDkJ76NDSbnPrSnKO7HpcVS8tE/K6ImYY4lqBch5RfbKsSw8S+2EzW0/9YdifbfNzTk3DRO6gP/pzmaDSeYnyM5tZbm0qIMGuVEbHgLqFahQHuYomUesmG6QWqUFbrUCrkcjhWDpTeZYcHrTRKWdiScw4tL4JPKU7hkWCoZE17JDICInbJHuQap2TRFdqh9eKvXgD5bcGzNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1/9OdMJkHKBjNVsPJ6bd2AUK4eNIxF24jClluphnsY=;
 b=mp7GzADM6/ojVMePPUXFNAmwEWKsmn27iOwzYcB1uxY2Sgm2rCylTEJOZK3Fn/yUMYynYStInbXky06c5LZVUDyyHZw9BkGWjdnQSsOErur1pO1uVgjRdgqZxeDTsHAQTV3T5UQja63NPI/NhvDOEazfOo1SRmzSVd+JFPn25qGzmGTUL183yeCRVubvxzf+7jSpa0h2suFA2IXs8XaJbLuw8jvgw0s1gbQDuHXey913I1kxp/Q9FZPHDYkSnUoNVKl0Jb/RjdIscDJaWWV5lxBD7AFfP5ZYnE+7xwobQaeobO8+pRPURVeNi8OCsG1VNaLMd8Hl95uIbAwZPA5K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1/9OdMJkHKBjNVsPJ6bd2AUK4eNIxF24jClluphnsY=;
 b=OFUXKaaoGFIPLsAv5gy5Hka1EkqDKONZ92Buu/HMKi+yvX2k2sfONZMgaFVHNwO9UKwbVaTyEdrqHJQksJA6BMcGgCHgQP0elP+6yHxD/Y1v41b4I4KI6DlSPupApaOpSA3XqnugG9XiT9mg1ClJWA/e3toCpJT9cTavKJb6W+w=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR1001MB2204.namprd10.prod.outlook.com (2603:10b6:4:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 30 Aug
 2022 16:44:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 16:44:22 +0000
Date:   Tue, 30 Aug 2022 09:44:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Yw4+YvdS9kJUnx1s@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <57c8f032-e48a-bacb-7922-3e2cc10dc0d2@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c8f032-e48a-bacb-7922-3e2cc10dc0d2@linux.alibaba.com>
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27612682-7efc-4f21-90f8-08da8aa6e3dc
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxxyzY4w8IvAJqHACklZ1Naf3nXpcUY7qY7yV4nbhZUB46veMwDvE3Oo+VTQ8GM+CaIVW1Lmteq1hey4Ur1wHi7KpHYQgP+cznPgVaLLsP4A1hjk9aAWnDgcSBatjWnbL8zBBrGSiNI6f6NnDlYvg/8eO+r7Tx1BaHOSOrk8vgRyZhbZLRPshFBwo/K0Iyn0UIsYuXUHH4Chj1M0B7TS6KRd+mBWlrMMhluN+OtfEqJ6DVgL38S8IIAZYw7t4U/1+9jCmgNHP3TJTcrVz/ZK9WbnbTqZ8k+CLcZiw3bKgX08Df/A/iAx6wouyaDdH/cR8zFsaTjh2aV49y7UeaguuKezLocCOqTsJQWa2Gx1kad1B2yOSzEy962zf5mqPg0k2beXMfyAuJu54c4KycpsIl8HL2CRx15jGKAdClDuoqcYzoyLydMQPIqScSWGeXfPyCpT++ATwWXNMt8QWX5nMwMeZXVs+7j4YlisJFYY2aw4pNJ5Gh9qvk89EmGMkyic4FQwAIzDp988Jyog6TSFVPHfdQM1wIVNc6vgV4FqhLLEgdgAggey9ySj2YFzU2A79mNSuMib5JbojSJ//to0Xh5qDp6zx5LOtnCENabU/1gBSsGSo3fz7KcT3AIhO8DUoS7uV+HhVXzfTVosWrAHy9de3pm4wK3XTPiPlc7M380w+9TAmPMPiKpTQ51BbzMkEDzgp48NHBxYVDN2mWl5+7ggFyp0lgVVRb6WoAT21SMzxxYwCSR/047Pc3+ouNth
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(6486002)(86362001)(2906002)(5660300002)(9686003)(53546011)(186003)(38100700002)(6512007)(26005)(83380400001)(33716001)(6506007)(4326008)(41300700001)(7416002)(66556008)(8936002)(6666004)(478600001)(6916009)(66946007)(8676002)(54906003)(316002)(44832011)(66476007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mmFTYh7ptGHWdWZai2pRSfAF8mIlzc9kkbMRTzwcypssync6SpD1MM06Lzl?=
 =?us-ascii?Q?roBvHI+G9o4f8tsR6wRJkYx0mw38MjIvcv1oN8k7Cyr+qjtmSDwYv+Vf34W0?=
 =?us-ascii?Q?9vRkF2y6MNUokVxDHk1N/rmwhXJme17t3LjdcLT/4yV25359Z+vNSXUWdEnE?=
 =?us-ascii?Q?HoRYFrPTx9SpuqTQSu/T805LBUAylzM3OqYYcmcpmlg+3AEvgS9WiqJeH7eB?=
 =?us-ascii?Q?cnCDhiAg7DxLTm5he+HRbNCuH2V4Lt3dyZ/JmPkVkIAFJ+6+Bkr9sKWKUS+Y?=
 =?us-ascii?Q?D7d+GonToesGQmhAY4q9B9g1sK2h6E1b4QvuBV/D3WNpwhwiijH1qzO7V+et?=
 =?us-ascii?Q?VkH3rqgX/QCFaB1VTccN1Uicx+zmhqCPWpGGOP2s+QjvnAkNZx/ao9oOmrSH?=
 =?us-ascii?Q?yfjZMfIvEKs7vUxM/+w/DW+Z6417nUPICSNBX4eGE46it/sy8h6/yLGIeeBy?=
 =?us-ascii?Q?97jQlqG7M3KdpByRFy3+TYIuED4crcUfdcL6UOnSOD5Mc24GtpeLFS1AdPal?=
 =?us-ascii?Q?DPbl6kRfWHDkwX5gvJIj2LX8CIvrRlSgONNYkl4sz5c/vDiZdXJ+MiGor64B?=
 =?us-ascii?Q?Rv8z3EXMkJl8onXwhKyGHEUW52eXRsBOGuXs2S6cnFNd92lI6nhHq7rc5u69?=
 =?us-ascii?Q?+p7+3LCG4rhpkfUV1XOxuDSCLmHWE/PUPp82TAR3Qc+NQxuwJH0VHHXudKB+?=
 =?us-ascii?Q?XqNs2kWMO8m5D0jMXyWRj5gg+EGIX6kLk+W57FD2Yw+HZWSS/hYMosA9OoA5?=
 =?us-ascii?Q?mx5GMkuyq0kHlQeOGP+6rxtoyZEPqJsPAhjeoYi1riQ9zFsFFPkW+aGQqUB5?=
 =?us-ascii?Q?MUqrSwMQS5mTGlwjOhuy/lUp+TwVajE8GklgSL/Q+216fqw5kp1v6sk62OeH?=
 =?us-ascii?Q?rRNvWZtAKjYvkcIcmcdmZVPnNbo907ZrcW5sgSuyxBAEs64X9e9jPmdnAtrc?=
 =?us-ascii?Q?t1C900l7DPy647mPRQEXktlrg7Wo0N+GqHH7ssHwsl96wJUufueNSy7bBbIN?=
 =?us-ascii?Q?e6+sgyzqnXWQ6njg/HJIho6X+u3tZWr4L6OkCKoNl5XZCTOoH/k+6TQ9W3D7?=
 =?us-ascii?Q?lPCTkkhVFgSSws79TmBprelKY+sk4uvveECA5zPyDDbrpYguCxE0YtmbzrhB?=
 =?us-ascii?Q?oSAZN1h6qACA/gKWScU1BXNLQZ2pFQ6JU3X868f8AXIGtdQEhqDvVmS67rAC?=
 =?us-ascii?Q?GL1f3Y/Vd6XlKs6wOdsUWcWXdwzDF5RR4kh9AG/0l4xIdZRT+9f8a1r9NGqO?=
 =?us-ascii?Q?aPSKhnLECPTYaRI3iazY1+v9XvU7fVtVxTbEe4n0cHiVDQGthKE0R3mxy6YW?=
 =?us-ascii?Q?mH2qSIrv+rVb6lOoejF+tHvsGSan00YeqcfLYQl31IkXEZrCe/y5mbVXHrB5?=
 =?us-ascii?Q?Z0qdTx/+YcA0xfPjrvXcBbd3gFHst2cSU3wajXyIbkB+TXNMpkPM5PUR1J5V?=
 =?us-ascii?Q?4oa+Q8Z/FtotEGjJF37Segwmy2uiiwgt07nSSpoqdfmXM8I1ISUnv5dsk5nF?=
 =?us-ascii?Q?B4Rej70q1aMwqttwmuQl2R0R/gHKjZBdb0/msSM6o5DoPsPXkmh5r0C7D6ra?=
 =?us-ascii?Q?tP77PsmeaHXH1RtyRlg5fOHNtZpXtW1VJhAgCIi7FiGM6dezgPL2UNoKxYzP?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27612682-7efc-4f21-90f8-08da8aa6e3dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:44:22.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq1LOzD2XK6nUPVy9b4cMCCFvt431yiTg6dXnJtCtqWcnp8L3hI/7umQTJss+Tg90HS+UcN5KGdZ9a0csYdVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300078
X-Proofpoint-ORIG-GUID: cvCUyfUL8KlkvdsZZOA0Vcc3iVXldCEm
X-Proofpoint-GUID: cvCUyfUL8KlkvdsZZOA0Vcc3iVXldCEm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 09:06, Baolin Wang wrote:
> Hi Mike,
> 
> On 8/30/2022 7:40 AM, Mike Kravetz wrote:
> > During discussions of this series [1], it was suggested that hugetlb
> > handling code in follow_page_mask could be simplified.  At the beginning
> > of follow_page_mask, there currently is a call to follow_huge_addr which
> > 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> > a follow_huge_addr routine that does not return error.  Instead, at each
> > level of the page table a check is made for a hugetlb entry.  If a hugetlb
> > entry is found, a call to a routine associated with that entry is made.
> > 
> > Currently, there are two checks for hugetlb entries at each page table
> > level.  The first check is of the form:
> > 	if (p?d_huge())
> > 		page = follow_huge_p?d();
> > the second check is of the form:
> > 	if (is_hugepd())
> > 		page = follow_huge_pd().
> > 
> > We can replace these checks, as well as the special handling routines
> > such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> > handle hugetlb vmas.
> > 
> > A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> > beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> > existing routine huge_pte_offset to walk page tables looking for hugetlb
> > entries.  huge_pte_offset can be overwritten by architectures, and already
> > handles special cases such as hugepd entries.
> 
> Could you also mention that this patch will fix the lock issue for
> CONT-PTE/PMD hugetlb by changing to use huge_pte_lock()? which will help
> people to understand the issue.

Will update message in v2.  Thanks for taking a look!

> 
> Otherwise the changes look good to me.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
-- 
Mike Kravetz
