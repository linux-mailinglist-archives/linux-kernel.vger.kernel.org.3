Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576DB57852E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiGROSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiGROSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:18:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FBA1FA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:18:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZHNq029595;
        Mon, 18 Jul 2022 14:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=Hn8scAS4SW8pHEJOkFqQLu6M0o7J/m3JbAE4tacqOl4=;
 b=m7V64PGupmsZ9pUDssDTf7T14jo4lBB6PkTr6kbhEhMztckLFi1cIeExbH7LWdeS3e8A
 NjHcG12LVNhWRifICuu1IScSVYVTkpaDyuEtB3MFKlI2a27xrxjoD8BvayNc5h8H9eTC
 qy0JJjeSq2djxyoNwDaViqQ5dgCi4m1+WcKGhvfMxIigWR/MegRt5Q030KaoweXeqFX2
 2UOy9tEwAtDGUKskfPCRWy2okqbDDdpq4YifWmoYYdoyMmrXpbaiW05VSQNz37o7NdI6
 K+N3nlXZ0IoL1BDid/TFA0BDv4VB3TJRcogs3HvSdZCcy1kdZTDJjaUVHeuSfZrafAqt fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtbdgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:18:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICLdP3004177;
        Mon, 18 Jul 2022 14:18:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3v490-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUVed9qZ5nSyFQ7aDbewYy+BEW8yItKTNAT2/Sy4v2Y+Za/mVwBwwqbtIO68X0Gomh3KNarsUaEbZhFRrPN37HYz+fXGOWYlCQw/B2jy/IoZ+r+qpw2i4DOoq2sBb3/4ucfh0MbnHaO04nv/Zde1RGHTzni2WEaDJ29F4V97g0gJI5mkkuEzIYeyeR8j/0v4wQVfJ1bx+pAELlkIBxTVPuEM6Cg8LAN3/cS+hdrrKv+86seePvsRetEGV0BZ4NwR/a5PJzx5l/Lxj5GahOtqCw07CMhxu9j0lqZqXbUBhq/eA9hJqVVypTZ8rbX9zbRVNxDBRkP4f+RnEYy9QUVoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn8scAS4SW8pHEJOkFqQLu6M0o7J/m3JbAE4tacqOl4=;
 b=SiNxW5hR+HvQLpHWcSpud7Oz/WjPSFVML//ga7dpeRuACkO342I13ZaALyMbXiSFxl6CRLc9B0LR4n1kUSjaty917RoqezGp7yk0i77zRvE7+XYYsjcnMxPffpxOUFwk7pJ/1BHcuQ80w19eDJsT1lkRv5LhxZ7Qg4BkLmPG8ftzOOL4eSj3qskQbBZybrEtzgj2EihzwLlVwe0q12Bvh85ZL6e6WRlTC4t/BNduU1vgF4pxRacv/zYJ/eWJlLPuc3roxn69WAkMkFbqh/8AG5KrMm1Zk4epIPK1RHWPU1lv5QUA39s/HJAYOwTfC2Yg8WxRe2zWCZdCgCNizffb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn8scAS4SW8pHEJOkFqQLu6M0o7J/m3JbAE4tacqOl4=;
 b=LQ8u56PJxKxykdyXl6cW7vqn87PJo+bC9siMY2mVVkENwoXPCB62vU31oIdIFNlHvcYHaMd7atX0If18gjALozGBEeiGXArlSULYtj0GUd5V2hTB2vpEFRL+JpCZBgj3YokvL/qlJtjQ/VS46tQmwMkQOQ70Oewt0XDI4cRiym0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3811.namprd10.prod.outlook.com (2603:10b6:a03:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 14:18:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:18:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [RESEND PATCH for v10] maple_tree: Fix stale data copy in
 mas_wr_node_store()
Thread-Topic: [RESEND PATCH for v10] maple_tree: Fix stale data copy in
 mas_wr_node_store()
Thread-Index: AQHYmrFCz2uoTyd9lkuIUcTlC7rTIw==
Date:   Mon, 18 Jul 2022 14:18:31 +0000
Message-ID: <20220718141818.2569416-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cd4d917-6bdb-49f0-71fe-08da68c864c7
x-ms-traffictypediagnostic: BY5PR10MB3811:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdgAds4XcAVLcqdFpQrrDQW19i46bJEMJEJTZhhq4jUNnF/1yTc5eRSdGDTBgI7++DfA/6dSTuCI2JxpSe4qlRAP4cPu6/aWLIFs9zPfL04QnF7KYN3BXRycKQuPVu3LD2FfeFM1dqghFwjfKrDK9WZKyk6ttfUdICeTYF7ti6KV7VBWx2Vq+iHfqYvOgRg8v765Dw+YEZCJcEHvvHSxtV/DpOPpGy7kYvsdkKGBsh/N6F4ctZX53aN/Ug5Gq6k+QgAKs2g54itlRlOKOVFB/5qTqDKs+boZkW0PWciaCx4K0ojWSaeYqV+OKHR/j8DhCds1dk3GldbpBezTZBd1i3uAsYlwz6cC+RXKFtLdDksA5SAMyYjIs/zU1ydTdVIBoI0N5xOco9d5UGsyCl5Dcps+9hhArENHFrCbG1htJnnBsUFU77UutuBj+wD7ef5g2WrETDAvV4tiZhYj9R0/r1wJjgOCt5lBBmtTG2FmepV5vwjNiOnkp3Dy7XKZ30CSMl6gAqNx7b9H4URkGKmTWXNEtGCT7w4FW25Vk6DQ4FZ0nNcAtPLhpHcqP2RNY+9/i0seFAKqnFBLwamYvNCQQZwukfwcX2GxrqO4Ui5CoLrElioCY63M1GbkkY5O+C0BnnnDk3sZQGHfV/X8/jsEJbEOc2cPlsl8BRecpHvrCKloKyyqLoIOuaszkzhE1WyuiHDMeGFnUBr4JSByOGn3JaV8fdkj26ADmq63Ugz6Kb0sQilK5KtX3hWIRSZTKKEnsgwjXHzYVePKh91gdFNrOdMAmXPmTLOfFYHJXhd2ED8P99ex/OfUhC65PndZRHqF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39860400002)(71200400001)(6486002)(478600001)(41300700001)(26005)(186003)(38100700002)(1076003)(6512007)(122000001)(6506007)(83380400001)(38070700005)(2616005)(2906002)(110136005)(44832011)(8936002)(86362001)(5660300002)(64756008)(8676002)(316002)(66476007)(66446008)(66556008)(36756003)(66946007)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TH9WBTzZVFYZHGgomSUQGhswc5uVK2wuH+FBAKxJM5IZhoTrDO9ZjfWDhk?=
 =?iso-8859-1?Q?QXVd6fajgDhWbK7It3djbipnwICseRmyKQyE5RYCvZMJZcf5WZulRLnybU?=
 =?iso-8859-1?Q?f90l7SmEtwXVpwmNAueiM1B0hRbHaB1iotrSR5mMPjG2NPahpfEgNENWxA?=
 =?iso-8859-1?Q?PEApGiWOCb/yGs6tH3lnnNpSTfItCfxbwU6ks50Dkhv7BFL3bxCCbvQoei?=
 =?iso-8859-1?Q?9OyISeGL9KzWqo9qn/4zFmhj4/cBf06AY6xUjo4xU55PfHSpBRZaR0S11f?=
 =?iso-8859-1?Q?F32xf3/SXxvI0Lv/UPzvdehjZTRjBsZOjHeC60jDwd9IrDsuyokQca0nwE?=
 =?iso-8859-1?Q?oSo8xvpxjdHvaaAp0Y2BuFWfr/cRo9WFnYBMAMmLjnvCKoXYGjn4RSfaJz?=
 =?iso-8859-1?Q?Wpka10b2GuMqY7c5yV3egBnmDp6uDDFfm/9NKnS3bJUJLyCiDnco+tJ1DH?=
 =?iso-8859-1?Q?ZP9sXsBBFl2PFFc2Y7LUr7a4ssrR7K/asAlSn1+O1YJVlD0ZKAZCIh6CA7?=
 =?iso-8859-1?Q?5lAt6mevUL3QtQYfHNeAINlgDgWWTppxZbUU8pc2uvnc6wgmLrQLvWh3ij?=
 =?iso-8859-1?Q?lTgXzbz6iNqeXI07Ua9+umJYC1VQ2ntovMkC80x8n4YPVFV4tXNWWAGSTA?=
 =?iso-8859-1?Q?0l+LyvyVgCYbAuBmi69lQEnIhFeOtvbSdv0cDGDbe4x3fC2iZsPGDJt9AK?=
 =?iso-8859-1?Q?c6KBp5BVOHznZ7EJWNKjwiMoCSugak1FTzPat2/KiIcQLp5eHNctFEne0Q?=
 =?iso-8859-1?Q?3QUyzpckZE4YJpcnLro6Yhofr65XhRKgaifpEJ+Sevyi92DAva3kh2Q8/J?=
 =?iso-8859-1?Q?mqQmmYaZz0eN+UaSghYTkMFZ6d66shmb6JA/FY6G7wesT+PCC5SNR/bNt7?=
 =?iso-8859-1?Q?rpw9EvaXy0iNDcry9GAauXtKHa1xjhGqlsWs3dB928K1pcEILelg6do5Vc?=
 =?iso-8859-1?Q?ePDV8zBJ3lDl4ezglXiF0jSYzRyxaqlxUdSUjDeFebjWgpcltsvdkkODXo?=
 =?iso-8859-1?Q?yZlhnySjNLXaFGzO/8fwYo/vJ71U+KXT1jRqhO4fRBMJl3+v/A9lAmq8mz?=
 =?iso-8859-1?Q?KJhTz8ezkniucZsgdVQh8CktlR22FlHDWS7Obl70SvUW3b1jlYBJOj+Xy0?=
 =?iso-8859-1?Q?2o0gG+szffHlLJEkUjtgIDyHO6ZDi03JPziOmEINvW7q8qltr54xFmR+eY?=
 =?iso-8859-1?Q?l3dvohdX8S4FE4NCZQFS4GXbaF3Wid/dBaETQNK3c1A+WsyyzpY9Wg2iTc?=
 =?iso-8859-1?Q?G0nqolJgh7c7aHp3iWTqc/mIGpekwbKdI2ctGY/VHiv1Z0RKFmZy6WNMCI?=
 =?iso-8859-1?Q?8aYr2UGiXxBdSaVugimuhPI8k7Lp71K1WfFJcNQ0YFyGgJtkJCr3X8RvSh?=
 =?iso-8859-1?Q?S0lFWvR6LC0IBEFqnALwaJ5Nryt3qaqgNrH4ta8Gc13zRgw3CEzJSDaaQv?=
 =?iso-8859-1?Q?TrJwe1rQKKpZmHSaXik+U4LC0O4hAaE07HfxNh+MxUGEgeQ1h5ZzkCHkHB?=
 =?iso-8859-1?Q?RoKOEnJo1oYZ61eTEhoj+pUFhtKGmszL5xV9zj9rq3aZjQnwcu8ioccog/?=
 =?iso-8859-1?Q?U6p/DUxZpowdAnwcHEewGPmb5UL0FrY0n03P+mXKvJ99H+C90CnGkP4Suc?=
 =?iso-8859-1?Q?AzcdiO86pI0Op/zhjKs9e6+CMymXCF/QbqCsghUgfmAT3h+8BckVE2oQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd4d917-6bdb-49f0-71fe-08da68c864c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 14:18:31.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbkAfuKpxc7wLa1XmPIB4PTlXORshz2oE1Ex4VdxffBOVmN2Nwot2GgKuL1x8x1cj3M5LDGhIOUOIN1Kkb0M9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_13,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180062
