Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9845AB88A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIBSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIBSvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:51:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF964DC086;
        Fri,  2 Sep 2022 11:51:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GKLgl029494;
        Fri, 2 Sep 2022 18:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=kef41T/qTUgfuPQqLrksSf+/tPFsDcm/ZPXpzCGCA7E=;
 b=nvnmK5Zmu00soZQi6O6vfofzafLFfEe2BSwT5hqVR1xEakCIOeaMtQiN19sIYmmwrJEt
 ajLhoSrpFIZ+es63BNhUSygFL1hTathddJ5xYhTfDJiUItgyvC8lAfpE4LZsWSHTdrnq
 MQPJdMcCANFoKtZsekBnIbuSOgOHeinG+RTGkC9zFHawd6DXsTq6MgRjfNT2yus+0UPN
 M7AAJ3TcoWdl4JDcibS71p5oCevFO5ywQLWPBnaYING0L/iWHtuzQ+5RbRUTp3ubNPtg
 gydfI/8AuYn1Ub42H5PI5myv+K+oewVKgZg8JnCQWiILzQbWGh3zCqCpK5gj2t9IfhqS gQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pc7j6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 18:50:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282GCnAK019632;
        Fri, 2 Sep 2022 18:50:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q7syb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 18:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UASHoWgcroAgHrrfhPg1mrSl7AYogBKw5k/Ms743I2rYSfrAhNeWxoLpG0sZM5Qceg+rrj8VCnCLit3UjPGHCJWoUCPetEV6eRA39ii9Biw6dxCb/fzNTJ6THl2qc4PdyZV7dUIjD7V9sN0SG95hP2C3lIyEfZO2dBVlCrA22BmMmqbnITMi8IAte+926lGhpkM+nyepB4GQ9eagnRVseKCBpAJLmdgtFSAcaOpOQeB5ZV/NUi36hnOjax5IuYagoIg3KpRWSde0I7OwLa8aMPEOrVnXya07Q2NQx6fFv+aiDxgyc0j0ISlPkcaomFOUvPKSLDQYCaf8HN1qAxsAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kef41T/qTUgfuPQqLrksSf+/tPFsDcm/ZPXpzCGCA7E=;
 b=aU23+WP74b4rfSHRaQom0rBh6n61pDIvt5kBOYIxEMPtN/w1u6HpYNwsH8rIwbZUUwiafeDLPo4VXJD4gN+rCGuRHV0PMYzFMS/1mx7R18/kt1rjK+xH8od55J1b8PlJuYSOJTr11lwubIY2J6wPdE5UcXTaAdQoS5Q+e9rVdC1WOQPUltUb7ZWrebKVpM5GYpVo08seU/c3JhOGRSGhWILiw+GSIvoknBSFMppOJKi4L+8D8OLgUFq3G20iJJ/35rJSoqjGANR3o7EDz0xCiNmMJ1zDb4OucGe4BfrBTLqyTLaTfyOllk2HAqcI2ia8D8AujanFOyRyEKXNSADpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kef41T/qTUgfuPQqLrksSf+/tPFsDcm/ZPXpzCGCA7E=;
 b=ZNaWGtIa4R0uisEoccQ8EQERPMawWjIrZJ8z3ety44WxwW6dLTKttr7/qBj3mghzruOG8p9eTdlHLdgapI/mJ2s0+vKXAJ/PJBn+ZrUB45ke69yzKH8CUqcsu4lt9Nlda2MDs7LJ8KDIymqSOQnuZi6nP7IYJr0VYrYxjVcrSh8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 18:50:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 18:50:39 +0000
