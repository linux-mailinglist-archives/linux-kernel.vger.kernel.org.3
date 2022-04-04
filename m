Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBB4F1747
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378012AbiDDOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378014AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E353FBD3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DhxPo006378;
        Mon, 4 Apr 2022 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=oD03NNRoI5hIh/i9LjhEKNd2rcDKkunSRZ934itb8XEseT5drRVSqO2a3OcBxV5G1eas
 J3o0DELdhpHikLdt55UM9NpevcAvwhP35ylw/oOc6Q1yRBo0LzMM0Y8bBL8HHgeN1+Zh
 N/FSyuGNVCVulBWDfkMJeaBJC+FLfPF6iQFR44kZBNgrxAbCWKBIqUreAvlBlf9XphN/
 yp0ehxPhAZZ7YLzunh6KtigOSqnyURT2lBAL57DcvABWdDAdnh8o9OKaudGXhDCng6ZW
 WY5IClukw9ia+smKIsvw0/0OjW+SF1gy4MtkJQzm1Zx9nLV09sGIOBthXRElqp1csTFA Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGE027665;
        Mon, 4 Apr 2022 14:36:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLxNvQcsQAvcz8MqIc4NqELLgcbpPjlLbL1UtVHsuFcWERq22f3EbX5eLMw2B0P5oTlPjrgJI16MLV3P8Gia35wtEZGZQhEPzKRB7BFSRIn9GSu8G+CclzbW78R5oaAFgGl5ZTDh3nhirlM6yKfU4fI7d292IY5kM/w8qemth4q9NRm2/3QDVdg0fTWskQK9qEkJh4QGNwh8hPWzvM6qxGoHmzk938VhtlcpSYrGgq5GhKHT8RZQgOtNeh+ryWO2LNJlnfXMxdim6qAsKZtgdhZIMhmSlbhU/FDDF5dREzFKqEUEvKg95xH0Gscio3J5UpdP5nXvzGArDFSM/7LZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=AwWIbbFwtb6XbP7Vve7BwbGvk8XaiDSHiEeno5QaoiI+JbDjs6aIPP7/tB/RaCnevoYXYeqgzaX2T9ZFM3vzWGhq7Tsd7g0zgRE5He3rX5aiy4YaOYgRi+7Wd+jxeZqbW92fiBfBSFJUHfk9mrpcYIhVAYMmvLS+LLzxejYeNDsWOfop5RhAlVRUOLQyzIwUV72rUFnERTiAZzw+4ByWp1q2rpmdZBbbtAZE0/MmyJQlCGzE3vpYGYuqrqya/8nVfWMdCeUeSA1aJB5X2pu5BgHUIcVtKbmx3xNWGBDSImDAwmrEZyc4YQH7HR4q/slKqCizL/6tzvCgl1HCBgc6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=Q3lCYIJyJaYIBn1G29hRl1iaT9VnZKT93iiGtQhu+pxvC0RDh6gmtG0K9F3l5KJFbjiviAuSnZMg82Fq5imnks4M+2G5NRkFLK1MuQC/e0BDBvG26luZJSNK6rS4jM8eggz0FwkTWQwwW37rkuVOAIa5Z0+d3IDa7MtvaraAJN8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 37/70] xtensa: Remove vma linked list walks
