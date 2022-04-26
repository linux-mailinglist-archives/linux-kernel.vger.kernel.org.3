Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E968F510181
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352368AbiDZPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351975AbiDZPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C315570C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT1MN015475;
        Tue, 26 Apr 2022 15:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3E6LkP7e4ZDmuiJFF9cPsVh4eJ0ijYzZD3v7UZyQtvs=;
 b=ZIlZj4c4J62edxmMzbF1Z6V4+suaT1wEXeoVDR7mabYjCh52mK4fEF6MZSEKQiP4tGO7
 DBIxZJjeUBC27jarj8IkELI8hC1KeUh/xnjFN9vHOcS1qzJP4pa04SdN6Ul+H8iNnjaV
 MvGu186EkAE6Z0ar2PUhOnHzLORpAXQM3g6MhphiG3+Ctuz365f/3v0Oka+70I69Nv2t
 qfg94b17AphymqiyqIWECZ4YGqqA9uWuZXr4jUD4SVKXLmezH2oT5qzfT4kzxJxJqWh5
 229kKUFH/rgLyaNtD50dL2qnRa385ERTjjQpyQ1I3h5njZxqcDT5ymJKa8jZOZdgdA8m iQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Uro037859;
        Tue, 26 Apr 2022 15:06:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpJS5bUxyHt5KUcF65XZ2NEAzDjf6gixShyE9uKd6ClWPeIPjas4ZKGvmynXduvUfKtLjiMmIxXZPi4CNhtSDcTBfCnYagL4IE4rAmW451sleQtLAqZmw1zka+qNNjd0FReHMB4Tlj8FqIzX8jB1bLshem8y+URHSPMYgbgC/rYk92qGzrCsXf/avD+o6ULJnFQvuAr8dnl8HvQUgGLCxwl+CHqB+mTPoT+8kqLLvJAVpWmlCwfLfNwkvi/rorfSF1s2n3uxe6U+ZBwqv3Yg82fDgafUEAjcosDNHVBeilJVvzpxW5KHwyz32zC16EAC4XfEWHDkl+lf+ULhgpZRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E6LkP7e4ZDmuiJFF9cPsVh4eJ0ijYzZD3v7UZyQtvs=;
 b=b2dHJ3appGl3eUyr/kb4wIkfiDwQd+Hc9Tz/U9iWJXa2RZl89SbdhqshhuNm0s8lrrmWO7JfU2wdexEYBi6o3qbZzd5aPYmtwcfOktSheC3EYf00RN2sYVhmNde+Ws+sZtIZEuOBueVulV5h9UkU2+K8k03A16Zaidw+hVhm5oYrKkDrqswEm1Gzs3UtnMZTWrzZBWF6pDzSHmLU5RaV3GZi15rIQLvAFKhR9ru3i6SniNmS/xGIDjUpwwdy56phPLyv5L5nEGyIBD55AhUBvxnQxEOPNXaT0vH7WeX1buq0AkGi/SwsxwzVrTKanpB32apDB9fNH4/gpNHMwGvLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E6LkP7e4ZDmuiJFF9cPsVh4eJ0ijYzZD3v7UZyQtvs=;
 b=ZENl3Gs7TRkAQrC1DzkpqYA/vXuliL1sR29Ri9NDXOi7Fpj5wxBwa+Clqc/hpb+KHJ89tV2VEmbYlMtnWNkdlIwr3POdCm2yMZm16Pir4248mkBLLcH3e7zAlQa/UdEGxdBXXvG7R4FBfzT2SVyc1Ju6KGTg6keQn51FDNeM7x0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 12/70] mm/mmap: use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v8 12/70] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYWX81O/su961y5kKKhZdDACn3pg==
