Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B95A3224
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiHZWkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345345AbiHZWkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:40:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD402FFE2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:40:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QMYHwN010688;
        Fri, 26 Aug 2022 22:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=VkUt+sc/XfQwApt+RmsY+dubJp/82jdi/kOR/cVwyew=;
 b=tPgOQyTzUwvzSuFMNcf/iOX4h+XHC6gdYmvIIYicxcEi8LNGzlC6z+aYGz+PUACCcD66
 3gugeNao58wYdMbN3/R94c8cXcOoaNNmyUnOn0Ur668RG6+uWTCUGIsYZOGkDJkXYvVn
 Lxz86OxTqg+TdFkSlNpSAaFl/EP3ojdDA6H73HdR7fKBfL0jPYRq1Roe1LBE17Wy5Klu
 XU9B7F4cNOFiSWTNxK53vaCWOmcIdY7G+UN1PCGFa1ZSFVeE6X4he96tn+PG3UoxMHGD
 HlJ3jefeHIRnj69WVhwsX0ejpu7pHcb/M8e4RgDMUpy2ip/OWQuMVedR+dr1JkWjU6oc Yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nyh305-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 22:40:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QJxWXv018950;
        Fri, 26 Aug 2022 22:40:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59rhf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 22:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO2lrpGVXDGcoFgsWqmpMZ4tX7zqfYhy/N8+uewezGBMit3wdKcEyrQPU3S0esLUYS2903JTwdyr7MPUVf5l4o5GjOqMXs6532eYInHxHVWTIWx4oWtLXYbCw6I+IvFzpUbnyWYwjS0o8qoyWhUgJrp2QdnLNRDFRrAi7sHJOFKpwkHnKRePPaS2oFHfIozJFF9L0YFC54hpbjftamiFeJEKzfpvqfGyVAU5Ys1huYtMmus+u2qs60P+Hm8U6wChjWMseTUlrTR9x2tfE+6IJJTIqAN7qozRJNgihrtzgs/GTWlDckTqQhFl1mL59YVMldmoJVmWEKeb0EBMdbBgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkUt+sc/XfQwApt+RmsY+dubJp/82jdi/kOR/cVwyew=;
 b=dVYjkCk/j3Bw8DZrzDYPtjx+3jUdpjPJ6H794lP1sRXCy+Ddyts5NvIK85fYBAYpwDBHBTMcVrxJzc9wsgy9RDZX5bI3iuJhpd74R/8BRkVVYttchaWpfHUuN8Jq2bujlWnbzLdKd148ZJAtLKV4ureXizJcntp+jXZYOxPblEGS4ojwk04/LLR+kLMXV4Qi8tzl715J54wucJYi65xGwaiQW6Vkf+d7rKvw09NkWhEtaDU8ml5GE+jV013Ywgw5JiX672cUxv0MVl2AKqYKqMBeSbkFcv45nzXEIRgro6rOM72AjFCQN7lUC0oiTyJ0YEYYAVaPOzkHCS3uvMiOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkUt+sc/XfQwApt+RmsY+dubJp/82jdi/kOR/cVwyew=;
 b=dzCzgQrpcpPPp9MFqHnVNpSFmqEHcNunvi9aIs5ay+xUfRrRxBjxukeQTnsDdSdWdelfhUYiyGwetE1OLgOIAhlq7aopfnuYq4hXNjDNEmIxz5xK/tzBT7kixM5eNinFLH3ol4RrCbK3CGLfRPcbHnk3ZO29IQO+CqUpAeBMqm4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5456.namprd10.prod.outlook.com (2603:10b6:a03:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 22:40:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 22:40:28 +0000
Date:   Fri, 26 Aug 2022 15:40:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Message-ID: <YwlL2Wpos2QBM8o7@monkey>
References: <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
 <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
 <Ywfl/HIeO/ZbwYCg@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywfl/HIeO/ZbwYCg@monkey>
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a1a568-9fdc-441a-71e5-08da87b3f956
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5456:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WIFY9Gq3wTb8RaoWHzr43vdiz/1BZCDlt368+MKs0qbvhdXMXUL79l64YkSUpTRZnEx7dJM8cYw3z9nassQ9IeOKhbr3tmXMsS2MCOYG6v3E79uQGgTTEfJ9cZ3eIhd0ya1injhR167QE+xlk/ZuPZn/Jayh9jTTUnA0iiVpIvE/1C8RRla+6zxpUhCrW9rxFyBYZy96I1BbdRwd7BCzzPZT/apTkD01SEzzo2wDZY7CEiKVDnmZtHl1WfQxwPaELjzIqy8dekJf0TJ0LGOH3T+Cnu8GdCZDbhE2H1cyjfhNK38npxsiD0QH4d+Fi3wAYD8M+svKefPh29U3s+vb142wAGKM68qsh4EJcLkOzk69NyVAMtNlc0wVeSPiYSYZaM/TtwhMWTxL6fwAiJKzxLc58Oa2Vq6JSUQHK23hxpzg824RA7aXdfn1dDmSb0gtMuR8Jhe6gEsIT2tv0BA7byjZrqK/jUcrdHiwycnRaknM1Tbt12Ib5HZ64j/cQLbOS3a6aUk8QLyo2A4CYKkdXmkjVxCK0HaFsKEY5AYEtJg5H9yLexevPubqHu19g5bnIKfTtrza5jhIjI5B76WkBkw3aI7N2x0QTWwT0IdD/gwCeEAlCSRKqpFGL/2Qxm4D8z/lfuMY9N/Sag7k2hKwpve0XkgXxP/QkRLcGGPgdJoJVGhEYF1lDYjFkTwP5jmeCHd9kbf5JQD3CCz0BpZnUWtypX+Khb50aMLa19bck0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(66946007)(83380400001)(38100700002)(316002)(33716001)(8676002)(4326008)(110136005)(66556008)(66476007)(2906002)(9686003)(44832011)(5660300002)(8936002)(53546011)(86362001)(186003)(6506007)(478600001)(41300700001)(6666004)(6486002)(6512007)(966005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tgFON9NpnO9i9AbJv4qMiJVXD2uiXKw68zfrsS45z7sBzy91+yV/rm89Y+9P?=
 =?us-ascii?Q?Tn2UNqtrELUwvc3PJgCapvmsWoCdKe7Yb2AjveutfpaCoaYbCiC63KMdp3FC?=
 =?us-ascii?Q?DxuKm2ACQ1lYX9re7Cc4ybx5AQ218ahqMTKvxdZLWC3eZfYPGnIK7ZMekQOE?=
 =?us-ascii?Q?c4/5v1fLs+pkp5oTw3vCyHpBdv+BU2vlwbAgjH34ETRhwk8kXxarr3/bI0jc?=
 =?us-ascii?Q?IaHci22NQaRZtf7upxKbjIRCzIX+Q1ErwgOvjx5L2CwjJiQGvm62bShPnIk9?=
 =?us-ascii?Q?wy3GgPGh5pwkdgyvjdL0MbhgV/RUhLhSozYze6vX+ysByq9FtbpUBMK2pnGG?=
 =?us-ascii?Q?otbYXUj1A/c8Z3dt/rax4sHOvzQjykBv/mx7c1iQruBeaBk+KBuRSC2cv/1n?=
 =?us-ascii?Q?8htNegh4nA927FpRIQi7190X7/yWbkAiKZqx8WVh+iUn/FlBB7Xj2jS2ERo/?=
 =?us-ascii?Q?L5SjrDJUG5RlS7LbAc6VACq22q/fvnWcvrpStcEw05rrglZBuz+NXBFVBf7V?=
 =?us-ascii?Q?TUDL1cKr41a4eMdjXGJwPU+AQddhqmjM/t9AtyNO5iSJGlR8LbUB2PDPKGXt?=
 =?us-ascii?Q?IFoqenMzg4H4Xk8vjg3JGu/Wfyu+iIWukGW77jXZNd8HiAfExs8yVgtqdWa2?=
 =?us-ascii?Q?Imtpg29DBoK0+FIpIZ9SED3IUeMfHBgIq4Jwl4z8Z2kW3U6xh8KQ92q5DbKu?=
 =?us-ascii?Q?hxZqKbGyN8IB5PI5U9FB6cs9JkN2hGoaR1ZKQ73XYeqITCpXVc7Xv10//jKK?=
 =?us-ascii?Q?eKGqpVzLcTfVPtPouo7YmqwEfH5POv0EJ/Ozu5TaGzd7XZlg1qKNeR4JZMAB?=
 =?us-ascii?Q?S0nyOxIn2TTrzO2kBxBc/Hw37DRKZm9AQnbTsZsM5DD5Abix4eMsxfFi7h3z?=
 =?us-ascii?Q?CaTSFIN09xAsY7/msULZAJaXXHj08yHXtRgmNugXSHV8ddt0I9VOOidNEDBU?=
 =?us-ascii?Q?2gFR3eaoadN1LDUG/YFNrGAjsJTxdz2NUmRpMcE8sAlXBplGEew7ng0KhFoJ?=
 =?us-ascii?Q?5stoCR6CUKQWULSdVuvMT3ANN4mcF6+OzkEqDkInRMnnCEO2J5qAia4UyQHo?=
 =?us-ascii?Q?wIeeD5zI3BV9PctlJNlzjh9CGfWxxBf16Zgjl2D77qr6tTAKyrTN+RB9mROt?=
 =?us-ascii?Q?KLWMmXaMaTOjyGys0o/xYi/AtkRl9LMl/gCc8niXmFznXvnhT2rxmd6dySxl?=
 =?us-ascii?Q?O3t/QdeHcgocN7rvLR1KiNtu8vIzxeScWNyZ7oBjdebwYFAurPHJ1ecoDFeS?=
 =?us-ascii?Q?mbpDSCPpqS98O486jMixjfRMCh3tlfMZvvFKujXW4Qfuhpu0aIM+ly6uSpDT?=
 =?us-ascii?Q?1GKWDgynHfyvvki4FXiGlDgwR3izfkUQSnb2rJA1/QzIuqEsUppCoQ6XkKTf?=
 =?us-ascii?Q?0TDS+cNDcXk/c/eseKPabSFKVcCTpfSQgCR0+BhSAfUgiSChdr3xnLvF7J+R?=
 =?us-ascii?Q?H4Ef/4Pv6tNHFMtghgvoBQaZOO5qFWW0BtyBvYrwl3G4nnn9wulqoNCRl6nx?=
 =?us-ascii?Q?mYykQ1dBUYiGOUZ29CDGPQF5ypgKEL662byAXdJJZUPCtvSojE01ivlarW/A?=
 =?us-ascii?Q?SdYYzM6RdXFtWl0W9XxyqG77Ih/GE1OOWvU9mRyrrkd+kuofkYwVUaVSoUJv?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1a568-9fdc-441a-71e5-08da87b3f956
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 22:40:28.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwZojBiX31U6ne7r7koaelzUDkuVm1Ii5sdkTpBo/bSFrMesPsIss2A4DPsgs0q0iEF4vFa3Xnb0Ok2FCl8pEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260089
X-Proofpoint-ORIG-GUID: NXB3HYHYWS2mWC881nkP0beh7kvAgd7b
X-Proofpoint-GUID: NXB3HYHYWS2mWC881nkP0beh7kvAgd7b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/22 14:13, Mike Kravetz wrote:
> On 08/25/22 09:25, David Hildenbrand wrote:
> > > Is the primary concern the locking?  If so, I am not sure we have an issue.
> > > As mentioned in your commit message, current code will use
> > > pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
> > > will either be the mm wide lock or pmd_page lock.  To me, it seems that
> > > either would provide correct synchronization for CONT-PTE entries.  Am I
> > > missing something or misreading the code?
> > > 
> > > I started looking at code cleanup suggested by David.  Here is a quick
> > > patch (not tested and likely containing errors) to see if this is a step
> > > in the right direction.
> > > 
> > > I like it because we get rid of/combine all those follow_huge_p*d
> > > routines.
> > > 
> > 
> > Yes, see comments below.
> > 
> > > From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
> > > From: Mike Kravetz <mike.kravetz@oracle.com>
> > > Date: Wed, 24 Aug 2022 15:59:15 -0700
> > > Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
> > >  follow_page_mask
> > > 
> > > At the beginning of follow_page_mask, there currently is a call to
> > > follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
> > > architecture which (incorrectly) provides a follow_huge_addr routine
> > > that does not return error.  Instead, at each level of the page table a
> > > check is made for a hugetlb entry.  If a hugetlb entry is found, a call
> > > to a routine associated with that page table level such as
> > > follow_huge_pmd is made.
> > > 
> > > All the follow_huge_p*d routines are basically the same.  In addition
> > > huge page size can be derived from the vma, so we know where in the page
> > > table a huge page would reside.  So, replace follow_huge_addr with a
> > > new architecture independent routine which will provide the same
> > > functionality as the follow_huge_p*d routines.  We can then eliminate
> > > the p*d_huge checks in follow_page_mask page table walking as well as
> > > the follow_huge_p*d routines themselves.>
> > > follow_page_mask still has is_hugepd hugetlb checks during page table
> > > walking.  This is due to these checks and follow_huge_pd being
> > > architecture specific.  These can be eliminated if
> > > hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
> > > that need to do follow_huge_pd processing.
> > 
> > But won't the
> > 
> > > +	/* hugetlb is special */
> > > +	if (is_vm_hugetlb_page(vma))
> > > +		return hugetlb_follow_page_mask(vma, address, flags);
> > 
> > code route everything via hugetlb_follow_page_mask() and all these
> > (beloved) hugepd checks would essentially be unreachable?
> > 
> > At least my understanding is that hugepd only applies to hugetlb.
> > 
> > Can't we move the hugepd handling code into hugetlb_follow_page_mask()
> > as well?
> > 
> > I mean, doesn't follow_hugetlb_page() also have to handle that hugepd
> > stuff already ... ?
> > 
> > [...]
> 
> I think so, but I got a little confused looking at the hugepd handling code.
> Adding Aneesh who added support to follow_page_mask in the series at:
> https://lore.kernel.org/linux-mm/1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com/
> 
> I believe you are correct in that follow_hugetlb_page must handle as well.
> 
> One source of my confusion is the following in follow_huge_pd:
> 
> 	/*
> 	 * hugepage directory entries are protected by mm->page_table_lock
> 	 * Use this instead of huge_pte_lockptr
> 	 */
> 	ptl = &mm->page_table_lock;
> 	spin_lock(ptl);
> 
> Yet, if follow_hugetlb_page handles hugepd then it is using huge_pte_lockptr
> to get the lock pointer and is wrong?
> 
> Hoping Aneesh can help clear up the confusion.
> 

Along those same lines, follow_huge_pd looks very much like the
existing follow_huge_p*d routines.  One difference is that follow_huge_pd
gets the huge page size from the page table entry (hugepd_shift).
However, we are called for a specific mapping (vma), and encoded within
the vma is the hugetlb page size.  Can this be different?  My first
thought is no, because the size encoded in the vma is use for page fault
handling.

This seems a bit confusing.  If huge page size for huge_pd entries is
indeed the same as that encoded in the vma, then something like the
proposed hugetlb_follow_page_mask should handle huge_pd entries as well.

-- 
Mike Kravetz

> BTW, I also noticed that the above series added the comment:
> 	/* make this handle hugepd */
> above the call to follow_huge_addr() in follow_page_mask.  Perhaps there
> was at one time a plan to have follow_huge_addr handle hugepd?  That
> series removed powerpc specific follow_huge_addr routine.
> 
> -- 
> Mike Kravetz
