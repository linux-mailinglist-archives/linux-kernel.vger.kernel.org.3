Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B304F6CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiDFVfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiDFVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851216B14E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:49:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JcK3o014702;
        Wed, 6 Apr 2022 20:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=TA6chPUdNmd4bF6clOIFG/RZU7E4WhRydjW8fQCv+FE=;
 b=feG97glTZDMJjYWxZj3T40WJ8CPa+ZfOmO8L00XSIREme2SKdwKSyzqrdM4lu0x56Hvh
 8Ncy6l7dRgZ2hC5D7YDJwpCUklrpYkpsjccsws0tJDOldR9hwBN+FKFX81JpysoW0Fs2
 ki6/hQD4rxsABRHmNQOLyZnY4k9gQY5dUdyFoOoGdmjYl2vG4rwCxK+3crEoFiP3sWNu
 +3JlKzKGmdyfCjsA7WQfxmmfBIL0oPiqI3FfL5FDDdr2I62D4dvs5Y5IO9KbhxDnYP9/
 Z4WglTKE3+uL3uwOnvaPXOggJLl/Qgil8z+WwJFRbMfTrc/0WSxlMmnaqU7K4GJS0DqE sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9swep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236KkO4U013648;
        Wed, 6 Apr 2022 20:48:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqhmsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU/Vai7kBXrWRLNEwh6JO9YJh+iwP5OL4af2DqUPhflH6At6kXxYU6b1+xMFS8mzjf9EiYGMTklntM/Hc0nwu5pIextE8SDynNDMdjy1fkw3KFfgrMjusLSP0B94FQqdHakDk+bayBqXUJIRbLvS522eAtnVI8b5OqdstpXazQdrOr/7uT2k/6LfI9Qe6aSSO/rng84kTXtL+wd6zAMBtuCt9tEIdes1yhOl1s3glkv+wT6V5YNjbLQMo9AvDMNwo8IwwaoQQSkRFF1rxI7caQ+orRWUg4g2zmCnFoYZqbQtz6umYJzJnBgB+fuJbPW/9G4QmblVwdt5VbP29O1gmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA6chPUdNmd4bF6clOIFG/RZU7E4WhRydjW8fQCv+FE=;
 b=EeF1qam0kloS3cRWxF2sR1MUP1VSTAx07cNizarspoT73Di331AOKcCxa8xvIu5/IruOnaEV3ymRILeE6/2Yyax0fMyOn/nBVSUf168fWL9iRC9d9SENjo0XEmX4ZbEhaNnZrdq2tctOeGYyh+wELLHHBI9WPxtgR/PCKXJNKphe/xJp1z5S+U8eiP1sSDazuc96Z32ICIBamYJqymJG9CRl9VE3j6QPJPoCMBmTY/btetXO/RNhQlM9C+ppVHMg1sqBU8dAubKVJ0MZ6wnfFv1nYOacjuESwK+W2G+p+6LHOj84xGoTDmJZi9gOsH4GtJmbExFvNP3rMt1OHBL45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA6chPUdNmd4bF6clOIFG/RZU7E4WhRydjW8fQCv+FE=;
 b=feYnY9Y39xq8GQPpvAEHdo+8GFePuWIyI4d0GwrIO4eYn3JVL1QwaYcv9syGIItls15gvKvoSgecmZGt/DAFwJsAEo+BX9nGkZByRDbRdXYEy+KUSILfI1HcqvCBp5+XuRI80tbcza0YxEI52OrbTzUXiJ0vGAdMU+iV3jnWAnk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1909.namprd10.prod.outlook.com (2603:10b6:903:11f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 20:48:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 20:48:37 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/5] hugetlb: Change huge pmd sharing
