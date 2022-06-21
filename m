Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2145553C01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355028AbiFUUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354645AbiFUUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:52:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0E02FE51
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2U9Z018663;
        Tue, 21 Jun 2022 20:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vPwbpL22VIaeF3NTC3VFoBwAx7aF25Ak9varGQeFz40=;
 b=IaIjC6F9WIvAn7hGcb1a/PHDzz+vJeW/orbDeJ1W/lVhJpYbsPCTuhKBVE41Bj0pirud
 zpQ+z8seKhiAeozoClDIR+3V/FZiDxJlB8iM5D6Qb2i/AmLd7HrULUe6SjCXnfGEwwkB
 OBt7olU/4U99I2sjwx/EVmzX2k9PwDr3MDt1tawq5Lh7GG2dQMKM22py1ivivmnUX8hY
 /GTH4cgOC9YmXiEQHq8eVzVOq9dCJfq8HGCBfRQjFQLOGXjMvGJXKvrVvXevLtEbV5nI
 FZipNQSTb18jNR6POHB+8prMLxyGvzfAwULEk/CFIpIrgYjGscJ5QgPogbd+ACuR8hfd nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgt027828;
        Tue, 21 Jun 2022 20:47:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2rRltHjguxqx/FtM9rh8WamQfNDo8P/8L04RXO0iff4kR67uSw/wXmkKBQyOhONOa7DEsQIWKa3iSUDq+FZOXaDHSxK1tofMO614mX5Pa1CxjuiEQn0tFHx3xsrNiIqgfSQ5K5djbcTJ+D/vCPxdFB6hAUX49uORGJwiK8sb3WigoGKl/NbwdDZIa4+c5NWJP+eHBuOD76o68rcj8RSFuWmTAn0vzrVXIPhQ/KyYsaC9j9T0b/MvCQv7QxatMMVXZnMfzCWZl9K+zaN3BMogFTgykTPuhyBwgdmQYaRVg6dn3e4OYNYY9m7cVJITwbKjCNVJn6C0UzL5Svy2CY3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPwbpL22VIaeF3NTC3VFoBwAx7aF25Ak9varGQeFz40=;
 b=cxog7GEJWm7QLAT8mzz6CVoriwcb1aCZpSgVCd3TYENERi8y1cIX1cTMSJtYfoQLXKSLk9Q1Ip9xArnqEt3r4DP4GXDWlP8zG5bQAJipZaNFzKxJfx0JeJQ57+ySlXeviMV7irmc33vESL29abUCozfuVO4qx23QeBYP0Na9gP70u61WB1RPvlRFceeJQXofqNG+7lt0XPDr6MwEuqd6repPDbp0CtjgmTRnF7Q4mPN+2OB4zj8u4l3KMM8Xkem+f+3WytZOlKUmw8WWefquanVuma5ZRY6Fq8PTr14AxZMoqc4tMTKSxaQ2I9myYNyp+/3emQQnmSdgI1JAaHHotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPwbpL22VIaeF3NTC3VFoBwAx7aF25Ak9varGQeFz40=;
 b=0I5a9xQCi1jRsmHLVbky8kf4u2mGZHgbks9CQwS63FId9w0Rzujx5Q/Ln1UFXwpDuB8IhAWEiVm6eqcsXpyU0T2YXDcRrwsTdd+VFbXpgUQjDc5KXtqVUhLUCM3ONPP8E0n/U1CIHokLHJTNQBIXe6+HqkME+vW8ko5jUt+c7OM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v10 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYhbANxSE1TW84RU+pSInS/Ep6HA==
