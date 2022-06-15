Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584B54D039
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiFORmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiFORmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:42:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1761034
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:42:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXwvX026644;
        Wed, 15 Jun 2022 17:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=jVILuQqnxqxn0HceyM0L3RpuWuhLq9m7mY+ED2ztJV8=;
 b=Dn8UvQs5GYcrY8YrtIhlsrZz4rVLzsce+fjjP5ux1dtOfymS6UloYjifxXA8X7V/4HVD
 c89zgQOXwqyu6Zqd4GVn2xlUqGKHrS0zmG3LS6EolJiXpXD5VGBsZAGw+OWY6RpsZ1yJ
 LCspZsAHLqMWOMYYp83JC5A9AGnQzH0fJmNSyJAkJWEAoSQSJ3z+ks+VAm8gReGP8AOL
 E6GNHNMdtAYI4aLW3XjHrR6D01QqS2rA1LSkptfa3wgatExOSJEBqn37DONdwfT3yci1
 hOVQu1WmLvGV+rgx1Dlxs0PF9j5jV6558E7lKit+mWRyuldbhBfemSNphdh5wVVB7kcL Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0h92m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:42:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FHehGo016252;
        Wed, 15 Jun 2022 17:42:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbs0x5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6hYwoPbzExNYH1ykwHJPU/hXe0pfT7pIbuvUWQqX3pqEUCK12U5H96IJTKhvZ+XSdy3a+LwskctnsCOQ+ZVUOEoZUMpsZQunKZXyJ/5OKfNMcaIzbOXNoFxEwkfyWQxcE4+4ZbLJ+3gRzE3t0ev/E3h3XZGyWjOnJhKxHcT44fwh2ID/aDOuWlDmS3jxQyrNlSnPqAHoqDDZidL5tPcznhr2wVcZIZPTK9LzF9+PTs2khsT12u2dg3/sK7lQZAuisgIQSBlkeUrKMVf6ixGij0IXDD9o/eVQ1GRyA+9sHsLhndRKJsB3vGrrHh15A3DuaKeQw117Ozeo6D0PVWOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVILuQqnxqxn0HceyM0L3RpuWuhLq9m7mY+ED2ztJV8=;
 b=QUkkGQO9qFLDPMZt4E5ADbA2i/lDhY8ViBuK6rg7AAZBChgEoNGIM/vWvZIVpySYC96y+qT5qOSD9XUUIEuQCSXcPSZKQjfMY0V+wsKxHtXsseuyztu+shJOEvxT7fVUqnE2kQ4pbrc0DOSl6KWW5kNEBd5oRVLViLT490SkCU3EAnwVyVXFRwggRxIva6Z4+KCNjAM0AZESarqaQkhUbqnJdS8gqEcmg+sPqGDXMjOunzyLKSgwvpaC/jrg/6ZpETdZQKu8P/I+c5cRSvoI3eizHSWvZMk6KF8lF76RIihQ17AKEP9lRpLCm1x9FgWQfGgNxrQB5nTGgWsWAsALyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVILuQqnxqxn0HceyM0L3RpuWuhLq9m7mY+ED2ztJV8=;
 b=t/VLt4G29Ve0pCRY31nXIqLlPpkThM9M11lIqXnNWbc0A5yTNJUeXj8DZx5jTcyi4WpnuHfENnMsqnICYzdmCq9PZ0tM7gePwwprNiSvDWMRQ/sAXiVPU+iy+OLMogz65WFDdiPUa092khGTqXJUI//nTkrhHEVcCfIemI6Hzhc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2391.namprd10.prod.outlook.com (2603:10b6:910:40::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 17:42:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 17:42:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] maple_tree: Make mas_prealloc() error checking more generic
Thread-Topic: [PATCH] maple_tree: Make mas_prealloc() error checking more
 generic
