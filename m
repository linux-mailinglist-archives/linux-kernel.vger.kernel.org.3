Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DAD57ADF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiGTCYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbiGTCXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7590709A5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0bCP8003860;
        Wed, 20 Jul 2022 02:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iboY6lFG2ecmK1Fi48ztiAzq51LWKfOobF+kuo6Dl3g=;
 b=TfvyO7XmArn261j5a1apARt9z9p97KjmEHA6vyQqt6FGA0+e3Fw0fuKlIX2rQdgtEi6s
 Q/Tcu8Df5RzSqCHs2RCoXml7kvSYZsdq/8/hUi4Z7qCayFQajoqOoCw7cR8ZqN97NOyd
 RvV1r3L4+8EH4dJKSR+MHbkG9a5GTcj8ipSv+dGD88xzrZtZoA8HbM+2dY/3ZbQ8I6le
 EO8ixWF+PJYJ84pAZ3Yghy+ei9CJ695qUkGNcOX3iBZb8Wec+5MaGF7Yol2aaE0T5szI
 tz5POaebptnxrD2KWjGe7mGFGlhYgrf5xTg4DiYv+SDHDTp462A/qI+699zu5BfsAsf1 jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1t66J022428;
        Wed, 20 Jul 2022 02:19:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseb7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDxH6Csz4eKXNSzQCRZOOVQaRIRCPVv9eyywVxCqn/vaTaRZy2r+FGypKU5jVrNf5Ziel52yFM0aLo3fES3TggGtKTOsm1YoYGqx1//yMu1yicA2dW+SvC5gFQx97gj84r4Ww0lPlcCmzFi9lLMUJGKAsXVbDygN4Aqp3mMavubZ7HkFiZMxrErNl7ZU1nSys+G033ReEmSixr7OrhFYdZ61PZ+XIH4cPbMseUL4oU7kbkss45+ENREoHhJ4IqBVK7ENrcQIBUFhga/NL+bmejQLTsgQJ6CeXYZidP4sLXD4D/jaIfaWkO5n6eEzOKlLGB8Nk2i7AZcENl+mRSXXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iboY6lFG2ecmK1Fi48ztiAzq51LWKfOobF+kuo6Dl3g=;
 b=hKavQGY/QkZnw9pQloskfOAHBW5J1Cc0yGVsfKFc94ZXSyS9BqJSHOvN0OAjowX1gXjBokcU4Ht5PRLgvUOEc1zuIpnPfcQsZ1s1OpPRepsUP1Gh0I3qKYO/Dpo2TRi3n5q8hrhN86Ay1CdUCLL0+eW2/eIByPzKEJLNCjF9NKmFZbUGOR/K5Mmo/ZyAk5Ggx+XRLgUgI6h3Pfca0F6f6y6qDxLcUp3x/PbqKMtgvxjEbjAstn2XuZ3ANh7CBjw+nRj4iBBxhnyMGsj3hdvCOwvB/PZSalalpB6YmIh9u47cYYsNTus4NyEK0md6Ho+QCjgnv+ZKEdgXW4I9mSYR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iboY6lFG2ecmK1Fi48ztiAzq51LWKfOobF+kuo6Dl3g=;
 b=nTjDYwMpeQXDOfAp5jjSNXf5BtjR0k6Pqpp7A7oZFeRS7n6jCkJXaG+tx3o3x57C8R4hgcIptHjIcHYWe/ptPN0c0ECoH6BSMscidqtk06MNBgmD2928e5fCWaDLiEWOgSMVw7vheP+FtW3eue/qGPBALzNGQ1TjWZAqP/olBDI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:19:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 69/69] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v12 69/69] mm/mmap.c: pass in mapping to
 __vma_link_file()
