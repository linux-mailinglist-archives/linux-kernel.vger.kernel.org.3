Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8B510189
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbiDZPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351959AbiDZPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58B1541E8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2aj015530;
        Tue, 26 Apr 2022 15:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8klIjg+ZE9A5NpgXVEkjPxOyY6MO1DlQ8+vXBvB8UNc=;
 b=CGaNdObdu1jpSbLM8oQpbngyIzJ/6iklNmneANY1GMDE1oEjzYRjzqQPYj+h6RPy17dO
 NKPMVayiNXmgAQ03+oroUgQl1gKXwGUwCMOswCZiRvZALjhlL1o9HbhvMDLuQZODSIyy
 TdLTBB8Uq4DxiTdH1zNhB8Izc4zu/Dx19dN5mhbalT4O2Rk6rql2z9nVcQi+k7NO5LSx
 ta69nQj8i2LL2X674+BIa5nLVh3BV7CECAtLGHmsNysokf2Q2nHDetSMxafFoBPqy9/1
 oylTk6OeZvupp2At7fGiDxJ+vVUGW4ZiMEP4BKjwBgeM56CvKjKY7VyNbwW+EC0UMzEF dA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urm037859;
        Tue, 26 Apr 2022 15:06:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOFs6WvnP0mnWbRfEK9tJR53xdPngvKLWLQCWUnRygZ/IlrMUsywbJI9CZ9CoepNDApNWncbz/chwzO7FgKqG2oee0Nq4T2FCFCE8r4fTrKuaOH7jWnJYF/SM+3h5U6r/ETUahgYn6Cc2SdOHKm8FB81UgwsiOS8J29gxoOkDtv9jPiOqNNt4twPTN15RCXjPHTRMmuNjrz+5BnnRF061gAtpqbsw+LYkitcnCGHWxPVvIe73JhftE1yZSaD2UgyHO9Mvh98e7MekFH3vBqMysF56N5FF2P+At0mSpL20YbO+QHSyTZa2iDH2xCZTGNMOhXuAnJ9K0RgM8XhYe77jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8klIjg+ZE9A5NpgXVEkjPxOyY6MO1DlQ8+vXBvB8UNc=;
 b=bn9DvLSBc6Yv9LsFV0TnTYnpIWrt0FrCk+g2VAfsF8vy7DPg9+4zJEy5oH6j9SEwx5lup+1Fhscw4Top7RYmDGOk/wcss98xiGftcOwkQEvI5V/IaYi1Q7/cuUD1ajs8Z7a4pks7oOxkwL30R5FvuhOrL2FYuc9LdypFY8PSjo5SI7O5tNvFkKTw9ergQvnu+cBadGS322Yl/fNLMy8zLOq5OoJ6G2dceaW7WJ3cubT4ZQ+JlCDgytnu6Tv2tRh7kyLCzQSzkiS2UYArFIp4P/AD4wMM9slJaKzuIEhaAsDVrp77uiN2sqyQYRR/Y5+x0pUCANWWdF3OKZs1bU5msA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8klIjg+ZE9A5NpgXVEkjPxOyY6MO1DlQ8+vXBvB8UNc=;
 b=jgQdRS1Lp6WBVvXeSZnR0Ul3nelRu6n7LxkmBZATSViUOQJXCKpxJTgIGxRHhmMB4uCBZvaeR1oq5y44p2x5cBo74RzyIPWPYQ9paiNkzGvEi0XU6CxOmvAd9D3/jkgP/UEsJWfc9yTO35ZrIqU/9KgJSLRaik2FnVfTcup1pI0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 10/70] mm: add VMA iterator