Date:   Fri, 2 Sep 2022 11:50:36 -0700
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
Message-ID: <YxJQfGSsbXd3W4m/@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <608934d4-466d-975e-6458-34a91ccb4669@redhat.com>
 <Yw5AOZ/Kc5f3UP+s@monkey>
 <Yw6Bpsow+gUMlHCU@monkey>
 <739dc825-ece3-a59f-adc5-65861676e0ae@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739dc825-ece3-a59f-adc5-65861676e0ae@redhat.com>
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2e7880-35be-4db3-0c15-08da8d140783
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7WQPlL54b6YKnk13fuVtL24ttPLeArP50NM3XM7dlohHS+cEZf52yUAJMwW9Zls1BC/eVc7OwfVBnAYaJGgNSMOvDxHDato/f8lcbrpBNLt2I66Yb8nv0m2PubCMzmeGoGaycxWcBsPTEefZrZE2L5eoe9MWsVHKMeYpf9DvcuYiTiNzXLGHh6wsQWWyPya1Grz7nDAA738ByyohBHUiR3sckPeVI6LMzFC5e8F3ZSwbGHJ5VngZub1OaPHa3UsviuKsy5P57YwTq8GAh475vL40bOWvcFr6y068Ai6ohcPMJ/VKv+huhV5uLZZFJWSnnosq+2JAqp6CRb3Va8YRUiSh/NFpvFsefbpMecMlH8CmltaAE2yQfeNOcSKEEt6Sl7774j4h2VbZaX5Qs/dhHoCZog+ZUJwZjzHUPXZBWEEn+vvfBBHXAvTj3mzjRmezPnXlcJtz9YOFLontzKBj7ecVsRpSiPxfEq4WQFJfj40JmYP7wQMO//XfYi9LtChP0OIFCccgX3DrxHdwa1LFutGhtUDWn89N3G2K7cSnWRColfK9lRG0e68eZmmp97P5b+ckdgRK7jU+HbQ9XdbbcQzt2H4ZWjZVGXExUq9ebXZVRNiM0lr7a9sIZjWm8PAJHOkZVMAvKB43gXa3/dycrX27rMF9xo7pmFtoOKHF/AV7Jy+C+czmuz5KXF3adL6+2V0QRyCQqy31hddB+7CiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(86362001)(83380400001)(316002)(186003)(2906002)(38100700002)(4326008)(8676002)(66946007)(66556008)(66476007)(6916009)(54906003)(41300700001)(6666004)(44832011)(6486002)(7416002)(5660300002)(9686003)(6512007)(478600001)(26005)(33716001)(6506007)(53546011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CMUEZIRQRXrA1Qcwvv7nRoB181znPCidsUEHzNwSrIG8Eh08e3nZMF5Sbx6?=
 =?us-ascii?Q?DlNg3JEKO4ZYDz21Wg/1bNuEwXJnk0DlzXYiS28Hx6HN9ZQN/Vuiwm/NtqCl?=
 =?us-ascii?Q?qXOL+hkOcm/ryqhm7pjXG/kIgZXXPjIbTFdIjuED3cE95EwQHM2Z7lmsM/Cb?=
 =?us-ascii?Q?OkarttrWKG73T6W9guhgxn0h2u0v4EVrqG7Tv4e3XazIx/PMXWBMMhaBhjwO?=
 =?us-ascii?Q?7/Pi5/Qa12r/Md0nEC0EOQgdbD6/f+FEdnntZXxfPQtF5OtpJ90qWiF69idy?=
 =?us-ascii?Q?Dyc/yfoykS6JZgWL1JY2llBPfQBs1pvmfKE9ekqstVr1BdE9030NdWtdr4Bx?=
 =?us-ascii?Q?AEd9GUN5xELoZ6SWYRsqlrACYEUDow3F55nRO2iGh0hH1ZL23XlCea6IbuYE?=
 =?us-ascii?Q?3yQ8tqC95tU5v4n+0wagtxKwkmvQKagfexiDDVVPRhWQmkCUuY9RMj+lRbcM?=
 =?us-ascii?Q?KbrVaBpL3HqQZhRBZg0F2i5znP1RM4bg7ynfx7pE02mi5rfJ5Jj6Gufpa/O0?=
 =?us-ascii?Q?HEUNdsngDyopR+CuYuvCTusc/w4CirkbvLqo1+VcobcQYMyGokvWFeGxdCMQ?=
 =?us-ascii?Q?+1HM2EFSGU8ieR4cb2N9MNtRy20y+PnQvHqr2GO9avU5uq/ClboYIteQea0F?=
 =?us-ascii?Q?WabiBom+vh1OsWPcEbEqUoBveg4c8HJK6cyTeEgoAGdkUuvaOlg6ikA+zDTd?=
 =?us-ascii?Q?/22TsL6UAw1OxkUo5rXVkW6TTVkq9SUDm2yTCi7ussGFCIVGc2cCPqCOy8qM?=
 =?us-ascii?Q?uDmOv0/eS6ZnqzKQn+ZkhKyyuBnKPY4riDgaLTWD7UilVtXytcYrNe9Cx9zh?=
 =?us-ascii?Q?kV5yvIufwFZvbaet43SWnS7W6I/3g3M++wVX/zz9QDzXTgGot2igZyh76Fd6?=
 =?us-ascii?Q?koNY3u90SgfLmcufvik+etvV5Zq8nvXDftFx5dFMQgc+NGx14edNyFlvrWmn?=
 =?us-ascii?Q?BdhAXTG8FfSeohmCuOHEJzX9og0yNEG3tD1mQyeoyyWpmMWXxyb5JUy2CDyd?=
 =?us-ascii?Q?yP/JjeUULHOD+OjnYc04d/v3s0nSqlUMCJPdse+aMJDHYWMD8CVFWcj8jWDH?=
 =?us-ascii?Q?dOIbbcF4fQ49zciYIoaOSvQo77UXVqqtDwTMM68aFvbuqcDUc/jnmBoyhPE9?=
 =?us-ascii?Q?su1iq8euwVqvBucIuydsTFYq7oSYS4fGzOhdXTOJeqQ2JkVXzOvodSnGMp6e?=
 =?us-ascii?Q?RLIaqY60b7OUkoA/6RYT4kcK9+UMcfIs2FXBWAc7nI8wxjPH2fc15XXY4QQe?=
 =?us-ascii?Q?Wr0kunhhBx+FZ9nhmyrli6dIQmAZQA9QEjXFTKqlzJkqfcxTmOOKnbVeBiGS?=
 =?us-ascii?Q?Q6sP2KYsfj07kMWQLj4o8CoykRoOfdm2kwxmkMbeU3nZacJeunR9hOF1QuCr?=
 =?us-ascii?Q?xaFLTjb+avzYbxAMNPB76+qx5fb7PO6yw0Q0rxuN0xfWefTTCOqoBg/lWq1M?=
 =?us-ascii?Q?4KyYa4yS8zNpXGf81jWOhsZHyPpCKeGALQ1/ohoppBeHnbwZGj7fniI7Y/lK?=
 =?us-ascii?Q?PLV4Yg7i6JSvRgM6lD1N0HHJtDSRofQ79i9sDzgo890YrfxUYx+GjGFujAei?=
 =?us-ascii?Q?IVPUrPW/z3XdM46o+NonBTZ8gzfgQrS5Shn8HITzlMKdooJlVMvmncqLbLGy?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2e7880-35be-4db3-0c15-08da8d140783
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 18:50:39.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqiDY/uYpQvXOHU8BYlK6ozt+femoJZkqHVhmxjjHJ8r3KnTNWYagEwi0LWkSkbn+t81uyA38Vh7dmeo8o02/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020085
X-Proofpoint-ORIG-GUID: SFm044T9UtkiwsQiqTwygj7_pUeTeS2A
X-Proofpoint-GUID: SFm044T9UtkiwsQiqTwygj7_pUeTeS2A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/22 10:07, David Hildenbrand wrote:
> On 30.08.22 23:31, Mike Kravetz wrote:
> > On 08/30/22 09:52, Mike Kravetz wrote:
> >> On 08/30/22 10:11, David Hildenbrand wrote:
> >>> On 30.08.22 01:40, Mike Kravetz wrote:
> >>>> During discussions of this series [1], it was suggested that hugetlb
> >>>> handling code in follow_page_mask could be simplified.  At the beginning
> >>>
> >>> Feel free to use a Suggested-by if you consider it appropriate.
> >>>
> >>>> of follow_page_mask, there currently is a call to follow_huge_addr which
> >>>> 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> >>>> a follow_huge_addr routine that does not return error.  Instead, at each
> >>>> level of the page table a check is made for a hugetlb entry.  If a hugetlb
> >>>> entry is found, a call to a routine associated with that entry is made.
> >>>>
> >>>> Currently, there are two checks for hugetlb entries at each page table
> >>>> level.  The first check is of the form:
> >>>> 	if (p?d_huge())
> >>>> 		page = follow_huge_p?d();
> >>>> the second check is of the form:
> >>>> 	if (is_hugepd())
> >>>> 		page = follow_huge_pd().
> >>>
> >>> BTW, what about all this hugepd stuff in mm/pagewalk.c?
> >>>
> >>> Isn't this all dead code as we're essentially routing all hugetlb VMAs
> >>> via walk_hugetlb_range? [yes, all that hugepd stuff in generic code that
> >>> overcomplicates stuff has been annoying me for a long time]
> >>
> >> I am 'happy' to look at cleaning up that code next.  Perhaps I will just
> >> create a cleanup series.
> >>
> > 
> > Technically, that code is not dead IIUC.  The call to walk_hugetlb_range in
> > __walk_page_range is as follows:
> > 
> > 	if (vma && is_vm_hugetlb_page(vma)) {
> > 		if (ops->hugetlb_entry)
> > 			err = walk_hugetlb_range(start, end, walk);
> > 	} else
> > 		err = walk_pgd_range(start, end, walk);
> > 
> > We also have the interface walk_page_range_novma() that will call
> > __walk_page_range without a value for vma.  So, in that case we would
> > end up calling walk_pgd_range, etc.  walk_pgd_range and related routines
> > do have those checks such as:
> > 
> > 		if (is_hugepd(__hugepd(pmd_val(*pmd))))
> > 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
> > 
> > So, it looks like in this case we would process 'hugepd' entries but not
> > 'normal' hugetlb entries.  That does not seem right.
> 
> :/ walking a hugetlb range without knowing whether it's a hugetlb range
> is certainly questionable.
> 
> 
> > 
> > Christophe Leroy added this code with commit e17eae2b8399 "mm: pagewalk: fix
> > walk for hugepage tables".  This was part of the series "Convert powerpc to
> > GENERIC_PTDUMP".  And, the ptdump code uses the walk_page_range_novma
> > interface.  So, this code is certainly not dead.
> 
> Hm, that commit doesn't actually mention how it can happen, what exactly
> will happen ("crazy result") and if it ever happened.
> 
> > 
> > Adding Christophe on Cc:
> > 
> > Christophe do you know if is_hugepd is true for all hugetlb entries, not
> > just hugepd?
> > 
> > On systems without hugepd entries, I guess ptdump skips all hugetlb entries.
> > Sigh!
> 
> IIUC, the idea of ptdump_walk_pgd() is to dump page tables even outside
> VMAs (for debugging purposes?).
> 
> I cannot convince myself that that's a good idea when only holding the
> mmap lock in read mode, because we can just see page tables getting
> freed concurrently e.g., during concurrent munmap() ... while holding
> the mmap lock in read we may only walk inside VMA boundaries.
> 
> That then raises the questions if we're only calling this on special MMs
> (e.g., init_mm) whereby we cannot really see concurrent munmap() and
> where we shouldn't have hugetlb mappings or hugepd entries.
> 

This is going to require a little more thought.

Since Baolin's patch for stable releases is moving forward, I want to
get the cleanup provided by this patch in ASAP.  So, I am going to rebase
this patch on Baolin's with the other fixups.

Will come back to this cleanup later.
-- 
Mike Kravetz
