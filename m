Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8E553C23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354830AbiFUUvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354651AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80F020BE5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2w4j007494;
        Tue, 21 Jun 2022 20:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o+nY9Z7FGNm8v41V1Tt2id788uqjsQs6BElWlZzzmuY=;
 b=hNqDA8UlP9pog3bOAGAcmvYZYY5GX6sdK/ZQJ4EyK0aTMJgZFzYFu9OKl6lrAgWp/hjb
 qo+wRxkpPAeRtttbfuX4Zh8I7DYXgMQhV3xzvU2NTlJPp+Ije+AstdxX5PKmcJK+9nHK
 VxRRqv2xbLNeHLoEeOOq72T55o4jFVlvjJfH2Ay0UVJ9s1egBARxEr5rWtgyfJyA0vFK
 EQkJ7OglL2RMM/6LBcjdDvU4XOBliOpCCaTbTAmUyWULn9+IwWxgrrYWELBTKQZEPDnD
 gpaP8HlFrXRHwEY/FrVLhsEdc7MeqLj1G/d/BNZxui0lWI3kvuUpbugljsY/8C2tZIGl Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYI001682;
        Tue, 21 Jun 2022 20:47:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLPCqVMH0YfO2sR4PeWTk/x/hTpXh7TyL8Pdh96KowCmet426+Aq9P5g+JpgzcIxJaYN66XaQ3a1gVzU4WuaJLpP+eeQZmbb0JvRGuLiMe5W4Tydnhh+Af4fMC/mDURPe8/jh65tdQFzLG2HVcn9ejIhbpqw3mfKroIht6TS220GSHol3NCZ3d+AqsRUHpEDsxA6TY2dnULBINHvhcPI+8cAgHY2mNQI7aNu8C8uGljfgj54zCTXr1ETuJxOR9wekKmmIi01x4eQ3UZTOBrg+h6oqixV88/aNtVkP0/CqK9K6qXOJeEsj5qohcyXY+eT5UrHfsht1NHuVpWf/JZEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+nY9Z7FGNm8v41V1Tt2id788uqjsQs6BElWlZzzmuY=;
 b=lOAuq0irfxNXMtL614Ojmcg074bJ+ygouNihpcAaBW53iWJIgSM/QGhlhAo6S1xhN4S3uG4vy8sSNpF+a5QhLm4d54JIwe6So7q97vO9K5EwSav/vjIaKepQ50GIrAbH/0T4qhhVeKJcrJjCRQ02KdxFoG51/hpDTTLWvvabuecI9PFs4a8TSl+Qz2IdqtmBN/ICX4bGsy/KruNy7/dz2cZs+OLhevtPhKuZRITUTupiuf2+g+eKyT4qzAIvzQLiBO5l6AJppjt8m75Ucqd3/nLaUixd+oUV/avLdv3SGQLIv8/vDFntV6wiy6LYQl0oeGX2hYGOL1ELzsSaRUn3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+nY9Z7FGNm8v41V1Tt2id788uqjsQs6BElWlZzzmuY=;
 b=GArmQG0GsCZyrC9PHwvhYRoL+tKmqiY0ZYMV1nevvBdTb3wfZzWrmk/HoAAaNj9lwK/SOnD3PBRFW8LBmyr6KCSRfSOuKYSl95IFgCPUZg13k37qPCeZLJLvgHpCXCpJFYGoOJ0XwaxsI33YNK7HPUguJQBdokDegVcIKblWPkQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 46/69] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v10 46/69] acct: use VMA iterator instead of linked list
