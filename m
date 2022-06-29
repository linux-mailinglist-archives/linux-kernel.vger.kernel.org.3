Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D09560472
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiF2PYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiF2PYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:24:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3B1DA4C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:24:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFDxv0010301;
        Wed, 29 Jun 2022 15:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TcjNnl307OKjnTK4RiWtKGt+ILAqOYkFUZvJU6z3N54=;
 b=mS+/GvSxf3IKUNV7BTvtjk3rodi6c8DQN9ICc6nwJ3pt/IJH/p2PydveZeIlrArvsBph
 /mPfYzKEYmcSY/rO2yKZ/IwnWox/R6L1YnbhGng7Yr5GF/mRWRvogrSlUeEEgEbAaCmN
 ibaF82UeHjQHJgfxV/5HXN8yhoN16AKvWxWUAKE0kTtnyMlV1ueOPJ1vbhvP+Kx0cd0Z
 D1SNcC7WuMPr4Glw6KAorORNEFr5HB/qPSiYkgiIZnkO30+r4j0MBxTYEo41DFplnGdT
 QaIYYu9wbF0J8+D4inH0q03ghoPBxlYnLgR+hXAhW1e6Cbz9IkuwphNdixTqP4VolbG7 Iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52hk65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:23:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TFGsTP016936;
        Wed, 29 Jun 2022 15:23:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3duhd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDw1ntNYveGZq7ubEKM12ZBmPdT1BzO6E9eITdjdYtT923gAgcI/IpHU5FUf6nDAhbDg9LRbJP2crBtp64d20BykgAp7wRz61tUYfGDwCPD45qSBmkbLn/Oam9YaGR4Fo5q1AGn1ivMR9XcnW6uJQTBGXjHgk4cTPWULw/CslNDaR3b1P5qMIUTA7g+PLouLAdzhViO57s/wLdMbZsBWSLbC8Qq72bE+8s0wyT+ToUGzNYwWdJwLBA3GAUX+6ax9UEtKIT4z5f1CISJe93P3LS+D+N052D79nKKsSShQheXOeoWZAHmSF6RWbl70VNXTFux6cTvoJwLzVPytGkLBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcjNnl307OKjnTK4RiWtKGt+ILAqOYkFUZvJU6z3N54=;
 b=I4veuKJ/CgtywoM0y/rzQdwZnIfokRmgziLIzRNBsRSsYkWRF5X684/4JttE3oAnTFxYrWtx3n3cCNl0e+ZrWPHFYZwKeawkMn+tNPEw2uswgLJiytPcefCO5iq2M0S4Brw72kxFF/fb0qaQyLeMTR4fo/zXUDF3qHasOo5NSY7VUBYpnwx5ozUfqrs+KofZOSwWnLqhx1xsLzawbMPjtPnSQkvM4wnpvjL9NyA3YFLP+03XHhL8MNXNCrDmaREl++1Um03k8t5Vu0OBLRTa/tHPYNuq1pPHbv/j5pV28HncL8B11sIHMc1+XTL0nGQQc3mezu8yshu3ZsH3qfqECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcjNnl307OKjnTK4RiWtKGt+ILAqOYkFUZvJU6z3N54=;
 b=R6A5LEiO+GijFCEWL+wiLs8cGYEwUpcSniP50dM9HGFzDxwPv5OV92B/eJ3JYUbEObcupbqZccczPS1I24IgWFs/yV7/xRp6xvbBEecK0YMz8pwP/a/SWj15vJadLG7CdgQtu/D6wD0QznDGkA4FhzNVCEoNxcOF+6fmbQ2PizA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2382.namprd10.prod.outlook.com (2603:10b6:301:2f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:23:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 15:23:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 2/2] test_maple_tree: Add test for spanning store to most
 of the tree
Thread-Topic: [PATCH Fix 2/2] test_maple_tree: Add test for spanning store to
 most of the tree
