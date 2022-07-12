Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C55571D47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiGLOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiGLOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:49:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD63326D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:49:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtaLD016693;
        Tue, 12 Jul 2022 14:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=SMnTdS71oyZX7DNMIW2AIbn/yA/1VIizW1EIPmAMPOM=;
 b=rxxVLxieR+kPDiUnezle31czsmwYt3DrMhAMkLx/aypcYw8kjQiJ8vUBsJ3jFvSBRucJ
 Dda9DFej+Zu6uIk+nch8mw6v7HTpOiX9dHMg0UZ6m/bkImuhgzOchPVrIh6yILViaVAZ
 QxgIPdKo5/eX9qQRXKJdlVvqaJa/AweHEprxhrmd61Npus33HoRIXDujXoZ2j/0VzVBI
 H5c5Per1yJMYTcKryji0OdOGoY7md1PjHk9NwlGPSAnKDWBqB2fL2VT8lKuoYOZFqNU2
 shygDtR4VrQISiTI2JCx5DANlmfPAY2LyDFxr6wMjyfadNg9vjmzfFXUJP8Nr0LXyApi Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgps6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:49:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEaDVX009161;
        Tue, 12 Jul 2022 14:49:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043sth1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWjZfWBzg3jgV9Uw5VBOJxaq4pbMr1raBTuD6p7BgQubfazWd8HpaEjUOnYqEXhC1wAUQ1u5T3rXOP3ysSxOCbRASHWyRpH3owEJgyWAty+7BNnZ+6X9JBVAE5l9esUramGeFZygp+BWjQ/Y+UOExK/0zL5rKVPIHzeJWjlvRsK4g9zM2nFj8cqA3tEFLMnQVcSNUVN2ilyOVrYbHqm1sK1cxj29L7M0oabv9e0OuceORF21c5dwPuruDv30dnwoaUPma8ljH3cMimBo/RKAqvM1LLa0fm+wNBHa0OSi6lZrFQLbcByU2stfA790F4/bkMw83mB+CNZHnQTIt5BlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMnTdS71oyZX7DNMIW2AIbn/yA/1VIizW1EIPmAMPOM=;
 b=cyTB1lWFZGOE82YD4ESP/S87Qgy9FSRjKllGL5t9d7QK+LiM1KBVtoyyzF+bwKVmmB0L7wM6ltrbMeP2+ULQh5l5ZwYwYQSt9d8Wh577XHZi3Lv7nQDEaykeEIn1yFzSEcZnMgJ6rPoWQEspVsnq/jjdMABVs/D/7m+q8ucaAx7lIxYEXjnVTk2E2QsRhlTl++n7O5rGDmx+FN4tMPvjBTGXlbEDYvIulEAZwjRQ5/Mr9jB05Kte6ZZYeB8DboBOHnkEGn4L7lCWj2Q6OtmKgU71m9ca1G/NY6RKLHr+7TEJY7FD+nUCW5Chmt5k2YVMNSHevK+ZwRc2hoGawFpRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMnTdS71oyZX7DNMIW2AIbn/yA/1VIizW1EIPmAMPOM=;
 b=HPz5ZsuY0bksEv3HwYDIFAG6xLYYx7LuNDlY/uKCLhwc8W+2Aofrn//cU3htr0unp7N+7A4tJ7c+HtO2OIUjW7mnvPHx2xduQ1DWoPuiZzWtW0sreNP0h0QHYmilPGkYl1xEX28WMtPWmV0kL/iH50MDdKONB3EmCZN+IbTYVVI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Tue, 12 Jul 2022 14:49:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:49:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Topic: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Index: AQHYlf6fdQQFbDqKqEWjS3P5pOojnw==