Thread-Index: AQHYm97x7LISvJEFkkawcVa8OgJyEQ==
Date:   Wed, 20 Jul 2022 02:18:05 +0000
Message-ID: <20220720021727.17018-70-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53da1d90-d488-4b60-76fe-08da69f6418e
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIt9/Cqr5q//SP18Fgb6Z/ZXsDnDbiY4llNHcaMGv4HlsA2VfInnBe6+kGjvwQRdTUgf/XwBRo/JxcFBiQJp2dq86GIJOzlXcmvxjz+cFBYRtbLEYpyPJSzEoDUQZvKnQQ+Wi9k/yaAEtWt6UrxcsmsNmTQ0IkPXqHVy8dPabB0/EnKYVTRXY3iJUHGKwz5yUexZdQku7uYI7ckX599UmnRsDc5XgH9WxTmEXFGQjO0tCbhn+hGOk/srnCGBi21ojiJGiimKAz8cbtuMIx0WiyOxC1CDjTAF2+Lbnvt/D5xSR+1SKzGcVmn8ZXDKFRO4waGVIZZ9+LqSSgu6pxZjWd0cnm22u0VDQCuRhw0IZ3y8IHFZfXTEtaUtvZ8y7zBxiv9idJhgIYSHlyYvrqb6+9p5oWdz03U8xq5++2ttc94DiGDKrResPb6VcofNOkHqrv6Mxijgw1/wiaHrDgaZLvL5fWD5Ht7YrSl6QddyPuOT6sF10qZGPVyc4H3TjObGnZFBAc6fF18nBc9FoX7bCjaSvNrpt+oQBepxpJTF/QMfSeFyShOW1w8sWzzhbnlVXOISbX+yRQ5Zo0RJF0v9hmESB2tNv5KXQnthDZgr3Zp3eJP+mcxM+WH0g/DJSJLAv7WOcW8eEu/Fdd1vJYXmCsgXSCuQ9KhejQr7eWGima/8tx4YkgF8JbHgfaBViu2FbNvHBVlW8v/Glqq5sCbRawt3P9HYL3tbEZF+Kx/RF6TP0v6PztPAJCy8Jf6hiBioj15RV0IOddUbWNvBFUHfgRnJDXHPmI7XZHSfE31BpV1vXi7lu58nbX+zTJR0HVGxjNofzS6t21zzeEBsFn6KLRDXovBtuebftQKIBNAIeqCqpWi1uEoPalQC8wHhBFXE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RuV8FoPv2zvcqb25S12075D0x7t6j9t3kuXu63c6ezyol4jIHBBlSYHGZ8?=
 =?iso-8859-1?Q?WzWZu8v7g4m6hTWnUPeQGid2ImI+IZhWlU7oEncT83opP/NvKIzMStx5/U?=
 =?iso-8859-1?Q?nx0WbexgKh4LAPQ9bmYNnACadOPqq6MB7n+frNFCIf+n5S7+fYw8hfUw2/?=
 =?iso-8859-1?Q?ORj28YTGGuNfWAtajL9pFG1JTY9QOLTu385Uu3ngrG+sOkZ7HvXXiYQrBp?=
 =?iso-8859-1?Q?jqXX5nSX7/WqgR4ngtNGFT+5jqCUnPBEczx3Oh2zF1BPchdnM34FxL270W?=
 =?iso-8859-1?Q?ee6kBUit/aZ6npOfIJ6j9x7dW8qqcfRPA7/L/tDBicapcWnhXqxiLuGyW2?=
 =?iso-8859-1?Q?CAawq1aaCEDsg4sJsXETqjMiHLhfeE2+GR+r82eIc3BnXxCHCiBYPDkjO9?=
 =?iso-8859-1?Q?D7ot7xWHvXrFggkhu0tdBZTCob9oNk0hqUgY1bKyQrNQ5VqV/QutD3Zktd?=
 =?iso-8859-1?Q?LnKXBXM0UDz7rxTZSMQDSbruqnGHvv+nQhH0ZUCE6wbeFEYacdCMxffx/v?=
 =?iso-8859-1?Q?Ueu66kBcfMG90QVlODwgU5LfkIe23URrP3/wRtul9cUh+RTcIWWMup3XB2?=
 =?iso-8859-1?Q?SmkUxE7GaSakj+fKoSpWvXgxl/6MOeAoF2G+j9yyCp6LP93layUdq/NFIM?=
 =?iso-8859-1?Q?fl7f/uIiHPiZz2Zpky00xGuYjB/3qhsrTO9a4CDH/Zy9XLxrBdWu7Z47f3?=
 =?iso-8859-1?Q?fykBxBh0cOygQXloZkHC/d/Hy867QFOK161ZvhQ4WL++hqrhkrX9mgj2uJ?=
 =?iso-8859-1?Q?KsthIk7gBVsLboCQqU/ajvVcJ0f1xYsY/ruIGkJfOr9vIBWXrv2WBEb2Jj?=
 =?iso-8859-1?Q?LW9A6dyh+vAOjjVBNz+dmPATYjUOL5RJH7aRsejjWc0m4aaLm9CTGUOGsf?=
 =?iso-8859-1?Q?9/YfDdJjY2HVY4mL1GvhimRMO1DVgE9XWZHSpbL3HcObtlZ0ZyZ52oilv3?=
 =?iso-8859-1?Q?3B5pdvJpMX7oZrRox5d+D0KMXHQLWt3W0txf03gHE5DtLfyzoNy0g0P9jW?=
 =?iso-8859-1?Q?9Tk9ccVxQqKBsBdYVeB3E7C2+hDeRwz18p+i0m+Ks5e23IKF0L50UaHq94?=
 =?iso-8859-1?Q?t6k6gcwbIDiRVdDKE8LS8J2AKHF28Fu8oDYfu9RjTFMBRwpfyacVJWwGnY?=
 =?iso-8859-1?Q?TODzTC6Zb7YmsjunXa84gp2EciREELq3Jf9sRGIcsqXRpxAAkO7UW/H3vk?=
 =?iso-8859-1?Q?a7k8bnYCqqrQ56qNcyTXyasIjFlruxtAZgDpcBgToGbWuV4qkks6GueIq0?=
 =?iso-8859-1?Q?irZ1e2Q84BrtI12H1Pc1oMjlYjNbbU5tpqtvoFlwhJNZfnLYq56MufUeF5?=
 =?iso-8859-1?Q?ted6CqKS/E1eOwYnyV2lpH7U2C9fkATayg+zeSQnlhy16xI+dgHC3u6hzH?=
 =?iso-8859-1?Q?dqWaPu8PXppA6dLHWn3OH9zIZB47pTNr/IK+Uqo+xIDm0hKqNdT15QbbvB?=
 =?iso-8859-1?Q?So31zHK7VmiWpOLbo7Jwii8ztluJHVlmEKQGAwUpnJnnHC/YxL8ZyoW4xf?=
 =?iso-8859-1?Q?iZG4Zz3/2jyokrCsZvkUoK5tFFqBMjwY1JgU2PtcBx6V0EqIFuFy0LsYUC?=
 =?iso-8859-1?Q?H+6CCZdS/OFcd2XMiomkfOsHzPB3dBFbDRbFsrf88ilXEFp/vttaxfCbO9?=
 =?iso-8859-1?Q?+UGEAddXeYunUwr8nkcL5IfgzbfeuDJQyCrL6zB86B4tjNZHKexOKnIA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53da1d90-d488-4b60-76fe-08da69f6418e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:05.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gR8PKbnRNTaKUKctn1SBETOwiwoas1BLPvUXCQpDkA8jmoxPRTT9W5c69BKA4U+SoK0niB+exj7h6wFLW3U9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: DvFeBnsXRiRdW6skVLB9WjKrO5t94THj
X-Proofpoint-ORIG-GUID: DvFeBnsXRiRdW6skVLB9WjKrO5t94THj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Link: https://lkml.kernel.org/r/20220504011345.662299-54-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-70-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a9ebe25c5b09..37990e66feeb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -246,6 +246,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (brk < min_brk)
 		goto out;
=20
+
 	/*
 	 * Check against rlimit here. If this check is done later after the test
 	 * of oldbrk with newbrk then it can escape the test and let the data
@@ -322,7 +323,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
-
 out:
 	mmap_write_unlock(mm);
 	return origbrk;
@@ -454,21 +454,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -535,10 +529,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -777,14 +772,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, insert->vm_file->f_mapping);
 		}
 	}
=20
@@ -2982,6 +2977,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	struct mm_struct *mm =3D current->mm;
=20
 	validate_mm_mt(mm);
+
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3039,6 +3035,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		goto mas_store_fail;
=20
 	mm->map_count++;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
--=20
2.35.1