Date:   Tue, 26 Apr 2022 15:06:30 +0000
Message-ID: <20220426150616.3937571-13-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c454865-3252-4ac2-0b0f-08da27965912
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB467987651B2233C7CE98B533FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkJfiifH4wlciR1SMjIE39l5IsWDPxBYXU1XIhrgcH/UYRD0WA7UnSa5KqlbwzsVnuEGbp+svS9CfDmjy1uHhNIzSav2Zddc0DE5i2OXS7DtEBZhbpXlHXUKXEcIoT/ipDOQr0PQOKS5TXaM7GTC0+Jmj84BNByP3vmC9P5Oj8ELYrC+I8eMLa2jVBmSFLVkgls3lsXWAKYCcGlMRsriF4SxLnXLJgSgQDCz/o14Vj13GRNz+Q/B7d2Kpl9F7SBGzqChOvNctyeeYTqYYBBALuZfcCN0mVDb64NVkHhDT7SRKdC0FHx9kEmxjMYcFRaawboRczEaI+i0AS20X6xwcSu2P4+XnOiAhfRWGIisdS0VjXSUnbR+ZmopVjZ0SnRl4ppfLn9MNiI/PF4SK8M5fu6gIjNZPSHJorJ0CcbK2Mg7SWvBqA9qQZ1p8KDDTEO0szTHcQLUasQ6ovg+3ttVmK//sX8OYuWe08x6JFLCWx0KVBHxrakf9c+zrM7tWz22hJFmKaWWWKdFUiLEYQ7+rkTu7E9aMZhZY9A9Ar3kJsQ7eHOC+sIIZfzJqUpFpu0QSNwV9RHdZ/C+0oKR/JmiRgHYr/oqtUbMAmUCLc5tN2bl1fZHi7w4rh/8ODeowUUrjLNra5AvaujYza4vosaLkLvwK8Sb11jus6C0IWiEOe7GsDXB3zf6W9e2HcV2eC+wALsNXpLAAKtrvf7rvpchzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y8XJWK3zsDMq9rNxzYZ8kr7bn+YPSIf1FBwp6g7qtt1EcAVlUdByeYDZAZ?=
 =?iso-8859-1?Q?14P4kTsZ8paB9QUMWvP1tTZcWSuZepC/BCuur097UZDY1tZrCxWfRAHsN8?=
 =?iso-8859-1?Q?L9JWGYUz1PPg83v1/9z7MDBS4ZRbLA/X4aVQeZyBUeDy/3omCqVBnV1d8i?=
 =?iso-8859-1?Q?eMHQsw5IXpHUDgxt+Ksl1ve0vsqfvknyjIib9f04FUFOFiLMuobJrrAPPz?=
 =?iso-8859-1?Q?PykIhzSybj5eBjYxFYIgxSjR9Kclhkq3Wg3CfqXWcyv9gh/gIwqlHWg5iU?=
 =?iso-8859-1?Q?f1LPAnPaZsG8s1E1UF3GfYdH3AOBtG1N8MoPwO9R9ILEeREf37g//wDmqy?=
 =?iso-8859-1?Q?LlsV5tD1osbhkIQSvXar+pI+b+Cz360C8WXBhhTtWmmUqcpwT62rjw+GZ7?=
 =?iso-8859-1?Q?ktfTD+EOAG5vNeG5QPlr9zBvDKdDleCAONH80l+yEUXXNy9LFixpLdUmPZ?=
 =?iso-8859-1?Q?t9XT/RIQFXojbCCyHL4dGn+UlvTxTWk/uHQN5DClXtURCm5lAStxRb8TAm?=
 =?iso-8859-1?Q?MvxoiGaU0x6n6jQiuoLBs7Qz9GBbpEjG4O5OOE00GBNgzYhuv99cwW7lr8?=
 =?iso-8859-1?Q?W6CMifobXydgAUEc7msdusDFo6rDVW2dtSCZdr4Fh3aDe88PNl1gNHABGy?=
 =?iso-8859-1?Q?ePJswe8FVuPTwhY2GmXDZQoITcgC4iSr/rBL5gMmQxPZcGNGSeyJbiJu0n?=
 =?iso-8859-1?Q?0ondNAXUn4OdAVgxOMXIfzPuHYLc/DtT3OWqoZ5tHU19Etg+b8BRArFZCV?=
 =?iso-8859-1?Q?8+up3IK73FnOWVCpBfRSXx2eunOvEuMPdxoa7UNCt10DpWxgKWFpCddJbS?=
 =?iso-8859-1?Q?WGS98t7hEny1zfvXTrRGJwfgryg9nDJBpyE+grfA6G4CWX+EyPi2hMngLV?=
 =?iso-8859-1?Q?rOukJCs2+vUf4wk7Y8dVG4V3b6Y9RGCBuZbWJ2E3cyA96Gyl4wSxygxJRi?=
 =?iso-8859-1?Q?KfYweoQApmCgcM1CPBf4K6FMGCnGJiKoJMbSul0F0mRmubwyX2OnBfAfMh?=
 =?iso-8859-1?Q?WXWo8HSSu57gKy5ajlvnMo8Rgh+3X8XdC/VG9ugQdI8c8TEE4lyn+CCCou?=
 =?iso-8859-1?Q?BP26lUotaKkj44HXenw9ODYH0Ii3QFJ4Fp+e/NJVyslNqnBLAySWwdnrw2?=
 =?iso-8859-1?Q?iy6rh8K7RRKPthSxaWRffO2lZT8jGd/7SOdJMQlxHGVzUIxDdUZV7gEvqF?=
 =?iso-8859-1?Q?44nP6aAleaUrvXGFkTHn5K05mtZ9hxXRdiI1TWKPYiMQdOO7pamhQ8bYfi?=
 =?iso-8859-1?Q?/OeGMW+pkeuUN1x/AkoeIoIr2HWcNdRXTF27zStqe+cysm1wmJdtOL/Rv3?=
 =?iso-8859-1?Q?0WYS0uq3Lv6+X5e4P/VUWl510eFwqHHIGAZA57K+SOmaMHkKPKIa0qd8uH?=
 =?iso-8859-1?Q?rXqhx0/TJXaJpoOnEgIjE8m96u6aKGro3E9qJlHYLvh5c5OQtNv229jc2z?=
 =?iso-8859-1?Q?DK4w2HIDMdVygD7myP9DDyofrnXnPQchUjxZs9mKes72nV8JIfLODPrFqI?=
 =?iso-8859-1?Q?tYu+KJaL0TfATA1UHJfsNUm2cMzq3wYCBzQ24orwCQZyjANaK7tqCsuAXU?=
 =?iso-8859-1?Q?x4g7EHGzZaslkkT7DUkMJaMHMNr3oCuqyccQ8sPdcueqeko3FV8aGfPUAz?=
 =?iso-8859-1?Q?IrRz2ydMHeFPtCc714RcOjatnZSWdjrA/qGXiANacRQVNueYNv/PwBXIpp?=
 =?iso-8859-1?Q?lKwD2trLc/X3kOByJH0F5KtqIPxP2MfOHcCyDiozNgGzW0nJmxDfsxD301?=
 =?iso-8859-1?Q?tLp/SrV8cZUXPhnbiYxXXarSMffSm72dTV4pYljfEvja/gmKffYMbPkopg?=
 =?iso-8859-1?Q?5AV1tu4NroBWJFaZ639U3xQvDZojiiM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c454865-3252-4ac2-0b0f-08da27965912
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:30.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KrmvpH37vzA8qh6XbHQhLnJxVu6AnaZuJzALrUM+SXQbng47IAbE564ROeRVaK+/ospXQxiBzrpSSVdYWJa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=897 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: d--1pl88wjLG_6OIJ4DeSl5rG95yJ4Q8
X-Proofpoint-GUID: d--1pl88wjLG_6OIJ4DeSl5rG95yJ4Q8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 041a706a10c1..b8679fd1f7e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2455,11 +2455,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2467,22 +2474,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.35.1
