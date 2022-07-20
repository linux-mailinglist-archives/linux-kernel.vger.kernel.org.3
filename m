Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5E57ADA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiGTCSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiGTCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7147BB2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0tcCK031787;
        Wed, 20 Jul 2022 02:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=+0b1buKPxx6VE+xS0ILIUi4REqrW+FO3AQ1K10fXSH8=;
 b=wO41Lp14qc73uaJeu7w4ev68xvcgI05xJ0nILBk4Qw3nWeS4gQeVrpbjPKW4Zqn+BxkO
 v/2A7dvnbchVB9EdwqLMHzKPJloT01gHGE5Pfh0TlspnvoPD2TnsHqr1U3Q40kElCmSF
 LofjBmUQerjNtEwfSOWvGZ0ygVCLsdzmpVNpVEw7PCezVlokqapTg8Js2DUUX+1BoRdk
 hYoqPdM349Gab20BH+HcQbtBbJtlbEBQal8TlthVq/ate7NxC8HbHuDDVfsaWxTcgu1p
 YvZ3zkaebFunmeShLNNlFxlRgtJvxKPyBpmga1mDsdfyqZTkts0TeTdEEQYOJ38k0lx3 uQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JMwV09039184;
        Wed, 20 Jul 2022 02:17:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k592px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eePY93obnD6HW3vB4muYH1PZC6QEEg2n+8lXXQslvn2ERAGTv2AGznMeEbsO5ALSiVZIDTrOFvl8wDlfCGfRIgsPm8twYrL8RcmlG7BmgPjd20GwC72Sc1brPgRZTd/B4UmLLqu7z3/LzvLGgNlM8Q9dvB+6zLTmHJJfczxX6F5weGplxMCBTQAZI0DwP7HhgW3DdTASd+2EGTKZ2CtWtUT762M6aFdy6Pb/wO989mR36SldO/Z89DiVkICIF/f8X6b1vrSbRJ+NCjxJTG3lOcP3GrltPD4MzNnxmEmHjwwF/yDt0Q3RPtRVsskiQvdeOrd9qp0h1bq2ZUu8G0CQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0b1buKPxx6VE+xS0ILIUi4REqrW+FO3AQ1K10fXSH8=;
 b=S6alqOivrHzZ587Y/v47EgMxSAkzP0ouiRV0KEFIrLsPgKBNlX6ZrD5HohbTMgD4z2HuNlG6hv7+uhRMS2/T2qwVbdESCOEbCTXeavmuNvFbFdFFfHTbf8dlBb0oAhUhbFP6ZFzi7Ohw0ODA+FcIo7UUdlteFx1BGxGnmS477vLRNaDIo+HjTZSBMxDOlfQIbHTQTpG6l2H8PDFrOdD+F3vVO2eDmTJ3Q3COU4nWuvoKDj3wnqZBMEYcu/O4LjwyU0Nh3yQ1TcRZlAYVtCDP90h4gXwiARBwQeVpj6OtyCSWslNx2Hz2vxJtJPjRgIrq4kCEHtSOM1dSD4EbbVV3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0b1buKPxx6VE+xS0ILIUi4REqrW+FO3AQ1K10fXSH8=;
 b=v9XkMF3UHr5WL9SDPgNYEAzL+4nTAUdy/brvyegwR5HPDnwMuJbjtm/jtCz3e93K9k79YRtRsmE2FiaTPKazKjvXV09jD3ENugY56Ev36+npGvufddjfUqZS75JYiLocrNIExOGScFxC8ECquKLeQhk8kaOp7zSgBYukDPDv+tg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2889.namprd10.prod.outlook.com (2603:10b6:5:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 02:17:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 00/69] Introducing the Maple Tree
