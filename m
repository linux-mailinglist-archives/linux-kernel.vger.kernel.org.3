Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D59E553BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354520AbiFUUsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354384AbiFUUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0922D1C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2axH011598;
        Tue, 21 Jun 2022 20:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8Mc6iVgyfVpI85jXTil3GVWdKwgFLirCXDRksCdowcE=;
 b=a47WNe4ucJZpa5c0NPd3Fuv7LKPLrliXo/xp13BXkI3VzXqmUbiTKHhy9QA0BzyxN1P8
 op9u3HY2N66WaJ9uWWx+GAK7P9PLA6QjWlx63NprYL57KD9zc0pYCAUNx9lXz56X6NSg
 znhvKyjpx7pQJbt3AVo0nSCDDK6treHi2v3aGvSPjpx3RW1x8+eNeiIUUBoeGLbbEeAc
 YlUY+fEs50gJjMATlHoWnQiLNUTlgiFfw21gZIZb5dlN7PASbDoQvI+/f/Y3SiCVme/G
 3KBR9o5VWMfP0Dh+C4DIrjFGQZ8W/ekAw9mcY5azpKNkdqKDUjVIBnkaRP6LNWUjszsp iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eq8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKembm037937;
        Tue, 21 Jun 2022 20:47:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us8n9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCcUTJz4uTXRvBnqa8RlINSVWD/Ko8/WAn5/QHnNTPDIHOmX+zsqWCRqVy+N49tD9JhyR24TEV6ynhVJmBiT5KZGHBg3Cc8EdAebqIcsP6QJBTujolRJtwozhQzTnzkvoLKaACYRmA8Cni7jrGY6zJNk7K/ZkDj9Z+hRhsDBtDD0A8GTCSpT62se/JtqXUcor7GEKQDFfJEfnSIIh+EP4rp9BKsygUsT7E4HkaJ6uBA0VEf4/022FbYDe8t/9kfAZISHI1n+g4i761/M1wo/d97nUF81oE6ONedfn+lqdlN56uVamy3SF7RiiIpfDG4q2BrTAPkzPTYofFeWAoVL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mc6iVgyfVpI85jXTil3GVWdKwgFLirCXDRksCdowcE=;
 b=CDVkUdeSv25lsqpk/K84BcEXCTViX9rj0O+f8JmRCIJboyKvfy4iDc4xZVytoFoIaoKwWXQDzdN8r7WcFcThXnU0SpkpR/XtEbxQd8GC9awTL0AbKmkkTrIIdKiW+pIWvNnROD5bP2lTgCjsHC1jUqcBZZ5ZvSEDAp4TuBy/yY8UVILFimcQ1Qe04cuu5s+OHq7+Qa8XfEEN1kzSxu87vF0xno91nrYSXVY/M/vgSGp6x3rQ46Z7TaisWhP/Om1VX3cPu+F1dztGMb/hotuAbOa3cM8p/a7Kbg70OmZxmX9wmkBIiF0/JXsBvMDg99IZhmUm7cigcyQ/e82FBut2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mc6iVgyfVpI85jXTil3GVWdKwgFLirCXDRksCdowcE=;
 b=MYTvxVP28XlvJvaP10FZELU6esanQ1BxLOcFfQisGUsIdhY/rqkdA7lQITnp/Kc4bGUeYfnd0LSH61UkuGXmmBkJmP6vdzpisfTzzStuvhMXwPPtJyzgypTnHL9OqGQB21fEUj1NPeI8Wv0EAzJcrF/j1fJtIQu80iHKlZDrmts=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v10 12/69] mm/mmap: use the maple tree for
 find_vma_prev() instead of the rbtree
