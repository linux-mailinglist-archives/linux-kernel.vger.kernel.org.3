Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F9A5AF504
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIFTwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIFTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374786F245
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZi029954;
        Tue, 6 Sep 2022 19:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fdwev5ay4D3x2kQKB9VNRcywSShe4j0a78M76tLKDKI=;
 b=vSJi13ya+i2ZDPe5h9sk90QoS+I7aVih7Ha/fPx3+IX26Q0bC8G3nJsoUAuA+LAlZZFO
 4YKnoMiYh+W9XBOQM95QVjiOM50qq3Jtsscuf0EjiCGcNdxjvW2FDOkWsYH7CBVrrX3/
 GqLHSaE7RvsPe7oBWm7WdfRWEU3xZpyKCyEgfX+vtbsW1eWvFUetTsg/Z7SlFP7WhS8x
 QuO/mR8pJxYXfT0swWVnEkTVgyzlZXitTp+4nthiKE5NJADN0BabcXjQfIc2tURS5Vcx
 z+YOMpgROpJmoEgjqViUSwwGuTozDruSzEG4QAZJ2kH5VPZD0gIdj4ii9rDSePLAMmKF zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WQ039711;
        Tue, 6 Sep 2022 19:49:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTd4H2l7FeM/zBDBkx/vNHdloKyGRjrsR6KjLlwe951EbbqdfTzYCVYceBBahq1oGo2WDPLpH089wC8V3y0pie4iMOd+NvDWSxEQl4Xrjr0o8RQJhAvmx4fr/8KHj+zI+7O9f+4XJ0YGc15OKpswjBgnjSwJyEMN+ap7jZBITuxCUF+tcIxrzelOQfBOzfZU4iLKgCkdCMC/7tY7SGQT7u5qdID76TUabhlgs7MR7utlOLZKOVg1o6A0Y9jc5KLSaY4nWJKe+EmVsI8FLkcmJlt0aoMKCMFUS3yv8qHXYlQtB3fgrBnNzC+fo2AlmBYX9a5S+jLIqqx5EyzDEkJv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdwev5ay4D3x2kQKB9VNRcywSShe4j0a78M76tLKDKI=;
 b=TNTMZI9iRFwYP68P22683kcMyoHzTLCn8HxvNh3zxEj0esA0Ws6DGPso7OgNIONczR8B7iax3VyVTeVEAYR19Ot59H2ZDk8uoyeWz3Sy+5tQIn+PIEvGY6WFmfSs+eEvua5G/CpOu6cbSLbH+rCouPycsrOWaf3+drvkBH2IJesEUxX5oi13IrbSSPFQ+Ybf0XuVnTwFY2/cSpIUHK0zFlBGGtmS7eYGfW30J8ICVY8DTgX0gCtK0bintQ9S2KBkQ9kAw2NIJ1STAn9Na4I9nAlGt3N8VQBLOlcDNPKa6G/hwKgsL8QicrQC1cT+lmQcJiOpjrfWYKRlp3fQpTa2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdwev5ay4D3x2kQKB9VNRcywSShe4j0a78M76tLKDKI=;
 b=h0yKx3oy7lqYPeJKd6UF7RoD9CywX/i7BanBcG1kjBTjkJeGlDhCoVOI4fqyCx6soTRjdEOyYZPi26mdmgkDuor/NoHirS3exjfvfSsD1EHjLIQryCWOF+HrDNIuPYmWd5dztXrPXPu0hhUOXJ1jvs2KBwO7b79vI5tEfzD/5ho=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 36/70] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v14 36/70] xtensa: remove vma linked list walks