Thread-Topic: [PATCH v8 10/70] mm: add VMA iterator
Thread-Index: AQHYWX81GzdwxmAI/kuYTsgs9gyOjA==
Date:   Tue, 26 Apr 2022 15:06:30 +0000
Message-ID: <20220426150616.3937571-11-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35037a86-8d76-418d-c319-08da279658a6
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679E3D07CA048259C4D029CFDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKCgn4iqOAHcZ3/pJc2c9ADo0YUvvlqMQ+WSKo9Q2rY5N1dPxBhDyFw2G+EmJeQSv1gy20UqNxAYb3128YbkTLgD4qrUaI/AJ5rV9yBk1urhaOALBaC56XHAjvImzUKsbFQpw/ajaLgm+pCYvqfc+JlI5CEV5WFptLVeYeJheucMD4DbZVWbEXBxSYxbI75vRHAfXErqEGUr64E40BP+0UwMUbymt9Z/gDsz70CwJjBgKvskpJh/OQxwd6Oqpuf+TeEPo+jPR6y7vFgxL3g9dgKG+c1h39WMSuJtocDhhqBZnPQyzqve0WKkaPVgOR5xP1ckv3XKpHracTKw9tD7sVeBTA9J1xj9/50hFSTbXJxVqZJToFsfkuxtXvVkpKah5D70JARlDXXaIo1AuW/jXZJLIF0pnSIhuQMcr2Wx1ImadQ6BWj6CWIgA3EuoQAY7+UMeEMQyXbN4h3U9EwN0MISlsaf2ARHtNzQrkqC3BtqYI4jfraNDWPbIpqIrp7LIkKQTCWZBq7aY/3AdVXKXkcKDMNp4trkN2pw+ELiISTmMYpHAsxONY6VU6IZceD4fiS6mfu5TgRXfT0ONflgIb3OV41mp3d3yBCDIo8nVSgDw6V7UPTM3JUbdXS7Kb25I1IsM62Ci/Cf9lbELVLp29a/o6RC/5kfi5UZFjo0EikByd0Yfhe366eLAphp2/XVohAf2gLReYTyj+iOkIveS/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MqWMIGTnow6J6Nm497weNV8ZKusY4vkptYrKbzrSkrxsDHCbKnl4n8aQ+C?=
 =?iso-8859-1?Q?nEGthDNayKLf6wOcbX79+VW19iz0pWFPHbaGQa/iDxRXtM7OiwPJZ3wAR6?=
 =?iso-8859-1?Q?W23mLWWNHZH9g9LNyt4d4PlHzvYp+YrfiNT8lciggvCbb5+pkUjWITUlqE?=
 =?iso-8859-1?Q?Y7bK27KeLiD5nD74c6ktMtumPvabYJWXaRAV0kDTs7M4kv7zkQmR896YMz?=
 =?iso-8859-1?Q?IPVc0IFWfaH668l2jENa5bSigyYV+boIEc0LFqVqHFe2+XqF3EAFPZ7a7a?=
 =?iso-8859-1?Q?uvvqFfArYY2JQNdCLKVwcgdJ3/lwT3caVXBUSVVQb2eok0/fe9Wu9dazLr?=
 =?iso-8859-1?Q?buZfS4Hqj/yMWYhhKwyEPJHWOrODmS4+mBgGY4dsn7nM95ecsnGi1G4X7i?=
 =?iso-8859-1?Q?IgXVHj4wVuH7XRWvahIj5JPcPHXHRYb3+xJLBXGUJYmf47bluC6DaPv0/F?=
 =?iso-8859-1?Q?C3Z6FH7dkwr6wi7/H35Inbu//xkj9xg7CFdJUmD80zPBT2GPiZH2OUkBAQ?=
 =?iso-8859-1?Q?EYZBI4TH2UXV5Bs9KuJpViEE3MCJNnAZXUvsIyXjkI0U07REWDeh1fBVBr?=
 =?iso-8859-1?Q?jRA4KbVZOxKNcjKzKFAXrRrhH9HT65ii+sm0tWkNSN0Os6eQJ2/7MXLPNX?=
 =?iso-8859-1?Q?sVSd2ZjuM2pmIeST29yP/KjPKMZnHYuyXvW4DxNTN1QMxcDHv0rn29sZzE?=
 =?iso-8859-1?Q?q9zVAWtyLO1xVjGXV5D1GCQlV5MAMSrHtJoluaR03dS5+2bdXabMODZKDd?=
 =?iso-8859-1?Q?Vga8bLmMlQJvEbmfDcnXi4PRpLCTOlNVyRJwKtb3H0T77gvCzqKf8c8mI3?=
 =?iso-8859-1?Q?AbJaibROPkbsXDbEzu2xfsbQtjffsYKojTBze0ziWb2OVFxb4uPgKH2Oam?=
 =?iso-8859-1?Q?6aPbDl+qs/h26rTpyo6HAyFoKyiOuWpe2q1b/WB57tB/6surtNCnq1wHBN?=
 =?iso-8859-1?Q?fJAG7c0fJDgShi1z49nOfRkDQCpxxxp+8+6ei9HXnVPbKhfcwIOlJLqXqb?=
 =?iso-8859-1?Q?GnKVhop4YPertqVaD1Rg71Au+cKLVMf/7Y7W6cuNlgH4nmdPhaz2qSOa7G?=
 =?iso-8859-1?Q?xLpqPYTYsxzeN+Dd+m86y6Qtzi1Gq5pw9RYIG2VMMJpNaeAeDqWzH5wn5h?=
 =?iso-8859-1?Q?uNGXkwjC0sVwEVzsK5fwoJjppfW+3BuqFqZSXgyYh0zd3hkGutel6/szV4?=
 =?iso-8859-1?Q?BgObDH0yyDIAv+q1DMiaKjdK6ZqI3iw57dFOiQ6AmubYpN0yowNOfUJ73y?=
 =?iso-8859-1?Q?FZeTLyiVxn0JiCaq42vTk2XsR2jZZxojTr5qgnIXrsLdLo0YFLCDet6CRW?=
 =?iso-8859-1?Q?nD2ywDYCPU0Z3T/GxwTdSrX3NX8i7ZzKL59gubWsQ5lCeB8HNP9DGHouUL?=
 =?iso-8859-1?Q?ZR+ulZAV5Vva565UBtX7uArtQtZd9iN2pIn4iWdXhB8W+iP7eghRRWyUkb?=
 =?iso-8859-1?Q?Im5LLVYYSYcI5+ykTWFPQUd2J20w0MRafI45uZzsmXkBrWDyIDYwNNYRcS?=
 =?iso-8859-1?Q?AAocPphhz5Bg03zKNRMYMWAAezAsalC+JT83zJ5HIKT6fuJpsP5fweMLCl?=
 =?iso-8859-1?Q?uElomwwsNYZVyCSk7cg3sSm+DunXgt0iPM0h4Db6KvcjDk0mRM4HuRy/Ew?=
 =?iso-8859-1?Q?HUYaFUOHWM3bf+t9Rnp9HYgP1qAprlyEYMHA1RRbHxhPYPhfRUdkJiRDfQ?=
 =?iso-8859-1?Q?UuP+i9UqQSLyvCDvI/JQvO7A6XD+2DiTqnApOFWuevsp8wj3GpuNK4LMtE?=
 =?iso-8859-1?Q?L5FRjJRbbj2YnjzO3uEgtXFC2ILvFfSarvUZ6gQ5thtkaZQR5MCZ06Khxu?=
 =?iso-8859-1?Q?y9mWAAt6/Z/ZnumVzA8Nj3z0mGZ6EZ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35037a86-8d76-418d-c319-08da279658a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:30.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8P3sVpNFBJgL+keTN5wJjUiUcKL+eCd3f/yyxPWUA9j6MYFyTpum9CdIU016mz8Xi1jpF3CselgHMxFKZyy09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: LcfHlgvkAmIGgtgHhEdAghYrb4VIF4Uf
X-Proofpoint-GUID: LcfHlgvkAmIGgtgHhEdAghYrb4VIF4Uf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for iterating
over VMAs.  You can go forwards, go backwards or ask where the iterator
is.  Rename the existing vma_next() to __vma_next() -- it will be removed
by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4024ccc94c71..2c639b0a9853 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -658,6 +658,37 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&(vmi))) !=3D NUL=
L)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&(vmi), (end) - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0953add99518..6b31c5252b76 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -678,6 +678,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, mm, addr) 					\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &mm->mm_mt,				\
+			.index =3D addr,					\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4512f64a30ab..176f114c2ad2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -635,7 +635,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -643,7 +643,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1317,7 +1317,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2836,7 +2836,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3035,7 +3035,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			return error;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.35.1
