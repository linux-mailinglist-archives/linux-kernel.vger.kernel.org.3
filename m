Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636957ADAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbiGTCSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiGTCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740E4E84B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1FaEH015096;
        Wed, 20 Jul 2022 02:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Inai7+Xsx308VsWeAtBqzeGr8bnOosAz9uaDpcaMZDw=;
 b=I+9l9BDow4GelXVY7VbnOgc3NYVtLXOptYN8rOY1AuSt3zXD1EgIwT1v7zM1T2+ojpLY
 zcm3jWVAMvH4HEY3fGa23OK9N22ke3QqE0jGuYYebWsIyLH8m0z4g8Ysslg/EhzKnM0h
 sAP72Gt1x24gTQWS2nKFT3WXyNBuRcuWSmKpawKQEp/INIGMYZZpzIdHYGqwBYq+pcnN
 7QmarSLxpTY4Zid7NiUY4W71fBHBb0Uci7705QMopLK9ymkdBIUtuVEc3vMNzZnvrPlU
 nGPwQeolZk/dKdOKrNoEC+7g639wTEmsNyYsUKPqr1EdRty2BKB4RXv36IbycQacbM4c Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g542-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLKx022321;
        Wed, 20 Jul 2022 02:17:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9jN5POusYlE3+uoKevdKIjRCUA5W+tmkiiS9BCDmNy669o9+pp3cpcHdHAkQnFWezxAuj6BNaLCpN4v20KwIN5P+qqhgFPk2zqNEH1jj9Gx+PMu8kaAxwjuxfGfFiAdHvGxFYvk8u+KXqCTSPEMcO/h7spc7R4+hRjkt8Gdt45z/ul5D0G5ABKf7Vz74lpO61ouqCrrhEATmf+NAoRvzbLTHnGKK+GROE2Dmu0VleBYt5TSL31Ee7OGvnQ8IgTiCoInk2onGCOwSAytjD0bHvZe6EK2ZhQra3r1HEfC/1aZlRT39oq7CGusczuF4mwvHprYW0iEt0bwqFvJqew3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inai7+Xsx308VsWeAtBqzeGr8bnOosAz9uaDpcaMZDw=;
 b=hEvG/B5dge+EkqGJd4jOOw1tb8J7D6AOA6uYetP50TDIIqJXYMyszULdVK7A6RDwQSS7yzcozVR8q7WYIiL1QkBSNdmfDPRUc4+Abky5t/1oW9SonQI/o6zHe24O+MXJ5BGjOlboIRttq3x/u6a+knqHjZBMjXMhAtAfK2Zo5SQuXvgrgX8j4HMR/OEMLT7gRVlw5WMZuw8zkq/OWR6Q6T0rdHtwOW9tKyqNI1HomboKTOleqJhh8il4BrcPoqWSzE9sTwGh2eT4JsY1NkGGpvjVagdIgJuN2aUKOJELkntJXa2kE9feViCn3kmVM1HJVd+P4FT/j69QDH9eAOFSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inai7+Xsx308VsWeAtBqzeGr8bnOosAz9uaDpcaMZDw=;
 b=yPCF7/sS7/Mh6BLFOpKLuaKAfTlgMFcZqjTIRcIMBygqCoVIKK/IYarDkU82+cFWCN/pWgZKwfNajtjkXgXNXh13NN18IMsQtgkFywrJ1hGCQmGXkgjiJ/mvpcUXN+rwBSAa9szGUMjGryeCyQsLl15i//G6M4gzkBUwHBDbnkY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v12 12/69] mm/mmap: use the maple tree for
 find_vma_prev() instead of the rbtree