Thread-Index: AQHYi8w8xc18m6PLe02s+pty386ZDA==
Date:   Wed, 29 Jun 2022 15:23:51 +0000
Message-ID: <20220629152340.3451959-3-Liam.Howlett@oracle.com>
References: <20220629152340.3451959-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220629152340.3451959-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d0bcd03-22eb-45ae-b35e-08da59e35f3a
x-ms-traffictypediagnostic: MWHPR1001MB2382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAf4nhI3ttMccyNvNgKl4HR+sxLH5lt3LF9oQnbeFm4W3E3/f4tA9Ct1+8hrhe555l122KtaK1FeL0Qt6OeV6rQFviPZYW1wUIXd1PqNXc6ecw9Tc4CqRyXYSkEyqXHjCt19rcz3guKIYhPwZJ7p7eVHluZ7YaDlOlDKo5R72gYepXtWgbOBanxoqpUBKSeoBt905dR1go472tgu8UZYwRjjAfWA+B19P1SGtVtkz5/TpSJqUBU+jVJvocd3qUOgYWDOGzjZRh78SI8nHldnZLO+JRLDtCyikDC8iMl9q0iosnFVyA3dV7WQ1X9TCnuZRnU6pun5KMaz54+NxHju51rX+dtGZQ3ledqZfo9tqucGq/Ls8SaOBfviR0iSgHoWXD/KvL5ULU6a4g+npk3IaUmr7Oh/n2Xqc5sUkMB1swgpOzskaqb20aFfeFIW4JkTKNgBvQpCmFZDJbw/wNhbKhT0TZmXbO3gvEdtDRFu61QOAx6PaGxwglesaJNq93IosBXFKYO0wj4/YjRxBN4GNtqGs+jwA9U4BeNHWNErVjasyv3WjjRJAcoIzL5usxjGCpr3EkXnAv7Le0Ye+IRBrjVLmu5buwH4lrGpQsw3EuozQabT5qN+WGFB9FMSnpo/xNUGwem6gpDHHb6phD6izPBeEgbuEcw54+r91BStgx78nyqOSupsSG+1TnAJrc1WLd0mvzK4GOG2BDkz31nW0cNE5x5hTx97D9WhW/BIMhBs5fF8zsJeznNmbpEUWBbXKqPJeI9LMGXgYEZfBMHdfZGLDJv4d4A5+1AMnwYQrPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(396003)(136003)(6512007)(2616005)(186003)(26005)(1076003)(83380400001)(36756003)(38100700002)(6506007)(2906002)(41300700001)(38070700005)(110136005)(122000001)(44832011)(5660300002)(8936002)(478600001)(64756008)(91956017)(71200400001)(6486002)(76116006)(4326008)(8676002)(66556008)(66446008)(66476007)(66946007)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TeXy/SW6XPVklFnHCBIZ6AyeKBwqcPhjZaH3Q9QcpENgU0oIgj2zw7VLZM?=
 =?iso-8859-1?Q?ltIQpNNKr96Q0+1k99VoaqKByoOekJhHAEH9+miv9Xaqbzq1nv4Q/7gPOU?=
 =?iso-8859-1?Q?hArD2gUpNP2cCefmOSCVagl1RfIerxzddcpvPbM/dsCOjDZZU3HqlJircz?=
 =?iso-8859-1?Q?fk1rXpZgfbYvaIbyg4coar9f0iMDeQcDFXq5B7QU2GFaZEn8R8bXFXT3Fe?=
 =?iso-8859-1?Q?w2+AoEDr+de/P1uuCLp59e0eLKQmCNosLLn36wgBESvkKyNtc1acck4eBC?=
 =?iso-8859-1?Q?Dt+vIgFX18tIhCwhQ7QpQn3UTbrX7+5vbihASgUAGJINZeEq+HrZaA66V2?=
 =?iso-8859-1?Q?bOI8s+ZQdlgkUsqt5OqMAsY9YBFM3MSn8TBdH+VOsc0ep96/2T6MvEAAmH?=
 =?iso-8859-1?Q?8PG8k25mG2gqc2zrznKbN/QmaPG/L80qY0V08CaGSYGR3U0mnv5YjR3pLr?=
 =?iso-8859-1?Q?eAaJyGuTUNl3bgUVqrVs640KWNEwYgaym+yPpUvwK2IV26W7SUkWVM6lWQ?=
 =?iso-8859-1?Q?UMl1q9gYT7YANtg9g6po4QjXuFDIGLq1dSofmB2SIZH6azFo5Ft7uNTDSC?=
 =?iso-8859-1?Q?0Y3GcI15A4cSRCoZX3m1PDcyyHqXwITFfOC2XKs6XZ8rP4RRvUqONTc1A/?=
 =?iso-8859-1?Q?PxqvS6f3BdV0U2RqQjHfV2ZK1jN7YBEE7jjYUDVFfqvDkQF1ZPYuoMkSFN?=
 =?iso-8859-1?Q?HQ6CeRwG89VDEGOVe0UCYLXCmVYvEKkO/Nd2z3lKBuvCoFVeXCPSEM5yN4?=
 =?iso-8859-1?Q?WEaLe6pzf/bvXkfX2zrhzh0ZOHsRbvHUsUZQl/EzO+FC87YG1Ko+/8W7VE?=
 =?iso-8859-1?Q?ju3XZ39OwAxqjbCLNids7J72eZjB0fkHC1t2yKUvlS7UNC7bkxuxCRXjC7?=
 =?iso-8859-1?Q?mukgSkW3z535cz9eDjisXt2YczL/hg22Nk/YfdU3tMSN/cyTlgxTCvstgw?=
 =?iso-8859-1?Q?wt5gmxXTQDsGkygeZ+VWFxAP8DV6l05Jl6mBelwxnEbjxelYK/TAk6JSwu?=
 =?iso-8859-1?Q?fsg833ihfrzIYd7XBD4F4igfmexzJTeFWHKoapDmWlHvYZo6ZiLH3RJb1L?=
 =?iso-8859-1?Q?L8V3oJlEbdKiJnRzhIqEnXTz3m/ugwPL7Vs6zRLgEQsKibVZsX9igF2UG4?=
 =?iso-8859-1?Q?j87bCirZ3V4l22ZM1evaBV8MOB4HoR8q7pVB4tXr7KVuNduwC7oz7IWxYk?=
 =?iso-8859-1?Q?0YsU+uCKbE0NUiv56wlZ6/jilqKeITi2vAooQKLYwS/YAnorEsqqSJgOlN?=
 =?iso-8859-1?Q?H6YjsHGzmYullSGrovtf3svI4LYD1SyRNoYnons91LiUYHfWNyfqlI2kEH?=
 =?iso-8859-1?Q?zb2lO+Vjlxt7hlIGhtvrq0fWH1d6r85K36zfsxPUhfcQP5I2G7gO7RzK75?=
 =?iso-8859-1?Q?w/b0WleEU2XsDNnv5LmEZvO08yHwPMWZCrU8qvGduxjY0SCznJykM3fh4w?=
 =?iso-8859-1?Q?+ofdM5xQOFyblN2qWLYSX9+jdk8gFmIPwbf3XZ032n/1nrxK9K6IGYdDyK?=
 =?iso-8859-1?Q?2MdVdI9+UNyGcjOb30JsQFzgXdmJmuAWXQkO1XKZrmjYyxRpE1iKueeu84?=
 =?iso-8859-1?Q?Nqivwpr1/eAmNKm8bxf7AQQ74IcSqWalIZMWLWRlk31w1mqpD9tWqJbwUD?=
 =?iso-8859-1?Q?sEjpM7z+dOb2R2YC5SZw4JxRZG3Ec6GwdI2Uins96FHatv5KWxUJrBLA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0bcd03-22eb-45ae-b35e-08da59e35f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 15:23:51.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttW4jh2JF4aP79wuVcAj8mkp66olE2WDFKayYcORp4F1jp1ncskFN+nRitBOuWg0PR/cnLNsHmbKWDK8ki4K0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2382
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_17:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290056
X-Proofpoint-ORIG-GUID: RpucVIHUofRddi9GW7mx004ZdSFA6AEG
X-Proofpoint-GUID: RpucVIHUofRddi9GW7mx004ZdSFA6AEG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test spanning almost the entire tree to detect if the root is dead and
the node is placed in the wrong location.

Fixes: 1d3ae73e4e86 (test_maple_tree: Add test for spanning store to most o=
f the tree)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 8de5705b7b9b..b028f5648857 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -35685,7 +35685,6 @@ static noinline void check_spanning_write(struct ma=
ple_tree *mt)
 	mas_set(&mas, 1205);
 	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
 	mtree_unlock(mt);
-	mt_dump(mt);
 	mt_validate(mt);
 	mtree_destroy(mt);
=20
@@ -35817,6 +35816,15 @@ static noinline void check_spanning_write(struct m=
aple_tree *mt)
 	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
 	mtree_unlock(mt);
 	mtree_destroy(mt);
+
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D 100; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mtree_lock(mt);
+	mas_set_range(&mas, 76, 875);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mtree_unlock(mt);
 }
=20
 static noinline void check_null_expand(struct maple_tree *mt)
--=20
2.35.1
