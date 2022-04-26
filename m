Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34F510166
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352149AbiDZPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbiDZPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF089158F84
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStYB032115;
        Tue, 26 Apr 2022 15:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=qo5CaMsQhQnWwLkM64SNZzGC5cJxLPQ/aQ0gTzeSD5PFKt+mEqz+NxxK3tP4TdWcYk3J
 qNbpgSUroRFUxnCKhTjewNUXMEDhrRP/RPbPS6rP+SsqMJBHOxo5CXhUbOJNS3dwM3PQ
 VP0B/7luAlr7vm47tfPpesjgFdb77XxY7K2nE8oGsa9KoLpxVOjIVuKhxaX/NVIq7hpu
 PzAZ8z8qyomJBw0ab2adYWAa655uYmrOj3Y6Uo5hlwv8pGqE09UHYrhoTnJOu/eN7IUn
 XQ0OChOPL/7Dm27gaOoYYCzNXOQPcw0hnHmJnqRfrdoZ9Zw3lvM5wpt/sFO45G85WnAh GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx540-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF554r019202;
        Tue, 26 Apr 2022 15:07:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3feud-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/F6/R2snMwFkvuqxiopJJXpnF0E3HYCZ4phSsryux8v22ZBYlYkbcv2KDSgunlw6Z5bI2MCR6vr2aQHjPyQu83ZuUUvY2z6Xd4KbkzotyMbTu+8CZqKf2CqPxjjYyxxBb3wFn0CIN1oHQ1WNJJJDjL0+jDwAU4lioFzIFrJeT8/G2V+qEg1L62Hh1fJum8KJ1/qn0PI6iyPWNrGfax7eK1dtQpttUYxgASQkcL4xHDjSr9Rt2eUYmNRgCrHdGDo6Ajs4Aa3WW8XIHu0l0Ace4Yn1loeIA5+7pW7rDrHW8jha2YrsaBRJl2DWpdc+t/gpb1IwanrgIIGecFJHfpEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=hKFNTYrM+38CYw3bEOktVJb1Lp+JUSIli+3hPw8BH8y2MoTco2bbT7lLp0O1j3IkyltB+vJPvwQWSwSqZE0D8Y0xjgYW+nWiJo+87IfHUKnn+OPQj8BdqRHRHD+kaUuzanI5uXQDQ7sHm9lboQxNS6qZzYSs1Fa20cyxXyEz2NcvQdpGGkUbjx46tHjkVGlfPWhmazG8Hxoah+CJyTSrQXgMgPSv50nzXLgDONtZca6Q91PmxnaFsGqk6c98CUasCzOco7UunFSJfo8tUy0uWe6CY9pH9oOY5w+TfNzelACZIGVECKi+XYBOc5ve+XVAvhMsKeIUKzg9v3D6d3si8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=xm+YpRyOJmIZeVF/9gDb+OP3BSJSG359hlaCo4j8InCNNnxRqCwb0xRH2WHf6tmZ8GpCeT7ftkogKL2p07jZv2GM8V238LBISo3S7w2sAsjj1ZMubyZOFQlLdqoOXsqsevZaoQPrZX4NE5fbP7R47MBzeX8oOis0jRZ1P/LSAeg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 38/70] cxl: remove vma linked list walk