Thread-Topic: [PATCH v7 37/70] xtensa: Remove vma linked list walks
Thread-Index: AQHYSDFGyffbQs2wf0GTBQeUb++4Yw==
Date:   Mon, 4 Apr 2022 14:35:47 +0000
Message-ID: <20220404143501.2016403-38-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 679ff0f5-6609-43d5-6ef4-08da16487d59
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB138168D2EFC0CD28E81228F4FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 239FSmBCDngjSmJQZKffG361H2+eawe/bPDQTioCWxZJhUnzMxcWB1wvMOJOi/uuIYLluAe0zIlKwNg1yhhufFQu0PdmK7pk2GdwwI7DLql+5W4dUC55IyMa+OS41+cIWDG3jpXfKFWgROrD+aZz5mWWXNiXzX1o1qqFjyXf6augRjA37AS8u6dm37PooQI0CFX6RQxPM1ZINDHMuyzykKrPZj185U6Vr9r2KNgEnn7F6ql7qea2n1mwlCJz+n+V9g5CQsVUzJWcZ/fFQWGMSy0Hltd3omAHD1RZKMDAPa4vLDHCy38crbQF2Gvcq7+nFVhDJmLEuqt7VW9wTwR4AsPGSuuRy85+f4OITtuk30zDbsc4sEguFsHmaV/0/ORv6AoQlLs6SHe4xs3zup11Eh/yq8Vm8zIG/ysxK3+W8oSpoGviPVK1pLeYAS4RetOEBgaR/N/PmY1xWjJvzqLQryNzOKXdfAz6C2WOkS86W5VzTXlAIY+lc5L+CyzrYH9OJrN+5v9EgHqwp4BQAzHXZ3t52NvqZgEGPr0zX0JSSf16Vg0W3FbtaDFfUZIOcoshnUO6lDcNdKjb3E3p5mlG9oQbedDcylcMlpy33u3kh5bbNJ/4lEIC5pgwdQsaMi99I421kB2KkKiWfZvAP32SGzIQ7TZUj1yJYhG0oKCGVc9GdaavYjo5IpLJ3CitpSJDaZKwv5ZC67po4yOqyF55rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RKziatTe8Zx5i3pTw8QUZT7T2LYhJWzZsMCalbML1z1rTSf+UpBM+Ap0g/?=
 =?iso-8859-1?Q?6GlNGqZreBM5u4Za1/cIoYsff0bIfmccQP/wFCYv9qn4YugmkeDMNPrIoz?=
 =?iso-8859-1?Q?1MdaFA6bIfzuMMz8tc5S06H4DWRlZNoa/cNjCOVJCP6zFks6/qzZ8BTqU5?=
 =?iso-8859-1?Q?cpYsu1uD4badiLfPWoPACJDT91haXG2kZnuqrecPYfCuhTFFQku35mVPG/?=
 =?iso-8859-1?Q?GoPniAkXHgXoEs/RX4ehcKow48xN3iTo5KOtNwqaDash4e4qMc5Ghaisot?=
 =?iso-8859-1?Q?14hLTol14TAAk9p7uD1zywfDNKhdum37jqTXydj7Y78UHZoqc/5nwMXTT1?=
 =?iso-8859-1?Q?occyZEu8C2zIkX7d0nK53l2AfxKpjxEWE1xH/LNanf0+Uk36wJhA720wYe?=
 =?iso-8859-1?Q?/465dy+Z6weGN1Uj/KMOW4xAcVawMgARDrhVhdGFjE4QCr4vCp2M5dk6YO?=
 =?iso-8859-1?Q?ZxaWB8wT8OZFMlIM1/hqUpuGvI20UDIYd0RbaKMpvnD9vei9h+nw7ovByf?=
 =?iso-8859-1?Q?jHdBf+N50IZBBlUAUijChouFbMpJOpCPbpE+zquxJRX+1+QzzXgyThhiNh?=
 =?iso-8859-1?Q?uQwyx3Y9/8eFL4UVQEJ19+bIoPPmiW5kBB0TbOB9xX77nv6V8hlKpl4DEe?=
 =?iso-8859-1?Q?PnCuHnu8NPq5mM6TRRMBK/7SzEyodlBmJwSofYfyxrTdov5BPrYw7BooRi?=
 =?iso-8859-1?Q?7ghuMsApgfDge6Yh++7LojoZcMInSSV7DTSTXRqSf9T5xbrn96ZwZOovGV?=
 =?iso-8859-1?Q?g/jYfwT7ChBp1Y3BF1tjJsxmtixiGlA05iw+V6QkkjoD2yxInye44QT9sB?=
 =?iso-8859-1?Q?OHfm3h7eC+ydjilwLez9YATeLEYdQIAxgTvXDDZRiSKe930gMYrApIb27r?=
 =?iso-8859-1?Q?k5YKhaZeooviXGcevewzYP+W+4/WLZk1NzK3S7OK+nuU9ce8y2lTPzcqin?=
 =?iso-8859-1?Q?z9udD9LJTZWyINwTaQ0c8afFH0KetgiODXTZXoRGxO7LwzkJQ5Bg+2aHkY?=
 =?iso-8859-1?Q?zzty2GvvjQ24BIzcraZ2/5o3x4/pQTgs9ErruhUoukdDVZxNe4gIBqW3ku?=
 =?iso-8859-1?Q?mvKFzGV5TlmS8Xar7XpFG6O0EPrTAW4/XS9XjVL7pXFBDlcptcmrSG2C0e?=
 =?iso-8859-1?Q?n+LkXS/NTNjBACyzi2clZZOY3X+zhoLyehdMc2BAl6xDQwbccp7I5sX8x1?=
 =?iso-8859-1?Q?BOf/3aJ+vB6CMljIwK0rGU2O5ClYoUSH134LGZT0Ap9wQz1aBqCrNpUZh9?=
 =?iso-8859-1?Q?57FOnOKwKCyQPNHu17r1LQ8QKZChCYnPLexj7VDnhVQeoJFz39Wb03gwiW?=
 =?iso-8859-1?Q?C/2Bi4y+L8GorFP4rH/C5OIx3AdmZsBxXBChKmR1nAbTlic3u2Gu4rtiF0?=
 =?iso-8859-1?Q?N/WzbPwvBIVmnYELaMXAaAhYgKYJrQApBwz0PGDyOQ+B4MgMRydpKs1je2?=
 =?iso-8859-1?Q?qN1Me/oBXfVh8zfHvDCdyDOeFuGr1awtqqxqL48qNUvlEFIiZyQIh54qUr?=
 =?iso-8859-1?Q?m95d4jy/ifMs9s1u1auzjqdboi1mALlObuhStDd89dGiM/i0i4P3PfE0nc?=
 =?iso-8859-1?Q?hcajmn/JSfmOmiS/ofRcw0N6sBxdU459PgbLMxsb1epE4TFe0NrikmEBct?=
 =?iso-8859-1?Q?gqC+cg5l/1CbugevcsAkmB4kVBdWssaqCADwcW/T6pB3Nfu4tnj2rGEOmQ?=
 =?iso-8859-1?Q?SXLU/2XdhrYzvKdR1fqU8AKXHTo/xrNceH9qonX7pO/RO1IBEA2ZuGzbWq?=
 =?iso-8859-1?Q?MrFlMvbjW+H9KXWbJGvlo3i6orwKYRtPy37GnjaeFuoysDWrL3JejwuOtI?=
 =?iso-8859-1?Q?+em6qV0oZt2t6/xfvxgXMdAvWaWTnXk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679ff0f5-6609-43d5-6ef4-08da16487d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:47.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2bABW6u33uKlbDb8149ECA+v1uXKQcwmj9h2Po13Vaa8/edfTxONO4Vsz/rLD/mKZN9rLYQ7OQzqbWbpPs9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: O6t1lIp35Gtjn1O_gAIxZ3VSqmegIRJy
X-Proofpoint-ORIG-GUID: O6t1lIp35Gtjn1O_gAIxZ3VSqmegIRJy
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the
loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
2.34.1
