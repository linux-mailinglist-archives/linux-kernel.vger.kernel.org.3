Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7254F880
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382330AbiFQNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382320AbiFQNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:46:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDD2870D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:46:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HCr0t5022330;
        Fri, 17 Jun 2022 13:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=wGPqcMeoOh0sgxuVxotf/9DS81e6cgkPwz2uZN/xb8U=;
 b=c589zpM6PR2RVvHOdOhosOmfPJwJvQQoxXp0ASJt3IK9PrEscJb67ytauHctF9IK06qy
 pRhe8D2QM9IkVhioSZRY9yaycRi0ejZL3fV7udo49Un+FlQMsEULYGNF1Fj/1Tj3Yu+z
 KfgmsUPD+OK07X1FpmNMt2fhgdYIUAN/kCGxGPXuK8ZEMKZMRaQBiAgsQcijekL0PGVg
 90utJcLZGmjhNsw0yBnh3ZrzIBfuwViLxJj6EEqNAIUl8wxBRnYhwJ0WIHW5jFcBGlzo
 TvOVZmCXEiqPSp5b6hZKFDF0UwmiLG8mGaUws3W4lW4WZHLYweIq/wmwc+ABvzv9d7iK 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcwrfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 13:46:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25HDViqN030778;
        Fri, 17 Jun 2022 13:46:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwd805e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 13:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvz8eA5JZ8WXJDKRljfc2MJ8sU7U6Ia5yIuntvWPn9I6vp5+z79nUtu2TawYZ5DmgKRNg5si83p4+3rMQ2CLHlp9NIo8jNo1t1FhMGDd27h7ec19Dg1JHcWnxXyOTcKoVNP90Hdz74BAmOttYKjyBcP9KmeynXmFcufIvXgt1UkGa3dHXGgc2NXYuWA9gv0iINr8tmKTwM+aIkGzkr31M9U/R7L5ZTWV+Fz8Qi6LSDbMExAnYns79MJ+UULS+kIUnF0/78pPsxJ4UivijxMSAEFYU+k68xfI0tax5rkcwID+j1FYPhHMwn9Lb4lEPq+9mtNEWaHfQu7QJnT87EjHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGPqcMeoOh0sgxuVxotf/9DS81e6cgkPwz2uZN/xb8U=;
 b=EKyI4MamUrHEG6s8J5Dr+7JB1Ca+31u6o2s5E8LVMIXJKWBT4bcdc0clAgjT5E45QltZ0yTjRP4w0bibaMmtax0LPAAWsGdloTSpSQqeo8u3pE2dVFsFq5hVUjg/Eh4mDW/5v7tKOJvQkl0y/NVh0Za2vlbE3ZvX0z7ixJmZRYAw/ZMMyLLCwsb8g7oZYx0ffDSQ40EQ1wt1GUhWuDUUcIFJ152eGRmjlXrppcGQjoQK/Z4C1lnYjhJoDpcTmHWFrg5thqTWoEieR2zBV1XJP8dLE2gE/VTE9ZESDmVvkdmI0QVCt/idEYeD5nCwLxNZJ/hitgqUjPwsSkDcMLbbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGPqcMeoOh0sgxuVxotf/9DS81e6cgkPwz2uZN/xb8U=;
 b=GwfOmvBWlXLgNYYtCennTZmWkIzygbny2JOFFNmcNZ6LoGVI5dvGuB80Xe3bPLL/e3k5nSNqj4KG5kSYLw138G0YH5i1duHRctyMcucHraO/ff4v+pPOh9l7Wct4jGsQaFgXNYGn0nas5S5/84ASuZI/Xz1RDkT9EoLxuIGVQV8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5232.namprd10.prod.outlook.com (2603:10b6:5:3aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 13:46:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 13:46:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] maple_tree: Fix return from mas_prealloc()