Thread-Index: AQHYgN9Debp7oQI7bkyolUE9qJsVew==
Date:   Wed, 15 Jun 2022 17:42:20 +0000
Message-ID: <20220615174213.738849-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d996c041-2e40-451f-538c-08da4ef665fd
x-ms-traffictypediagnostic: CY4PR1001MB2391:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB23919EC72A04DB1DD51847C7FDAD9@CY4PR1001MB2391.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCyL+tq89XHbr05q0tGXFWm+plI3Q1DfOQ4R8TaJsqNeaNTQg73p8Y7DACBOaNvf37onYqdq8lNGRDO8+Y5az77//FsORihjNPDSWrAtSI5mOo8R4gszPXPDYSQtfg0/kk3gKq64mSVDad6i7ddZJ/MpivpyHgH/gRF+Ok0SatXParbXjwzgFiLT5KKuU/O63uqmDI4sSHc6xBHwDtI7ooQO0vgMBxpl3SC3O5NLasxtAlJZt7FOAFm14mDNth9WRqcazTwUyt0pJAMBh1Q1hGBiUrNakVu0DZ+zQOgECxg2oG6ZT17gY9pDmWipQka6mXZry82/5+kT11dKanYJPVTO5+dXe3IS/o5cAo92Aqld7gbFKvO72qU1VqJ16T6YmhCAu3NA2cnUKj34slE12HfYxOS10FNx0TlOXMVfQ8q5HdjdcgNVCDa/mk7ancBuMffKqqYTTHTJhSRi01bKZUuUCNEn9KOQvkApBGtr/dDeXbSsZvpyktqrEmzBLlMb6V/OE7Pys/+duSC6FXXBtvyNfIpF8jgzegSNi/LO9fvo1+iJyGnkwd45lahyjr6y7b8SgVYAGIqVBuMbdop49xlh9e+cwlka/kOI/XQPJksKEFUnEB+UvooDbDOv/oktiDBAgZR2Gkmq+Xp2+9bE7fVYfemXyit8JyYPEMITD8624QPLyv3PEP39niUR74vc6EyD6LH+5xg8YnU9AriGcDg6NQTk0dq5ABAKrcJNLdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38070700005)(122000001)(91956017)(76116006)(2906002)(66556008)(66446008)(8676002)(86362001)(66476007)(64756008)(66946007)(38100700002)(5660300002)(8936002)(44832011)(4744005)(6512007)(186003)(508600001)(6486002)(71200400001)(2616005)(6506007)(26005)(110136005)(316002)(83380400001)(1076003)(36756003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DrM0l/EXnWZ67AKYbbfm4QDiMQkQXQQEa1DZIuYFiOKfwjZiIwHQrh35HS?=
 =?iso-8859-1?Q?OfAbThDnkv1/nFmJw993PJ/jgmAhUeZSEWeTO4XOMUHqDistZqnhRDnuIS?=
 =?iso-8859-1?Q?nvu9G4aga1NppH/pNT5YiWIWPLqjGddfSn3It/45s1CTK8aEEoaUzqJW0m?=
 =?iso-8859-1?Q?d2vb9FQd/EkDx6Z/VZTjsxtZVzVAbapCAL9pxZ7gk3c4206sYFpgZC8a72?=
 =?iso-8859-1?Q?ZAdzkbTJHIojoVN+CRZpuX+gVKgSXoKPpAi+Jv36+LZYskwAclnaaBfzAs?=
 =?iso-8859-1?Q?02bwMooi5Q/DlW84L7RPtVCN7/bQHCtSP1bEOzlTuGQfphZd2zUAk9o9Q6?=
 =?iso-8859-1?Q?6GMRxaaVA3TVoqy/zYTMf0czVVU6H4hhsvLZDwh8up9aJ53+XKupUBAXDt?=
 =?iso-8859-1?Q?WHW3+l8TLmXZPeCoWGvJvYZgdpQjPeellmbopYwX+v0DSQUX2ygtZwnUFK?=
 =?iso-8859-1?Q?2alFqZLeasdTb5a2ZaGlwl3YuG6dSA+f8h0R0LPBS883vNM70WXB5fOIoL?=
 =?iso-8859-1?Q?M0J4VG71Bpzw7mlmBByDef40I/k3RjLbvBvOkhFeQB0LrWjbRybhSAEqJj?=
 =?iso-8859-1?Q?hAk/e1RysXXiQ5woNFah4zU+1QbToSlgDcxPvtdAmWfNcgKmJ/a+7d72Jw?=
 =?iso-8859-1?Q?nIxzAxXpDi9QkfPTI9fNQb5579sIbvbjd7Xv534OPoCkcAcGXOEgCqACFP?=
 =?iso-8859-1?Q?wp79x83DvF4N7EuxX2GD3W3xJECRaUXkxqusa9jBL/kUMKG5sbxZakT6F2?=
 =?iso-8859-1?Q?IQSJyWTeNGc3pgeMY2eUKuqRhVbGtBwV5Pb1musXIoGg4F7WikNgVCTNC/?=
 =?iso-8859-1?Q?JrNN70YDcXoyX9JAwyUYdJSeqm2+JLpxfRMpZyuQpLKiig2DkpoM06kHU7?=
 =?iso-8859-1?Q?eDfaNsJ0xKbrSPaaSmWUmSbMx++INordqA1vaGTWd6iO8rr5l7lIdK75d6?=
 =?iso-8859-1?Q?jABxKdEnvBj9i3NSNo5+oYeTdQyiy8hM2JdlKnJP5uAu/vsjYXbeLgMAxv?=
 =?iso-8859-1?Q?S8sxqM+Y7i8Ef85OUm1e/JAUOQTWr95w+dzOAYCCEz+0GcYnvVCqbtKqyi?=
 =?iso-8859-1?Q?LiA4oDJyV2eDpgB9xkHOgHoruecL53adwni9kRSfUwW2a/Z0Yy0zcLbnCh?=
 =?iso-8859-1?Q?DpVbb8hG0eEbaQfHAANAyqwy4ao/5Iwn7rMu4l7UqjKzX3oc6vKeigimKM?=
 =?iso-8859-1?Q?8kOvuXijjL5OAWEOa0s7F/BiDYSvZempsC7gPdHPgfZU02Fg/8nttBvWic?=
 =?iso-8859-1?Q?CIC7iFrgfhy2I/dJvcs/8XZbhish3y7YeuizUDq1IhyYhl464sZYzBW+PO?=
 =?iso-8859-1?Q?Qeeoup45kTTcTUKu8XiJQdGCF9BDjgAXD2JHrnagGZVL3gShFViT4cYGBa?=
 =?iso-8859-1?Q?0pJJydPizUbFPxjyVEFvn4jzX4WWWdlH90Vq4G5hV4eIdn6AulHZyIJ9iV?=
 =?iso-8859-1?Q?C7VEYiO/NsZgB9NClifH38apyTaOYVzXws+GPxE2CzInA8sdg4x5Hna3bV?=
 =?iso-8859-1?Q?+rvnOiEVD1eklxR+9Es4Ce8TQ4nU/GLWRAFo9f7OYDWA/XyZD4hNY4wpyF?=
 =?iso-8859-1?Q?19A3YGVxmyovtHdeGCI3Nwpres505Wz3t7MU3dk4CDPGdqeuEaOs9SeLTn?=
 =?iso-8859-1?Q?R33YN7G3L9tb1kcBySa5zTF/BdATPM1OT566GhSQyNXnlCwB+a1UaNoFcr?=
 =?iso-8859-1?Q?9k+cocexcDExpP1n1LpvxyLE1MhVLI/ZwvdvbmKEG9jkqK01D7iadnE8iN?=
 =?iso-8859-1?Q?YC1uNhKX5mmv5cTQJ+o4tsnRVE4OVQhET+NkvruPyCKA6NVgcZMCyAg1a9?=
 =?iso-8859-1?Q?sgCHRYjMVuIFjT4D4TGxFlwH7+XzkWI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d996c041-2e40-451f-538c-08da4ef665fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 17:42:20.6212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqh13ax+vV97lFh2qTVvcChivXidW6rCXSOaT62t4pSegD8XXkUVUk6mu30fafAEoPs1Zs2L22S2pWGAiaphCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2391
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150065
X-Proofpoint-GUID: 0WySrbVsEHdQRaaBgrcGP7Q-5Jk8H8xc
X-Proofpoint-ORIG-GUID: 0WySrbVsEHdQRaaBgrcGP7Q-5Jk8H8xc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the error regardless of what it is.  This is a safer option.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f413b6f0da2b..89ff5ef7ee28 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5670,16 +5670,15 @@ void mas_store_prealloc(struct ma_state *mas, void =
*entry)
  */
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
-
 	mas_set_alloc_req(mas, 1 + mas_mt_height(mas) * 3);
 	mas_alloc_nodes(mas, gfp);
-	if (likely(mas->node !=3D MA_ERROR(-ENOMEM)))
+	if (likely(!mas_is_err(mas)))
 		return 0;
=20
 	mas_set_alloc_req(mas, 0);
 	mas_destroy(mas);
 	mas->node =3D MAS_START;
-	return -ENOMEM;
+	return xa_err(mas->node);
 }
=20
 /*
--=20
2.35.1