Thread-Index: AQHYhbASuamK0tkQDUWfX8UmoGGaDQ==
Date:   Tue, 21 Jun 2022 20:47:08 +0000
Message-ID: <20220621204632.3370049-47-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb0c901c-9ac9-45aa-28e5-08da53c74ecb
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392DE71A839C79E98826178FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6WO7TtFR3l22oL4aLM3yH3sglvibf0PJVou8uGu7cDYJz2M17k4d/0xCqalp1rGXDJtiF42xnNEi6rANFqDmBDBYhthkt2NbCb6OOipBb+KD9WzbIu1xJxixuY3A/7iYgd4TNAJIpU8DmUkJR41zCt9HK3aR06FBgi7H0UBO1/OpwiWsmeBYDPzmMTLI36Opme1HHDZ8LKJ5nOeU697LavGSW2iZlT/PN3XfEqRokZ8FnYDC66QmHMHGS/c01j2mc9Yc3B4pJ60jghaPq/K1JV9g8DUXA9CtWLET2yO3eW1wVO3HG8Q7m26Mz1z+zlNXG7GhC5rgwjrV9xCg80WhtGllug5hYuojvvLuwIbhM5kPsQUJAmBENqd+8xP8bzZn7/4sLe2BW8w1lTiaYItXrcEmP2ujGCRcKo1OrfiChZO8XVUk3QrowcI1evnbYt4ITS2yxZG78S1VusBTvxyryk8hmoofdj+789oXBZInxGUSiW5VXHQy4sDiIlm8v0bLRuxomZGwL+spbQ0SLiETUO0Uws+zKzga5twn4JRiVQPFF6fxF60eLq+/oXl4sWcIT+v/AfiofVlD9L0xCgl9zXi7sveNoma+2/SnTqwf3DfzPWRK/6BXFZzfJLYVKDb8GNT3wkvPfIYUDW3Xb7zUbH4a0FDYyX/3R77FJHn8OVHgBTaBZCm+8AjFsyQnIZHtSegns+XJtQhVpX/Xce8P80LhLnUTUgwkZ4CTs3Xoio6kNvWLKrdw6XpV+5diuFTZW28VbiZyWyr5WBSKZyA/ZLicLe24Z+raD0N27cfatzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lTDGFD0X3A+Bx+OafjE/xSyR1kazUhFm+sE6GcRwDz9h3kHcYKHTbBa80M?=
 =?iso-8859-1?Q?qTkL6qmJo4hnCgB3RUC48hqmpxp/t4y0MPL+JtETMnqK8hEi8CVyo1VAIq?=
 =?iso-8859-1?Q?qF2Q9SaH3GFha0QQsaCB4Jz2fNKyfwwnPyYupR88Q6rX0bcgxFky441UsV?=
 =?iso-8859-1?Q?3qrSwo8btVU2GE3I32SnLXtuqFm23rm7qh4ub7Xly/nt1rHSakf6GRdrFj?=
 =?iso-8859-1?Q?mk2x4XCrMYPgwocIGiV3V6FdQxnsyye8rQHg71MCSAXlT6LudBiKKWQH2x?=
 =?iso-8859-1?Q?2lZW3cHFWuoMc7ZCQtuInOYl8w4pQG03yUru/FuLZ0hf35vTO6b19Wxmnd?=
 =?iso-8859-1?Q?kAXtkCD7EipgNhZHJv2+6IBhboGSrKh7KjlkHylCjF6gMcwa1MWC1eCtm/?=
 =?iso-8859-1?Q?n2LSE6/n3Q3AiBE+0wCKWOEYpBP2grkrz+erNRKHs6bQzGSHUybjSyaSUF?=
 =?iso-8859-1?Q?ViYDOM4N8mi7yTQA2wvFpx5JHFKXx9d63KEWSq4OJXKv+Y1Ulrnz6xniBp?=
 =?iso-8859-1?Q?K6ESBsBsVCf8f3iDFM8N70pIo1UhB8Bhiyihw3wy7ArQDxHQF7DXr8DzXt?=
 =?iso-8859-1?Q?d1nWe1e0DYhvTiLYEPolLrADQiaqSLMu6Rr+KxOkJnM+0HXsl8ylZvm4mg?=
 =?iso-8859-1?Q?9M68PIFWa3nl6W4r4SVqoueOGDtUyYi3whVeCp09ZWA3xDX8qT0Pm0+ugT?=
 =?iso-8859-1?Q?3rURSv2hRqpYWng4PB3vYK2UPciZtRx+a3+ArOXBbzc3hDLjhlSSms0/XD?=
 =?iso-8859-1?Q?N+rQTwjLTTTVHLfcf3CBK1NCeIAcRkE6epOxRU3jOmiDb7p3Fe0HU+Vl9H?=
 =?iso-8859-1?Q?/r/php1Hpjo3p6vBN2OPM2T5oitc/zox+079rPCM8NQaUqdryL0Tr774FP?=
 =?iso-8859-1?Q?86gz//a+NbTtw/5qBLBaH/kSddTfm6MSL3BpSmNo1udP2DgOKU7mC+AOHQ?=
 =?iso-8859-1?Q?Z30mpQum+30+aZejShk8Xao2Wnk0yclrvvH1t4pblmBalcMkHa823ZjEDI?=
 =?iso-8859-1?Q?wtNdb9Uyk305xxOiqq5NM1zSgRpracvPXWK82AAxPk+pQdj82MY1GXmb7F?=
 =?iso-8859-1?Q?Xim9Y9aiEafGhv4xAEmTDZfOoTxbADJ9uopf//ssn4XyNy1TkAoNfmhLut?=
 =?iso-8859-1?Q?M3Jif6BOVHgizg3KQW8FjGtdzrqNpbTx8B4ZhDKzEMJW8lSQA1FGAaJ+Fp?=
 =?iso-8859-1?Q?OTKkXtAkzFJ0/AOfbAKRGH61mYP7p3l6RGMpPsii2mgLXBHcuVH86c7SAy?=
 =?iso-8859-1?Q?+qqYgDBg6tcP0vqBjUupXUDgpAOJA3SS5fwswcb3S+a9x2fcLBO/sOaJEu?=
 =?iso-8859-1?Q?mqfLrB6pbmsyzfMzCptDPoaQ/qIkjDnv1p+LxriNNa0g4gM3hOKJoYlAWZ?=
 =?iso-8859-1?Q?CzquSKzLMgjOROE81mw5V7nHEN3syOojPV+aOdcvbb8VBIVW+bYEmTLsma?=
 =?iso-8859-1?Q?WP9VatR86rSS+7sw0TC373DY8mL68YUzphGFsK3MXfkURcPtTUdrRPnApz?=
 =?iso-8859-1?Q?W3n9H/QjJ1LrY3NRlOcdL62U6lPf82dWNxn3X1n5UIwv5WKSWoEiGqgwrA?=
 =?iso-8859-1?Q?nVybAVzDo8t5SH79pgO0vyHThiHqy3qFu4rJ8OmsDlO6QMQP3dOGNhYN09?=
 =?iso-8859-1?Q?Os/M9iMCRt9PcscwPCIDQpd1uq0ucFpsqj2yewbyY3JqJeCWA8SXYgqnE9?=
 =?iso-8859-1?Q?Ejz8Dybu4Mfmd0M0/FDvycVRlXPiezd4y9S0cENLAAvxiyV1W1RCQetA9h?=
 =?iso-8859-1?Q?vJ1yUc1/sFW3npExPIC1smpC0GZvcOZghPHyh6JFXx09BmhoeUTtz+LPbV?=
 =?iso-8859-1?Q?zxrTcJlK5c+FhKyCrGQHHW+zivMDpPc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0c901c-9ac9-45aa-28e5-08da53c74ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:08.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMO5eROeyAggsvtvU043bJct34HzLzp0eb2QPWsjArJML57hVEyrt+k/0g/HIrcItZ5r7gLl5FhkS2Ayzw+G3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: dbwMgry1Uu-AKU-aIw4mYRPtAPq36maK
X-Proofpoint-ORIG-GUID: dbwMgry1Uu-AKU-aIw4mYRPtAPq36maK
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

The VMA iterator is faster than the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-31-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 13706356ec54..62200d799b9b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -555,15 +555,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.35.1
