Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480245AF500
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiIFTxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIFTuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF4C8048D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9bU020014;
        Tue, 6 Sep 2022 19:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mVi/y0eTExMDSkw6WBRer0pQet3EtE1yE0DP60Md+hI=;
 b=XxU7MFKaLp3v0y95adzUanuz2oCOKK4rI99do9ob6cBeChCeqnWx8Eb+Cz49pc2/nnTF
 ZMtmHgK3r6JDxiMfcDF6OUHJPyjT15NSzAbWRftukgaEp1d5pAUuhZwQd88+rFMeJ7oa
 0zxttULZH7b7lvSFCXd9BCTWRk4jWsKlqaqmrw/pxhq1d9WqCnxlr3MzUd+ik3QtZ7Mm
 HNxi1reNYRV0MqbkQHHYXf13LrK3j4Po/QGY/XdnUoQGw1mGZB7S/zd9QM8KSL0hwyEv
 NX85bYQV0xAX57Xz53SS6Uja3c3V8I8Vaui9E2JfAphgD3WvGAmTPfSyquIPWGx95Pc3 AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WU039711;
        Tue, 6 Sep 2022 19:49:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRkB5WXZcJwxRlVLQ1v+OwYwdjZ932zVRxJ6hprx7QuD6/KvdEmikFsre/2jtM4YQgbPm4XoW+HQCmspRkDPxR9zItEbVPUVJVZKR6zUcW9utfjX3jTg1C8Yg43IonGCBHrOCm8ijs1mCC/9/2jzuVgIrqqs8y88o7BHT7PkPVFU39K2i2PACHNTlJIU5ntMq2cVIppAWChKotbytb+G03sQCzHDkrK5VKPl5/9KwKLHfA5gJPaqEMI/URL1+zNxsnALyMTK7NznTFQTsoEwtLLSwB/GBBSamUM0Ds79rJY072UOsrZ8YJ7jR5ajlBroe4SNdIq9aKATlXUKmDR8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVi/y0eTExMDSkw6WBRer0pQet3EtE1yE0DP60Md+hI=;
 b=ZaEncpmydnIWSXe8c8UaJBHtYyHzd9601euhNHLds400MVEmYwX5pa8f2WemOM8N7HJDTGbomhuV6o/hSCupNn3250B/g8wzimHvJgxPscnQFmRC7SwSZdytEmGFhp8vAvJlVoy0S4++T3TlUFGHuHwJd+K1rPrhk+/Kq7bpO8WEGI+B9En+i8FWy3EIMDqxC/ITkrK/XPOrynAAZ2a9CJxxq44jQx7VbV5eO7DK4AwvZ+g4SB5u1OLAOLAHkG7BaUGevlE7ZXKUwVadTpHKbNCENNCcMwYMhmFjJ4UtzMU0PxezsTrBJ7ogY9WeSR+Ytkvw+IrtVXmj6GWjk9B48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVi/y0eTExMDSkw6WBRer0pQet3EtE1yE0DP60Md+hI=;
 b=FUXePDsKctMw+Ylrh/k41ZfcX6u6EwKYrQyKGiobbvkStxxlrlaJMMzK/4SFuBAHA6hTbCPPXgq8ZBa2RX/7Rkoh1y4LxbMvqNptaEvxjQRe2PPh6ch/uXqv0J9l/xWtTq80BXSf2TiiI5yf0ugaKpuUaNb5GbqQ/QedoEcD7i4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 40/70] coredump: remove vma linked list walk
