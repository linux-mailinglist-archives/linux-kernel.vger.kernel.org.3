Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED2D4F172C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378035AbiDDOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377757AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5643F308
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoUvs014716;
        Mon, 4 Apr 2022 14:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jSzyOSUmMh5E5ORzgGy6n96ij8NXJI1OGNvJmRH5rEc=;
 b=yurC5N/I28s6scdOXIboPeQNp+MgUOiLpCRQ9V8jSAkOyDJSSzP6D1qmumWrxoh5IW1F
 ZU0UIq3nTkGAkzdZT6UPKXDKFbmdIPiZYDweKdKNK2YROtNqGzlH9dAzGWV8esZf1fB8
 NGdIRPi1f7xAer0+qyTTbrjBOYkGPwOfKX+1hP8LIuvseYZGlHGELv+sLt+FVfiqQO4+
 i8i4v7l5sV/C/4qX4H86sPnqEs2FmUKF12P5yNkWKUz+SiIjnngPOoGW+ReITa4ekm2L
 ReZfMJt58i+D/cTs2Jgm/lRDe45gk7r5ReFSEY4wIywSjtdgDpmrGUuoaQfRqnE6Swiu 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaSX034390;
        Mon, 4 Apr 2022 14:35:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mh4q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdcjaVwnO/fwuAWJmtfXqrqPlmLyK85k1ZGzjoW+wHgY+b2ZiaCfFRK7oSisouXHIcG4e3GIYD7RL3SU/AmaPKzaeYTfZKb6BYxxSjP3ThiIhKMBubBkGhdKahjHFVXoc351zhgjK3EZla7O9+PX2jH9kaCp6qx2EkEunPdDw41GeUaJGhS6ALJGZqXqF+b69Newv+XIvSn72juwg5IxDYwYo3dEM/rdAXRUohST5syvS/vhXSMhErLhEN4YzFFm44/S7nVXqg0ZFwfRQg2xc3ImJIFdSK4jDfjkFmGdpvdmg5Vf17ghojiASkfwmVRFkoYBoZatzmnHfUSijgpfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSzyOSUmMh5E5ORzgGy6n96ij8NXJI1OGNvJmRH5rEc=;
 b=DLuQlo73KmaRYJ41BtwfLKU8LD11Jzu8FVorK+CjvCCOoDMDcF1jqA6YqDEvT6udYl8bbKvorvZN47K8cPuFPTzFyg/RqqCR3RHYITiuPhXpLB7OfIFugM9JfTzEZwTJIAbJittJg3ery7k4g18SR+QsWsu/J+/kjp0ouC6als22053Drti9qONwnh5ZZZ2NH0VdmUZyXnSbdjQCeYgG9vLwKflikuzYaMBPEp5swOJxVETHW9+WseyyJA5HZo0CEoTyWepPK3nbc0QNpYsdxH4j9RFVYakcILV8WFUbxM02gd1y3gkmyVB/y4q743KQqsXuqerA6HQ/zJ4LNY4p9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSzyOSUmMh5E5ORzgGy6n96ij8NXJI1OGNvJmRH5rEc=;
 b=MKGYUvivzxr7wd1SECpCq4Dq7e6IAgCJxB6HfT8A5P8u7Q+/TKRd6kU//2yUooofQyGZ8+o+XGJG3jfVovBAKLquejHsyFexNLdRpB/KC2jp+LTpNT1/MIqIhgSgoE84QBGLd+tTwqBW3/hDvnRAF+d5alNSBgsAb75Q2COOl8w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 13/70] mm/mmap: Use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v7 13/70] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYSDFAIWwp4o9j70O2wGP/NvvIiQ==
