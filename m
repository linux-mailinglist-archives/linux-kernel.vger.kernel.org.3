Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078774F1725
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377948AbiDDOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377795AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343123F32B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DncRw012575;
        Mon, 4 Apr 2022 14:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wpu9ix1pQQq61HWzR/2PxWS9UF5tsnRJB32lxY0UXFU=;
 b=eh7AsMhFllpI7jCtkm4P/DnNeE6LAKh55WhqqUxY2LJCKFN5nRWhACuYMlMXIogctSo0
 r+CIUwQsI3pqaXtSxoJRCkJYIuH+p4IM9Z6zmkf+vBmEHyw3yJ7TS63ZKuT07tHfVrYP
 qk9A/ZQGNXDrIfXwI0DTangIHEH0PN+27snsVE73SMFQoo2/HG90bn8bs1K1KYQU6QRd
 D/QYPLRDBomSRam9hG2jE+yjNVppdUaGE8S94ZuiOFjkrii+2XZzxY/qrZH8ePt8VQ12
 3eyX0jRxiK8/w8f+45xyQLVWSCVfFzi/GwnSrWbmUhuXT8E/UwSQl0r1HFEuAjtd7Nyh SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaSY034390;
        Mon, 4 Apr 2022 14:35:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mh4q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4v/70ypBaDRYj0rPV724kNULbJ96KENv3cPO8KzQGq3bmowMerruqxyik8zQ3DoyET6tHodE5QoJmUd8j3RqMjz0TSq7VsBRtxJ1fm20FqXFhj1nPp+PpLM3py7mELSyjQdvDBGYaLeqY5Lg1B14vcPtjRmAG/48ueSvu0EYNAhCeRAmgJR948V6v33ziZJIge0LprYBAosXqMX4lDVSoVEVYYxgADL1uFqf8QJfN9geELb4fCwrXt1YL58A6uARBBYQ0h6elvdovQIuCQM19JDzBceB++OmTG3RaXr/y5C1J6jyOVVInHN/3mO8135g3ctGTPGiPCbjBPu58317A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpu9ix1pQQq61HWzR/2PxWS9UF5tsnRJB32lxY0UXFU=;
 b=CZaJybrTsPc5cuidmAXg+L016bLGSJQtxMbCmvs9K4oyiVTvLtp/gk7vTNwDMqaAkRqL5/q3eofKaRO9PtVISj5+Z0gFi1Qohwx/RnCaVw63DYpfXvseY2VBW9OyDAdydoVtWOdQjI2/xre/kVkKRpGpZdrzkujWQlhKsPuIwpifQ7Spj3Dq/g1ed8+xOsV+lU7mt1SHscnkRLsYwy+kMvXpsQYuQeh8Jh6ubMhQtETAeLhTEu6vUenDhtyGaK2ssYXxmPRZGLh04JzFoWjKeX3fztWfUyvurYUfrCk86yO5EArzsvTPp3WnwTrnUaW1DDZxOfvgQJuCOzcWRfNpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpu9ix1pQQq61HWzR/2PxWS9UF5tsnRJB32lxY0UXFU=;
 b=UwPkL9KVb1XHxn5GvWNL9sBzw2/bE9Gu8yQYHWGeLCDKorImNnTCa+VzkcNtBOMBAfgrYkFU2bviNazFpnK1hLKlIB0+6EwxW/1h4zIpyFFcp/xCJKlcl4evE8wkDb9JZNWQpojufdDAAZiw2BNygIBqcrNf00z8U6SqGY1wbJA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 14/70] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v7 14/70] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHYSDFAoG6KHe6yXk6i43IFyI2PRw==
