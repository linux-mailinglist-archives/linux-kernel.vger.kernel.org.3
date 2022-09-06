Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09C5AF4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIFTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIFTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B398C86
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZQ029954;
        Tue, 6 Sep 2022 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ddj2FICrVCtFlnyoGw3HPuEX/F0/JqO/TZfzNPxhAuE=;
 b=SGdYQV+9S8IHTAZLt5Se/TPiuzmOBEdEDxXQxlU3xZVlMRPkLXI+rA9UFgM3w1sym004
 IrpinlgOLROR85rtVXdJJ1f40//rEqolgLE04e0rGysfWKkxjBYI6wt+/uc0kPgfqb5F
 5Qj4oSkdqFs0wRXSmeiu7FwM3kh9pe0482vggy2QvCiU4NdT5MgSQdg0JDbCz66/N6tP
 krP1kfqdEU6Hbi6+trpMn5vGzrt7oIgj+/CA+TJrnq7JIMdMZt4E2VasMvLS9rILiTi/
 jajSIq4xhA1z6MTycdIkF7xqXEc8FU7jXXXe5BWHsEKsjhk1VfHc5wcOpnmSathcIIDr xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wa027549;
        Tue, 6 Sep 2022 19:48:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHJty9r3CQb9Y4vIlhnGovJWi2KgylTTOXJPeF9gxB+Fb+dg3vdsenHnPe1D9OMaGwpfpwW8hTEVNEvheUlVikSElNuJ6V9/PrfUALDcZ+vUNDjangabqmXEbyLu5ArNiR01cue3qLMd0yFtmZapnJneeDU5quBfYQYnG8a7jnOCpPHpYxu/1XhoUWKE/9uBk5r8wq+ba9CkBv1NJ060jdxqF6Rvd3C0S6aejoxV9OjY1eb3CHY4v3Cs/ij7lnwnnd7X6LAqJjWB9i+iP55NJQ+ZF+Q1xakHkWHFRukxOJxsuyO3ok1amWhrtSZbGwP8s+GIPcojjQEeDM4ijywrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddj2FICrVCtFlnyoGw3HPuEX/F0/JqO/TZfzNPxhAuE=;
 b=Sx5giI2EGGMjqj0f010JgNdwmwukEjAgssf3WLIAhFgaWpmtfp2KIcdRn/D3VXZVTJlVvSwNopQu5rRMqtBHVke6wcVXfdm8cP/aFjpqPLe+yBbtnl3+SEEWiFzxuFZ72I/O4yxD6NxfZtovcuKxjIAuLKZNYACFigQsgOa+aRHSO191v+vj5NvvAGFUst1prOfagisPJXO1vcnFdDTa+K7oXI1e1wQdst8wLm49t9MjgRvqlhPpPWXUgG/H1fqIcOTCnimn3OQFgRspS7lwY4x+iL2hGM2j3ehauuBNY0YxwTutQKNf6atTgS3fR2U8FlQKhE0w3qBCkBez/rOsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddj2FICrVCtFlnyoGw3HPuEX/F0/JqO/TZfzNPxhAuE=;
 b=US8w5OsSQPStspuYi6ibymcTFoyieokwDBjCOHFbpxky735Tb1g9IW2yV6qxpfEimKdVI3OVDzZZ0wkWMmN81FkAmfV39wqmAf4z92uIPSHB5YRki+/O74MPjXUcF82DXZGoe7309vi7sF3hAQkuer+5YtotW/0wUVyKEy8Smb0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 18/70] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Topic: [PATCH v14 18/70] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYwimuq/Hw6MXDZUqmKH8d0iFK8A==
