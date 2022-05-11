Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D695235F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244961AbiEKOnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244938AbiEKOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:43:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0AAD10E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:43:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BD1GjS023549;
        Wed, 11 May 2022 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x4SDKfQeKlXZNynp6uVGH6qSSRFvaXEVpnYmka3Iv8A=;
 b=JW3yD2NP7MKkE5tuX8hFZ0b0Fcv2Gr3fPQVKo5O5GgaDRMfvfi1hbIGQgVpJF06xJ2yM
 HPCqQTCoPkEu41fPtegHd8wqdTu0rjNeC7QRp0UldohFlAsj0DV0TpQ2FjeZ/CKrHVsO
 nrDhoy3hThxJzUhv/rP01Ae0Cy83QQzF+p2M3XO1x5Dw72ddTTTstjTpHv2wOmQT8ELu
 5bv6A4hOe3G5X0PNukPbhP3W8E+UB9DI/GxDscqmfXxQYJW3E0mgqgL470dmqa0rYnEM
 u7ChV++ZKVyFb96WgFRtLIGcaO98YvH65qpPzdSTcZO8xuafXQthI11hnM9hIOOO8nWZ 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcst3rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:43:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BEg3c4019674;
        Wed, 11 May 2022 14:43:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7appr8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZenYml4bJkecbs2wsBIqnOQGerdBP7amta2Eqn/E6dbQtpYyNdGb9qpXH4ATKBrMp3tQTe6cWs55mBiOtLnOKQjnaKDwLAYTHZGVZR9Bw/U6kiN8KAFZR97FGMwCLmIcu8jELOHkcFFN57nm5q0uNAInJ/TL4qf/xS2mURFsJyyXumW7xjBMpznKPfwwoa7sxI05O/8047gX2gq4ENanmCcv/BDV9jmTRYaO4m49ZhNuIrG6pecEiPIIapYJST3dbzv2uwLTSP1E7Bot+lbmPcBHh2FjwF8PYOOSNdtZOJWJbFgIRfSv+KdwXw6YaDTDBs1rYTUH4KtJE+U9JL0ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4SDKfQeKlXZNynp6uVGH6qSSRFvaXEVpnYmka3Iv8A=;
 b=hHYwf3gIeJnonzQcveEHRrbsJ4TmXKlyGX5SIJt8BpZ61vh/00R1VAgGb1l0odGO3rI+fdnbvcGF4D1aGPMCWIv5kp+q4/7NVUzLJ03i9RNHvFemj3aR2BNo6ZtJXPRfntrAf1CFNd39JPI5KKxc6GcFd0b2uvbE3HGX//x/TWREiOaJH396AD4S0QKRiExrD0F1iI6u2RdCBzFR8yejmqIYnVTabxVl6sjCDbeMiyymt4/iycq+Vr96T4mfH6sfQ0U3TU6vwasP8cHNck081fllQVXLHDarPZ/VZvsmcYCWtl42wth8itFtFNb9SEuKfhhCbBdDDJCaG0bNXCb+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4SDKfQeKlXZNynp6uVGH6qSSRFvaXEVpnYmka3Iv8A=;
 b=BQPa8IevwwigC0TbpjmlX2uwJVy6AMO2DrEAn3cIVEPLjqBQ4L4j6Agew6NuvPMfExVvw3dw0ixp8WRREjdbvVYpKN5Cx3LtdBNbIZzPitp/33VvFI39tetF3Csbyu9ze3PPJgCxLV4hg7/RXi+KbYuo2aVSQyQxNtV7jRabM7U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3351.namprd10.prod.outlook.com (2603:10b6:a03:14d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 14:43:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 14:43:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH Fix 1/2] maple_tree: Fix expanding null off the end of the
 data.
Thread-Topic: [PATCH Fix 1/2] maple_tree: Fix expanding null off the end of
 the data.