Thread-Topic: [PATCH v8 38/70] cxl: remove vma linked list walk
Thread-Index: AQHYWX88ztObwv+hQ0eO2Qkr4L0vgg==
Date:   Tue, 26 Apr 2022 15:06:41 +0000
Message-ID: <20220426150616.3937571-39-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc6798b-3c7e-4279-fbf2-08da27967373
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929B976A8E512E85D1482C0FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZvNaGvyscGaflA+LTVsyzsHJa8GOOYfdpM6cXZ+MdsaoOe21B0z8qdslYjElEYlxKrHzjM9rwVhUi92+TdXgN9aYWQsLcxmWvnljLJ/YTXFVx/ycXlUBYtmVu5cjOCTLAqOK9y7xC5m5mibdM6dSFU2EMCHYgtwT/T3R7eFcyX0Oe2GOcjq3a6qXrHnqZH64YsockNu2hnJDXwQLQNdrdwLJP/hSRaor9fB2bxXjHCWjsRr96gqFkJIYNvsDVKpgdrFz6NUNzdwee4AOSL5DSRcD1lOjSzVa7V5Tvsnn3i6kqctWr++h3S6Ns4oe43GPlxHhmpXjeNHbzOGUi/Svs9zTUyFig8o8nkWeUoEFz1tc5Eyd193OTYiKdbXBb6HPnVkiqPRATwLK4PlMU8LonZCzwY0weQSL9xDb9zsRkEOEzU5cSgCSIQxl7xYzWXeAunvC6DBu+xHZJ6p6n/Au4BqvY+tT0iZ+oWyJ+1w8hn9MSow025ujfUYkgcm/JRsAQEszD8Iqoyhk6XZ06a+G7qY5Pnr6kps/AFbioLvcaCbjeJm3yOWdLjnHzQIiP2WSiLe5fWDB9o+YpS1S5oggRyURKUtW7rKU4Ez246Ur/xmrlj0nRfKIUT/cmA1tG+K12U+2Y0uom0aYDMYEaXC1L/SBOiKdSe3cj31wxqdmehVgxEBofeNHGAIZFJ0uvW/3OkxbCl6IBLShPdKtQvN8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JUCB2uLy2q5ETB2eiP9kY88aLBtaJoQvEkg9z8yMKfnCcmiUbD1oVWSTVs?=
 =?iso-8859-1?Q?jTYi4WxexsN2D2NtoVD3ELi7/W1MRZyeAuv8EgYG7jr2rFqZwZu1UJ8vLm?=
 =?iso-8859-1?Q?3QOwZl/VdC3SC5pUlBbrA5VzHdo1xmiWBINCBop8ONn/jouDT1UZnpserP?=
 =?iso-8859-1?Q?InL0QRiCPgDD3H9g+Va1k7Uwoe6UZf1pn3vkpsByP6HbqRS1ZDy0wbzbub?=
 =?iso-8859-1?Q?V33LD9y0hSNmFwu68IZGmjW+UYOfV2pJxV+Bk3KWe+DiMlJxzfqaqMdK5+?=
 =?iso-8859-1?Q?TnhqOkbLCEowoLmBLvkrszC8k3bBhcg3ceJcaKcaWO6TTiik9ADWXZycfh?=
 =?iso-8859-1?Q?hskZqA/YRqm9b4ZoFgPzTcfQKDCZpR/k3sddFziAOofafTu+t+h/9Axxlo?=
 =?iso-8859-1?Q?FX56Xi+V5C1PYnfLvgWm6TKUldXzHK49BmMV8yqbVP+I6NhZ79yc0nevfc?=
 =?iso-8859-1?Q?wzm466zq9D5yIShpUWqIC6Puemaia0KVNaFrhXRK6vPu7/KbkrUpMNtuTg?=
 =?iso-8859-1?Q?x7g8IzG7FVcidZIbG/Pwh60yFwz+84iK3pmbJ/CttNaHzNAFUKU7P4qUCP?=
 =?iso-8859-1?Q?zoA5Akpo+YJNyo2+XAfvkL/DFmfl3WBTlSFC9Ab+fAXiZ/3uheiWSQ31DS?=
 =?iso-8859-1?Q?AAp4+cT2xq3jikSETgeXuJ0WtiFmWHvX9tl68L8kE/2IFp9JN4PxcLvWse?=
 =?iso-8859-1?Q?SAdUP7uft7XMaFsrrUtqPCc2KbAoudlR/eoFa9PILHiBDXxS4OC9t0dPKn?=
 =?iso-8859-1?Q?qpDZeK5ghVRwEvqNoml0OlIJIPOU6IzsSHMWueNLpPQbL+SfCvmH9Fl5yt?=
 =?iso-8859-1?Q?hCr735/N3WuVOaQfDa3oSc938+XP3gwvC9cLXmQ8HgpETI2HV5r9ygBu+p?=
 =?iso-8859-1?Q?dJC75hmGb9db1S6kvRLIOzGKoxpwYgIdwSoHb5/31EYYGjyJTUs/OqW/A7?=
 =?iso-8859-1?Q?aPCKmabtuEQQB8D3o29JUlPdPP/ptqTFwt3ykpOLMXfbuZmkyfwANUS94D?=
 =?iso-8859-1?Q?plt23O6zXiK9hiiusrx5jgXD/J1ccLqRyn+fr97yUzGOXSClprqHSpe92N?=
 =?iso-8859-1?Q?I4u0LssO5eeAowW+sjwmLu/f0h1SgmqvrcQG71vGfAObP4FjqUf8d94Mic?=
 =?iso-8859-1?Q?aU527e4vRZxJXybOIL2Zpj5wAN8NbNOUl8PXmuYH0HGHHfAajWKD2h7nLq?=
 =?iso-8859-1?Q?qyEgk6wYUvjOX/pC2dYKhjBJ7476ilETGk7X/ruqeoZLtM2Ykb2ppG/4Nt?=
 =?iso-8859-1?Q?6Ib7HmcG71xSZp59iNxczYMm7k6SRlBX06tK7g7MRiwpDK8Uxi7e2j1L9w?=
 =?iso-8859-1?Q?jL0ilaJQFFzb+Cvyrdg0mbLPfbTlSd4c06CWRptcvlEALnB4387ffXNdUe?=
 =?iso-8859-1?Q?ApcRAn3KA8u8Y0XopI/uanOKlTgLN8lZ8MhpEJEdmffdcc5kLDhlVi6xTM?=
 =?iso-8859-1?Q?tQPwCOt7IdLprWA/+uxtaPN3dewv4T7xCFXpmICS9hBAR+iMhRMiUUCGeo?=
 =?iso-8859-1?Q?nzffS3btHsX8ynEMGYuUDSDj4JhSylJlHDqXS8hPFW2H41IJGrU8jfvZWF?=
 =?iso-8859-1?Q?S7uC55Y5qyoxKX+d2oSSOKkYatAs437W6hd/0bBxLdPtxd2rNfUtujYk1r?=
 =?iso-8859-1?Q?dC8oZYIlywliLl29PbPKYe+c6eUVsZmjiv0MbopJnTgYW36uAPb/wGQSNg?=
 =?iso-8859-1?Q?p9tOxrozIf0Jw5/szcbldoysdqZJxnw6AZagxRoIbp5ySTZWcNkjgON58Q?=
 =?iso-8859-1?Q?RUeV85npf6TlBBGKL+diAtf+bpdcWvVPGuZ95g0y+nmd4/Gh6W5Yy/tnDF?=
 =?iso-8859-1?Q?T5p0C1uljbOHUuhe7DC361G3uZwkHn0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc6798b-3c7e-4279-fbf2-08da27967373
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:41.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu2IP8vagaqvGlzZw8XvsIbOO99l7xu6v5TT8nRwlbhVbBLkoJ9+09P0nIoWBAXSiHbX1A/ENjj0b/mRSerl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: MOjTYr0weEQst9udW3RwcEo3xTHRL8L5
X-Proofpoint-GUID: MOjTYr0weEQst9udW3RwcEo3xTHRL8L5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  This requires a little restructuring of the
surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.35.1
