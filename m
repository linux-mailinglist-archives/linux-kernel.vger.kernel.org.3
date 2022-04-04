Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26C4F1744
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378158AbiDDOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378021AbiDDOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703113FBED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3Nx014690;
        Mon, 4 Apr 2022 14:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tqutiM8Js/gtlzRPlWNBCB54E8CtTOlVMFhPhyoWZtg=;
 b=Y7zwyLYdXHytK7xxWQfl0lT5AYpe0hvhx+woRtVjJBdNkyqi+0REemviYFr2g2h4/Wpf
 MjRK6wghsnNwvc1vjiWJnbwX9305fxZ2+H1lkmZPJM3KtzjcIJOxRwqIenpph3J1fX9Q
 olZZIpuh2CVTFJWexZsCVcv4TaGdc57g7fupTD9PC0NUdkoeHJEgdywv2Bm5uQ1dGxms
 vDK9dSHVZ91+K8h31tI+UbNUApJeEQXJn6SJR18IFd5txJ8Zz4mKrOIDOIyD+MUwbf3Y
 zx6GOPW3LJayp/jCdVwxTDAUDFX4xnCKJwEmGRnW6gOOaTs9OR1/XisuDUXAJMzzZRYu 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceb027671;
        Mon, 4 Apr 2022 14:36:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxV0WMpFvn2wRHpe7x4C+73Xj9E7pgkpmeShKbdZ53Oz9hXPj+0XDeR4UpVpsCm6vd4lQsSigdmX+6uVhQVG1WgfRdXP3wBelgCPgb8++2cqZhJbcC/L3YmFF8WVCvz5wfiSAGWVSktmPujOv79F9t9fWqs8sZHN5PQqdrUnVtv4/t6HFEj2CTrtNfudGCjs12tY7y3DUEx8eIsrEw01QmjV/vYfn64Hi6epALOTEMSClqbuRPqaX+eptdiCyW0kk/2l2CnIrK2boHja/cHC0iFvxo/W5e9dGE7TjV7x6X1TX/93D5amyfY9r8oJKNJe0wUJpiWoAzLBkXiPbx6MwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqutiM8Js/gtlzRPlWNBCB54E8CtTOlVMFhPhyoWZtg=;
 b=JOoazdTW0RAzQNInq68y2rLVW0fl6oWL4WU2eCir5I/b2RB9ODgT552p0feGKQsvZzMt57GKtc+e6l+JTcoRlexyy5tDW2KnGLZy9wf9Zs7Mxnd+qeGtXJBY7CBm2yRNztWcEtj2dGW7/TH5YuKY4xZDAEWENjEi+XG33L6mCP+ClZ/eCLYI7dw6dvNS2sh8JTyWbFr/UFlq0ZgqpGhVUz2JpzkraTTD5lkzOucJvKVMfpZ+O1NlPAJ9PSxoYdJ1bgPjycuDU2Aygl/vIFdFKOQHCDYwr+WARDQ/RGGQ+Z2/ZbGIwsZyKP8iDStwrIj7kSeozUnLMeOsrHU648RFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqutiM8Js/gtlzRPlWNBCB54E8CtTOlVMFhPhyoWZtg=;
 b=uS8MyohmVPvVGRnXkAXpr/itUZFs7a+iB0O/oSi7fsfyl5QtzkYEUK+TevCxeZAVaOkkEN7Qx4gcG4iS2Jz3SqSdwctbVh09oN176U0r4JpnPXTtqtQRUM9OXk2O3nJrD78nkHoivMqQcVVBI6WPoY7BfdfGrMkMLSsHM1hHWkw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 50/70] fork: Use VMA iterator
