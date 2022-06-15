Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B354CB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348392AbiFOOUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346483AbiFOOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCAC49937
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDvQ1S015201;
        Wed, 15 Jun 2022 14:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gTOa4sCsowVfnMdwtik+r2rl6y+WpU7ND9MuGs2cInU=;
 b=OwO8JApKapKC6acGaXwDqLR3fnGED+ZobDeMzGxQvqx+jrrUITCKT3qqwkiSkEMAxI7q
 wOYkxsYzOJ0W/r6nnjJnmzaA8exGsYtJj1E9mxh50uWuOXY+1n+qV4tOFOaAECMWVPZ2
 0pPjZ4IfAn59gpP3b216nNdGw6HX0QhFOqqXF4pbtitusRG+if0cyNgYSTG5e3L/zDXG
 UafYUK6ZACp0HlieOBNGP3Q1IJVGxip7Mu8g5C/B9sA16pVJNqR8M39jc0vu3EaZYr2o
 Q6BR9jCAo52I3rc0NOXcImJbc4aFUP4cirCnFV4mNurkVY/9ywvjacA7VpJvLaGYsH02 Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0gsfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FDtnhf031252;
        Wed, 15 Jun 2022 14:19:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7p2nrp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAVcxmU5UoP1HFpE8xSFAVXMI4+q4SxUyMjGYGk/SyqIKgWoM5S7Oopq6vrggGsjwsZ4wDxKLIR6xYK8x64zaOz/lVXStZLClgyi4z4UIm/SyQWJJtUTDREaT6mmHQrDxNN4DLMfNkFIQCVbQirGXLTzKIkCu+sEQIYreONvuWYx/ktbAkiEANHTQNTTL72E/qsBMWWlbWaqBHQfM40JsuvD4hCghH1X9xI4qD1udqm3hlS8dDtETEY7bPUW9ISLoIV9YSg4C47BOA27m8u+cJ+OPMCWuiqjqexELPiDXoIZvfynEBxB4vCkTNw7QwJLRpQYOJj3VIuW2TbdqyIy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTOa4sCsowVfnMdwtik+r2rl6y+WpU7ND9MuGs2cInU=;
 b=fG100qUb8FKI68ANOFuz7K9igKYwriJ2BJlU0Z/jWuGNxF0l/sSSquIq1jHIGPx36uV5Rcs7EUqKXiUl364fNvdQJ99RCMszw3onrdTQlK9jOKhvK4ttdhOa7mP32NrAgLTmWq8iIHJdWVm5cRUDWG1PtRSmDKxhACzdWSty177mW6lmH4xEFHUcYPbr9bupaaqX7C1Vz77lDU/rTDiMU8q53Xgd5SW5M4xcmXoVUF/uCqxgiDWwuuVwZK0G39l0gNmagInYNa1JHKQeimqTaZpPT+NvrQ0TrPBcPUZPo9VVVNl7jNsFBTygcVA+/ZDKxEDlF+fuivXMQzIvosAKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTOa4sCsowVfnMdwtik+r2rl6y+WpU7ND9MuGs2cInU=;
 b=cI93iyTsIzV21JBNqVqRMBgjoZKAdUgmZXw9aVAwmCt5/H4+x30S7ZpRbalR+JLYhMb8P23i9kyy54tZvjPZKZbV7RQhW5Dz+oSYfNlxbXJf9w5f5zbW6Uvm3ccUcaIMUyVysQaLLEHyiIuuS0gm9MWG4i5WncWRIlWxe5tGyLU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3342.namprd10.prod.outlook.com (2603:10b6:208:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 14:19:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 14:19:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 1/3] maple_tree: Fix mt_destroy_walk() on full non-leaf
 non-alloc nodes
Thread-Topic: [PATCH Fix 1/3] maple_tree: Fix mt_destroy_walk() on full
 non-leaf non-alloc nodes