X-Proofpoint-GUID: eQ_gw-AhrVqu0t3cfVcb9AqVNCUUQ6iF
X-Proofpoint-ORIG-GUID: eQ_gw-AhrVqu0t3cfVcb9AqVNCUUQ6iF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already in v11, but I must have messed up the emailing of this
patch so I am resending for completeness.

When replacing or reusing a node, it is possible that stale data would
be copied into the new node when a store operation wrote to the node
maximum value but into lower slots.  Fix this by skipping the copy step
if the range being written is the node maximum, and skip setting the
end pivot in this case as well.

Reported-by: syzbot+b707736a1ad47fda6500@syzkaller.appspotmail.com
Fixes: 2ee236fe53a8 ("mm: start tracking VMAs with maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 56 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 768707770926..6583c2c1145f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4120,12 +4120,18 @@ static inline bool mas_wr_node_store(struct ma_wr_s=
tate *wr_mas)
 	if (dst_offset < max_piv)
 		dst_pivots[dst_offset] =3D mas->last;
 	mas->offset =3D dst_offset;
-	rcu_assign_pointer(dst_slots[dst_offset++], wr_mas->entry);
+	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
=20
-	/* this range wrote to the end of the node. */
-	if (wr_mas->offset_end > wr_mas->node_end)
+	/*
+	 * this range wrote to the end of the node or it overwrote the rest of
+	 * the data
+	 */
+	if (wr_mas->offset_end > wr_mas->node_end || mas->last >=3D mas->max) {
+		new_end =3D dst_offset;
 		goto done;
+	}
=20
+	dst_offset++;
 	/* Copy to the end of node if necessary. */
 	copy_size =3D wr_mas->node_end - wr_mas->offset_end + 1;
 	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
