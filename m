Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6B5A6F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiH3Vbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiH3Vbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:31:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD78982D;
        Tue, 30 Aug 2022 14:31:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ULV1tr031625;
        Tue, 30 Aug 2022 21:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RyKrtLSLhLozSGNMZerEsQfMnFxrolyV/v4VJ/J+MPc=;
 b=EbpJi55D51Srhl5EG5kLx/bxjsIdtDCv0fv7gkdtwE6/fX+jAihiV90vRb5qygPk+S8M
 /76QBEIADX28Fb/28uZYJvGbD33ip4y6CMVX1gWz4gnKEjjCBbd28CV7v5hCu9dn1Te3
 zncbjxa9Wm0H2KsfQzfWkyBI1xOE3ZgSbZGf94ATnnSqR2hxYEfB9PWwbQr5ohJrql9Z
 EoTrc0h1jWlRXngxGTyeH7fE5k3EY8uXgI50iAFRpa9kMFs6Gb4whssT3hSOrWle55sr
 ISh/2h7TtjKQtIP6MSba5VsL+CXdkUrQTmr1PI5kakoptuzCmeUjX8HW6xjmdpOb6pKz Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsfmrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 21:31:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXb4q027289;
        Tue, 30 Aug 2022 21:31:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4da26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 21:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlY9tJAwGWkfeIdfNVBosVJn1AB6KbHIpD1HNKspSjoymHtASqaii7ZDbFDzl9AKSFxphtysQVxi5TXtjLUHt9mDOaCBforGXm9SbE3mq+JeVxJ27FY9a6JSfD94Gheqsxdpy4sxig0rugtYrYCWFxKsMuFQLsVFnnoEzVRzx4h+cGlETUPGSI7sk4sxhG7zVjbdZq5XZuxH9hSqhRem5GahQy02KrrmdVudUaPyPTanpUVu1FDfxifbchi8o0YX172AbTQ6OV8h366PVO0BI1U/7FRmLKXjke2Wncf6zAyd8iE1GS2EBD/xS3n3ddiYWZJ8uPg6uBvGwVtEvjKn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyKrtLSLhLozSGNMZerEsQfMnFxrolyV/v4VJ/J+MPc=;
 b=fZBsRgwhvTvb7q+LbY44kha4deMaS1bCcEEIltjA7KzWFdBjDB9W0vFc8LYH/ieJJ0tNqzS6BtyA9cyx6/D/qUB4fc6AyuZ5jAYbrllJDp0TNTSx6KMdHgkSGkb0hY6vN4xTO3bB9CmeNzK+NXy0MCAat8eCNQU7Ia80jykR2LrWE6P5+rNDobXwdLqvnUmHUmMeabBP6Ddiyo7yeFrLNdHRJiKy/lnhNFdfLawwvlzH5rw0O5H88PT+OO5YbCUspWlSCjXYU9INFgoxUC7rUpTmy2DoNolM8uxYYE1HEC3fHB5nkL1rRgX/0WwZ8L80rwh/ssX0tA7t9fasdjYAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyKrtLSLhLozSGNMZerEsQfMnFxrolyV/v4VJ/J+MPc=;
 b=ORlnEmhm+1LQCcd3iCG1wr+QalpaDBsjoUOTRloG4k9h6Bc9UrB67Be0WRCovDnL2InMGeYHbweHt6v7sq8ugkwwj5iJ38q2Hh1dSEROX6Uo1jtPACni3J0eUeBKA8fdzmlSw1G5pG78wo9Qa4e1E0fG9i355NlH2LJG2lGtouE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 21:31:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 21:31:21 +0000