Thread-Topic: [PATCH] maple_tree: Fix return from mas_prealloc()
Thread-Index: AQHYglCgUeMNw6QdGUmy5JaYt3ukFQ==
Date:   Fri, 17 Jun 2022 13:46:20 +0000
Message-ID: <20220617134609.1771611-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05dd766d-f91e-414f-53fa-08da5067c2f5
x-ms-traffictypediagnostic: DS7PR10MB5232:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5232469EF0C8571395B7F974FDAF9@DS7PR10MB5232.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9BJVnlVbeXlynZP0E3lvv7SQ6zneUmFoYkOeJ2qeE5u2h5u8Z07W754uS6F7QmqWXPzoMzRBGk2cdUaBlYURIyEqK356Dc9RzFFdM4lLm0AZs3oE8LWNZRXoEKJZistQNYR7kbFb2sgfcaicvDrcYqEu/J+U77rDUeJxKES1smWY6P92YfqNkED4jjfPhhNFjSY24L56lQR7GaUeB9EMWbuWCpWjEbCrPFdQfTuPcewl3akADSxDDIGCmqMJyBzMy332u2+rxC6prspJEXbgrhdLb0hm//GlXQRHKjh7fD09hys1Fv/opyyeei2kQJTJC5Eki+s7SA1/fGOOwCIcQ0JFcNTD8Ku43kUEqNKoeKO/2kZ41q9MpGD5kfNv/I/UYy1/CH3k6G0HGrkADOj3aKQh+cfhTA5kJZsNYn0em+StdpW2rmcpPemIQb/qT24DxgthAij3Ywp/lWqaURBghJe0a/Q/HlFR4wQ8D4yCoSsQXxRYSbA/SBjqb6ChVaxnL6dgs1EzVC9PO2is74V+rkpElVqkx0DsDfahoql/2jdhcs9prRdKK9KdYU5Vn30nYL+CazFCPix6M86erfagJ1TrFq9ksGkgWUcia84eFfdK/EeovDmCUm9+vmksEWciCoppHFcwBDm40D+1XN6R9KZ8fDHqq7kbq9oPVWjJWPfIqg+4bphKVZJGJZzQFXcoll+NpeUfOI7W/DuC50nuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(91956017)(498600001)(44832011)(26005)(6512007)(316002)(4744005)(71200400001)(110136005)(8936002)(6486002)(36756003)(76116006)(66946007)(66446008)(4326008)(2616005)(64756008)(2906002)(8676002)(66476007)(66556008)(5660300002)(83380400001)(1076003)(186003)(6506007)(38100700002)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vxPwsbxwwi4Cv1G++qitCOd1JimeWjYFci9y3zOUhZ1Tbgd8NLOkTbyozo?=
 =?iso-8859-1?Q?LqHg7citSoaLPw4Fecq6FaQoLb/kwTMblhRPxVrs2xeRpH1VN60ecVQg2n?=
 =?iso-8859-1?Q?fzQynY+EHkkS29kv/wtisBwDF8Sq1+WjvlS66M7App/K52B3YuyMRZuduw?=
 =?iso-8859-1?Q?KTp8Y+q74XAb+WO3mHqzkagab0rFT6DWI/quA503FtAernVWke4RNYCzVN?=
 =?iso-8859-1?Q?opWZvo6IdB4fK+mjbQartkiwHThJA9R8+m/Y3211NZoOga8NeV5LdSDTxr?=
 =?iso-8859-1?Q?nfszDYB/Zobq7vaCHdTOkiIfJ6eGwCvfAmLQy8BjDKFmf4gcEBg3zY1G7h?=
 =?iso-8859-1?Q?K5ayL9fnYmA1QA6P481aPi0Vlsw99KhW2w6oxzcmXxaHqTCwg0q/sGpLTS?=
 =?iso-8859-1?Q?dS89Z3Aw9cxd29SUdw0qYnv948yqAo6ZkRWpL4ck/ytQbdNeM1lonvHpZD?=
 =?iso-8859-1?Q?sUIkGHYU0jh9gTzX6LwZVuTT1PXthu75VYMn3cKp94kIzbuyK56h47kDfe?=
 =?iso-8859-1?Q?ZuF5T7NLxGLaDnbvnjGL+QIRoxEau1NcUqH2BDdJJxTsLlxfYdK5M+CRw8?=
 =?iso-8859-1?Q?edZZ++VecWDUXLXPEe3K9O3pQO64/ibifucxTtyEyzU44pteAwyaq5/Z97?=
 =?iso-8859-1?Q?Ap9K95ksR4LBRziyHHeHyfT69QtWm+Vm7Nsxh+G+yoJ8zZ6G04zjzYlpgs?=
 =?iso-8859-1?Q?mz0TCOCYpD3UhLbBTWG8o6ZQEJXTbdeS7gXbVHML+dZeY2LXwjeGMeNjLe?=
 =?iso-8859-1?Q?AGgXQZtPozEbXTfV6TAbrs9DzEsZhOMQtG2y8D4j0QvLJnXfY8zxlx5+o5?=
 =?iso-8859-1?Q?M3dywuVdUZjjq7t2tSX7F/CshTCo0x/7QKF2PA/OOWLfeVV7ssu5HmgF1e?=
 =?iso-8859-1?Q?nwm7hBXVMrgejYZvclHk7PcnWG16PW8RZXNlAqV1NYy22Ep05YCLfoZssQ?=
 =?iso-8859-1?Q?erFxWgrdSNWKuIn4+4D4j/2MD0E2YcMmgpginkiqJrBLPyC/v2v+xe8Z1n?=
 =?iso-8859-1?Q?eMjWojulDmCFpVg3M2uCDRHIRG/IxD80EJlYjn68icSaN+/na4O54VB91x?=
 =?iso-8859-1?Q?pxK/ElUlOveULiuad5gAgfSZs7KZdJhD4xHc/bR30dsBH+69YlMYyxDhlq?=
 =?iso-8859-1?Q?36lB9f202iuioTwmxwdP4uq+4HIGUundHIsrdst0TivSQCfzmIAsqYwvRy?=
 =?iso-8859-1?Q?Z5hKFS664Ovqg94oMO32GflKfsDOQ3+FfISxnRRTu56rcJpryN8/gAX4/P?=
 =?iso-8859-1?Q?eZUhRhonHmzNuTrnCd4E4DSo6hmMsL//9Mdar3LUSqmRwL757nelAekK6R?=
 =?iso-8859-1?Q?2arzHZshxG3df0rYpEJtQ7GYYHYC9ReWF+EujOE/HV5KsJSXH22TWUzH2c?=
 =?iso-8859-1?Q?I9wG8tXHgCtjRHjP2QkOFpBg6NvReCBvTlu+D8WpiZsdC+tkXPc6W5ygm6?=
 =?iso-8859-1?Q?tTjR+sKj1if1GJSCPPdtVnFnLZY7fYLjDOtQEdOasHEo7vuu7LvfLiQLu8?=
 =?iso-8859-1?Q?wmUpkVEAghf2VWYrxRX+opQ2EAdpsSxTfblw2dH+vfLtPu2xgksjHoX0Qa?=
 =?iso-8859-1?Q?zawlHjJvXkExSVHv8zStJAo986z3HGZ6TR/tu2evi61o+AYOZISvfgZ4vl?=
 =?iso-8859-1?Q?Q59Xp+R2wJ4HMuxXXGHgsOGhc7p/QzHu0ASuwSh8QdD0yAXszlS3tFxM0S?=
 =?iso-8859-1?Q?2Xnxnz9Xtv+TIuLs1BDsOdcvug+G9puTs4O3n/67HKX6nOrJiDZTIYB7ws?=
 =?iso-8859-1?Q?QH16XUaXJ4JCwiAlj3WG11mdbsXmAMaGp9WJQWEmJ11L4evhmp9cwsdSKQ?=
 =?iso-8859-1?Q?IHxAYHkshm0cjItd4afiviPRPQ8JmzY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dd766d-f91e-414f-53fa-08da5067c2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 13:46:20.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Z0ncanFR0izq+1JYMi0l2ZWZ8SlzvNbEC5PkHNm1K6XXtCLn9hNMscTXCrieiVNc1EJTKMXl/4FhlRLlfgwZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5232
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-17_07:2022-06-16,2022-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170060
X-Proofpoint-ORIG-GUID: EgUE5Rn5nC98t3_kirjnlx4bOge-3rYv
X-Proofpoint-GUID: EgUE5Rn5nC98t3_kirjnlx4bOge-3rYv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the error code before overwriting the node pointer and return the
error.

Fixes: 2ef6c13ee71e (maple_tree: make mas_prealloc() error checking more ge=
neric)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 89ff5ef7ee28..1f4c476aa5e7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5670,6 +5670,8 @@ void mas_store_prealloc(struct ma_state *mas, void *e=
ntry)
  */
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
+	int ret;
+
 	mas_set_alloc_req(mas, 1 + mas_mt_height(mas) * 3);
 	mas_alloc_nodes(mas, gfp);
 	if (likely(!mas_is_err(mas)))
@@ -5677,8 +5679,9 @@ int mas_preallocate(struct ma_state *mas, void *entry=
, gfp_t gfp)
=20
 	mas_set_alloc_req(mas, 0);
 	mas_destroy(mas);
+	ret =3D xa_err(mas->node);
 	mas->node =3D MAS_START;
-	return xa_err(mas->node);
+	return ret;
 }
=20
 /*
--=20
2.35.1