@@ -4133,14 +4139,16 @@ static inline bool mas_wr_node_store(struct ma_wr_s=
tate *wr_mas)
 	if (dst_offset < max_piv) {
 		if (copy_size > max_piv - dst_offset)
 			copy_size =3D max_piv - dst_offset;
-		memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end,
+
+		memcpy(dst_pivots + dst_offset,
+		       wr_mas->pivots + wr_mas->offset_end,
 		       sizeof(unsigned long) * copy_size);
 	}
=20
-done:
 	if ((wr_mas->node_end =3D=3D node_slots - 1) && (new_end < node_slots - 1=
))
 		dst_pivots[new_end] =3D mas->max;
=20
+done:
 	mas_leaf_set_meta(mas, newnode, dst_pivots, maple_leaf_64, new_end);
 	if (in_rcu) {
 		mas->node =3D mt_mk_node(newnode, wr_mas->type);
@@ -6946,19 +6954,20 @@ static void mas_validate_limits(struct ma_state *ma=
s)
 {
 	int i;
 	unsigned long prev_piv =3D 0;
-	void __rcu **slots =3D ma_slots(mte_to_node(mas->node),
-				mte_node_type(mas->node));
+	enum maple_type type =3D mte_node_type(mas->node);
+	void __rcu **slots =3D ma_slots(mte_to_node(mas->node), type);
+	unsigned long *pivots =3D ma_pivots(mas_mn(mas), type);
=20
 	/* all limits are fine here. */
 	if (mte_is_root(mas->node))
 		return;
=20
-	for (i =3D 0; i < mt_slot_count(mas->node); i++) {
-		enum maple_type type =3D mte_node_type(mas->node);
-		unsigned long *pivots =3D ma_pivots(mas_mn(mas), type);
-		unsigned long piv =3D mas_safe_pivot(mas, pivots, type, i);
+	for (i =3D 0; i < mt_slots[type]; i++) {
+		unsigned long piv;
+
+		piv =3D mas_safe_pivot(mas, pivots, i, type);
=20
-		if (!piv)
+		if (!piv & (i !=3D 0))
 			break;
=20
 		if (!mte_is_leaf(mas->node)) {
@@ -6991,6 +7000,26 @@ static void mas_validate_limits(struct ma_state *mas=
)
 		if (piv =3D=3D mas->max)
 			break;
 	}
+	for (i +=3D 1; i < mt_slots[type]; i++) {
+		void *entry =3D mas_slot(mas, slots, i);
+
+		if (entry && (i !=3D mt_slots[type] - 1)) {
+			pr_err("%p[%u] should not have entry %p\n", mas_mn(mas),
+			       i, entry);
+			MT_BUG_ON(mas->tree, entry !=3D NULL);
+		}
+
+		if (i < mt_pivots[type]) {
+			unsigned long piv =3D pivots[i];
+
+			if (!piv)
+				continue;
+
+			pr_err("%p[%u] should not have piv %lu\n",
+			       mas_mn(mas), i, piv);
+			MT_BUG_ON(mas->tree, i < mt_pivots[type] - 1);
+		}
+	}
 }
=20
 static void mt_validate_nulls(struct maple_tree *mt)
@@ -7023,8 +7052,9 @@ static void mt_validate_nulls(struct maple_tree *mt)
 			offset =3D 0;
 			slots =3D ma_slots(mte_to_node(mas.node),
 					 mte_node_type(mas.node));
-		} else
+		} else {
 			offset++;
+		}
=20
 	} while (!mas_is_none(&mas));
 }
--=20
2.35.1