Date:   Mon, 4 Apr 2022 14:35:38 +0000
Message-ID: <20220404143501.2016403-15-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd0f68eb-c2c4-4a3b-8f59-08da16486453
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812E2E706E8B654123D0064FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfS4TmAvY3DG4IO+kUuP01ZIin/vYE+rqVaaw5hHmsjKitqHK3CEysseavrSdJpm+LyT3w0KH1xhgM1kuOLldkAV0jtobClWiO2CO5WsS/JtfPWnIgXVs+YJS84ahIZiYqbdzXP+pNBVIyJlWt8a9dIPNvxJei59DJtZ4NKIblqwdr+nrzcI1oXgyR6Qk755+KsjcuoAGM+9rpXEFbfQGaqdN/RTydAWBarETR3VPuFaq3Iny6BaIjg6T3KVeeKMb5bhog/VGzpvmd0quLGiJpqhetWacIHYB1SvUsVMvgMGyUADi1WnIVregAdvSE2+mABbRCuhAeAPI7hbfv0vroGQrfPSNPA2zUFBT2DP9mLygSydIxbWhX4z2go2QBTCXcVdIvItkOGjq2pUozHvmQM2eQ4xzbmD4WRQ93eEinBDogyhj/XTMgjwTbZxRfnw1BGsR5kIO321qvuW8KmFeLaIzrepHFFe/dIxLXbvFwx/E0Jj5sp8scmXnqxCy3Vhdra8qJGy1OyeKk+ek8TVcfbfVs2cApolSjTTVh4Y5uqsxnu7YLbjUn+PaQPUBbDLHAvoSoF4P1NZARArnA0rVflC0D+UwVnYq0D4oi4Ym0XRA5+Hvx85NGXY3r44kqDTeyAN0k9PdYplwXUkq7Pk+58xj2qGbl148vaAhdjMOjIYEVZiAS5YZAQ0GPqpjXohJhinz5Jn3N8KEHHFyH2IeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tnmip0mWdE9YTs2TT34tfqAHX+K8GtBvayFnNrJwG2QNKiYWmoTWHxe1hv?=
 =?iso-8859-1?Q?WNPsLw503ldANtB3MJ5bt3TKEt8K7M2n1ssQRlgJMVFddwx6JB0r3uaghT?=
 =?iso-8859-1?Q?PSlmV2kM03n1V9fQRJs4fczC7siVt8MpjNHlBDlGdcAdBslt+Umb+hfTXO?=
 =?iso-8859-1?Q?N6MibOb1WVkgrOqBxvG2BRlhOA8DHb+f8ofVYVuQv7x6SLVb0AOGX4dBSI?=
 =?iso-8859-1?Q?Z4TREUk+JE6VSsgE7TBp3PNP6MWv+oY6UIjRdV3PzLOcZQWo6jed23Bcyy?=
 =?iso-8859-1?Q?9qXR8ARjrNRjlgF1dXDtW5yopsh/4Vem/7RvfTPdWnbWBl1l47chajaIsJ?=
 =?iso-8859-1?Q?VyFLMqOEk5wt+TqmYyi8ZWLf6N3G6N2fFncK6BcwSvkSc9OZm+9dduCvYU?=
 =?iso-8859-1?Q?HknvPCU7c1euOiKsB8N+hWZn+7cyA2zHKQZyaZGVW3hblRiScAoXWRQJz5?=
 =?iso-8859-1?Q?5DmSqMEjx3RjULCRDzkTXixAuqDs92YXVN7cofPuuY1zplsPMSHEuDR1ET?=
 =?iso-8859-1?Q?uvODCyGKdxPF9TAFGN2oIjnz+GLmt0ofNRg3tlQYiS3d57OsnzhPHdPTAH?=
 =?iso-8859-1?Q?vuq1V5KI0e80QAXIgjxaWopQ3khuyrO7ctwJNCMhRfwIvN+JzUuA88J32k?=
 =?iso-8859-1?Q?Le0bOucyG0gzwe16SbzM1X+jGchLWi50XGCz0DkvzzhTnnTlpY6t3/geey?=
 =?iso-8859-1?Q?Y04wjlfrNzvSocatJ9/NAfeIzXKMEjYDvee52tk+zDbAAxKGwmwCeFzHaZ?=
 =?iso-8859-1?Q?y7cqdVvSVl9zSXaw3XG03HlGRTiC8Hz276JbmeS4GWdy/qH67MBdKyAvat?=
 =?iso-8859-1?Q?Dknj7ZSaKsJJN9LRtRbREpQO7s4nc8C/nlUdddUQQm/W+stwEaxTr7lHGs?=
 =?iso-8859-1?Q?U73sCmj0H9t3TMyxMGn/RxVlzE0H2f+A5fSK4FvBzmuQwYOWkeHyMnxvtm?=
 =?iso-8859-1?Q?bhSmFMLw4XyXipgJt8gZ4J+oazNq8+e145dvJBdakdBGDoTjsZ7hbedv1r?=
 =?iso-8859-1?Q?b3ATy30824CJAPLxNh/4kAJvkygyfGP9JitDrIiFS34LfzoLsTmajJKq+a?=
 =?iso-8859-1?Q?g41e05xbE2cemsnUrDZKUpcS6ZPBZUdrFKja/Js1bjBtXa+5N39JJWO0KJ?=
 =?iso-8859-1?Q?Ssmzx1Bqfq4RI1zjpK2aqMVu7bhhqmIALHR2ac7C8FJW7+CwmNzafbCYoG?=
 =?iso-8859-1?Q?Ruc3W1G5ClaTkt/4mecwI/52QJUFVdLyTZpPS7tE7t080LoNv2DdF39HxT?=
 =?iso-8859-1?Q?wGqvXjEn4yM4fPUQf8F+4HnVpea/7BHTZq0WlJjXI+PVB3EgIFSLsuGHYX?=
 =?iso-8859-1?Q?0wFSeXZwQ7/t8UC/7l7ifw6K0EbthF9VLpYnZTwntqueoWlBnMvzTGOo4I?=
 =?iso-8859-1?Q?78gLTx+YOhlKllbff4wgemm93Qx3jabqnL78a/0jkJW9RFzPqmPWYn1n+b?=
 =?iso-8859-1?Q?PDeiXl7TLaOaDa94PPwBwd/FvWDMgDveYz7VuC7QmIBjefsqDLx69nc52q?=
 =?iso-8859-1?Q?G9JuJytgkmytI+/fPieNVUq24D8b6d4olp2wqL/4FM5NjYzL1+6kZSU/aL?=
 =?iso-8859-1?Q?HG6uPOT9a028KiDvCvEjkcr9sYRLhQ56d3yorujBhc98t8QwnvLhFWmtFy?=
 =?iso-8859-1?Q?tcdf6AaUzdd3v3EZyaynSP30oz0ZOqbRwWUQ1RXGV1rQfQwp8u5sPHt2O+?=
 =?iso-8859-1?Q?nemPhkZO3k6bI9uIqNREW+HuMxvByaqua3Me0wrgY6/DH7xYy2MSFXD3s4?=
 =?iso-8859-1?Q?PfUloJloRmk/fCyzlmcNrcmaA1H35bldgvZ3Sb1FnUYK3pP/Sqtw/OHuZw?=
 =?iso-8859-1?Q?gfxdgmTAthe1ntkpbgP6eO1b/oXRl7c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f68eb-c2c4-4a3b-8f59-08da16486453
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:38.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3c8ACjksvh5MEku/TXte/d4XiWFPr2credTEvB4DAXPWzMDxmczLN0RjmD0+8krG2rm3Gg35roVHlMVs71TB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=977 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: mlYgxBX21pVfhHpE5occQXXjPG5Rxvqh
X-Proofpoint-GUID: mlYgxBX21pVfhHpE5occQXXjPG5Rxvqh
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

Use the maple tree's advanced API and a maple state to walk the tree
for the entry at the address of the next vma, then use the maple state
to walk back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4b1f0e95375e..1b6d7667b45d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2450,23 +2450,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.34.1