Date:   Tue, 21 Jun 2022 20:46:59 +0000
Message-ID: <20220621204632.3370049-27-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a233648c-cae9-4716-ce4f-08da53c73736
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30852F6FE871BD6473256FA7FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZrJCgZP33v0DUM2WNwlMAdgh5++Nr51FpZdXwsnm4y9lxF2hZt6yJZ+Wg77qJNPSZWsEoAlG19VPE+0Mi4Mw3/kkK3EVNPBNd/A62kU/uHNUawVHVvnsuSqdzc/ttRn9E1jNrQvW1nIXxxs+V20xv72vHN+RoPnMjphUpPCMIiwflCHkxx4HU8zmmp8YeshlFQzirGpVjxQMDAQKE0DbnUsLWRh2YYXNTFexMSzEPi9/Fkaix3VUefTgrdpb768WTpVhrJWfrAEKkaQpB72az2V+hgyhVHTtUAhRQUyOjZmXZ/TksUMRxaC5DdpaUZV9AeHyQ5XTCi5LYAmGhX4wVauFSOYK1Y/TKaGGX22xIOXp9hV2iAdytXDAoNkGFA9U6S7DakvjwenF+T0TDYAlPXKfqnjbdbdyjuLAHnuOern+itiHELpV2Q3vCjGHH0ag9fVASyh6dCQicnL1wwjC56LhFisoh8Ddrdrr1OLkx3hWQLUOJvsaokY/cgJeQyvOsJdKQ9KWSB3B/WX+WaUFmt1Xi7lzjmfGBEIxZYr+LLex6YYR88nWUTeuP0MlhNx4UaOaIMP8kG2LGc9j0Af2yy/WYQl9XXg3MgQtjBizm4rtRgJDpMN6afsGIyYhHPIiueSfgp76XARvF4215jNit73SsQhQv1vP6Pb9UESZiDyHxzsEqj/ozVo4GFbJ7C4HVuZXPpD80+XMEMiEFCXpQxd12rj9URo5+Jrkb7LjcSVs7cdU9+6Dk14Vq2qZxtRCUzRdiZNbpqNrFPA+PwlNatOrTToXdhc6BftHFWKzQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UXt+UneDuNQ+U92AGHK/lO/iBzyYEr/3AUWYjKQHOlW5ApjAp3w4StSkIb?=
 =?iso-8859-1?Q?rUDd4BRGexR9uLm2Svj5ey9HHu19C9LoBoonODx5yI2yBGyO4XFwAMeZxN?=
 =?iso-8859-1?Q?/JLOjRIrkCSwp1bWyb8SAv7XTWfNt+tN7ACpf2N7kwBHuufxASNkXgZSxc?=
 =?iso-8859-1?Q?7R+19KwsCQ8YRWAvnSGzLagVUOX+i+g+GcjuahKjWPoE3eRsA+HfIex+0O?=
 =?iso-8859-1?Q?4KtOPH+3g+ls+jTeyZhwjx44Zq4ailJB4UTOTeo35newMp9mh2A/ims3Xr?=
 =?iso-8859-1?Q?V9dOmb8/Ac5+4alg/zc9hiuT9EIUnx5+tOquK1CsB3vmk/qKE9iMgD6yyh?=
 =?iso-8859-1?Q?Gh0/32ZJ+cQ3Yo2wAg9deVz6IPbH2mIsPVCH4bFjL/GSehtXwYzImvfk65?=
 =?iso-8859-1?Q?ol/YsbM/5Sbnld0J2cNscjAYfWNkV3/ABiEu8KqbkH+qrpItPnt+wp9I77?=
 =?iso-8859-1?Q?ZCDSdsq82T5tb41IANNPfQ5yYaFNpdtazdIoKhy1WZixcvYTU0Vfdo8C+W?=
 =?iso-8859-1?Q?u2bIl0kcHOmPd50L2rCwtV/9OlT4KwgajDKUiDFt6yov1YKVPUb5OzeVUZ?=
 =?iso-8859-1?Q?v3a5MSBBlFzxwfn6fAtIjoavWfvpRdUlO9oicA1RVbG3meE8EpN+V3SGs7?=
 =?iso-8859-1?Q?YmyohM3Ngew2dr124hcJUnokUqk1KGpHeIksGdiCUtjsfLhXUAdF3mAFXz?=
 =?iso-8859-1?Q?3ZM/tEIpQoJ32MBYzgPDzRx3GV3/lqZbreHKqbuYIK0Cn+THnZi2JtOVXB?=
 =?iso-8859-1?Q?AGc/l56uyDoLsI8GiLPGLP1g1vEesNxeLYP3nhY5wiOPLOB1ZD0lRI14VR?=
 =?iso-8859-1?Q?bxBxDlOgXDFYbdgO/O5LvoiOlrTaaeWu3oCaOGBKn/eYJJb4jiWoMhA8HG?=
 =?iso-8859-1?Q?o5SFZiS5BCRrpKNjaulpXg4OAekB1qXolVO1fhIkYlzLhHjbxbdx3oshnG?=
 =?iso-8859-1?Q?xyiNYmqMC/kp1LT5ZgU1nAYBBIsHIh2b6Tor3zdz2Msjl9qeM21nVhm7hU?=
 =?iso-8859-1?Q?A5aqkDSHjgLlYg7UP/SX1qpet8qQ2xpfTPqkd+JX29hxAUZgycKW+3ynAP?=
 =?iso-8859-1?Q?jIKSZ2R4cSnXxyP2CYwa3ffd9PNkM3nvfh2Mbee8AhuFmrt/qzd8nM37tb?=
 =?iso-8859-1?Q?OI70FGGYOm6HIq8tnJLEu9+WNPPMB2w7tLvsM+lz4BYF1GAzJFhGUa08T8?=
 =?iso-8859-1?Q?Daa8FYRp9gRUi8L2LZSlwfYu+vl977xLqbriUf9wwnAxeA+Kc9PaEqdU6i?=
 =?iso-8859-1?Q?8CNR+uUqb+D+T8lYNA/uF0NU4D+O0DO6Ah9R/05EwLANMNZiYGOZmwljZk?=
 =?iso-8859-1?Q?/rB32nDeBo8AMQuBXawePbc7c4J66g1qHXQ6YcksY+Ng49iW+nSjFXaXRu?=
 =?iso-8859-1?Q?wzsOmvi+SfwDclIbkyLXZjzOkHBCqx2QNY+Vvn9YzqygCb9HGbp4kcx+h9?=
 =?iso-8859-1?Q?np5Tct/ZbvFc1jYb2fJ0AxIXvR3Z4BHrziJKeAy8FTaKH23wMpcrMFcZDI?=
 =?iso-8859-1?Q?9I6VyPuwIf3WgOXLWavn841Nn0yH5VJ+FfMVSyIXPKwe66wb87kH4FZWHY?=
 =?iso-8859-1?Q?16pS6NrTLz1WQkc2vQjTVBiI4J3EveIo3gMKdQzfUdFKBeyzrZ6YcyI8x+?=
 =?iso-8859-1?Q?03jIjayQ5Xg3qbfo64t1WmS++w+DjbUrr4WmxgVrwzKDSDasor5TkbkUIr?=
 =?iso-8859-1?Q?43CtDOcvGbbS4Aj85YryZ8yyIPNqRCaYCOm3mG0Cb8LY5Ig4sJuusV4WLh?=
 =?iso-8859-1?Q?pguMfIcQkitZKB31TxVeg4qu4JWjU21sMxN+TsTdYim8DvY8Wir0smOOCe?=
 =?iso-8859-1?Q?gtOzxE4nZ4Y9+TdBzNWf09msz+wPbng=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a233648c-cae9-4716-ce4f-08da53c73736
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:59.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tl664p+SNR4k6eZQoWk2wiJZkx9RTiMHxK8GZN8Q4mzCKtP8lHJHhxKLMdQvBAKw9XX7LkrEvStvmF5+Xow2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: F68_5PxoM3jBY-0zcAug1Yz7gMG0Dq7C
X-Proofpoint-GUID: F68_5PxoM3jBY-0zcAug1Yz7gMG0Dq7C
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

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-11-Liam.Howlett@oracl=
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
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b0a84f7c79fe..1b02988b6fc8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2808,12 +2808,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