Date:   Wed,  6 Apr 2022 13:48:18 -0700
Message-Id: <20220406204823.46548-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84885f10-3a62-44dd-7dcf-08da180ed2f4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1909:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1909E466AEE4E6AEDAE6DB20E2E79@CY4PR10MB1909.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5znHoy/cXVH+pGUynquUfnVAqDmFfPWPbw14LPHnUVQkog2hvhcZysDxWwcSXuklQ5sl3MiigH/ApByfU0vITwr68R9RDsqvr6Wr5l/WFlj8/rUv4Yty+I9bYwtVCdf8Ca3li7orcnu/HqJQiPEjiFmWktHG3lFhv0ym2Y+6osPfnc4/wlmw1gNuq1l+azOe7IB9uzsi/CyXtQNyLRr4oDQtvTNYhJbrXnjgo7GQjNmjzz91agbxQP+7wfmvoQpD1fU8XSlA/Fm7Ac0DR9cR25p1GLraB90a317Q6b+qYGYiUjl7jKSeW0AaDDUYBfq6CL391TYlp9w140MTXcwr191/CH9NmFeyljoU1jeZwcv08/X/FyXFUcP1f2v02z4XZ+xOr3q3B9lnUaVdM+RDC2re+bku9hM6p7snhbo+MY0s9ss99SDabL/bDBdoakLfN4lvCvZaL2udjrC0GNaVirQPj4sXqcTGJtVV83Nu7PHpW+GdChNt7e7sknYwA0aFWyEJ32fcrO1LRZ8DN+wQWmJ0jGLwTD4PDL7YZT0okBXJNXX5I5hUQ2/69s9li9G+5UJIeD/MnzO97+eZ/efxtQnZLMrOFZkRtO0AKn8Gx5ZujOs0+KipFY5ssffQ7xvcipVO6UUMXi0kT3VvF+Sh2r7CEOkw9KK1DgwGqgd/jY547AXhKnaFl5u0YnUV16IQ3mfoqRM1A3NZUP8KbvjEP6JJW7zvujGhug7HxE+SRPX21/61sHMzmItGynpbFaLIpHSzVzYWakQLq3naHxyhsGOgr80pU391XLsPDIUOhcEn+ix/HtiIdhAILBPGDVe+WbYwio1zOA4TcvoLsl2xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(54906003)(2906002)(26005)(6512007)(52116002)(66476007)(66946007)(4326008)(66556008)(83380400001)(316002)(186003)(6666004)(8676002)(38350700002)(8936002)(86362001)(508600001)(1076003)(6506007)(7416002)(44832011)(36756003)(6486002)(966005)(5660300002)(107886003)(2616005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExZuqpFLVtZWbFzycY+/Hh0Z5PG9tdyiC8a/IULh9yDuHU8GOAzp/oGdoKF1?=
 =?us-ascii?Q?i3l2tsn/XIw/dfN1/XySIU3B6JG0CJDxGD1FMegcY9cPN4FHogMoPBHs2KZp?=
 =?us-ascii?Q?VFaztJA2CatZLrv9iN1YDcwS9aft7xXKP9e3/c6MyhFxAfklw6D0kheyZGLZ?=
 =?us-ascii?Q?TUUGIO1qwMMqmLvAa1BYr4YEjkDFcwEgP+0uxjiAYg6rh3mdWIWKuhDAUIct?=
 =?us-ascii?Q?s9FmWKOCRp9yPeqGVgoJTHwTR+i00ESI6hLDxxDXDJnxtLV04CQl5J63oypm?=
 =?us-ascii?Q?bFYz6tPkL7Ur61Jrq5Rk+JQ8LLEKJSbWIcpY/d/HySQcizZNOLDzn+OPdJEs?=
 =?us-ascii?Q?N6Yng1VoT+piTtQqbm36+bybtNOd6Vs0ZXQMBl4FUzGiUs3e47+trzyHfWij?=
 =?us-ascii?Q?QoOOFSnaZyym7dsTSTvMU+lS0lHKkoVNkzTdZ3bZzkCbgCe5cVtTmKQXjlaJ?=
 =?us-ascii?Q?Njn5D+cMH3LnRGaha4NDoKJ6iEhW6HorBg/8uKzeSvHHjZTju0MfCsF42lQC?=
 =?us-ascii?Q?aXAyVk9WnIitJj6k2XwvJuWkxWNvMUGMsGxGECB3GzORE/i5EUw3SfDGLbeQ?=
 =?us-ascii?Q?In1FmqEnwFXKyqDZDtvPoblj5pnS3qG41RfjshNw8yF3p6LQb7jGLmuiW5lX?=
 =?us-ascii?Q?xMZWZwvWh0hkfCjUUIQ5bG3dcii0MEM2ywg6PibE3LY2cV7IJW/HykN3NDG3?=
 =?us-ascii?Q?O4mC39qVCirJ6Qrr33Kwx7KeBiBr7MBm3aeQgoUdf8IBfVw5qVZiruYeorVM?=
 =?us-ascii?Q?Mo/x+HmtKcTR0D51gGTj3eJAORIegIMbyZnpVXN9cpp5zNpBZ1h1yYT+Cxx8?=
 =?us-ascii?Q?Ko9lOx1C+omdHkmmc5L0rR5Wy1JaWnVmWeYPlpdsBK/abud17vLgFeE0zNHW?=
 =?us-ascii?Q?6ITwexxr4KaqTRB6hkVubGxMMgDBhXz4yOu4YR/Ks94f+FCCmFxAguEwDDk6?=
 =?us-ascii?Q?EW9+4sf3LdA+nB7Xiny3hk4ohXPXLoDrt4ZVvoZ8+HE8oz95UzpOwJ0C1oYH?=
 =?us-ascii?Q?8Nb+ONwXZcwFCFXwdu3CHiAHT3VcSl7OfDvLxd7OX2/7h3xxwpgRYGMrzjKq?=
 =?us-ascii?Q?9kn+Wb/zvCz/TAvnCOCTxTCo/Xluk1E7daPGH9CVobt/+jcnbtob4BrhGuLM?=
 =?us-ascii?Q?JAsNrzv7cFIfU28pdHMeK9IV+NT9uWsUy5zx++QPgrc4y+K5OxRJzkoBsvlD?=
 =?us-ascii?Q?i9Xv4B2Y2+9QGTHVYEP1a5hF+xv9L4dm+4uTNdycC/Np/1bOMr+oIwWztvgc?=
 =?us-ascii?Q?hOk1s43pAleU7AzWtpDiry1QEsilHru8bndCI3Pnw9CQ7vaFHjKtlT9N6hVu?=
 =?us-ascii?Q?v0/EWOuJpuzTXtW9ua8hOyvpjlJVZHBGjjLdWh5T+T63uW1cliUpgcPz1DGR?=
 =?us-ascii?Q?lNg3uGjGbXUX8ash6kNAA6BioWeI55a8xJOl74wgLrvB8u0RUaDOAE2D3cQS?=
 =?us-ascii?Q?aevThjKHZZrJcG+JhaSgv3c5oA7Gz26voPxKEEZpFSE39HjN3+CX9+HNfSXe?=
 =?us-ascii?Q?OGc1viayf+lwM5Bh6pbLEDirmC5hDmskZyutZNLjwAOpeLWJx1/qhKJFOvpD?=
 =?us-ascii?Q?gwv8VGNsQNe9b/sVbH33zSpr1hbltdRu/KTXIYJ9qcXvKmQDxEQ2qU6WAain?=
 =?us-ascii?Q?OI3EV9gA8NrN/8yP261mvkuVWJ8JW3wE9wA0KR3Wo+HozAC0rZFQQ03kwG52?=
 =?us-ascii?Q?ppMzJE8XZeolwn00CtwmhzZKfbSnDhaRDlninKx5MgUAMFBL6MWialoMjeZN?=
 =?us-ascii?Q?ic6Ghaws3OkeXxKcFCqjbV9yqLLiDQk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84885f10-3a62-44dd-7dcf-08da180ed2f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 20:48:37.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxkDhk5orkOcrbasH61OR8WHeHEzStHYQwhjbamlbQZ5KLPHoKSAbE7L2xQv5oIK191xdAj+FJP172WAieH7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=881 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060103
X-Proofpoint-GUID: gmdyui6uGkzG0Mj-Iu4OnlR4Tuabr0yg
X-Proofpoint-ORIG-GUID: gmdyui6uGkzG0Mj-Iu4OnlR4Tuabr0yg
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb fault scalability regressions have recently been reported [1].
This is not the first such report, as regressions were also noted when
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") was added [2] in v5.7.  At that time, a proposal to
address the regression was suggested [3] but went nowhere.

To illustrate the regression, I created a simple program that does the
following in an infinite loop:
- mmap a 4GB hugetlb file (size insures pmd sharing)
- fault in all pages
- unmap the hugetlb file

The hugetlb fault code was then instrumented to collect number of times
the mutex was locked and wait time.  Samples are from 10 second
intervals on a 4 CPU VM with 8GB memory.  Eight instances of the
map/fault/unmap program are running.

v5.17
-----
[  708.763114] Wait_debug: faults sec  3622
[  708.764010]             num faults  36220
[  708.765016]             num waits   36220
[  708.766054]             intvl wait time 54074 msecs
[  708.767287]             max_wait_time   31000 usecs


v5.17 + this series (similar to v5.6)
-------------------------------------
[  282.191391] Wait_debug: faults sec  1777939
[  282.192571]             num faults  17779393
[  282.193746]             num locks   5517
[  282.194858]             intvl wait time 19907 msecs
[  282.196226]             max_wait_time   43000 usecs

As can be seen, fault time suffers when there are other operations
taking i_mmap_rwsem in write mode such as unmap.

This series proposes reverting c0d0381ade79 and 87bf91d39bb5 which
depends on c0d0381ade79.  This moves acquisition of i_mmap_rwsem in the
fault path back to huge_pmd_share where it is only taken when necessary.
After, reverting these patches we still need to handle:
fault and truncate races
- Catch and properly backout faults beyond i_size
  Backing out reservations is much easier after 846be08578ed to expand
  restore_reserve_on_error functionality.
unshare and fault/lookup races
- Since the pointer returned from huge_pte_offset or huge_pte_alloc may
  become invalid until we lock the page table, we must revalidate after
  taking the lock.  Code paths must backout and possibly retry if
  page table pointer changes.

The commit message in patch 5 suggests that it is not safe to use
SPLIT_PMD_PTLOCKS for hugetlb mappings if sharing is possible.  If
others confirm/agree then there will need to be additional work.

Please help with comments or suggestions.  I would like to come up with
something that is performant and safe.

[1] https://lore.kernel.org/linux-mm/43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org/
[2] https://lore.kernel.org/lkml/20200622005551.GK5535@shao2-debian/
[3] https://lore.kernel.org/linux-mm/20200706202615.32111-1-mike.kravetz@oracle.com/

Mike Kravetz (5):
  hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: revert use i_mmap_rwsem for more pmd sharing
    synchronization
  hugetlbfs: move routine remove_huge_page to hugetlb.c
  hugetlbfs: catch and handle truncate racing with page faults
  hugetlb: Check for pmd unshare and fault/lookup races

 fs/hugetlbfs/inode.c    |  84 ++++++++------------
 include/linux/hugetlb.h |   3 +-
 mm/hugetlb.c            | 169 +++++++++++++++++++---------------------
 mm/rmap.c               |  14 +---
 mm/userfaultfd.c        |  11 +--
 5 files changed, 118 insertions(+), 163 deletions(-)

-- 
2.35.1

