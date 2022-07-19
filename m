Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8B57A6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiGSSud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiGSSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:50:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB73D597
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:50:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGtjbV002381;
        Tue, 19 Jul 2022 18:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=lzR/Q+9W3o7oxQJPQQNX5zeUGZfoEqB5RzCpe0LEaf4=;
 b=gP+woQzVuQEG81VpvcnHgN9k6rvtQfbM/1DPFE8SGFQ34helq530ZrLGFgJ4mSvD6v8M
 315wUtKWFR3IvrlL/KX5IYLC0UtIlV6zpFm1vwqwNi7OQMGiOgSypjugiIBlkqyYx02W
 y1/QyvsNmr3nuxmhufuz1lqfQN5h/Sv7wdq/61F8XGjJmgJyoWDf4vvZ+ANXsiEK2ZYe
 gVuQmiGXmhDxVGH1Jo+KkXqhhMv8mauxzDBsz1fgIvmvYYpoXVe0b7ybsd35rvDoWBlP
 f6hXYZfofkFbopqO35gZj7EQfazxnOk8AcyixjZmMPa4RVEjjIZf6Juld00qPi1t9l71 zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a7asn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:50:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JHwCvW002728;
        Tue, 19 Jul 2022 18:50:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbdeyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CObhCdHHgiFq1eDQgbDfEeL0AgZT0/1EUSZa6CXpyh3CkH3OwyFXoc5XNWvQgL8H4fdc2nn5hsOX7JTEP13hQc6YL+qa3cTLlqunNCjdIyKPaNSN81V8ExjVwnlPTCvcBdHnjVfpP9tMQLWCmhvGrR7a65UA5kOVNn/FjMbQ/pN5xnV5phC15eti1qzO4cNAWoXTPiS8SExVQj8bwt+5xxFU4MC9AlaUNQivibKZEBNcgw10dWD7wdjc5eUvaO+K+gvxcjv0nnsVZCQrvotHv1UtMwMvx+taddOfGyfYEnpBNK3xv+fVuebTq6jvAgrcTeT3p2GjZIlENXlGYyhceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzR/Q+9W3o7oxQJPQQNX5zeUGZfoEqB5RzCpe0LEaf4=;
 b=nhKpzFVVUFRZoVieTk3JBUY5bnUaKjEc9ItL0Qmv3yi8xgFTxcXU+U9BraTMSJ+OViGb/N0uwU4O7nf55fpOr6ZS5Eie04YHIjCrrAf6oSyJeN1F1dkTyEP8Lq756X9mhPUSnVCSdX3+rfK/lz4qBdtBfIWHcD8Xa7YkDvv0vzp9IaXL9OtOJMNDfXR8g2rIol9o5Ne4vH8kA31Qi/ZexeZxH+MaWiR2cIPKAruTY5RwBzyzbbgm0LYZnSAqGfEnMrQTCkq2oR+EzfUPSE1K8YpDxR8jctQUa9Rx0NUIdkroTC0yXyZYEtUnLsn1TEJe09i5snVsIMvnBt+jEI0OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzR/Q+9W3o7oxQJPQQNX5zeUGZfoEqB5RzCpe0LEaf4=;
 b=fCGY6Jsu7TSE1ibyMitqxoHv+ZJ3NAmjNP6QZ9Z8b6O4kXxmj5haKLWUIc3pn0vLeIX4TWvLG7DFPYqEyemALAnC4xkGfRBo98CDrXqhlCUOGqYQv2fP0NWpnP7x8frDlp1rG9k9YLppyxUUx6c3pCeCJzCjmdFsjyPUxJtw7V8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB3326.namprd10.prod.outlook.com (2603:10b6:208:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 18:50:01 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 18:50:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mmap: Remove unroll from vma_expand()
Thread-Topic: [PATCH] mmap: Remove unroll from vma_expand()
Thread-Index: AQHYm6Ba6xCVZdMO2E6hHTKAiuM4zQ==
Date:   Tue, 19 Jul 2022 18:50:01 +0000
Message-ID: <20220719184959.3360032-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd393cf5-c548-4626-3d03-08da69b77c8c
x-ms-traffictypediagnostic: MN2PR10MB3326:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMpA4ba/L74dowUzVllN1ypL8CCfRlBa+AItaWzPuzqponBt3tXZJe/1CiQkzM5nJ7g3ZI7LiCYv1UEmvG+BEB3ZqVFhPisioR6VodFU+ZUdT1Eb5S7q0vOxBHGhoF6bheaBArWGRK+ifdhGFr4YY0BLiP3J+leIE/hREXNuiMHvx1yROHMTcKUU/XNfOE6tUW/IAwkUzpI4HXypYHCo68FdT8hk4PEN4IzCPbk3aDD36pda6Uj/AR6XMxqGKj7JcMWiK2x1w5ScPnxh6zAaleYQl/m9BQATyJL24MZAvyOEkHC0WkN/vxRexTFj1tlOQoezkIOY0FuA40xbBCMg+T4P1kZVOmEDOGuyfzBqxBdWlarn3Ja+cPhTs3Vk7ux5Phslc//z6kfWI6nWoAO4JgXf7UHyuA6I8Vh532sKspxBW6e//c1HmHuoIGpcKIuAVk3A3v0NTbG/BpNMhmJsetSzvTTqYIbiFP6B8uZANTFg4uugftmqc9hue+Klyy35qfW/eD8sj/cGq8R4yfjMtcu+7W10ndq+KrknKeUgNj8riTWR8Jr11fTx05Ye84NG9RoTmHDsIkfpx2Y6EsieFeEHKi9W+QcdTm2lV0n33HIsw8WHq005hIzxttNFXjCkbdl80ydbP4AcFfu8VPDtALvMNbVvUXpPb4omMkcDZ+di+ucKIUdeFAfaQw6BPe8eNOAlWzsW5+739gV7xzZJ4OxA5DeU5kLzsjV/WIgOAX9VCnS+/585hlPsUczaoqbLUFBXqvIC+yq/tbUObwHgYDVqz9Zgo78RxAizCbY/ViQpjTBq6qCR7Z8og4vWhG51
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(122000001)(66476007)(8676002)(316002)(76116006)(110136005)(66946007)(66556008)(38100700002)(91956017)(4326008)(64756008)(66446008)(71200400001)(41300700001)(186003)(6486002)(2906002)(6512007)(478600001)(83380400001)(38070700005)(5660300002)(2616005)(36756003)(8936002)(26005)(86362001)(1076003)(44832011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4ASO0vm73rZ1d7FES70dl2kDUUjdrvSkTIVOO5C4hRs2qCtLyvXhZ4vCFL?=
 =?iso-8859-1?Q?AqAj2J9vDKaGdIo85hXrlipKCCwsYdAAjSciI/fo5FDx47vX4vNcz5Vsa5?=
 =?iso-8859-1?Q?vHnXuDF4nj77BST3XO8PX6INiAHrZLvsC6Ycgqaax40vzGwlCT1n3b2kP6?=
 =?iso-8859-1?Q?/OMqYfGXACT24Ryj/q4x6X82hf4GfRpeXgQr9sfykyDUh0ysC7Lrw3QqVt?=
 =?iso-8859-1?Q?svDDPaF2/26OHVLeG89TBS1uBrnM5F8Y49/KutcNWUp3FWAz+iNX1BLd4q?=
 =?iso-8859-1?Q?S1inqAcvyUm0LtQ8ZWwfb1oZHchMYA9SPZ0p2pYWIz240fYYPwvx4Ekmnh?=
 =?iso-8859-1?Q?sPmOTl+IOMu5n1o3x74Gcse72TcowT2W9EWNtj1tiKTHRVxe33RxqCV9pD?=
 =?iso-8859-1?Q?DDPoElIrKwk3sVPtIzCiZSQ69RwQEUaS7anwDgk2UH2gcrcOcLdhGpTX4M?=
 =?iso-8859-1?Q?EMnHxZtLbf54Y5ndAbIezpvg2JwIKAe4w8G2QicynOD5nZ/wgVaTyOqa28?=
 =?iso-8859-1?Q?dhuk4WTpKgxxlmSB2aJjTM234pExQAuMOb8WYcAP3xul+u462bOYfN7lbn?=
 =?iso-8859-1?Q?0NJhHQk7tFxMOzb8E3v14SAkXgX64A521+M77E6ygZInoIAs7QrGvKu+1l?=
 =?iso-8859-1?Q?+CHIZklPmFWnvQ5hnVIMqNNmO7VGh2vwELAvt0tKPKftyQmC+ZlOw0yyE3?=
 =?iso-8859-1?Q?mzpyOm36dTCKeiSxZ+vOfAJaqTxKkjVKhaYct8Dn8ullIlF26PDzIs6HbM?=
 =?iso-8859-1?Q?7irMR78zW79bbgEcrMrR014V1xNFD/4YCR2OhJEhGNfeHgA/Lb1DGxzme3?=
 =?iso-8859-1?Q?HEfadGLuAhmPC+B5MOjbdzjt0/sD2+kSa8oq+phqWHPcGz8QltsqWrSJVb?=
 =?iso-8859-1?Q?MMBqF0ua48FnwCnjI1S/nFlP26amoJgxBPRPcCpvsUdpDztZr212rvdKUi?=
 =?iso-8859-1?Q?+46aRE86pS8luJxqB/Sn7L/Dvc9j4XZG7UylpBKSJO0d20qL1NrctVUMJz?=
 =?iso-8859-1?Q?1Wt+xmPnRajnRc70d9iIzB/6Z0LVdMkrTKkz99zQVWcWerZZeCdShXOaFi?=
 =?iso-8859-1?Q?ngAz16cytU6ARyJU/iBG8AKdJno2fr+H4kavIaKOtHJuaiCojmCWXyO3dv?=
 =?iso-8859-1?Q?FFSZGsa65W0qu4ghTTwfVu3F/TmjoZDv5PZvgz2ZjGRtsShT2IQbhtFlbF?=
 =?iso-8859-1?Q?WgGbELwrcZyohas/SKDPe/WQv5lLjVIsrSArLeoFed1es4T6j6VoJXJ49M?=
 =?iso-8859-1?Q?0fcYVjpT4EY7qWgFNkulEvF5A0ZL3/wJupUXPQQH9xzJ30KF78h0N7opSJ?=
 =?iso-8859-1?Q?jIJE+DuVp4ZlWDwI7OhgFAxtqMTHnKQ9p00wh745qPN2eMDGp580dokGt1?=
 =?iso-8859-1?Q?J9OGoymrS0HWo3D+HbMUsE3CKjTq58mmyyed7ht+eN0Lx6x7CTlmiA7Kdu?=
 =?iso-8859-1?Q?8fIAX54UwZ/Aw73VTFMSThT6EUE9yN9Fl05N8s23cn1eVzmUCFaaJjUrpI?=
 =?iso-8859-1?Q?kRz/JWR+68Z7BPyKrFmHdP2+1HUbL1vVbqlHBIgvfKMIyyaXhk8Gb9YP4o?=
 =?iso-8859-1?Q?RnlMRMj9OI9LoLAhfd9PxyTTcVSdYTZ9qyyA8c7NTw3xEZRomIiuMZVMBh?=
 =?iso-8859-1?Q?Tc7w1eoa222S9m8ia/yMIAt8iARQ52b6N0rUcc5LnFfWy4+pV0BLdLwA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd393cf5-c548-4626-3d03-08da69b77c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 18:50:01.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8hfVm/XyUUt6ZVrHcThHMziW3FbdRt4QWwg98qSvFAMDgeq2FlpMrOgdTwth6x60wk/DEvx2G4dARWxHAbhlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190079
X-Proofpoint-ORIG-GUID: Sadfnn6FiTzWd5i-MBWUDDYRdUBPQWZc
X-Proofpoint-GUID: Sadfnn6FiTzWd5i-MBWUDDYRdUBPQWZc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Undoing the anon vma work is no necessary since it will be handled by
the caller in the freeing of the VMA, or in the OOM that is happening.

Fixes: d8bb385648a5 (mm/mmap: use advanced maple tree API for mmap_region()=
)
Suggested-by:Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 139862557cc1..7440f250581d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -670,7 +670,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	struct anon_vma *anon_vma =3D vma->anon_vma;
 	struct file *file =3D vma->vm_file;
 	bool remove_next =3D false;
-	bool anon_cloned =3D false;
=20
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
 		remove_next =3D true;
@@ -682,7 +681,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 			error =3D anon_vma_clone(vma, next);
 			if (error)
 				return error;
-			anon_cloned =3D true;
 		}
 	}
=20
@@ -765,8 +763,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	return 0;
=20
 nomem:
-	if (anon_cloned)
-		unlink_anon_vmas(vma);
 	return -ENOMEM;
 }
=20
--=20
2.35.1