Thread-Index: AQHYZUVxgvd9A2Z4PEqM7YyCmqXtMA==
Date:   Wed, 11 May 2022 14:43:14 +0000
Message-ID: <20220511144304.1430851-2-Liam.Howlett@oracle.com>
References: <20220511144304.1430851-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220511144304.1430851-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a36fa7e7-2c64-4655-8271-08da335c949a
x-ms-traffictypediagnostic: BYAPR10MB3351:EE_
x-microsoft-antispam-prvs: <BYAPR10MB335185D71A13AEA2D607480DFDC89@BYAPR10MB3351.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1BTiqTBz1bSDcU1FPzzxTfinFTyzukerHL3Z1x0oavPY5zF1Hy1UTby3Vd2HqurJ5Qx6bw5E1cz+YA0DocDz/ZVxb3RgXzUqyNdfzprI/iPUyfhIt0HmXtwOPn4LlWopDFL/fHsV3PvMPGalFQK51hKe0Os9pr+9Jd0sOMrfpsJbBSkfAh0psjOjSpj7T7f8CcZSCKU1c8RmYozIslh2sOnOFweqX0AkSth7pX6fIl/MaxYuS6zXsG5y3dtiyzJOHQ1km6Kk6DDmiQ5fCyv6GuE9Uw1Vxs9tC3tjtnCwwhXySCFmVWNt1jwjiKz7fsv7Dj0JJUGMH70F5osCgLBuvG4EYQeyzsgD94tcDE7ibPoimSQdxLxruEZnVAAHChFK9TlbsbNmX37nVmUfsu8ZVH2f4AvIzFBz+1thniDblh27udTcvP3ltcz0HQxKwVAGs8D/XNi3U2nUqEJtfR2Pqb/wCs5WJQADzLhWuzp3OFvvVJrK/AAXuu4Pvm0mCuyb2xwZCan0piVnK2NcxzGGY0BlhjmJL5Gm3/qXaaixO0Fmquy1D+SucGlGggsuu4qVb48KtPP20REDsUQMnpfV16qIyFxLjKVRnwVGBpcC1avhqKq+dn1Tv87jGZLV1zOhNn78cxezoTnMmxQlWJw7SL649HR/sw+Irvdj5uI0780aypOV3RNJueTSI4UmE/RpiKkKMhNO2blyZJNtN2asng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(1076003)(26005)(122000001)(6506007)(6512007)(38100700002)(86362001)(316002)(186003)(44832011)(5660300002)(38070700005)(6486002)(8936002)(71200400001)(91956017)(36756003)(76116006)(66476007)(66446008)(66556008)(64756008)(2906002)(66946007)(83380400001)(110136005)(508600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nBE1+bTsp3vYmNGbHqTqLDyglSlrHeMmQy5zbINl2e2nxd4yFLjrvCFgvO?=
 =?iso-8859-1?Q?Pb+Hp1rnW8lFdGR+LcHaChUiCVT10kpO3ymtjLzm2LKh/SdbS6/t87x3KO?=
 =?iso-8859-1?Q?uNj7xcX4lyAmbV/Bw89tkmblL36rGeY4ZrDfoknise2lBTrmYaARzLEwtD?=
 =?iso-8859-1?Q?UPqqynXV/FLuv855TYF2MucHCpbomR4Axip/M57FLHoOe1eh/vNbTdrUeQ?=
 =?iso-8859-1?Q?toUTSa7CW9ny/UEiwaHzOW5UVzs602XvkEkjKLe3PB0ovtMd8/hZG0+rGD?=
 =?iso-8859-1?Q?2u3dwvXphj81h08DQVnr1KbfafZ1v5CbpVqARwvL3ptGvQIDcg9ehJhlQ1?=
 =?iso-8859-1?Q?fR3fgS8DKsiTQuz7ykDf+glWCVmv9/7TpNOQOAwy1NJcAnWvzDt6ktZPqy?=
 =?iso-8859-1?Q?6qy/sf+2eGqTY/K4K6hpg1HwxwVkKLXpIqRTS/fGloFeSUivP51xwiLa+8?=
 =?iso-8859-1?Q?ZR30oywkZcmy15uIZ/uu3swDQ0QJQ/KhSQ9BStlcfuw7MAacnK3NGZJyt/?=
 =?iso-8859-1?Q?kk3pWo7C88qSbyHMTwUyJq6+ryuWlwWe9ZSdPJtzASgEtyRMzsCVzv4/fX?=
 =?iso-8859-1?Q?p7w04oQwgq9vBOPU3iGMfApNLQ4qNZNk7AL6cuooy7MLwyH9LAWTMNb4Gl?=
 =?iso-8859-1?Q?oRM1KqYhNv0DN3YuuCN1UBxfXUeinIxQ5QJdG7FodmXQAZTuaLFZUVQczz?=
 =?iso-8859-1?Q?SwdwBlloYGcSi4xwcFBHP+f/Ew5VIpwVKVYVyNMryXOdkG7sNGYQuoNhzp?=
 =?iso-8859-1?Q?Ib7klzmtTi77Ht3NTskW5sUrZTr+BEXV/WGQdm2uatOMKXChjdSrLGTiyp?=
 =?iso-8859-1?Q?lmcG9dLJsZQ88nSnmaI4kdIECVFARMfFGO4UP1vojcUv5fkKekTHJDiKlp?=
 =?iso-8859-1?Q?norVozVGKTsoVZRuGEYvY0d8uLt0hbFEkp9HfjeLdkY2l9X6p2Iv0jI4pq?=
 =?iso-8859-1?Q?sOGfVD1jaWF21tnUVBRKmtAGLdE5vYt+Sj6Q+RsVzP4+ZLMdqpJJotrqAC?=
 =?iso-8859-1?Q?/T0HrYiKzbW2AAhYBc/r5yLyKrjkmOAeF5Uv2xWB/d8ZR6hrR49kXxuV3y?=
 =?iso-8859-1?Q?Zp938myIfAQMAaAwUMmPn8BAzHi9ZqW0J0kUSF6GdQVOprm8xVcVwxFxiK?=
 =?iso-8859-1?Q?HvQ/WlgRKdptl4bmKL7pRlzbBRUy/9kLtVvg7Uc9THJGc7uKOyxLOfjMR/?=
 =?iso-8859-1?Q?alP06Szq1/oleV1hNghUv1BfBC4X3HAutERS0tn9gQuevtLXRRkN0g5qRb?=
 =?iso-8859-1?Q?YzEDlwCbuuPtTbPE5YczEFfqhYNQanL5ryQB79CbbWfXnYBHLgCV78RMMF?=
 =?iso-8859-1?Q?eDBv36g+3Ju5w4KdGQnG/Rzv4MjyJ+MPibGpQfYgEQKdpVrDOyXzOSa2cD?=
 =?iso-8859-1?Q?POaulzgi2f05ib/il+fsOt33nCaerysqAeLan8v4n0PjoID8X2j2LgCvR0?=
 =?iso-8859-1?Q?D9ODzL8XDl6+j+CISMDSZ3BP23RW5s849BTQ6p06Vj5eMKaMube73+p2AH?=
 =?iso-8859-1?Q?hXHfgXe2E3K22OtZN4yYvDZ+YDMJbSOhI5MWC7i6wi0xzKjPoV1UOtCAav?=
 =?iso-8859-1?Q?235MzOOhyOwUfoRt8+VFFlbTeR6Pir8q9dAfSSAx7e0XWA2TU2Xwf454wW?=
 =?iso-8859-1?Q?Do83UGh9W8KzH9TC8eQtcS2l4HN4ewe0LNYX1fhuP029ghucuZPtarVaMB?=
 =?iso-8859-1?Q?3+thL7Y9Yu9kSFtFROOWZnGB4xqi6wlFJ8ClUuvVhXwShWMtru67eA3dUH?=
 =?iso-8859-1?Q?11d2A497yzvCqCeZ6Lu+7YxPRdorfJH2yuIAV0IELSf2fVPIg6aEQjFk+X?=
 =?iso-8859-1?Q?suaAegzViyoVoZCdbUSp9KJKxBak/1M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36fa7e7-2c64-4655-8271-08da335c949a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 14:43:14.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+oHnlmi8Q0Y2uFAoRLWGKLy5S0gs18optNiDBk4/Vt9nkDJU/udaSHYYYwBH7Wswz9n74uh1ruNZDbBHqIgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110069
X-Proofpoint-GUID: kVpkPExrkFkwmACgfLhYrH-4Zxa024Z6
X-Proofpoint-ORIG-GUID: kVpkPExrkFkwmACgfLhYrH-4Zxa024Z6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When expanding a write of null to another null, the metadata for the end
of the node may be off by one.  Fix this issue by setting the write end
pivot (wr_mas->end_piv) in mas_wr_extend_null().  Also use the saved
value for the end pivot during node stores instead of looking up the
same entry again.

There is also unnecessary code in mas_wr_extend_null() that can be
dropped.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c7b7a10b15d5..967631055210 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3981,8 +3981,7 @@ static inline bool mas_wr_node_store(struct ma_wr_sta=
te *wr_mas)
=20
 		new_end++;
 	} else {
-		if (mas_safe_pivot(mas, wr_mas->pivots, wr_mas->offset_end,
-				   wr_mas->type) =3D=3D mas->last)
+		if (wr_mas->end_piv =3D=3D mas->last)
 			wr_mas->offset_end++;
=20
 		new_end -=3D wr_mas->offset_end - offset - 1;
@@ -4146,10 +4145,7 @@ static inline void mas_wr_extend_null(struct ma_wr_s=
tate *wr_mas)
 			mas->last =3D mas->max;
 		else
 			mas->last =3D wr_mas->pivots[wr_mas->offset_end];
-	} else if ((mas->last > wr_mas->end_piv) &&
-		   !wr_mas->slots[wr_mas->offset_end]) {
-		mas->last =3D wr_mas->end_piv;
-		wr_mas->offset_end++;
+		wr_mas->end_piv =3D mas->last;
 	}
=20
 	if (!wr_mas->content) {
--=20
2.35.1