Thread-Index: AQHYhbAKWR90m9n/e0OhSgs/pJLosw==
Date:   Tue, 21 Jun 2022 20:46:55 +0000
Message-ID: <20220621204632.3370049-13-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81cc9d4d-d389-422b-2885-08da53c731a5
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30859A436295B568D117CB67FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mO8nkZhkq5/O7YOPz3rqmBApRDhGqGk5gJAe7RihnupHiYkUgJ9UTz6ylBMBoRH0X3g5RIcLEec1kCcWY6h6yNoqj2tD8nEmvkOyiDzarM8Hc52Bh6WAvGH7wBXZlkMhweC/euFTOS2zEuqUD0f7kyIrpMkOQbAEXMElcPWj7HaE7pxAu3oQIkQQjh8OPGmxfcUUMZKRBfpmI0BEqlHJdLg1QH/m8pyPufCmRzx6smD5nIVdlHXZQtWUn7Xn9GofWAnxiTVtcD4xifLeybVrDsTgOvRm5cA2W/aybLFIll0GvSGAgxk1s6nrVVhpjqVPJZ50gIQY3uoc6R27umwWfp77tR110nSMjHnTKqhf3pdXZ2rwzCqS1ofv6NStuKDk2mIaZPzKHgEjPKeN78ws+AsRpthqFCz7t7f/e+HiO9sb5ATB1tOXwEOF+wTkZYg37QcwhT3ozlQ+PwMGbPzA+5pfCTYj5QAJ1a8kBw8/IOqbunbamVW9kBZ9AkcPFYrJ2adTpmCn7QsENkR2orjwcRG180c6NN5hGlPaNB9qt/3GEIeeQ7NKvaY+4qLpj+t2+3gAVAHnjNnufsy0vTjTGKEqfTTUohI4X2hX8P05+oAJ/j3RRC/gMsfX51/WKjjapMOYlBLUR/xGPrYAQqlluTAf/OWurp3pXUEjZL5GQE4DxuDZwbmFbRXaKv9964JOs3haF3/nPVe4eOsPWGdQH5GeMnnvjlVr5HxB1CwHSIplgFLp+UHhqwCW6Quu5smw0zGpGx255PlSoKwnEmYcos/Y7AoIkmzdZXik5mBOUeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kydRA2SYYJ8DPi+kxlBaxcK39oWcPU9qcpd712+nDciPgeHevOdMMTsj6V?=
 =?iso-8859-1?Q?RoI9SZv80vofqc8pYF58BPbilm+VtDsJcSoqOctMMFqjUoJzlOPgG6aXE9?=
 =?iso-8859-1?Q?E8EFluvYqQOPxyQykKYi31EOJSGG7aWPj3VL3Kf7UcUJeCEGZ2LLUKVdR1?=
 =?iso-8859-1?Q?801Sm2Z9aRQjRTXNxaQGBhMlKTzcDykvUmjyYXw/Ss6mM+dNSR+dpzmARd?=
 =?iso-8859-1?Q?ZeRvE83aLeCyX31KrCZvMo385xC2Aln3iyPR5ecCaSwApS6adrG3XX6ob0?=
 =?iso-8859-1?Q?xPIo0BTE1j3Yg2+nCWlew2GTgQvNsUhdQd/1OizKRKTwbKivAFXxz4sxxE?=
 =?iso-8859-1?Q?Xkgq1PqYtt831VNhoHi9tzC0IvqcdV21laEvUpLoEBygW7lADB6KObVTKF?=
 =?iso-8859-1?Q?hvFYsZgijvlrldU7+ySq8LatfFvtBqU+bcMtNeCu+8G7L1BPo6EHVqdMKr?=
 =?iso-8859-1?Q?NKbnVfA/aF43QcMrxlxjnSNdYWN/f7GFnb0B28Tt/7pKK0+RcmYP4RcD8Z?=
 =?iso-8859-1?Q?AVTz3HGjplH/4iccEAkd7plQi3lh/+v3Tk4IYsFmbO7x5XZZikQNXIlajY?=
 =?iso-8859-1?Q?YA91PJLxy+D+HCUEltGnuefxPRz4bokbRPFqEHiQ/8o9AKhOUf74tNE4lg?=
 =?iso-8859-1?Q?/e2RrddZDPoGR2o9LrsG3rB5mHqn6pdDT9HSDY9IKnkRK32qOzq68lk8UQ?=
 =?iso-8859-1?Q?mj5g4PSZvycYiJ/Os+l5nFNpzjXUcfYv0AezsfP2KDmlQz4y6FSbZIvSnw?=
 =?iso-8859-1?Q?YEB+mP2TFNrnHOjFZ3mGv8DI6Pk/7nvkDCaqETaN1xMZe1RTC9hqQnSDga?=
 =?iso-8859-1?Q?H6k114FxKfGLmadziwubyjFnf9tDj9HsJ6bf5vIdov3yEZIUxd2AqkR6Dm?=
 =?iso-8859-1?Q?ePmYw49v2dFfoaBk26HpViOQch9ssUtR/f/wpHLbOq47BN3DOZ5nF+X9eV?=
 =?iso-8859-1?Q?2LYRANhiH2V3Ch0ZpME0o9VtcDDbK+5yZkrEzxSe8AulvUv9mR3wnnD7Ce?=
 =?iso-8859-1?Q?25UDIODrW/ahd6eFlR65alE5u9De3qP0Ie1gtvjWje5aNcnZ2uAyytWclI?=
 =?iso-8859-1?Q?+YNcpwEFeg/WAds2UALrdSpAYLmt6vy15NDeKr8JRpgUp1Amq73BqgP6ld?=
 =?iso-8859-1?Q?ebcPvC3QSdLpzdfn3x7enxoeqNTBD+zC5f6YadtgAr9BDe9LrdOuQMF71b?=
 =?iso-8859-1?Q?uWy9tvlshck1maW2uBvLoK9nWud9Eft8FVhez6azwgvDr+5jRcBSZtUVk4?=
 =?iso-8859-1?Q?SMkAl/eM57ImoLxD/EB/yz5+tY4K8mX8qrnpRksQ4lc1ckMERkxL4KDWPv?=
 =?iso-8859-1?Q?XRLf2xzWsJHSk9/BRvtHUXJejH4+E7+5HcjDAlcil+Eze1B668W3vm3QuS?=
 =?iso-8859-1?Q?W5Toyy54GbyMsYW/8BBBpPi/vXie3VMVlh3ZKwNr3tX5TkKPwl4Eii2awr?=
 =?iso-8859-1?Q?VUwlDBrT8nseDa89PnuZfFHdQnYOdaCbZXCSt9Ez6p/6sWpJteSAsE8djE?=
 =?iso-8859-1?Q?xiYGA6xdlVvrOdwLeggqsifLwl+nxn2MyW9bTgDA2XCyjk3UWZUociEJbc?=
 =?iso-8859-1?Q?wsn5leW+iuMpRcnbKEMrMeVJ0hLkRwXNtYh3JfeFrxNJOT+zoTLTG7psn8?=
 =?iso-8859-1?Q?ltotVNch3XHi/Qa4crhJUCoTQZADIPoUGUNIFG+/nsN8C5XLquzPBI6ct6?=
 =?iso-8859-1?Q?gufjjQTkKLllh5Q/R2EfoCX5N3+vhaCz3IAVApBk0ckcmoPBdqGIvs3dAN?=
 =?iso-8859-1?Q?/vgcWHtn878b+OdaYFzV06PSLf3fnr/wSPMiSVRgvPv7tN1iET7n8LZ197?=
 =?iso-8859-1?Q?u6FNgOih3ZyLnEXQ9sOZsV7ScYfcCPk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cc9d4d-d389-422b-2885-08da53c731a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:55.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CDPwlZTprsd+gpvvuT2d1Jm0lLEOGtgBOmctM4ZUkDuuXdycOqfdziB4QrksIuQGA90/Jj0bYoBWJFp9OfF5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: Umxzezvu2qs6B6GA3XFWZ0gNOpx4cg_K
X-Proofpoint-GUID: Umxzezvu2qs6B6GA3XFWZ0gNOpx4cg_K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Link: https://lkml.kernel.org/r/20220504010716.661115-14-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fdb61252448f..08845a0317bf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2512,23 +2512,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.35.1