Thread-Index: AQHYgMLys5sMlAg0rkKdMdWAEuRIZQ==
Date:   Wed, 15 Jun 2022 14:19:38 +0000
Message-ID: <20220615141921.417598-2-Liam.Howlett@oracle.com>
References: <20220615141921.417598-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220615141921.417598-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc122f79-b9bf-447e-c071-08da4eda1519
x-ms-traffictypediagnostic: MN2PR10MB3342:EE_
x-microsoft-antispam-prvs: <MN2PR10MB334217B461344B6B6EC2E04FFDAD9@MN2PR10MB3342.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8yBqy+6DT0/AMzL3EhZF7BS8UaWKcooNaO4E5NrVnFhODI23pHzP3AHN6zllK5sAu6yxuctiEhBfdgq652mzjDtcKwWBUdxBuVKNEu5B/24I5erfCEZADc5CFs+63b6/uFFEOBcVbb80+H1udMsTVx20J9D/RTLD5khKrlWvxE7bzZVK9ayEmdetFLjT+ql0uVdVDsEfv3/LnUa1QtKat+rkn5vTZ2xt6m0/VAurF9XSelFgC5fK7cV+OxnkwAAWSoN1U5e7MQB0b9anq/HZoll5SQEKPTn6F5ihInVbQlDWxy6iRFeRToy56E4zEd4Ag/SONhHqST6z1WhHMYG5zRGGBUCQUJVOzveMuMGnRckneTajhxMbnrpt0GPKDhV2tZhnALgfYURMDnRRhgwg8zv2PTFA2QYKe3ZEScEsHUrBdAJGlS0AdUud9lij3ieLa73LxJNUgy35MUzZ3q30rjAO6DYtiR/p4EymQeG7xg3nZPkFMMcwCiX+h8+xdbrO4aFyh64ZAlxXqXl+/ujRXAAoOUg0KudBR3GJ2dQSy07wry/9wZIA981b4ntv28S93y6DgzPsw88SwtU+48By8paFMUK7tXU/NhfdA8w5mOXJclWWtqtfAT7RX1d9iGO9IhsKMgqI0flFiRl+baDbn+pgUwJvSdfsu/p3dqGrQNM6Zc/EXw2BlrnbuBqEYsAi7iG3SGRPy7U6cAz6zhuqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(86362001)(316002)(122000001)(110136005)(38100700002)(186003)(5660300002)(4326008)(8936002)(2906002)(71200400001)(38070700005)(66556008)(64756008)(66476007)(8676002)(66446008)(6506007)(76116006)(91956017)(26005)(6512007)(508600001)(83380400001)(6486002)(1076003)(36756003)(44832011)(2616005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mT24yWl/IIVZDL3daLivHHf70f1REhRlk4R8dYnCG9NKTN9gbBUbUomNjY?=
 =?iso-8859-1?Q?raHKuDw5fFJ2dHEra6mTcrPGqU8dEN4qD6rQm9OBM9kAsqQD/AvMa/Qm8u?=
 =?iso-8859-1?Q?VKMz2XpV5fCuo3jnNFqztLIiLZ7l9r6jODAHhXtTDhcOvFWllNUKJsvWl1?=
 =?iso-8859-1?Q?URD1jPIVbsq1HBMdQD4dE0KXz9icXkHnnSVCkCjrzjOFVO4OyyZlcia4n3?=
 =?iso-8859-1?Q?m7fpo2E2hoT2nxYZnrCV6VLDzTzporaXFyiUQaFX7SUvTE9c/EkkwLVvcB?=
 =?iso-8859-1?Q?RlfRQW7t1uNi2md9jUB2SZ7a3TLxKDKfVBh1aDxP3QWMe83Q6uXgU/LtUA?=
 =?iso-8859-1?Q?DjW5SeZ6usb/g6VSBjfTRtD2MFv7DKJujLIvHFKKtC1VSWzUsBVBlnsz+7?=
 =?iso-8859-1?Q?918ZJZVN+lAV9qsxoY6y5qFoQBY+VZFrzimY1wZnYBz38tOkdNrFvFcMgx?=
 =?iso-8859-1?Q?6nyjiKvWlJaTa5BNvSV/By2Y4/qdjyN50WEYVCovHanxZiSyvydoH3r3qn?=
 =?iso-8859-1?Q?joAJsCHlpLd3bYOqgSovrFPQDZaDTOoh2kHP50Nbi9d5y5z0OCPD+5QLp+?=
 =?iso-8859-1?Q?deK4+3qn0F7BulCF9d9M4AaivBQKjvspza3zHvzYwgMeHYJ7yBwMAvpkah?=
 =?iso-8859-1?Q?rMWI84kocuZmWVT+JBODcB2aHTGW5PtMOnVe1v8s+7gXSBZzE0hYYj/LiL?=
 =?iso-8859-1?Q?cyDnbG0sCIpD6YmsiM3aApZCn02DY3U95aGlm10XnHVDMqh7erZAOd+XRC?=
 =?iso-8859-1?Q?4/IgAilwGrI3I9Ic2BhUvPFhlL+9wuhrF/1gP1irIvYZGQv44aXA5UkpmL?=
 =?iso-8859-1?Q?rRQOFPotp3HIIE5gVKXUp9MVgTABxIHFTJkjJtz4Odk1IQbhxphmXaz2mm?=
 =?iso-8859-1?Q?vPqRodwdbtWQxNOc0iP2fJEhvvQKhqLXloSc7Qhn8LStvrdh02beG3u+OR?=
 =?iso-8859-1?Q?Tx2sfhqKq0Yb21Lg0G1Sh/50yRhFKlPXq8yEhk9MNfqFYHhQtc+KYQHOov?=
 =?iso-8859-1?Q?zFPIkITu5pWqjxSEUDx72kXlpp+Nhp2Vk9jLXg4rGOGKKeZ+WRnwbVQoJC?=
 =?iso-8859-1?Q?h9ALluWIOUw3L+Tgt+OXfSCHPy+zTuNccASpILzsu7M7+mckFY9IBYrxv5?=
 =?iso-8859-1?Q?mdjaCS5c/a6+2tkdst1lzBypjG0HH0fS280f1G4jwzKqe8rYvBPsV1H96o?=
 =?iso-8859-1?Q?f+I6jLfV6aDeiadeTs2tHAXGJsR2oTZ7viHDU879l84lpkugzK5yJ5vdGu?=
 =?iso-8859-1?Q?NlQNxGc9xX8Zb+S2L6DcR3sVNqT5YZn/jV28hIJsij3GLQjpIkmaC2YLZe?=
 =?iso-8859-1?Q?XnhRWprwTctaVtYl501AKlC4gQSPa8PdTa6V+oouxd1GlMjllRGY/ghJqO?=
 =?iso-8859-1?Q?ity+HZkvhu/oFYxi14IgSxuV5j3FlIjM0Rihhdh4qLQqR4mlNi+Ubmuq1d?=
 =?iso-8859-1?Q?4a58mRZbBxT+dnSEpCw+bQ3eVzNd7VgpdUaovROJUNlulVuOYvY9JYrSwb?=
 =?iso-8859-1?Q?K75PRa8FilirTVr85pXDIAG4rIy7Ng9F98+jJ15/VxUGQzVIR1uMCra/KC?=
 =?iso-8859-1?Q?13yvoZyz7JtNO6CqN5IHZZP9skbLyuhFLKvLwm0n1MZLZOtzKUF0nhzIiy?=
 =?iso-8859-1?Q?pgiRNFMQ5FuttUlJoPP45Znkd2dLRG2YhVpY13+im42nByel3dEvSSbDvz?=
 =?iso-8859-1?Q?cYXt0jnI5v/cqBbm248ZXzhZcrExVRcYr+p7UAEcbYcpU2/rCHyFLA+RtM?=
 =?iso-8859-1?Q?lLQ5Pe+fFys70EoXxs/5uK4+VvfSsKQOLzXUClZIn9kr3H2Dn3L+oALE4J?=
 =?iso-8859-1?Q?Nf9HOLMRVkZSKMHK2C9TTU8PGM0xpuk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc122f79-b9bf-447e-c071-08da4eda1519
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 14:19:38.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxb+cYl0QcKFXL3sxe4ZaCZeeMn2+EUxoGCODm4K/NL211AtU0O3ksUIJ3UFU61Ur59Iy+MPOanUYn1Qz9YC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3342
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_04:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150056
X-Proofpoint-GUID: Kn3t0HQrhaVeNK94DqR1lg96wv-dcNP9
X-Proofpoint-ORIG-GUID: Kn3t0HQrhaVeNK94DqR1lg96wv-dcNP9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to iterate over the metadata of full non-leaf nodes when
operating in non-alloc mode.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 80622741c6b8..a1035963ae0d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5429,11 +5429,15 @@ static void mt_destroy_walk(struct maple_enode *eno=
de, unsigned char ma_flags,
 			goto start_slots_free;
 		type =3D mte_node_type(mas.node);
 		slots =3D ma_slots(mte_to_node(mas.node), type);
-		if ((offset < mt_slots[type]) && (slots[offset])) {
-			struct maple_enode *parent =3D mas.node;
+		if ((offset < mt_slots[type])) {
+			struct maple_enode *next =3D slots[offset];
=20
-			mas.node =3D mas_slot_locked(&mas, slots, offset);
-			slots =3D mas_destroy_descend(&mas, parent, offset);
+			if (mte_node_type(next) && mte_to_node(next)) {
+				struct maple_enode *parent =3D mas.node;
+
+				mas.node =3D mas_slot_locked(&mas, slots, offset);
+				slots =3D mas_destroy_descend(&mas, parent, offset);
+			}
 		}
 		node =3D mas_mn(&mas);
 	} while (start !=3D mas.node);
--=20
2.35.1
