Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3457A6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiGSSwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSSwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:52:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E713E03
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:52:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGmRWv003839;
        Tue, 19 Jul 2022 18:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=wdrbT6H7R1b6HxGHNIvEFLdY65u3lFPsCMTAonDWDY4=;
 b=ilOlSq2MpG3p6rV9BfiVw9IiA/gaXj71Jo6D2aI9ZvOzttFGZBGXCSUpHxue9EaL94+0
 7EZBdSNMBCwzXpayho2xxzuzIfxoQWan5isGXl/C4R7SinruXeXClw7YRwjMk28mv2+9
 ujToFrjxJgUzgLNwe/5otNrlLxOHoKCfWM0tpUg3JIfLgE4voQz0scDCAxeFlkx7vTD8
 lN7PzXsW6JMcDIibFw82Io1KFk8nx4L0iEyuLc53K5bNH1X3OoCuqx/tJ3THIzlHEuDg
 OwzvdOv8kRPRgG5lzk89h1TtDPagj+ul/kgTVMmEFA4jB/Fj981I1exquSC216nchedV Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs7cwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:52:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JI08l0002689;
        Tue, 19 Jul 2022 18:51:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbdg35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPcQA3jRwsqnB4U+p0/B3ddBfWZ2Np2UFLh/zbfMoTgRj27Z2eIVfAk27aAcZ9u+v5yE5tLMN5j8okHoD2dLXY0SX4BMcMfSsUHbRvetBGhrYP8ZZILhURA1mkJPWdzseXmUL0n4VUgg5pf8OyOw1J90Qcgy3+vnA+SKS7slFSyw8qZiAuPCnleqAtQKMTk/DpcAWvFIbspyH9J10Thqj0jA8+nQVD+HUiUvjsVfkbsnp7LlZGMXMjoN4gFnLeI4hRzqaJYFkRpWSeSGxDz+AI+ZEkcx2+lNw8sUb7cY7qClbzaUzz5gRUgZV9A7zJrk7e25sbfpfl4VtvccqMDkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdrbT6H7R1b6HxGHNIvEFLdY65u3lFPsCMTAonDWDY4=;
 b=hy7p3mL3WvMpEl85rA1yFoZWSpL61EzoqXMrX0anYuAUz8jsMcLqWDme8RP/0nsKdtHpQAEh/Uw4YPTXrop4neeYMbb47ZnQa6Tug6O42C/OccHELdvwbm8R+huTr+mVsFGxzJ8coy/+VfeH1CWffCGcEpkTvtz+VzIeg2+KJGVyWOFKtpSVN+q6cwjOYRSBazjubeo/O5/cHxW7EYR6r9pQy7KYuiiTIq75z7wqZ0V7iXy8Nf1qijF16M0BV/glGCZ/U0KvUJmHTb+rp7eLPWlpUt9sG4L2M4iN+qHH8W3W5zJElXYX8SnMC0RU71tZP/tcGtNVzbgTF8ERUaOvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdrbT6H7R1b6HxGHNIvEFLdY65u3lFPsCMTAonDWDY4=;
 b=Tn9z4HKzk5gHAg+ySH7SHLw5Gf7bB/Wd9OFGI2wXSaGqgblvyr70IA75lZf/DcpHGqA61293pgC9wX6THnc8g5wAnApsuFh2KraiGmSjzxpR7tcmRiqm7NR/in7odFr/ptdfi2swocsqtfnfutMNN9q34idPWAy+apZ9dTFPe2w=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 18:51:57 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 18:51:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH] maple_tree: Fix bitwise for logical operator in
 mas_validate_limits()
Thread-Topic: [PATCH] maple_tree: Fix bitwise for logical operator in
 mas_validate_limits()