Thread-Index: AQHYm97nwWeYiLIcvUWN7RbY5HprLA==
Date:   Wed, 20 Jul 2022 02:17:47 +0000
Message-ID: <20220720021727.17018-13-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1312f08e-784d-476c-b1b1-08da69f60b0a
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwSguN6pWztarzx7OrOIlI3RqInH3HeaSXeymDIW6wKpSaSyR/P2hNr+7lJ7VtYDBlLlW65fimsbEbbkvGiCj8OrcaOF8IofauYLMfyk7eG0l0Np0bvIx4AXBrXwkkjXxUqt40Mk1D2FpkLs076dpVDfn8phPsmdN28KSewFtyaMQHl6lOENCPwabj9BMKpI7SMK3Yh/1hE75ld5xUEHNeobTbz9fs5nAdP2/xJHQoYFK/iN4S++qRsNFU/FrHkuk4nROZnt9yFMJZxRy0QVeseTBNLRx7l6ps4Ydl5h940Lb8S7QlXvNtPt6LebZAov3X4E51/8ROmL6xnZyHISruVsjvaOQ+pwxntdrrn6FCPrZUZwkjyGIbYt8GG64K1cv7AED4QPztJeQ6Pgx65D1JnAEN4oh57/UO8qIfZZnTh0Cae5s4rU27dYd4JYLxdxWEiMGi5AoPAX9l5msbsGwqod9Mz3uo+ei9EAmso99v7EEXiEeh2a7Gc9H+z/vcL0GpYFnVrLA+eoP4/hmSlfaeLnkqbxMf9tRIYjR2PiIKIbYpPra5ItZWb0xPbQZp+FIWWaloCD+Bh5Qb8J8RgasD13CnmFWU4AT+vbK+ge40klvFkzQeOE4DT9UYS8lRYO6fgP59fF/7yoS6fPHqhgeyPGqbDmqJ/8oLtwtWKpGLsKNlBIGUsZMSA+mV8RGnOIPKdUcCc/xnHf3xACvwRqxVoIHsqFTfM2Reep3OX1iOzOyL3BiKaZi6yPpJVQt+Y51aW0fdjlp5aN0A2S6V6zXD+ceEI9eIDfqqLOkclWXUHN+D10GDjWRo1fw7DlFo64DFhCKdJ9uXuHqO7esYjnwinB3sIb3xA+7ieJU5pX6rlQcHCqA1vO2r5vq2bhY0FZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?69ONXJf0hncrpvBblUZDsWBHsRwhLnnkRYdsHRApywVqB4zthFG21wjMjz?=
 =?iso-8859-1?Q?qhkeycK8zIx3Gn0gwf4bT7ed5A5ybkkCEGwMwBlPZ/GyGRYxkSTudNN7/b?=
 =?iso-8859-1?Q?FXrGHsaOt9wabtKYe8zKY/r3pFB9cNU29T7WQFnCir9mT9IsFcto+Z9227?=
 =?iso-8859-1?Q?akV31g5LH+VugvHlacZn9iQ9S9fAYlek4OSCzYSwx3Caby0EA7rLXR64mS?=
 =?iso-8859-1?Q?2uVVJw6lFs3HlpJlhSXrkEiUwbktHMhWBpOj9f6DsyDmq0rRdIwpHj8gJa?=
 =?iso-8859-1?Q?C6eP2WsG4ThS5LZwM/h8H4kbDn46PdepZXO3s22En2tVTPmev/AzcOeoAg?=
 =?iso-8859-1?Q?NvWsd2QxDSRHJvby41r4Y66SlhxlwH4Bcidfcgo9W63oAorG9a+JZyqcWT?=
 =?iso-8859-1?Q?DYvM38zpPnAq4sClORwAoBU50jz9UmXy9tEZQhojazpG4SHr3aDOpMTDd/?=
 =?iso-8859-1?Q?0nRrlueDf1wECZsyFWk5Zmjq9K2dqTBvEvealBd3OH2BgrokyG8FVjWXfA?=
 =?iso-8859-1?Q?Z+cW81aM1o7OvebUB8XS4P8LyfuFciqdZUrfA1KCuEhpNUCTUEKcacBjLi?=
 =?iso-8859-1?Q?TYQEhEVw18AqKNVqLPRIthCavv0X6N4Hx9TaqtEotRFhnxlHpSdh/WULwZ?=
 =?iso-8859-1?Q?gJhbHSQnYJ/hKapklO5+D1KVTjCJpb4Ho/l+kAlzHjSmICS3y1H0HH2f2o?=
 =?iso-8859-1?Q?NJJJPxV/9FsP7ewCdX1rsG3c4k8ADJau1Bo+DrmSpEaYdiyieoCRfQr0QR?=
 =?iso-8859-1?Q?H5g2LKgPrXf+9xcIhDxBBYAibA3+pl9zJEe1OBBZdhV0s4UjIpJOXXwvM5?=
 =?iso-8859-1?Q?hXyzuKWE3yicrF3qBAdZiPpSbZ0Ca6wch6b3ONVb9SrFMNqoBKKYT/PL9z?=
 =?iso-8859-1?Q?kterrQZ/c9HOVBT9cD+jWSJcd3cYAUBMma4NjE/w4Z8GsnnR4b3cpobH48?=
 =?iso-8859-1?Q?8rfpyjj6JtZN0ZCeii3z/Zg4VLk7Wp6CHpTOFZCoyQYHUWMKOm+eVJRVpk?=
 =?iso-8859-1?Q?WrKtgnJhueQz7+NgtV5eZRpJlX2A2GYAFsQ42xd6bIzCWrW2WouPVKyVGm?=
 =?iso-8859-1?Q?46eAr7guvddN9DSwWGMsw/VPCpojhzQVz20bhyE6ShQGaP4Rd2J/Gq0sOO?=
 =?iso-8859-1?Q?XtZpN/xjZfo5ODmQr0pVYYYWEd0NHS3UbcNFyP2NIevo5EOyriTBQtrac9?=
 =?iso-8859-1?Q?m+EL9DMRQtiaMw+5kq7DGRyQPsdSOxplkxwiawnx/7z2nlFKAjwC/JOVVq?=
 =?iso-8859-1?Q?ltJ9ECEpvdZkMvnw46XbzgE4RBHMwKphv7GMD3rljOm3RIoyGmFiFyhbV8?=
 =?iso-8859-1?Q?SfjonODqL/yehUFyZyVPfakQAVq8PX3THqKyX66TI2NWEVt4SHMpjzDUd8?=
 =?iso-8859-1?Q?exYv14FqUdWjXyw2gvfHXEMRQmh+gT0FwwUBf9J38dr0M+k6RBvL2uJMH/?=
 =?iso-8859-1?Q?DEIkml2MXFRod+oK5DZvccGoRWcKdDBd2oBIb15cb1e0sb93YDyDkjz4t9?=
 =?iso-8859-1?Q?DbL+RPUJWxzUwfbXym1M05PBBIdGyEjia5+kzrGOwFOdsT1dHHDYX3jg42?=
 =?iso-8859-1?Q?KTtvZYBhjEad4dlDdZXlh36azeyDBOoPwmCD2QBMQAzSq6qkheUhB6/Soy?=
 =?iso-8859-1?Q?tfrTD2qfo/JAB0MOyVppV56wzYgvjR6k7+9Nvk3n91dUpRNe0N8nuUDg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1312f08e-784d-476c-b1b1-08da69f60b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:47.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AHqaM9E01zJITA71gvRR5aNBJxa+NRf5pPgaypa9wxADsf/dC3jp5bueX/dAOGGnbiewN3/hfFwy3ea7mU7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: vcbu30n8HXPE-xJefaKhGabVlPIXEGYm
X-Proofpoint-GUID: vcbu30n8HXPE-xJefaKhGabVlPIXEGYm
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

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Link: https://lkml.kernel.org/r/20220504010716.661115-14-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-13-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 208deb8f55a9..12abf6a75690 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2517,23 +2517,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
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
2.35.1
