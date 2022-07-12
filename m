Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2C571D03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGLOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiGLOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:41:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165EBBD12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:41:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtVKb022829;
        Tue, 12 Jul 2022 14:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=6We1wlaHO68LZ+KW+ig1acUOB671KFEMJR0GQYii48Y=;
 b=BsW/Arzl7QWG9FsszZo+tzsVqD6ILdH6LeJSaY8GzmAG01Kug/7EFaj69f8bzvATGEc7
 wisgaFWOE2ZSwI2RvJvYO/6qvnfKWVNHj6r3PhBd2G6USvXoXSFVmf9HqG/UmIxAT6kz
 Y/ZiSyzaZ3UMkU3gKoY//MNDYeXQQyxfYsO0oCD57qhPcTfHFY4rz9pajCeThkd4B+1i
 Szi3SlAeh2iuLaVYhOgpyZBPXPUwwUd8Kly0epgAKrylJmCoszhfqGuuAtcyX1cxf+dD
 tnC4oSJcVhv50MFZenyWKhgRgjz4ZqrJb2b+lYoEbLhNka3D8HKmeF8RoJIkQldZyJao Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrf1bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:41:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEalZ5014135;
        Tue, 12 Jul 2022 14:41:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043cen2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyQkHabT+/47I66008Fdu4JqQzcscihDa8esoUthfglwgWr0GgfgKcfl8hXt98Zi6lgK5/NLJKZFPxjy1szeGWFAqbNO6ZaJYmvzLyMJlNsEJ20yjxZqWjAZgCb42nRx9T8A0e9qeFkdLqsau5/G7yAqVWTjmrmpJmA51rR1wxUIxE0nBJ6ifjkIz+zGp5ExlOw09d/sa96/EL/XKJQB2rQ2swmgDQoEI3J/4qtFCnz76NtNoGY39IZqOAHb6C+un1jIQiSxOJbp5vWps2xXYQ1Qjb3qZGkVVZta+6G37C+q4VoQGfjuDu6WDyr+l+jvMJVJOuWVfhXg5j0e72UjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6We1wlaHO68LZ+KW+ig1acUOB671KFEMJR0GQYii48Y=;
 b=WbkVf6GPk5cCBdnTdi0xjWREX5UufjcWOrqQkVvHRHK2JoYAy9qzR0MaLW5Ii7jf8ZrQ5y5q2ojwmchq3O0tagVfWX0G9SGcOQnkgx8FbbA/dnMtnYotXNFjudC9PaWfjzoeSHYQT7rORkmb2B6Apn1J3dh0zIi4EJGVY5aGnaZXdKugbpCmWUzEl4MQr3feBrSr8e1rKCj0jNrGv6mOJpRXXw8tL+P4CB2xGihG7+fWJg6q+1yJh42/0pE85ZjvfvOhnp1IL4QDVzn5r9DfUxi9jPesiigOsUXlhJYQOODnXpR9hIAeXkPpHAVbfbN/J7fjI9uCDmURZPpxC7OVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6We1wlaHO68LZ+KW+ig1acUOB671KFEMJR0GQYii48Y=;
 b=Q5wfTKLaL8gcMTLTp/5F+Yr7OdHH5gcErOcW7fUCz+u/+9rrf1Cn3rTfs40ZhUoj/2GZW40T4qmwE+DlM+gFpWpxf4swMY7OKxASS6Nypel484jdTkKdZqBNzBQNM0nhSf7tcwnjqa6q2FbFn3bX7w5QSL4qCVDLMWC6R6Y3GKo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Tue, 12 Jul 2022 14:41:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:41:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Topic: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Index: AQHYlf11DPLJIcHrkU2C5BuTh11k/w==