Thread-Topic: [PATCH v12 00/69] Introducing the Maple Tree
Thread-Index: AQHYm97htRCukodqLkqezfCsabKJPQ==
Date:   Wed, 20 Jul 2022 02:17:37 +0000
Message-ID: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 897d0b65-1a8f-4847-6956-08da69f6041f
x-ms-traffictypediagnostic: DM6PR10MB2889:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFhEwCH5Nh9AWX7YrPfkUyc9H8hQu4aBreSIKdd7bHwpqD/ebgN1tfZ92fSbE3z+BEwDIeoqyg9ASQXJloXqnn3624pIlDQYqKI6/C1B3U8v8RTiEWwZ5XJNoU2tUyFvCDvUuPtfqb7AwKnSUX9ma98BV5dGncY1Au/xXygfmcuz38Cou5UdvKT3NZLqY2P+42OpYsVeu3LtTuLgiW/qB6O1koMY2WIzz+BvGLSB96N3nM0+2j7M9G+w96u/Qw98fhE1VvHTCF2IsbxT7WNP89HFrdAEamNuWWP3ek4ROiqjHmFiiisWL89yLUMKzO7X4YMdkGLVh0syvFVyX43pF/ordLraiiYnIe7cXBMZ242DW0BgX6ULpDdXffhbtzx+nm9fEKV5OJSCMREI3pWUBUKSqPxiTKuN3vVVFBj19QQlwdaWwg3K8CV7EJWj8fIMhbC4Uy28Cau6YVX8TeVuZe4YukGHNKQa7XdEhx5OOxzX1IWYtPMhN8Bye1l4u9keWMV1aCFdqfwaT0TzKoh+eQ51YYcsvkhUu6fqPE5m4yUJJcoTkDc512Qw5I7INmFM8E6OAqesEjgMy8ztpe5DfbLyFkpFn7ZxqOZCQ4GMIDbQQRgVIQ/VgvW4j2iFxlZGAEY9GS4sINsBZWDs6yhtk44q1pA5N1I6lu65A9YI0d/3xXoISe3FsCmcjrTfeBsEv0giFM/u8BWcvHAd3daprQ9xmckWugHJhnSy7Ih3yTYuw+dWGapXcRj2LOXD+F/eUOHZ/cZNZkV1sGGzgDjo+RfHvWQv2y8C2LjNoEGOCxo1EQ5XOm91/9JI9NJh5HLsLiX4BCEvkChmL0JYW1jUaducQzXVvvuO3lPTnEIhkcfDXkEzJ5N+5W/8wqLdcgOS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(8936002)(5660300002)(76116006)(44832011)(30864003)(64756008)(66476007)(66446008)(66946007)(66556008)(8676002)(4326008)(2906002)(91956017)(122000001)(38100700002)(86362001)(38070700005)(6486002)(966005)(36756003)(71200400001)(478600001)(41300700001)(83380400001)(316002)(110136005)(186003)(6512007)(26005)(6506007)(2616005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?trwA1++XFdG0qAhns0C/aMDOrUUwgdEQWK7Ona4HrsftsoeJICRC1R/9cw?=
 =?iso-8859-1?Q?Zpfti8ElD82FSh4g94jVa5tjwxlcm+dnqDzLVCdnjGHWsU3bT8boyVRsF0?=
 =?iso-8859-1?Q?JzlypFTEPke/niSr71u9gLum0aruI2SNQbVzlGlQ8SIGt58gjqBkB9uoty?=
 =?iso-8859-1?Q?t5V8JLQ1q1xKtEN7S+B9b2oOHkNbJ28UaZ68uLcBSrI35zvCZ74mpUdw5a?=
 =?iso-8859-1?Q?tdYh1wRv2UwyG6o36eNaqHIn0Ueyc6AnHKqaIkqlCf2qiGcmiwz7uyFILU?=
 =?iso-8859-1?Q?DwMJYToEAytpFcuC2kFux0YQVwrWTchogdUGMOwD4pvwJLpNGpbzdGAdeT?=
 =?iso-8859-1?Q?8CagaLdEi8cSc3TRDOLbLxSYUzP4AnYQ3nLLBidI7wnJ0QQ4yb5iWTR7Eu?=
 =?iso-8859-1?Q?p7awVR2koe1IXZEM3M5hQ6APbN9inKbfDPmzOHeC3JQvFKSUlT5wa5Npso?=
 =?iso-8859-1?Q?hxc9PCEo8eYmuU65CpwcW3AVTH03ofvGxQagT+1NrYWNJ9DfLq65e/+33e?=
 =?iso-8859-1?Q?bkDLCeETevVT1Sa2XR/B7IyYuHVD5/naBtq0XtjJDpt8J7VXzOnMAYjdWt?=
 =?iso-8859-1?Q?ywvN0I/K1FK/cXPb3ouqXIGok+uGEmQw2fpwrYoJwVnof8ozC2uIRlzpyI?=
 =?iso-8859-1?Q?8ektMo5E4WJSeWHmwJJmpaAozG6eFUTkmd4b3N+m5LA9tomfCENocXpxZd?=
 =?iso-8859-1?Q?+9W74RlIIBfUpBXO8gGyxQmwIagovBZpTZobXhLiD6FqDxaJ+yvvtaAo8r?=
 =?iso-8859-1?Q?3YsT4bs3kKs2hXV6W5niieM7CDJ3pN7e66mVoMDiGe9lnInQ8hwywa1uE5?=
 =?iso-8859-1?Q?NH/YT09l8gawRV9fwhAy1ETozBL5gZbULiOfUHcylziTQUIeOVgkTPpf0P?=
 =?iso-8859-1?Q?YZ/sFMrRJ67SRXJ33VndJYpkTcfbhPldKbbVZ0feojLOGR1q3BnEiVedJi?=
 =?iso-8859-1?Q?/uEEpCz3GL+G3O0+hjNbxzaDnUKvY01Z3QWHo4YIM6s1q6Yg1TkUIY2OFo?=
 =?iso-8859-1?Q?0zW8Ru1e0p8aDzcD8302nz4koPoqN/VFxajZQ1KCTVCbsJciKeYVxGUJGi?=
 =?iso-8859-1?Q?pv88xIg6d7NCPE0+2XawWJACtadz56Zc8xAeDh1DSMOzftJ4tSsPhLb1fg?=
 =?iso-8859-1?Q?ZyrMEh6Rp8DjjfIlnOTQJ8QSyykGLNC/U5uF8kmmss2JUB6XpOCQhAiMn0?=
 =?iso-8859-1?Q?+ocD8KdEiC8wQGePh2u0Acncm7VcuKhN+k81ovRDnvW7IkOkgUdvhUK5sq?=
 =?iso-8859-1?Q?bMHZhJwfGldB7DdCWm7TAPUAKxorCXA35e9i/iVrPL/jRCb6NUkn17DdMN?=
 =?iso-8859-1?Q?S6QquLUdQ6o/dGxT2imPnOjk4MXZrT+4aCAkClxqFeLSZ27GOj/sVF2pmf?=
 =?iso-8859-1?Q?St5aCio4D5sM+rCggqmc822+9OJH6NPDUyuGNoiT208fVf5UoV3MVL864j?=
 =?iso-8859-1?Q?Hd9gFLBe98ajZs/aKcgbbYxpV6PxREw8b6AThCmcIlYia+DJcTKKMu8x7r?=
 =?iso-8859-1?Q?7xA+1vlrKJRzQGCqAJ9CnzuMYg2VUZ9i8Har9nkqDBw4GHPzzrms+0EoUF?=
 =?iso-8859-1?Q?9o+bDRr8WT4r5UNgkPyxlZcG2wcFuNYNdvPUUjW+U8lti1M8f6/XW5djc0?=
 =?iso-8859-1?Q?/GcbHYx1N5hgvKJ08g0/FVgN4SDFChI9jJGKiRZaeygbX+hKSaSufbNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897d0b65-1a8f-4847-6956-08da69f6041f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:37.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJEeg9jsYgfVJQyRVzVMr1kXS/LdvmaGOeQwu/3vfbcbkny/Q/QUeDytBkf8MI6o4QgQjhiz07CkOyjcPh7hSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: dBb3CH4dZTx4QuOCn_-IdroZT7jQkykm
X-Proofpoint-ORIG-GUID: dBb3CH4dZTx4QuOCn_-IdroZT7jQkykm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the v11 + fixes.  I used the mm-unstable branch and patched in
place.

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220719

Patch series "Introducing the Maple Tree".

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  If you use an rbtree with other data
structures to improve performance or an interval tree to track
non-overlapping ranges, then this is for you.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter
than the rbtree so it has fewer cache misses.  The removal of the linked
list between subsequent entries also reduces the cache misses and the need
to pull in the previous and next VMA during many tree alterations.

The first user that is covered in this patch set is the vm_area_struct,
where three data structures are replaced by the maple tree: the augmented
rbtree, the vma cache, and the linked list of VMAs in the mm_struct.  The
long term goal is to reduce or remove the mmap_lock contention.

The plan is to get to the point where we use the maple tree in RCU mode.
Readers will not block for writers.  A single write operation will be
allowed at a time.  A reader re-walks if stale data is encountered.  VMAs
would be RCU enabled and this mode would be entered once multiple tasks
are using the mm_struct.

Davidlor said

: Yes I like the maple tree, and at this stage I don't think we can ask for
: more from this series wrt the MM - albeit there seems to still be some
: folks reporting breakage.  Fundamentally I see Liam's work to (re)move
: complexity out of the MM (not to say that the actual maple tree is not
: complex) by consolidating the three complimentary data structures very
: much worth it considering performance does not take a hit.  This was very
: much a turn off with the range locking approach, which worst case scenari=
o
: incurred in prohibitive overhead.  Also as Liam and Matthew have
: mentioned, RCU opens up a lot of nice performance opportunities, and in
: addition academia[1] has shown outstanding scalability of address spaces
: with the foundation of replacing the locked rbtree with RCU aware trees.

A similar work has been discovered in the academic press

	https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

Sheer coincidence.  We designed our tree with the intention of solving the
hardest problem first.  Upon settling on a b-tree variant and a rough
outline, we researched ranged based b-trees and RCU b-trees and did find
that article.  So it was nice to find reassurances that we were on the
right path, but our design choice of using ranges made that paper unusable
for us.

Changes:
 - maple_tree: Fix bitwise for logical operator in mas_validate_limits()
   - Thanks Dan Carpenter
 - maple_tree: Drop typedef from header - Thanks Matthew Wilcox and Li
   Hongyu
 - maple_tree: Fix mas_empty_area() wrapping - Thanks Sven Schnelle
 - mm/mmap: Drop VM_BUG_ON() until better tested - Thanks Yu Zhao
 - mmap: Fix hugetlb accounting error in __split_vma()
 - mmap: remove unroll from vma_expand() - Thanks Hugh Dickins
 - mmap: remove unroll from __vma_adjust() - Thanks Hugh Dickins
 - mmap: remove do_brk_munmap() optimization - Thanks Hugh Dickins

v11: https://lore.kernel.org/linux-mm/20220717024615.2106835-1-Liam.Howlett=
@oracle.com/
v10: https://lore.kernel.org/linux-mm/20220621204632.3370049-1-Liam.Howlett=
@oracle.com/
v9: https://lore.kernel.org/lkml/20220504010716.661115-1-Liam.Howlett@oracl=
e.com/
...and
https://lore.kernel.org/lkml/20220504011215.661968-1-Liam.Howlett@oracle.co=
m/

v8: https://lore.kernel.org/lkml/20220426150616.3937571-1-Liam.Howlett@orac=
le.com/
v7: https://lore.kernel.org/linux-mm/20220404143501.2016403-8-Liam.Howlett@=
oracle.com/
v6: https://lore.kernel.org/linux-mm/20220215143728.3810954-1-Liam.Howlett@=
oracle.com/
v5: https://lore.kernel.org/linux-mm/20220202024137.2516438-1-Liam.Howlett@=
oracle.com/
v4: https://lore.kernel.org/linux-mm/20211201142918.921493-1-Liam.Howlett@o=
racle.com/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/

Liam R. Howlett (44):
  Maple Tree: add new data structure
  radix tree test suite: add pr_err define
  radix tree test suite: add kmem_cache_set_non_kernel()
  radix tree test suite: add allocation counts and size to kmem_cache
  radix tree test suite: add support for slab bulk APIs
  radix tree test suite: add lockdep_is_held to header
  lib/test_maple_tree: add testing for maple tree
  mm: start tracking VMAs with maple tree
  mm/mmap: use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: use maple tree for unmapped_area{_topdown}
  kernel/fork: use maple tree for dup_mmap() during forking
  damon: convert __damon_va_three_regions to use the VMA iterator
  mm: remove rb tree.
  mmap: change zeroing of maple tree in __vma_adjust()
  xen: use vma_lookup() in privcmd_ioctl_mmap()
  mm: optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: use maple tree operations for find_vma_intersection()
  mm/mmap: use advanced maple tree API for mmap_region()
  mm: remove vmacache
  mm: convert vma_lookup() to use mtree_load()
  mm/mmap: move mmap_region() below do_munmap()
  mm/mmap: reorganize munmap to use maple states
  mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Change elfcore for_each_mte_vma() to use VMA iterator
  fs/proc/base: use maple tree iterators in place of linked list
  userfaultfd: use maple tree iterator to iterate VMAs
  ipc/shm: use VMA iterator instead of linked list
  bpf: remove VMA linked list
  mm/gup: use maple tree navigation instead of linked list
  mm/madvise: use vma_find() instead of vma linked list
  mm/memcontrol: stop using mm->highest_vm_end
  mm/mempolicy: use vma iterator & maple state instead of vma linked
    list
  mm/mprotect: use maple tree navigation instead of vma linked list
  mm/mremap: use vma_find_intersection() instead of vma linked list
  mm/msync: use vma_find() instead of vma linked list
  mm/oom_kill: use maple tree iterators instead of vma linked list
  mm/swapfile: use vma iterator instead of vma linked list
  riscv: use vma iterator for vdso
  mm: remove the vma linked list
  mm/mmap: drop range_has_overlap() function
  mm/mmap.c: pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (25):
  mm: add VMA iterator
  mmap: use the VMA iterator in count_vma_pages_range()
  proc: remove VMA rbtree use from nommu
  arm64: remove mmap linked list from vdso
  parisc: remove mmap linked list from cache handling
  powerpc: remove mmap linked list walks
  s390: remove vma linked list walks
  x86: remove vma linked list walks
  xtensa: remove vma linked list walks
  cxl: remove vma linked list walk
  optee: remove vma linked list walk
  um: remove vma linked list walk
  coredump: remove vma linked list walk
  exec: use VMA iterator instead of linked list
  fs/proc/task_mmu: stop using linked list and highest_vm_end
  acct: use VMA iterator instead of linked list
  perf: use VMA iterator
  sched: use maple tree iterator to walk VMAs
  fork: use VMA iterator
  mm/khugepaged: stop using vma linked list
  mm/ksm: use vma iterators instead of vma linked list
  mm/mlock: use vma iterator and maple state instead of vma linked list
  mm/pagewalk: use vma_find() instead of vma linked list
  i915: use the VMA iterator
  nommu: remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   217 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |    16 +-
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     9 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/coredump.c                                 |    34 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    62 +-
 include/linux/maple_tree.h                    |   684 +
 include/linux/mm.h                            |    78 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    73 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    57 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  7102 +++
 lib/test_maple_tree.c                         | 38206 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    36 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |     8 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    56 +-
 mm/mlock.c                                    |    35 +-
 mm/mmap.c                                     |  2156 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   249 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/include/linux/slab.h                    |     4 +
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     5 +
 88 files changed, 48439 insertions(+), 1880 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.35.1