Thread-Topic: [PATCH v7 50/70] fork: Use VMA iterator
Thread-Index: AQHYSDFJLcI6L65DfkKJADoU01lUEg==
Date:   Mon, 4 Apr 2022 14:35:52 +0000
Message-ID: <20220404143501.2016403-51-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da4120c6-5230-4c04-7348-08da164880b8
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329D11EC1B5B0E7385EDF13FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LncREB3gkHPmEVp+oDhB5ejHCYINQQVrZvY42hm4UJE70JSi/J/3KGJTqPCyZ3OgTtfQOvwhDU7PQmC/qpQH0tvC1ElZMEMcR1/2TOm2auYFZSoUOLjvWzSB8vA95hs5o/2vhmJX+BJ5OQjciNjieRqbj3WYSCi5g0WgXLCkzoOqvj4leGaAbZy38BYOqGTRFuWwYEIg3wo+VRFcQr9CRm92szak1/+sYO+Beufnlj5WWwHFDUGHjGtWwCqd0lWxa4FNnidSgkk2vhiKXHiJwLiHuJF3HZXD3AnJ7HXSyf279xyqEfXXgUeMuP/4tC/iUgvyar5n86PLNC+BtPbjJFGpWzPsQSWGYtEgwjf1DKCT/CojbgeUzhpKz/0TKr5GAjtsDSMPCK10HNH0ZcJamre0mw6Oho3A4lt+ZTy8ylGgph1fKqGg4SqSK23q8V7OpCfknB8cqw5MKkJp2LXjzF9oyjOx+IHAFYba/BxBmMBem0sOEtqfXcyXwYpUAsxk8BiRPFhuziVED3dg6bkhDxBB6Xhmxf9q2Cy8yaJcYGGnfCmGf+lVzTplfbFI44w/adiO9CzxRh8lSy9keDfeZUkDHUuMdRycisPBaYUJ1L17J8heYarLtib4MwGBUZp9YJ+NIMFOKevxPQXmNnqf5yXjRhiN/h1QaSh21UVxN5mvU7i/GeQ+vBVyFcWpnu1wNusv/VQfKu03BisUdkF/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(4744005)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KWhwqpCGjQlVcxhQd3uDPBORpQ7FiOY6SCVzbjaY6Wjb/zuL1deobnnIan?=
 =?iso-8859-1?Q?7APq6Ah7iaCpPMrtPE9Kgm9L8dLCFmfB11EeGUu7FZeliJ3z1OniBRkjIT?=
 =?iso-8859-1?Q?+lvhkNgorhAQJXshFIY2PXAdYbIiTDQ664KVqjbLxbMWAcUi0iIAUQhoKp?=
 =?iso-8859-1?Q?Mwd1+vwnPd1LrbjbvNqcSnqapfvxOt2SB23Iavd8xAwuGBCeWvLjSOSmra?=
 =?iso-8859-1?Q?ICBP9Gm7iny9kqjG+pJRg3xby2qJ2oUnOcLaP02/qhr0NpAy9kO6UAXKP9?=
 =?iso-8859-1?Q?692W6V7avcBZis6oX/P+M3gafzIrcIFHqzikB4k4ykZfPjU4YkX7CSOOAK?=
 =?iso-8859-1?Q?AYQ9cz5ypn9rnXE5ubOLyPK07bWaq5/ksq7a+/0atj+58L47boxsUYydXa?=
 =?iso-8859-1?Q?cM+LDorb7YBdDXjf69/YuDQSvdLlsMUo+hsi8CPbvFyMqoLkgLfG7NrpC0?=
 =?iso-8859-1?Q?xQq/b+6RghaQ+JmC5vkI88NKR82ExLCYN7WFvEKEm3WC3yrbUOrTrXT/fe?=
 =?iso-8859-1?Q?LNhJTiiNm0FIF9XoBmKoMOs4ENjdpfNoYsl+4Bbpu6GWMTyZUJmY6fSnpd?=
 =?iso-8859-1?Q?JI0Z43QJF4+xLJHYXgowX5+xXVL9TiioqqkedFqKyQWj1FiuS/yny8263x?=
 =?iso-8859-1?Q?jriBOE9tmRohsVulljFhWj0H4p9X+x6CnYg7cBfFMdk23t0MpMGeVz5WKO?=
 =?iso-8859-1?Q?PDjMeg3AfQkC7F3gps+UL5KftlBF/6RYSnrx12xivhIu/Dl8cfMgeBiNU1?=
 =?iso-8859-1?Q?8eNXbiu2tuhg/k75PbZrF+NQRq3QOb/brXPj2wgeFrDc/rSf35nyhxWCJ3?=
 =?iso-8859-1?Q?5QqHm9zN+brP19cR7T2KfVl0apw3II4gMtSrwgzNQqebvYGDNiqE5ziljz?=
 =?iso-8859-1?Q?/+PmgQsJDMISEeU6jLdDHPj2qhSa8SEAJl/2vO6DBg7XBqUZj7aRnbHv35?=
 =?iso-8859-1?Q?JSU88S5ZoYd7+Zmf+Y/IAcJRNRwBb6oAb8eL7gbo8nTtxD67U7IGDbuAR5?=
 =?iso-8859-1?Q?7wj+ejmKscMOAwWFUUTRhNGwenpn7AnM6xZcqlv1UZhU752aTDEJKtnbL5?=
 =?iso-8859-1?Q?Y+IJ9My1OaxpJC2iV0gnsu42Nm+8Pi86KsTn88OGmy4HeuxULhD1Zn4r+9?=
 =?iso-8859-1?Q?Z0BZqHRPKnGk8Bq8fSlE/mAWcsATSBu0UxWjWq2ejJHCud1rGIw78UFY+s?=
 =?iso-8859-1?Q?/4yxYDgCRDLYgzBJqX7N5h49LkndxxZdfR/Qb7I9UHV+VZs6hF8KdER4JH?=
 =?iso-8859-1?Q?UXHLBKvXp3iPD3r53Sclki1MkWhIXX0fg7Gvpu1/n7K4s0uyRpHr3/aPit?=
 =?iso-8859-1?Q?OkmYChGErCSNi+rHEi7G+MYmDPUIG2iaWKFuLajx7OAaHzirsu1cT4qgbm?=
 =?iso-8859-1?Q?5f0941MURHItJTHfszGOkQLPgpyOzFqMQujTA4e+ski3XUoCA7x1vJ2L25?=
 =?iso-8859-1?Q?XPBLiKg3QaSonzLMnPPffyylf8fG9HLosWLM9F7w43iMR9ZeClzbhvjkM5?=
 =?iso-8859-1?Q?lleJA9qTcvNisNb9i0yGd9W9XZ2NagBEpBMDjmEXYpER1vY0qqi79WZBLm?=
 =?iso-8859-1?Q?7oH1oECXo9t3nstNI4d6/8+NQ5b58NNIdtnfA0f1ZGlvVb5OYG9gR3c9OI?=
 =?iso-8859-1?Q?CPoZlttvPGCdtPFMj7LOnoo5CXVg0rv/QPnH0y5mS9LLxAWlT9/NcCGKyS?=
 =?iso-8859-1?Q?o3mrlXu1vWPrmGlQEs/nCBlCvXzJoECZ40FYID2UMl/wbC3U7s7stJsVPV?=
 =?iso-8859-1?Q?AOv/x+EgzbiwS5ONP5qT+5in8c9YuNCW2cxmKESflq9pfsUwAAgbXGobKQ?=
 =?iso-8859-1?Q?BJq1cHMsONLA5tKGz+k5du8U2SRHm+k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4120c6-5230-4c04-7348-08da164880b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:52.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA8pSuLUm4U39PTGd5oDkD1+IiDoHi53q1oU1zsHeJyBI7YPaTWp/qZtW8YGhrQcmHY//63otUyLEj4+Rtc7LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: zc2GGjm8-ahSn-BYFn6Nxbn8GHiBPx66
X-Proofpoint-ORIG-GUID: zc2GGjm8-ahSn-BYFn6Nxbn8GHiBPx66
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 20890be1371b..fa0ec0783784 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1288,13 +1288,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.34.1