Thread-Topic: [PATCH v14 40/70] coredump: remove vma linked list walk
Thread-Index: AQHYwimzf/Imc+yyk0KiuWgxksLiDg==
Date:   Tue, 6 Sep 2022 19:48:56 +0000
Message-ID: <20220906194824.2110408-41-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0134e23d-da60-48a6-a1d6-08da9040ef8d
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ah6kMS1ilE2/kE6y/4qFg7IL2vwY8fgDUuVrG/M4wQdrlcSzZtJmMdOdVS1eKE+LmurvdXEjMeakE9Qjuc86n0tSB1fyKNerS55LkrOOGjF3l73xSnIAG2m4sKlmLEOm168nddOtwlT1L0/ajxCL5FIXWtjpcevfEikgwGqwR4vDqorRLcAPHVDKSFcKe9h6Ur42c2cxIOT5L/NQ3p/FSSKBvblDngxfyzBUEdD9s+Rpx9gwQQpo2cn68rGm2rSsgs0pSE81xORa5pXlce4AAA2sZAsR4QI780bMkqTjgsiozXHSuBEtpKh8F8xMt1KBvVJpj2mwoz6LKC2vrS/4gFzKXwzackUovNdzHaHkxFuCEKZxSQ10+BOYGHKXZ+zgpFbO/RMe5BOAhKuH3f/fTVUcowbfef6c6FC9H/JNkXDJdaFy3KvCdQUyOu5Rf3b9fIaztbRgGiOCtBvflocnpT+5Dc7JxetGnHjs15+3jgC5zGr26e80c0sM0PND7K7/lzVV87OMdB9dW5B9An7MoWUpp3IZX/sRGDPwU1TKsR2q94TZVwN1VMmsAtDm3gSLyzaZNxki03iHsM/CgX0fgxBNYB9X9e9Fvi3heg3f3uad0hiaOue0nv968LxGQy5IyxtZJKOpyGrc0L9tnz76rMGPtsYHWFUzO17w/h6rDGuwi/gPOmscEF9ECtcu5wAWRP0YmWO7W1x4RRBe6n1D97mZi2o5pKsVMMr8/OlIz7Pct9Pf/f+SeAEV70Q6Z8kN45uWGga8iSWsMF+XJmU1hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(107886003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jWtsUNxj4+4Y+JF3IvaedWun0axAohilejn4uj5fRiLlquFCkRULwrMTOu?=
 =?iso-8859-1?Q?JEllEfc2LSrfrYEgkrpNZQLnC8ayC1BLDCJ6NS5E/XA+8iuU1smfE0PI3m?=
 =?iso-8859-1?Q?Vy1PzGRwTGTUwpFc6P833NzAXl/605b4+BNi5+2WrNB3fLEwdLnjVP5elX?=
 =?iso-8859-1?Q?/7qyVY2p+g1u8t4kHgHoiLldaHSzSDF2P8EthBiMDRhIu2f+EEIKQLvrKW?=
 =?iso-8859-1?Q?gCkhUQmoBdNL/3+xnWUVZDMmYuQAAtA7t0MZJS+Bsc+1l+G9YpA3YDjfBd?=
 =?iso-8859-1?Q?0TWQ39E/wJ0Vf8b0zR45Pd85v+SNbnH1VHncUdSbo743rbiDbEI57nIgqw?=
 =?iso-8859-1?Q?9yrdi+ESj2swb70dZppcyPlovGlkpb988GWJAmdKBqX2ky2s2qskiamqSx?=
 =?iso-8859-1?Q?XWHqLo6uEY2zdMM5tVypzPKmoNEz5UkK9KxNWtGq6zBuyZ5PH1dDEGBK3p?=
 =?iso-8859-1?Q?t/1t0ztl2X7fLHvO3HxO5uiV+QGMszIQdONH45gj+1L0AFJDBSIo/yq8D9?=
 =?iso-8859-1?Q?gAqVHP522/pG8luHOAD8OxKFGU7iHRn1Uey1dCHhdn1d+WcrVOa5PsaC7J?=
 =?iso-8859-1?Q?apICPwolatmG+C5jRAN9WI/PKPhSo1DgBiVLaSSj3igTXAlUXe3ERnMW4P?=
 =?iso-8859-1?Q?GBGhkA/uccWdoClP6H151DHNN7PPwNvsjlKwyT17ayqttjb5nC0hpauHl8?=
 =?iso-8859-1?Q?nKnkdbF/R84llD5wGEmBBt9UGU+mFa5pLVRZJUGYDnB0zIJu6H+ecC1YM7?=
 =?iso-8859-1?Q?PLbFrifzFDH9j/v3AnzFegIe4Agqb/9eqwXy+HydfnxKjkJfDw3BRN4jYP?=
 =?iso-8859-1?Q?pv6Wt3/zSiUa2g2p/0+ntVDqzLjh6IYl8pH5seHNu2lkZX8X3mFUNdS3Ss?=
 =?iso-8859-1?Q?Qcc0VTAYTqsQyx0mH6hQ1Ig8zFq1VrYC4zaqKyvwk5xQhh+s43KANNNu4l?=
 =?iso-8859-1?Q?xHfn8+GHnpOk98wAtE1WtRxRaRgzvn4egF7kSmkTpXX8H7HAzm4S8VXIQu?=
 =?iso-8859-1?Q?xm2rPhVUsXKLXF5BK7veTJJRTQbrz7ZW0ijCiqdftIpMENlSJPLhV/dQmB?=
 =?iso-8859-1?Q?5KEE2JxXf4vFUJSu5c/o91fa31QOlP4ISMi7kesma2APl3n5T7/CSTIseq?=
 =?iso-8859-1?Q?Gkf8oUe8vFjT3N5rb/9bDIuLlcCyxs2m9saXjbwo3/zb960Tbq54Yf9BfJ?=
 =?iso-8859-1?Q?u+1MOc9cf3EE/lNBkZFaewGmZZ5NADqHujce4c7oo4bLcWcf6bPLKckz3e?=
 =?iso-8859-1?Q?2eKRh0ySB+oUDwdjJctD1FNum3MEU6RNtMeySoDOQzb37h2MUz/U/llIs0?=
 =?iso-8859-1?Q?7CnI5qYlTGOVxv3nqNXjR5uHMe7/mGj86Jj1gZl2Ki4PX+T9YQ4Qbkeg5v?=
 =?iso-8859-1?Q?BhA4RaHgpxFNqPdAd5to3PuHJScbrseCuvrr0sdQPKZNjm/bZSsIT3xVkb?=
 =?iso-8859-1?Q?VK0O5NxkzM9GPPDBLA+ql3Dih9z86Jk1Aoa647C5xXe1dJBvwHz+g2B16t?=
 =?iso-8859-1?Q?gxNHcC7q3TGdbgpRZQsbriW53oiLV1gbjPCKHI+I7jyyb7/5GnlqG3HyiN?=
 =?iso-8859-1?Q?GVJ2rgfRTOfA+V1Mk/OWZsKk5J7GMSKK/bn8eUlqt80fXVbpPYaIX45Rfn?=
 =?iso-8859-1?Q?0p9kvaIsXocbxrAxMouqgVO9uktB571O6VEI4rHdkf7LpRts/1h9JAVA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0134e23d-da60-48a6-a1d6-08da9040ef8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:56.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGojr9k3MbCVlsAyOMgQ6auGsMl0bLg+A3sPZpg4uAQH+JtLJ/OBgSHwmeacXmGwnf1w2Ihxfm/Y6NZ3BYYaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: nhfSaEzXqq60cLTZgMgj8jPtmCXamTcA
X-Proofpoint-ORIG-GUID: nhfSaEzXqq60cLTZgMgj8jPtmCXamTcA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae202109..35f2af85b9bc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.35.1