Date:   Tue, 30 Aug 2022 14:31:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Yw6Bpsow+gUMlHCU@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <608934d4-466d-975e-6458-34a91ccb4669@redhat.com>
 <Yw5AOZ/Kc5f3UP+s@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw5AOZ/Kc5f3UP+s@monkey>
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cba51f8-8618-4145-7f50-08da8acefb17
X-MS-TrafficTypeDiagnostic: BY5PR10MB4129:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJhIkAlTPuQ77PNl1i6bFQ2g37nPrqOg0hw4gHmo4Yphmx/QH3jd5PQKzhPopzaHeHOtjUKzDAQeG+o7HqTYdl743hpyZKi4V05sgPybRHNUa5BOIx70gmaMt7fIIzkELKZ/hrJi91AobCw3zkWDDx9V23XbW46dQV92epLGSEGmm3ELvps+HkOlDZCeRLnEqc60vx53HBgVcAxwiLBMnlWT8kIb35J36kjF9JsYb8fBXJl186+07Ay4VJeNC1liHLyXHHv+NzxhMU15/MY41ikQy6GWZRNUJACvpm3jvL1NV49c6tmW2f3QHEgiDbOlhbCfRCMLuMYrNwnIyeCsUa1SdC0DufmYO8BKjJ49tuPxYvVcBRzeQ1nwcfkZfgAUkCa7Q8YofvAS3wdoV+ODV9a9dU+48XuhlZlk0tBF4Cf91ogxz264iEbkJ0rT/ROfnfWjkmhi8No5ZJ1DF7JMrjNuI/eNs0Dr+XS8xvpDsDY3MSAcc/4aMHUcEzh1BtSF1opTJzvRmyKCjm2bnHpsY7VDfgzkd+g3gLlYkhIKI8Dfytnfk1EKrbM+urto9YezMGtC/RcRJ5fwkfpD1VJXrk/kLZdzsFFCWd9zdC8WWiVgtlT52BteLtn03MxY2/QDNoDWc96WkxSLLP7/UdqhJjQT8n0wt4940GrOkO7lS7tE998zO6cZociqJa+i0PgtEQ4o1WNkuyMR+joCfBJRj8qRuhgiLidqR4BY/mH6Kia9HGLlRW0DXiaP5eHotvMF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(396003)(39860400002)(346002)(136003)(33716001)(86362001)(66476007)(54906003)(8676002)(66556008)(4326008)(66946007)(41300700001)(478600001)(6486002)(7416002)(5660300002)(8936002)(38100700002)(316002)(6916009)(186003)(6512007)(6506007)(2906002)(9686003)(26005)(53546011)(44832011)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zeo/qwwer2EnMqlh10Ncup10jg/NhJfAuGPEoCHtRHThWYOIg90/CG3uL7fm?=
 =?us-ascii?Q?kwwicRJGv4S4W5S3k/TCgwWt7d9B06AR9acepCWtbxxLzRM8dWLpqOLIy9tg?=
 =?us-ascii?Q?LuuJ/sf00+Ky3mHpLG+mLO7nIVt1AEhRrtLgMGH1e4wTzcSmTFIRAr8GDiiH?=
 =?us-ascii?Q?LijvHElbqyzqHh/zf3y5eHd6CDFhh7mH3L4T/sU0Zuq9PFINkAb0EQjYD7Iw?=
 =?us-ascii?Q?dWmxNQm1MdeRY8VziVLS5aJi+vYnkD7UFBb8MSBHUEdahRyn7zZcdAJIAA+E?=
 =?us-ascii?Q?JnbycKn7EY8zTucuzAx7yasDR01Z+SNchlvRRF1p2c3LZcHIh8fyh3scT7ES?=
 =?us-ascii?Q?JHNbmWsNHi+8DmUOZBgOnXBCMkwALDRpGi0KyUqT/HGR8deBYzN53c3yNyFp?=
 =?us-ascii?Q?ca0WnJ2o/sY31XgnENUt6zN+ULj3z9QBD2unP9L2Z2qwVWaw1E1AunbHBGZB?=
 =?us-ascii?Q?J2Gvl7JN9TXcmhs95BSj+BjNTCRahSSroW/+OMyRvbErSp3vh59PVoODGfio?=
 =?us-ascii?Q?Naijrrn9hBSDMFdhgLAeWSZuIppm55xpUdSzK//vC3HFV4rNarxqoNEq27kz?=
 =?us-ascii?Q?NWEE2aVOJPTi3BZSXdcxVSyB6srHPkerbB2PCdO9Vk+GcBxVG8QmYuOenPfO?=
 =?us-ascii?Q?zrPApKSSLQqkVvdYpixvIsXNLpToDhCdQ+6DJiVG+xqQ7Xu44D0p30YM66+3?=
 =?us-ascii?Q?AFXj5vXKQLB0LlcFrVLeQn0OEVcumOu3DR+2BFOWJN0eFYGDqT48y8Fp99vf?=
 =?us-ascii?Q?2aWH0l5zQB/VGjzxoMU0ga25IM02RObVVGT5KrzvK3buQ7nW9o+q4vBASlbx?=
 =?us-ascii?Q?T+gdCtmucdxxbnHDrVYtaOgPIiSuyvWXMx62RraECHnE89WmJ14MC4BIJfvC?=
 =?us-ascii?Q?8kUA+avDUHTo+gap5ZR2gRw/8neGHuGVdWcxAIS2QVDCLhbiCAX/TRa8JTVX?=
 =?us-ascii?Q?prk4sQVpDaCF21vDWJm24GV4rLr2KRvE6VOZBwyZtLBknzd5j2XqVaoVkntA?=
 =?us-ascii?Q?0zVEUawh7fCY/ur6xpCcDo/92KJnSJ8du0fNQDTj0NOCzp6S9DY24FEDlUyM?=
 =?us-ascii?Q?BBFPoA4MwKD9KAnTEZJqxXoRGN9sAN3DSMqYw8A4COKfhKkQCnrQAZgoWnPe?=
 =?us-ascii?Q?RZueotBk3QOTBG1kpcmEoBQS29j8vli3UPrgH63ogiS0WckoMqJ/Z0W2pqaF?=
 =?us-ascii?Q?NYLprN8bvX/GMG+dWQmDmw3iyxSQWPNgmC1joJaheSej1hX4LnWTiBwgbGrN?=
 =?us-ascii?Q?CE9jjMEyq55JtUBNqb1A3ayqSwkjc8jS3igIi5QsVyojwRYEn+K6kqKDa13q?=
 =?us-ascii?Q?Bfs5pX06Dr2VkG8o5w9mo8ILQXkrT6pPE36JKL1IB82zj1v5Rv/QIMdblt3t?=
 =?us-ascii?Q?5kK8ELrh5L+PEWn9AjSHblgYr9vTtFXUXn1qyVBST4v5Fi3aco9dMWD/tzV2?=
 =?us-ascii?Q?QfOD9adSdHpNnn1RkSIfmyiq9jW2pBXSlf6VPGzWZ0yhHN9yCwou0h0bzaFs?=
 =?us-ascii?Q?8Zx0yYZ02/5rXy5GTtliGX9pZ6nUuLSN4INJkqdHApU2AQJ71TTgLSFu7xIq?=
 =?us-ascii?Q?Z7XgtQznTpxXPmYjpIN1uuRlSjWOPxTxSBqKZad1hVhlIg14Js4SwDlZDu5o?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cba51f8-8618-4145-7f50-08da8acefb17
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 21:31:21.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+GQN8zOMThCb/rhNqgY07FxUX15vSrhtx5xTR2fWhzXR2qOd2qFub2ZrJkzfVqhZWhFkN78l/awryIZQej+9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=970 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300096
X-Proofpoint-GUID: AnZU9WlL_kcjUTeXWCawAA9JksBLbD2k
X-Proofpoint-ORIG-GUID: AnZU9WlL_kcjUTeXWCawAA9JksBLbD2k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 09:52, Mike Kravetz wrote:
> On 08/30/22 10:11, David Hildenbrand wrote:
> > On 30.08.22 01:40, Mike Kravetz wrote:
> > > During discussions of this series [1], it was suggested that hugetlb
> > > handling code in follow_page_mask could be simplified.  At the beginning
> > 
> > Feel free to use a Suggested-by if you consider it appropriate.
> > 
> > > of follow_page_mask, there currently is a call to follow_huge_addr which
> > > 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> > > a follow_huge_addr routine that does not return error.  Instead, at each
> > > level of the page table a check is made for a hugetlb entry.  If a hugetlb
> > > entry is found, a call to a routine associated with that entry is made.
> > > 
> > > Currently, there are two checks for hugetlb entries at each page table
> > > level.  The first check is of the form:
> > > 	if (p?d_huge())
> > > 		page = follow_huge_p?d();
> > > the second check is of the form:
> > > 	if (is_hugepd())
> > > 		page = follow_huge_pd().
> > 
> > BTW, what about all this hugepd stuff in mm/pagewalk.c?
> > 
> > Isn't this all dead code as we're essentially routing all hugetlb VMAs
> > via walk_hugetlb_range? [yes, all that hugepd stuff in generic code that
> > overcomplicates stuff has been annoying me for a long time]
> 
> I am 'happy' to look at cleaning up that code next.  Perhaps I will just
> create a cleanup series.
> 

Technically, that code is not dead IIUC.  The call to walk_hugetlb_range in
__walk_page_range is as follows:

	if (vma && is_vm_hugetlb_page(vma)) {
		if (ops->hugetlb_entry)
			err = walk_hugetlb_range(start, end, walk);
	} else
		err = walk_pgd_range(start, end, walk);

We also have the interface walk_page_range_novma() that will call
__walk_page_range without a value for vma.  So, in that case we would
end up calling walk_pgd_range, etc.  walk_pgd_range and related routines
do have those checks such as:

		if (is_hugepd(__hugepd(pmd_val(*pmd))))
			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);

So, it looks like in this case we would process 'hugepd' entries but not
'normal' hugetlb entries.  That does not seem right.

Christophe Leroy added this code with commit e17eae2b8399 "mm: pagewalk: fix
walk for hugepage tables".  This was part of the series "Convert powerpc to
GENERIC_PTDUMP".  And, the ptdump code uses the walk_page_range_novma
interface.  So, this code is certainly not dead.

Adding Christophe on Cc:

Christophe do you know if is_hugepd is true for all hugetlb entries, not
just hugepd?

On systems without hugepd entries, I guess ptdump skips all hugetlb entries.
Sigh!
-- 
Mike Kravetz