Date:   Tue, 6 Sep 2022 19:48:49 +0000
Message-ID: <20220906194824.2110408-19-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba31f96-e4d9-4cfb-bfd3-08da9040d57c
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhXJ+szwp8TcTTw+YnxoCdq1mU2iEb5aNmezzEVKfb00F1J4uv1qeUO6I7cp0FaLlcZ9N5CFe/o9aqbg+a4WmcFt/+Nhvx4IA9HaBlO6T+eZtcv1QpDNd8ccQ7ZFvLa7SEbKLZfVNwdYIbJzQnNFyYIgRciRbeD8Dc4Oje2A78WK48xx10g2T8Abd4RYNF/6/GO4wh7Cv/e38bfB48nVxkMtTyUOYyn8Kyx4ATJez3qpkLBsV7w9sb7fW7o1O9YKbWfnTRwLuJaA4fdf2mOI6Asd3op9gETnlKsQb6OT5NwnxkmAdccnQYZS7O9FnVPZxSu7lJAtPzdwOB04D8tpMLErEmRBq6VxK3hyr8O2YFgMIu633GAZUML5zP/Sf0Xw5eKP0MCQPO6V7sg5r1lYqz/+DJAWmTxtsF0X5eJKBBg/rWcH5tovHGpDu1PZ0iGK1Kpe0nFbU+8i+UsF7s7cgjG+nWCQqyD/ScrcrXTLfUeDUbRfQgjQxDuyl3GiMlZnXoVG8oUFXPGPSlMbUAjNwqPoYS+t5Mv4JpNlN7/z+1kJRtWp1P4YSUJ3cLSPvIDchXTGLWi+fRtz435Hfi8Qj0BwyCMGSMHdsBYXRoFupLtXIaK5wg8luDJDYXiGm+/kr3GXE8fCu1oiJvl3s1eAxf1RrFxttGHh/aCH1H1DgfNCfggrDUUBgBgFZLsI/rltNq+lpfMfKKyy+dYipwFYiUe0JdocUerlAUPCaOPTr+PheHN2XQLLsw7z9XGtUYSgQJc++TzxVMHWKa3sJXnr5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qDzWHrisC7j1Gv9ub51URyf0R0h3/e9nveeLBIr7yTHVw6K0i1S06n+yGN?=
 =?iso-8859-1?Q?sIOwUU/Fr3TeSQ9NvWd1m8nI8rbXphvMdK+V93rJ+FWXcikHRvaYX9zslV?=
 =?iso-8859-1?Q?BP9a0t2l3ufYKg8A0dg6rkgUj1NQZsvRW6jLe24FGrUhTaYOKCvSnyNbky?=
 =?iso-8859-1?Q?k1h3MebNE0nwsw0X5bEO8ON3DfycKgp4r73eo6mPiiQJ4Uu/1aKHM0UPF0?=
 =?iso-8859-1?Q?bJSER8uGy3a+82cQSmBOXbk7gras8hXSYRsPYO+gng2da/JKIC0/FbzL8Z?=
 =?iso-8859-1?Q?vhPJyLGY/VnFo5ux4OEUiQ+6GWp1SH9T8+TDPr7JEUzKY2IMC38IGYryH1?=
 =?iso-8859-1?Q?0KoWyU0uFAC05M0OM9ExlUKXgHDqQez0Qu77mxwd64r+AHBbdKzh9bzHbp?=
 =?iso-8859-1?Q?2uaATvG0V133W6RkfIlG49R2tt40LifWOBMPMIuMffn4QzoGgxkhTqam+v?=
 =?iso-8859-1?Q?MVqOstazmpLU63sXJO5zzLoSLUM/xmVMvyT5SZ81Y5O9VUC4KHv7DqBr8y?=
 =?iso-8859-1?Q?muETZWlb0h6DJ1ceuckqzKctRgnWk4672JFD8cfKBOfaSvKlptbzfjEibE?=
 =?iso-8859-1?Q?Hrtlmdo1pcG10W+jq6x60G+ik3t9vknqtzzOHIJJnGJihqkr7lysUgSk8u?=
 =?iso-8859-1?Q?4TuwER7S3mLCoDFhpIYXw4GE15ox8S8XaxZBH4Uef84/OPuPod8MIc8pQN?=
 =?iso-8859-1?Q?KP8jWps8N6bmT9W5CmFxEsDN4Gr7eoPiKY5tq/+rGO0V45zXvmaRbgBArs?=
 =?iso-8859-1?Q?fYTMgvqJkadDU+NhxeVZu48gWWaqUEYMfN37HqkSmXazrUvj4bUndusSBg?=
 =?iso-8859-1?Q?Svk7oZAnGGY/I0wXjDPOgGjMglm7IKNEu/LjOTQ7b1XmOJCcaKlv121pl5?=
 =?iso-8859-1?Q?Pxk+pGhKG7+tayyinlEL//1XKKK4NsjG/PQjtiW+eCjJ1XC6FIwsX2Rz/3?=
 =?iso-8859-1?Q?V6y0x61KFpuQo/yoSvlakarLd/czWg+ulTFDGpnF8fTp2FUUzavR7/rQ66?=
 =?iso-8859-1?Q?Uif6GKHVKSOXa0vbTxa60aKe9httyn4RnMSsxGc4L+NqQi1tlxWR01cu2t?=
 =?iso-8859-1?Q?F/5lFtLYvbyYjq8WG9ohLwfHWc4DTzY749c6/gr5UaZw3+8PQJudjMEoHn?=
 =?iso-8859-1?Q?N+z4ajkRlLr1Jx4YypjrqGParG8IrG9ltgjouAOm4NHGFLNxne8N0VRVJf?=
 =?iso-8859-1?Q?cDeBtD5gUBTriLyDZ9GGGKferbus+lSqVM+msG67V8ABOlvkSxldIACHAv?=
 =?iso-8859-1?Q?fCL2xddFQY2Mu2Fl3azbdETQff7Kh3LJohuBbjhCRijIsr2fl9lg0p4m5l?=
 =?iso-8859-1?Q?TI0cikGSBbCBNzSSykoagaUS4nWhi9TTEWyte8s/ZDnUK/cpxxp10syvuA?=
 =?iso-8859-1?Q?N4O0auFZNfC4n7dvu9KQsPTSYVDofP1Q5Uo4Nw1wrSc40sgkymlHtRd7VE?=
 =?iso-8859-1?Q?Vx++Occ/Iie3lqTAlfHkwfD1e4ZxC51MwA1cVFlrBMpdVXDmitp0eOs/oe?=
 =?iso-8859-1?Q?t0gnV/13Gc7DV3LLX3ys+/m8QdU7wrifRhnKjDlfS3YjmQpBIudMo9ECLT?=
 =?iso-8859-1?Q?5acA2CBzL592BwSpW//3o6P2wqwRsGODu94Z6PrOa4etyDB2kXyIFabX7U?=
 =?iso-8859-1?Q?KhyLO+5T+VxKRymgGUoxA6x5VbduysXzrT08aHSVTZW6sV+OLL81O0LQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba31f96-e4d9-4cfb-bfd3-08da9040d57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:49.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFPEbsdox/lwyeUBrvWFbi8suJD/Oe4MUIjKN5EOu56wyi16ursaoXnQlqmDQFbRgExnQIviJ4H3wn5eKKwKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: 5dWzjgYgaqmdXtccMOZhxY8r5dNHo2Hk
X-Proofpoint-GUID: 5dWzjgYgaqmdXtccMOZhxY8r5dNHo2Hk
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

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f60d83c7f233..52a774e70e5b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -567,11 +567,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-			       struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long location)
 {
 	struct vm_area_struct *prev;
=20
-	mas_set(mas, vma->vm_start);
+	mas_set(mas, location);
 	prev =3D mas_prev(mas, 0);
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
@@ -601,6 +601,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -728,15 +729,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mas_szero(&mas, vma->vm_start, start);
-		vma_changed =3D true;
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mas_szero(&mas, end, vma->vm_end);
-		vma_changed =3D true;
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mas_szero(&mas, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -783,7 +796,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
@@ -870,6 +883,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
+	mas_destroy(&mas);
 	validate_mm(mm);
 	return 0;
 }
--=20
2.35.1