Date:   Tue, 12 Jul 2022 14:49:43 +0000
Message-ID: <20220712144926.4190769-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9323c56c-728f-4daa-9b53-08da6415c1f0
x-ms-traffictypediagnostic: DS0PR10MB6054:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A005wGD5Udit9YIg1lzbQroGtA3IYadUu7aje6NsdTLSLuEJcw5/W5JwoNKy6BlqIVIGkxJP5TQzT/VmYPICaM5KG4mH/m/XXGB5kFwSSXD6RbA0f9lLNcbmZ5mJxzBVnR6p2v9Pah9we6bcEuvT31Ho1tLeL+ErAwOGEHP98uQV6FHoj8CRcSawFa7RK0b+YDy8utTna2+/K+Uma8kqQp8LQqMGLUJ+ySPFraqGEdS9g1a4mt4HKnDt/StAAl7GkbxjEQXxv7+Tbz70U1s7sg66d6tfbAvVjdyDyJjE1iqXuiJKl06rXIxQI6bGqoMNC6l61td+tGSwGnAadr9criRpsinP6ApMSP6bTztQRIue7aZPabaOXSpxU7V4Ev9UTWLFjvK6AVkTYh8aw5qVxMRwQF656qrYWdWhwxfi+lo5NWQhpihkXuy9h8tfwO6bTn5w7gno7cu3OYge2bhDbzOQuVXd0WoaNO7vNaBwu7AtLsd/LwFhuHIlAfpOHACaCVtj0P8/EI7wL1JGiv+UfjXIE3N8xsC8UNg+39UNWF6PAtAYfpDqqnwDaa35iXzawPRjzcqtfoiPCjiUWq/hy9gLdnDF83hwzgqz9S7mD8C2H+FyY3b42EVvurFAZDDF6onM+jdufgZhX5G05KFBo0MnmOmdYQDeqnxEE41H6+lNfPcVRdzIubGgH3vgMQqavbqubLSlSNdTmaIGppo7ah3/mcfk/wyQ4oODogr36QzlajaW+q1QuVIWhPGPUm0RlR4w9OX2eee5gqtsNCFuD0TxqteeJ7IUg+mjFrSLeP7GLxIJ/HiebTGEgysk6zGN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(38100700002)(64756008)(66946007)(66556008)(76116006)(110136005)(5660300002)(8676002)(66476007)(36756003)(38070700005)(83380400001)(66446008)(316002)(41300700001)(86362001)(8936002)(91956017)(44832011)(6486002)(2616005)(26005)(186003)(1076003)(6506007)(122000001)(478600001)(2906002)(71200400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HnPkfv9BAsV3qYkRsqXCNl+w5TLpNIH+WOl6vNI/RkihUAasVSEjFOTts7?=
 =?iso-8859-1?Q?y68B3MvAWg28FaUOqxKv8nQXTMz36jbv42Wp8lA+HYm+LDxodIdUvrm3D8?=
 =?iso-8859-1?Q?key1qg9Ucy3El8Kslm4ARjxf1QY/61WjzgUPt3eD+bpk8N4umJ0ds56PnO?=
 =?iso-8859-1?Q?VIeUxX3ktFTv752RMjURKJHzTZcnZx8cTeSQT9oBjt2UZHQ8uxd0K6dasR?=
 =?iso-8859-1?Q?aNEUTfNTAkfcrc1t4a5IseIwgitpafisnaquHhTGcm3a/z7op6xpTD114B?=
 =?iso-8859-1?Q?CAUFBCXOji0kOD6uesPGhvUHb+fo7F6llMh0RlgOLjxT/XNcKQoDRhbVQ4?=
 =?iso-8859-1?Q?W3oVpZbPhjKvaqMJTUdm48zcmALccu5rUSAEQa0MTeUdoSPpYxLK3+z494?=
 =?iso-8859-1?Q?BjSBN9Cnlrr7z/GrLeRQASXHdJ+UU1XpAMefQM4ZAZond+ItmI3LXV2MRl?=
 =?iso-8859-1?Q?QpxAPS9NYecXyabyzWO7ngt5ZVG3DMuZIn0d0epNGfcX8+tiQph78mZaXG?=
 =?iso-8859-1?Q?ZKnLUwETiDX6VKh42LqqMeR+so0ChYllSmFtyZiSZC8z5RGaIl2RkikaCv?=
 =?iso-8859-1?Q?nT1rxhv1S6dKrwyjyTgZXR4ll+mXEmE58Zjv0y+L8gcyWLVK/zpCDhdqfb?=
 =?iso-8859-1?Q?gjXdz8qhZukBn6S/91KDXanoleY7gcJRQxc9YN0zwSMLLpDikQ3i5IMsIm?=
 =?iso-8859-1?Q?JHaOvKtv80R5U2UO9wJUFOeo9SMmhQ4taiVQ23tFrHSh5YuH/YF5nCg3Wp?=
 =?iso-8859-1?Q?eMrimtxaZhXymUIo5qEPQKcnHJVcvd9WknDz3bKQYBzNIzzxWI6cByVWW/?=
 =?iso-8859-1?Q?Af7dvqdcHvf9en33J6bs7m6nwS73XBCBNm88SG0ASJ7zepPbEiZN5ltHKB?=
 =?iso-8859-1?Q?abtMqnU7NMoCe0fWevUA19w1nGHHHhrpncVAEdzVgFa+50q+q5RLgmVg+B?=
 =?iso-8859-1?Q?4jY1UdQV48FEsR3VDa317ocd6j8WU71dI8rOvKuqUxM4MLtGaKWBLkX33B?=
 =?iso-8859-1?Q?CL2ZQxMxp4r8udgcp7y21GdtpYXz+EbgudQA6RmMmk2Mp3QqAWo0QA+59d?=
 =?iso-8859-1?Q?qCLxUR8MBEL9uPvFMPV0i6hG7SqAXiEi5I99FcEb3953vWsaQp54vM8OIo?=
 =?iso-8859-1?Q?J/W9TVNQBdfy9r6ylyTFFHiTpeAbySo7W9gu0fsGLxf5PU8MiWrrdqb1/o?=
 =?iso-8859-1?Q?6/ozogmuDj0HrUO56+qmdbkH4Yg8nzZ3hnr/xA8AnVXJY6ZQpOayOSQhfE?=
 =?iso-8859-1?Q?fN3Ub+LSIZatokI6Tk7SCkeihdDiv8YhnaIxhLTfvl+YvmIPoBXAv9TLFD?=
 =?iso-8859-1?Q?WWIGaX7XgEypH9cuE7810U1bGvQuhcEpO39zDGpHtv8WrlBAEwll/j22NC?=
 =?iso-8859-1?Q?45huU25ty0Ee9wmVJDfnRgW7yPq82GrPQyAB4uObzY7b4CV2FY+2Ig0qP8?=
 =?iso-8859-1?Q?Cl3azG2q3o1A/ttr5PCzQ4m/FNS+BQrfAiuHDan7LNWuINoBLOmNWyl/ZR?=
 =?iso-8859-1?Q?bpcYnGfIG2PVjrs3jkunelqaLnAKEPE7yS9VZZukooAxMI6+pIL7zrLGaA?=
 =?iso-8859-1?Q?Ax1lx1LJtnvDfgo+zzs2VSgpbbxcTI1GdtdAaQbfq/w4GRKy49Mh7CCd2C?=
 =?iso-8859-1?Q?BXlsBrKXe1m+TNzVmCAEGiWychBez/eRsuosh/rXC+vtgcKxNb8uWe6w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9323c56c-728f-4daa-9b53-08da6415c1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:49:43.6583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqbBY5SugkU8SjuV2XuQR/Y5ILbVIcq6pxB3/odcn2lv76Lhs/k8YDghnrCTb6T8uOmiAoPCJ6sxbgUpL4Vtwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=898
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120057
X-Proofpoint-GUID: hVQbHoMgBC6gF2S2JIU14cXGMUaFPsn0
X-Proofpoint-ORIG-GUID: hVQbHoMgBC6gF2S2JIU14cXGMUaFPsn0
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

Fixes: b2c87578e0ea (mm/mmap: use advanced maple tree API for mmap_region()=
)
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9eb663cde5c7..9a07bc18e6aa 100644
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
@@ -622,16 +626,15 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
 		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-	}
-
 	if (anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(anon_vma);
 	}
=20
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
=20
 	if (remove_next) {
 		if (file) {
--=20
2.35.1