Date:   Mon, 4 Apr 2022 14:35:37 +0000
Message-ID: <20220404143501.2016403-14-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70bbd92f-abc5-4a42-9552-08da164863f6
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB58124B0FDFDE060C4ADEFE6BFDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YIxaQLXuN0CsEbMzw4+4QRL1kDs5z92ELsgsfWrYXRMQancar+MA9ADw6el3CJQbV28WNV4ME8e3cMNrC+lCeFZAhE8G+NwVdVQOTbuKJABbGjWNzgOPrPgrO6biqE30cFJeyIsuoxCl+uZiiu9AQUpBAYgb0rA1oXEzasIPw/3/B2+AxOzca2lYG1HiBxr3uLJxt3v3odtbyL6PAFpxsJ7Xw7fvZUNck6Lqc7cJ2Ynh6K6ZSNvs3EzHJsAX9G9X4yDgL1I7P8Denr3GRiOOhF2xQs1F8u+XhWNkUaok74hwx7QlbcMYUzZ5BrU806PsY9JnuTf3/byrNphx22Z2q//NvB7ZQkzeA4nxv+NPfcapbaDUgZRa9U1VeCmVfZSTa8U2jCQu9+GnRT8GvugkB90EoUyUk90fuHjJ6qkRd2oQiNnJ+n8acgq/tVNjrYQxcg4HgVRZyFjCBaek85UlzUQZeKYmx3EQ7xIkK11e20UyHgGMbQcdyg4yGycPjQgFO+TAHWf8ZuSKTlr3hm91Bj4MPZ1homNOTgOgsNpEYwsWRWMYZBLBS6dBWuTGu0qleOjYgn5g9P/h+NWGoULvYJ9DhnJrNxQLmqbFPsBkvCwre5pTtRcBVmj0d/McahUzTHWMobyIIn/5yZf5fVw/I/D6G9vEgG2sEvt6IWLO3EgtMFGV6SdxOcjRQGt7X23UcgPNUy5pECFD+eBz0i1LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?puBZ1EmZcj2gnWiQS+WWtc2nWq2ySo5RKz6zfMgvcgSdObGYYVLHjdtOuv?=
 =?iso-8859-1?Q?87EFfipyUTv5ux7HM5KOhEAZIGbzOVv/bb0UhKpJBn81KUhlo5vb5JbzbU?=
 =?iso-8859-1?Q?SgFicIlh3yfLSnJ3UQ56kM+Cemcj/2LlSBajpm47dmq5bp2BW2jmsLvUM3?=
 =?iso-8859-1?Q?tbxmv0egoG33co+XYwPAFGlwqUbOGh4Q6SzB7B43iYhmYasSerJCpGuOam?=
 =?iso-8859-1?Q?pwHLaj5qUHRvIfIWbG02jRxgKbRtFANj4OETzwFj9YpnX5LjhaPs+Uu4n9?=
 =?iso-8859-1?Q?DTOK5SqGlTnRrUVX0W795MJQHd58Nc51Pv5sWS2ohtjVyKLPy3wIfZm8J0?=
 =?iso-8859-1?Q?ZmsOeGRDBMhPAI2JZXEA5dCy7zdlGhCR8tAQJiTpggY7JrnPJyRUbLdqyt?=
 =?iso-8859-1?Q?tdy3r/ifSORZiZtsmjY7m/OpFJheZEmUd2+cdLN+nH7o2XpsK6XTAsuLJ7?=
 =?iso-8859-1?Q?Sirq2kGF6DC+zBGE+DCxAwz6tA1+B69SUI87NSWOjh9AOzOHP/udrA74Fu?=
 =?iso-8859-1?Q?BElxHoSVGGeJuThSvXdH8dy3W6UaHNJtfbFCpJGqfbjqD7StssCvIuXXAG?=
 =?iso-8859-1?Q?GxaHyoerELmaxUoIJCNqByNqApzSc6lIq64yql1MKBuNCRFwHCI/LHR5E+?=
 =?iso-8859-1?Q?gE8nYjEAKES0RoCC5y+BTW9Fygp6lCrY92enpxCKpwlA8PP3wgwHKy8EaH?=
 =?iso-8859-1?Q?tMqvRSkciNtZmLZTe63LvPRaqO17zoEnHiMMGxD6BeACvwJfVVxyvBECWy?=
 =?iso-8859-1?Q?A10V1elCtfFJArJWJwdTjwh1IWBfQRQqPPdpfVKY1lafKkBvF1M5qBg+65?=
 =?iso-8859-1?Q?QMjBhhVU3ScnDPqpPFADd9cHizzsZXnokdO7FrbpU9lV00uZtpooLnCYz6?=
 =?iso-8859-1?Q?YYoYt/UyF82hAP7gRoqJ4FV5+F3RtiW0IHIvnbnaB1MsMqyJ44+h+xFCrB?=
 =?iso-8859-1?Q?jgsJxCTIGCeV3u/1Zzp+hhWPZNOq1SlZqB3khe/voBvRmxc3q+aoP/F0sq?=
 =?iso-8859-1?Q?OjzVn6PU3lEFSYwajU4mxembQSUpU4QY3VevPF9BxOgsUT6Y9hh38gDn+r?=
 =?iso-8859-1?Q?TsiHrryPQgTjBrzmrZzNvgc8xFQvuQ1MPaa7dj6UZ6W2OyuDgvNpGd8kv9?=
 =?iso-8859-1?Q?ESmAvakewIRCjqJBHkZgAOp6LSixMay4qClsxWpPTj/jxBC1lfRwGMDTEj?=
 =?iso-8859-1?Q?4ylTc6onlmJ1Q/s7jgtKqk1FBeRg2BgfuPyvPFZHcSnQ4H0V0xt88XhCgQ?=
 =?iso-8859-1?Q?m21cbg7e8FttPJ59xZw8/MmybmCtL6XWVLHbBbjzmg0OI72cELEzymGID4?=
 =?iso-8859-1?Q?g7kt7QF1dYiAmyATRg4TU54XkVtVV20gT4nNTK04AB177HwRdXjGV2zALo?=
 =?iso-8859-1?Q?ybqOqZuO8/onZt9NqR7OYoycLzGkmzOC1y/YTkC7+T/OuvAEL2zQxn1AM4?=
 =?iso-8859-1?Q?L5VkXPuAdy3Nj5Z01AZn9H5XdCWyVWiPbrOUwVExdKg6X5ecWOfgp0UW3d?=
 =?iso-8859-1?Q?SRCfxguWBmafOvYOAkyLGdseqBYh04vRiTbZeXIv5r+sdOBsGk7EgHZehX?=
 =?iso-8859-1?Q?SLnf+TDKB2AKLhiPHw76bLOvcq1/HNVCAzYV1NhSw7jd+PNw0U1vYnuFhg?=
 =?iso-8859-1?Q?VHeoG6/NJW5VKp5q3Gy1/kZx2MLJj8isQ2RKlouseWJlis6D2t8O4BddHj?=
 =?iso-8859-1?Q?loOBl+/CeOoEpyjRmxwNOtT8XJ9fp0XnM9u3O7hDk3c0uq+OtDAI/tJDzy?=
 =?iso-8859-1?Q?5fLtOMk0W+wG5TOrCkLN1zhHuWU/iHYfjjZh52GjvO4DSt2crfQWGI3FD1?=
 =?iso-8859-1?Q?qDnciLR1gECuUwB+iLgPPT5OT0/YAck=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bbd92f-abc5-4a42-9552-08da164863f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:37.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W37V4s7kFmwmWgPpU0NnsQ2qnh5OyL0jbuTq0KNOk9T5XyNVTllVE1gjr5BQlSBK1nPgT3Uj5tCjqC9i4riY7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=862 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-GUID: SR7Fxx_qjVxgTvS_jLVP2fNsKUYvmNLL
X-Proofpoint-ORIG-GUID: SR7Fxx_qjVxgTvS_jLVP2fNsKUYvmNLL
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
index 3b4351f384b5..4b1f0e95375e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2424,11 +2424,18 @@ get_unmapped_area(struct file *file, unsigned long =
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
@@ -2436,22 +2443,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
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
2.34.1