Thread-Index: AQHYm6CfSrZ7XVpc4kC0V3L5au8Uew==
Date:   Tue, 19 Jul 2022 18:51:57 +0000
Message-ID: <20220719185142.3360559-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc143b3-7894-4d93-24a7-08da69b7c189
x-ms-traffictypediagnostic: SJ0PR10MB4479:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7BiI3mbwr6aAcfUVQSMw/YLAkrvIndbjoQTC8I4iIvCs6V81lgHjnw5ly3u+dxpyE2/clrobadRDbLzcN91NOAITNR3UPXQ8Q55h7fsRBeaTu3UfPj78XjU0UiIKm+sGmDJD0sOw2WXVEajdIqCTi5ohPWXeL7gb/V5QYNemb3yreBI30yLbA+MYUc2SDfrvEv68orUuNOf/fo0gUOnOr9N82Ai60q+SI56ZJe8koC0rcnkAOzaPTHqMM+afQQbS2VklvDmancITp3fPfk3HFnM3LIvKf3QIZGHv+H4YKEw0JbBNUJJukl/WqQ8zxV0Fg73BqtuW8MSgH8JRYtpixLkD1CaBMIfe79X0IruGlhW6ANruFGTjix1rdOMBr7jAR2zPoQkvqU8pC71nQI856wB77YiQSnLmdVWMw3zJ52gomYAbB0l++4OeNJvL3kiZznS+fP4mYt7mpPhsB6F+nyqV9ET/aImS7Io+Zf7ITOV7zTSp+aF2C+8WoocvJqxO9+V4mtORgTGrpSLwt3QGq+E67OYs2l1wzXsqHX1Me6PB6U+ymO/Jqw+BF/Ugmx7Kh68wiVELVN4XM2kmSJIUEglLNlzU4xjblpGOD/2oovbU31DYdbVc6cZPOpjL/WMuh67E+ngoAjjlg9K1jTAOrOT6yjeMX7SgrgJjhmqJ11JcQVKT5MqxGQThnyI1wPJObGhhSrVJxBZYabIdhWLiJ8cwP09/pg65AIJI28NCp6gKKLLpSi7UDoMP9PVSpbDcLmzSc4YRCpA5Zg+UXxv+H5ZeJRkzjPkRu1S7c9bClArCgPhsRoCYx6SGS3TJIDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(136003)(39860400002)(2616005)(316002)(186003)(64756008)(8676002)(110136005)(86362001)(2906002)(1076003)(36756003)(38100700002)(478600001)(6486002)(5660300002)(8936002)(71200400001)(38070700005)(122000001)(41300700001)(6506007)(6512007)(66556008)(66446008)(91956017)(83380400001)(66946007)(66476007)(26005)(76116006)(4744005)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YP6njaovluQk7aQIj99wmUUa1TX1/N6ZS/gwzTb+oVosnpZSpcHWCo5778?=
 =?iso-8859-1?Q?NMYKR1VlNNfwlAS7c6TA4aa4SzCmuBZt/x2xCUL7i1oHQMlj2oiTEnrJjt?=
 =?iso-8859-1?Q?sKFsm/DWTgY4O01ntowvjltYFkyexEt8Dm1I/ZLz28+yA127B918zygINN?=
 =?iso-8859-1?Q?pDscc1jIRRfKxBCVxgPAQ9JOhW2jCepAIOlJVH5SNcVYxBvbWcekzSzF0X?=
 =?iso-8859-1?Q?twI7C9bcsZWJwWE9FMHMAKduAGslBQqfHIl09REeVd6i7mq96M79T2m5Fz?=
 =?iso-8859-1?Q?7SasEZqjpPg8oizQmd8VYMKW759sSD/5rFx9uLu4Kju/ZPhnk60K88NtRL?=
 =?iso-8859-1?Q?AJ2dOoTH4TwXXplaft7A644pGLPX6is7f5Jr/Y54GmNaGZjrWWEOuX/r78?=
 =?iso-8859-1?Q?EqQ9ovx1oMVbVQwNIFJYu2YpVunAsrkuZuWu8nJcjTabIpvtwuuz1UlDEd?=
 =?iso-8859-1?Q?qKCJLuvynj1quTT4no38MzBHQtrcAyXBpv2R6ePmPxejwA6FBhU+yqidDw?=
 =?iso-8859-1?Q?qh0FWU68nlUiKs5uTkjl/pe8psO/c7nUBD9qfxlfxLnTOw/+Ft3iWq7l/l?=
 =?iso-8859-1?Q?KuPLTm5yBRGJ120+KBWxGTah3p3Wv4LcyqE5wrQDmkppqZrDOsAAHT8KCa?=
 =?iso-8859-1?Q?W44E+ZZBNS0VlF6TDEwsOcaznHSmm6dLfrLs6TTDJp7drtOX65gaodSFJP?=
 =?iso-8859-1?Q?gRoU8jaPWjbY+dX3ugDLBVQ/hNcdqaxgReXKynnmQHFkBTncw4EeU0+XJZ?=
 =?iso-8859-1?Q?6B670LEf5cgsb6kHPXNo0DAicgzLwFnBmYz39BBR/wKfaJK67I+ug72i4d?=
 =?iso-8859-1?Q?Fm7aVERmBYKW168fofNThRsYTnJwdQiJzXiImlY6Jp7wXI8pW8MQATfWEr?=
 =?iso-8859-1?Q?VBxAfZAL93RU4/JDn7XLVgSOXrAnktYPBoifC+0gsiaApChaEPAshbHXED?=
 =?iso-8859-1?Q?v/JF1TTODl5pBlAU5+Sk4u2Ln7QNHAibbrcZhxNEil6nWfxMntuALno9xG?=
 =?iso-8859-1?Q?61HRypWIgZLWNWhYAxtaqpOz3xSLai8M0g53Z0hpRHp23e2nZGXU7RVggP?=
 =?iso-8859-1?Q?tuKGMgoRrp61DE9gEWv4XTD8QiETKuxAnAtzkDN0dgNiALKbnJQHRoTPHf?=
 =?iso-8859-1?Q?ER533OSmiWgGNr0VC4YggptXCP9Q6b8erJYx1LJhB+0WiaSmIzNSV4XT7s?=
 =?iso-8859-1?Q?G3rYa3nnNGo8sm/cW7kASSoG1Vgepr8+K3XPM0Xy4QoRXENZuXuQ5mrPri?=
 =?iso-8859-1?Q?ujRdK8skzV9z7f4L/Zbhu8Ab0bZm0SKJXwDWgSY7YfoLyRa+IAbaY9xZNM?=
 =?iso-8859-1?Q?ADOdbfcvH0ix3MNkUS3N79H1JtPKhrIpeDJpY9dVzhNHGdkbJrzClZSxCP?=
 =?iso-8859-1?Q?BPSMUxfZEV7ka/CgGYivvCSeZClMJAG7tTH2AYjmNHmf1F2A65PzkoCdNV?=
 =?iso-8859-1?Q?YRa9mcwovAje0veMDClP0lfiGfRPn9QxqNfQaPR/Gh6wXSXwBNMHewaUXK?=
 =?iso-8859-1?Q?H70D8uOLaHYjqQkmvzMmGRQbaKEBxRK1A3DQhKZdyX14cWaQyPBxfStUlH?=
 =?iso-8859-1?Q?5u9zXAgiEdYVc6cgQ/CJRhBpDy+YsykerQMLX68W00Rh5A7PQvnbC6l6qq?=
 =?iso-8859-1?Q?YCTKVj9Ei7Sdg5dlYFsZvxoS4HEU4PKdGNVJVLjKNzlN/qRmM/wXXOkw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc143b3-7894-4d93-24a7-08da69b7c189
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 18:51:57.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj9B4O4DWdS7uDBhxUAwSb6On8KkgLm3/CpJA57PA3NHSq10jlS60lGOffId7pbt4DsrTk+Ha+Idolwf2fYjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190079
X-Proofpoint-GUID: aUw7bAyebej3oUUjqqbLYm0Elm8UtAXF
X-Proofpoint-ORIG-GUID: aUw7bAyebej3oUUjqqbLYm0Elm8UtAXF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct operator.

Fixes: fb7297e8a66b (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0c0bda979693..d5b310e73068 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6966,7 +6966,7 @@ static void mas_validate_limits(struct ma_state *mas)
=20
 		piv =3D mas_safe_pivot(mas, pivots, i, type);
=20
-		if (!piv & (i !=3D 0))
+		if (!piv && (i !=3D 0))
 			break;
=20
 		if (!mte_is_leaf(mas->node)) {
--=20
2.35.1