Thread-Index: AQHYwimydnsHdHq82EibWJW4KUOsUQ==
Date:   Tue, 6 Sep 2022 19:48:55 +0000
Message-ID: <20220906194824.2110408-37-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1459ba74-cce4-4c6b-2a4a-08da9040ee6d
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUC3zZPmtevUMfTMFW7b7taAgsDLeVJ9WpGvymYXMUmN0RK+e9TaLy4XX+DTKO+K+tojBjGvivv0aqXh31+Ec7EyG6IsKTtc/EYVwryq1f4leBXNBoPlLn0080NN8oTV3HL0PC12n3kmvBx67+SIXpBJjp0tri16O50l22vud3EGwqKO/iD5meuFm8mxSrx63DaCR0kuCqHl7/kzxzvJh5dpT7yv5lbpfbW6YNzKUT1x2L/WlOvb8fGQ5t4xIHkls7nKaZ8mGR74u//plrkJD3IEgYl4QzcNslcZiR2h2lduGUQfptt9YwIMU5SKcDPaXhX9SDRp6L3gIQKjKQwmSOMU4usBH/k3pvahw2hjGrGnhUHPFwDArVhSey+y9oo1cGUqC3wnDlZMZG/OLRAP39lAk1ajMHnCT3cGKCRB5k26UrowJnrvDWyMBhw0SApOSXP06O0neTDLtu4lHQJXRLe7UGkiUxo73Z8+JhFy7G3JrZl0Kp9K0p5knGwTSVr/0ibrQybU5lZO18QqsXhrw9d5pyUimQQ4p1qH2bLYkkPucgzdQ7GkmDIj7ZjWJS5HXv7pm3z8fpuos9y/J6EbU2sN3F0CT9c3lnbwCRNx8U9K5zXCZHVS55wqM4cWwteET6iGx+FP5aY2oR/KfKqkOWUTCNp2Da4KXglNOfy4ddL+LmWEwohRkcKxT5ufqRwj2bZya4VvKzbHNPT0OGt7OGoaFh8sTPAwjGCYuOnnrGawYaxmTMVAUKulKLyjG3P0pmyz2TDKDtgumHbgztsNNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aNcL4ucyTocup62yBkX97DU0M56trDzjAzhEe28iv1uC6cTDE6zrMuoqjE?=
 =?iso-8859-1?Q?2ZFyCS3/hPrKrLyIplyRpgemaSJWZ657H23W4FFLjQQERGOx2VH7AX5lmW?=
 =?iso-8859-1?Q?Ijn0/aqWTrOD9ZFpeGoztRw+OIPqQkeQh0d33HID7nGcLKcqvZ9oTbekYK?=
 =?iso-8859-1?Q?1NBlRBQT4Re0wJqLQ5pt6LhFf9MBVzaHzh8IdejIbA4Qa+hjvzycm/TYFU?=
 =?iso-8859-1?Q?040tqyMiHIQBIdvGjpz9zV1lYEX7l94cAJmPQd67SkO/LBBBhLPCLY/5i2?=
 =?iso-8859-1?Q?aa1IDDcuKWocNrIzdcHocVAtjehsFWFG+owTIIYiuTMerg6G7ka0Mgm1su?=
 =?iso-8859-1?Q?JeMESr/6GLmskKzOl3cHHkABAIOPKZTrnxvaT4fiv/nMslb0lwTsBdsb1s?=
 =?iso-8859-1?Q?fCqVEUi6E7GkVyFXQwXyJnpXlN+6lpB4jspNGaIRNFyv8i/SrAogb3wv8N?=
 =?iso-8859-1?Q?JgTARFnG4ZL/8kYN+reJ92pH3WYahay4G8QMM8FW840p1GiAmAcEw/LPQU?=
 =?iso-8859-1?Q?BZ0yOq7OjqklVIMjgKETN+J7EpGzRua4vz/xFarryuZUPDEMYVIEzUKNH3?=
 =?iso-8859-1?Q?c679LplsW3aAms+7xekR8QJZLObuzHStqbiZpwBLKTsCQClG1Tcpq247CT?=
 =?iso-8859-1?Q?AtoWhnFzDaxRZMIQ3qa/hl2GqcWMEk/OuZ01WYAoQqUT+l8ZW1qGmRHvp/?=
 =?iso-8859-1?Q?DzRLsVh+RXh3BRwL10zx+WG2DnU/4Fzdlcpx4De1DYePQkq3X41uc5XTHE?=
 =?iso-8859-1?Q?wW6mM3UcqzaT55o3CFM4ASdgt+ofUbkms4ipvfv6cItGT/DX+cj803+HnP?=
 =?iso-8859-1?Q?/YHCAF5NY7WfG5D0HH/BXhNuSkfTzFu3KcHxfvJgF9EkUCZd3VP//al9qR?=
 =?iso-8859-1?Q?jNQnvIYJAhjrJzoTYFwX98hYgJxp0t5HPLa0uhZxOgFfXq0ZgFFqkXDnb0?=
 =?iso-8859-1?Q?bxzsPOU2LiYxVOJD14vu2wTQRKjS0VQpzyP15cIXIF5vPQLs21dJ8C88jE?=
 =?iso-8859-1?Q?Voo+dEP9m8F9YM1jbzLpq4YtVdt2EUmDTu+AAUF418tyyG9MfCYBlDqTvh?=
 =?iso-8859-1?Q?Pkcb8MekXglI/2w27TxED+7FINn7mVX/6JkM5swW2c3AsAatZ0/EVnhvBC?=
 =?iso-8859-1?Q?mN03ZiZeaQG3WYrvsd5mqHm/0bOZS7wMiDEsOiliK5Puhjvn8EXINne7oI?=
 =?iso-8859-1?Q?+vlJKMRMncPJLCkgSPTsQIAV3V70vKcHhDbIYuvFIy04t60bJpB9yKRkCi?=
 =?iso-8859-1?Q?pq129jfOT6tiXzCUHg5QS4gSpR7ffjza/50+NCfvU2t/lXM7ndQxnlIsk0?=
 =?iso-8859-1?Q?cmK6FDNMyi/j5W2oBwkaYIRbyWis2KB6oVuWN3ETpXlEX5eDtA4Z94u5GM?=
 =?iso-8859-1?Q?8pQoh3gY4OQPUiYJUW1xeFRaQmKlCP1N4GIfndFIn7/Zowv+ktiS996vCP?=
 =?iso-8859-1?Q?cbqpXtDmFGs0GjfBqod07ZpTNwfMILc2xgQ+J8qhqaMC77LbvQzZ69GhbP?=
 =?iso-8859-1?Q?IItHknmjrJydcTOc54Ay5E5NeSCP8yrUrLbk01TOdWNDBGV0HshT+4XRG5?=
 =?iso-8859-1?Q?Km+0s257csT59nii8q4AiAUva8lFogDtLjScw507UqmQOFAAaSr+zTkBLP?=
 =?iso-8859-1?Q?+bnaEUgmg12IccDBpx99yu4x27S73AICDb4V5EJozroBvu40V+BLe3zA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1459ba74-cce4-4c6b-2a4a-08da9040ee6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:55.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiTw+LMZyeMr7ZO45bresIdX+nsPriWHBLVREMKnogCiQVddGk2XMfZlqc122rI2qDct8o9yAirSWCYYc1Z1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: z7Z40RKhf_3CgtVxQBFVUukGqlMHGOab
X-Proofpoint-GUID: z7Z40RKhf_3CgtVxQBFVUukGqlMHGOab
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