Date:   Tue, 12 Jul 2022 14:41:23 +0000
Message-ID: <20220712144112.4189027-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c9acb2d-7215-4280-3676-08da64149795
x-ms-traffictypediagnostic: DS0PR10MB6054:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCCQ6ZmH4/QpSWQuwczHqtRoR7oDpQ+0t3hFVPPZVDsHCNfc4YXNEIg5mvgR9DkUF5mvhXg0FLWNvqiAy6dlfmwmfhpzeJbAM3FrP2qU7Ls4y/jXySPRZdiLxgVkaWASalBYib/UbPV4mVrtxF/4YXo6enHw6HPeP93GIqQJySYRqWj7XpKq/JXsIJ+8aKp3N+EZfsiia1iEp63MU/Zky/ftYaZ+L5/ofhntKJAdXOMM7TsyyX/UVmbFi8EO2gwN0nV8lv6WJ4l+L0yt8810DZP5M1jL0ydy6LieWC+4Uf8YHHuvYlorXg5FETIzXwJWFpW9PlWZ+4PPYUIX4WaUHXUy7tkrzbNLe/uyacs4OQ66UH336oc4L60iWhr3CWM8evjSLbBmIVSiZmPbSgFQxi2+dWTDy4s79KjVj43mzTvMO0xUDGc+9GNtUI0gUSygjh3/+Q1QvRZld5O5BbH5d5oK5do+iW6Tt3fSI1LRHAL/Fv/24awU3afcar01jsvClKeLNr6P1ia7g3jJEy68VCCRUYqBL+Y4HjvMfxCP0Bz5GJIQVqN4iFHuQlLATCmzEdAf2Ng3+d3ZfV0d3ZX8tqWt3LIqcEwBC9N5cYIGg0zPcrhNBcW5SQudaEU3u7Ycum4At5BbsPEmV/IVATueL34vWxCAVSdF/imA0mmEvQOUqPgwXgVTORlZy7M83PemQdrnep1Qauh8XCDtUNj9oo+mMJ9JD7h1S2i1Z17jpspoxeG0c5gTp+v7p2nrsHgmKEztz20564Jv9OmTCuntHjNoOIg7nUw7waMXR3SkhuP0PkKSSxIaBR4VG8EiSEvF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(38100700002)(64756008)(66946007)(66556008)(76116006)(110136005)(5660300002)(8676002)(66476007)(36756003)(38070700005)(83380400001)(66446008)(316002)(41300700001)(86362001)(8936002)(91956017)(44832011)(6486002)(2616005)(26005)(186003)(1076003)(6506007)(122000001)(478600001)(2906002)(71200400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J6Hd801j8nIVU53D/cRGut8QYW0KfYIe2hizUFeRF9MmI29rJDqhGg0T+n?=
 =?iso-8859-1?Q?Rln5bScR0D+CxrGCOe+8BQIl9ftPUnGTEiL4y4iCF1aVQiW9MDposjNctF?=
 =?iso-8859-1?Q?onENpou23Y7CYr3bA1Odp9oaEltKwGR9g7xLFvmxD2YQg84hv5ummItYsp?=
 =?iso-8859-1?Q?hgraw2hhQ3TzHOFSPURycDlCKASZbPJ2/uBwwoLPC++8BEA7+WtA8CFkey?=
 =?iso-8859-1?Q?ZCQ5rkkc8Lrl+rTSKRNbUdqg24X0kSndcTMYW7w3UORZNfiuAHr1fn+pQt?=
 =?iso-8859-1?Q?CIJVXXL75HZr/G4haqz+YgBUdpEm/AJowM5Q8zr6Qf+Iu+7IhKHZ+ZcvhN?=
 =?iso-8859-1?Q?eMEqKGkesncifdOl9tS9ei4Cs49Q5F+QtxJBYIQYFK0zTKcpF/iTSa/EMq?=
 =?iso-8859-1?Q?YmS561tSNa+5MQijfJ2bex9+Wb7Z+t5VVk9ybOfGMP/qpjWahTY0KZcTaW?=
 =?iso-8859-1?Q?cWJSlwDIHircCDohRKogS1Y+xQs6G7cYjll8QQQ1Hpf1I7OXxodTjF3K8s?=
 =?iso-8859-1?Q?WTxKePPI6IUCfMYUZZAfyyCM5EjJ5nf02B/9gbM8UQXizHerd9vCGZ1YMB?=
 =?iso-8859-1?Q?cZ2Bb/Om6EP6pJvQdEraGEauCiqtwWRgOvHSh1+o1Y0CZLrrkl5sWIxRuh?=
 =?iso-8859-1?Q?r63EW64bLNihv00PMtbbGUkeUGODrCIv95K82MF9+CaVvNeQ2oL+Nlzof2?=
 =?iso-8859-1?Q?gJMx/nGnbjLpDfKNgvdri7at1DzIZmKJrhk+hbSfca6Qw97PcscWwSwWbT?=
 =?iso-8859-1?Q?RdhFfYOOsuNDxso+pbkX0YBbbVJjdJ5nSbEvvDWHlcSTg0qcAY3pnWbAMS?=
 =?iso-8859-1?Q?fRq5QzCmyj7qIm1b7GvFYPBIDAeP0ZTifJmFHZQoN3aY6y0+RnkiReFk7D?=
 =?iso-8859-1?Q?9isPxLM3j+vWG/rvMY8ams38DKYr5d60KK0Wn2iovQvOGrXwX+1hN7fPgo?=
 =?iso-8859-1?Q?JSYQKAHy+ZsBMgniGRq3XtXdQZN0YhRDIbyQOD/3lKHreAY4dGNBxY453U?=
 =?iso-8859-1?Q?ldB/FpgLxIsN6o0A8kzFaUU9yKGNYi4EvcsiLPcwxzNSf8I21UclPDMdg2?=
 =?iso-8859-1?Q?QSRyCaKnkDkVRe00B//V1cYyUFeb4jfociFSOIdoEacUsqAP1/PiHPbuEb?=
 =?iso-8859-1?Q?+Z22xPLpbVc8EcVWgY+CPQY2JulieSvveZjWQW4q3qm6ZQUJkg8ekf0z9q?=
 =?iso-8859-1?Q?KjUeml5PlU9XtEhOQEVE5tHnPnyf2aZomJ+/xQH55l7yZrN4m4APTwiKok?=
 =?iso-8859-1?Q?yQiVz+v7pCHHYqy1wCp486R1tApvumYeKeqTj0bC5lifgJXSDpo2x8YXYa?=
 =?iso-8859-1?Q?9twuxENX2THS4w6r1cFQC2GugtxA5VH4HtIYYIdDq6i7zftvM+uNfjlVqO?=
 =?iso-8859-1?Q?a+KMKC/pdBuREHsys08eknaeVp3vVchihkEzue8rx/O9Q/1BH0IBk4ygzh?=
 =?iso-8859-1?Q?P56XcVuQVWiIZrhpMP77m5DM+Z4fp+F0E/CX2VUOCEhiF+xcqFdZ7GlpkD?=
 =?iso-8859-1?Q?ze/k+SucxsZse1L6WtEjpfv5+aI0aQSCaoXOocRRUvZl4hoFEtCFn2oS5l?=
 =?iso-8859-1?Q?fKYc71JiABM5z8aF4qyCerWKKG4VYpynXHHRwzgjKhlN59uYk5bDxzjQ7W?=
 =?iso-8859-1?Q?hDoLM2nDH4ryA/suI4FeZxCPimdt+1Kalgba+liYtR7Af7CpU1JGupcQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9acb2d-7215-4280-3676-08da64149795
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:41:23.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKKuZLpRGtUeinZx5rId8Z4HM4dbv9Q0Tc8SKp79wRx9Ah8YJUsWbqMV6IJEsMpkiBvVP+hL64remBDZeGtVVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=821 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120057
X-Proofpoint-GUID: zISPOMVDMGYcMOAYiYjwNow3yEO84Pss
X-Proofpoint-ORIG-GUID: zISPOMVDMGYcMOAYiYjwNow3yEO84Pss
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh noted that the locking was mixed up in vma_expand(), revert to the
correct order.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9eb663cde5c7..001b54fe19b4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -574,7 +574,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		if (next->anon_vma && !vma->anon_vma) {
 			int error;
=20
-			vma->anon_vma =3D next->anon_vma;
+			anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D anon_vma;
 			error =3D anon_vma_clone(vma, next);
 			if (error)
 				return error;
@@ -592,16 +593,19 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
=20
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
 	if (anon_vma) {
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 	}
=20
 	if (file) {
-		mapping =3D file->f_mapping;
-		root =3D &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
 		vma_interval_tree_remove(vma, root);
 	}
--=20
2.35.1
