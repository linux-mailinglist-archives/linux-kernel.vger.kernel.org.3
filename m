Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7157737A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiGQCvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiGQCt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA90220CE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8ghs031747;
        Sun, 17 Jul 2022 02:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EjydbCDeB5HpqcU6479zQpQNFL9mryyodE0dDbbTFv0=;
 b=Y5uYrE28eo0r5iyExMeN+8yrlCx2z8S/Sf2/P93zH354IAZu4QHAhgOZLNrq0iFqzjnk
 zbnbq8ToVhtqosVy5rLz0F8/HFPRg/QYdKt9I3mUuBQTXrUHnYHDGPFVVpjXt68KDONG
 yGeq5s0ulUkfp6PLdgS+fB31HmTaqBw+1VM91anBV7dWb+K2+5uYnWTV2n+29N3lRhwV
 u58kqxGETSO2M5qHfSXOLs6S7nrXzPVF9Q5u8BolxDadizBip58LIWim9vvIio2YmDSm
 sU5Cokhm3vM9Imavb8NZdTuH+Qduhzq577bxXm84RTuTtDh4OaRUmBjDD9JTYpuf0KRq 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISU036113;
        Sun, 17 Jul 2022 02:47:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaYfobwZ6yl81w627ptY6P81B0mEkERHxZQafDYgpDKhLP21iv2RzROjT1wR0UAsuuijCK+RewXSG19buL9p2eW9CdlRdVGCScVDohRhCKHwF3gaECSZZynlPG3OjsFJiOjNHZWiSuXycjDPvu1WQNaiRkY5lvCy+7pvIHRq2+Q5y8Ht87fCTQ8Spdqx7tjKFIvjx3uXMTjINeIsoFak2Z1qMD9WItI0kIWvVcc4B61NeyqbP3EtugJfr7LbMcxJp8HpIjWieKlnrc5recRxRMx7I9jhbejnXrm2oXn7xfQz6mf4+/dwLDZKVv18HPEyhapdCFJStETRS0tSF/jrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjydbCDeB5HpqcU6479zQpQNFL9mryyodE0dDbbTFv0=;
 b=BFea83I0uHFiqLzBDBvyB8g3qqLTIWqwJUga/2aPxFG/XFRo5cu1vV35ua7WmZYe0XNg9xeDamt9OMmd+4SOtNvV5sN9aU6UnO0JzSkKzbVcb3NqYqz+dDa5GvoS+UxfTTUgRwkmIOk4zDN5WwwrFPibgXuaUCnhnxgLaTVDlVGQhZiXNXWlQ0UGhHr7DG9VSq7hVRlnAUA5PHMcIiRlXB1CifvHQF07iD3dQl14JCmeGpI2korkKsszLHdBIhILKiQ4cqqioFYAj5wAG7WSz6R7vQhT/ZFeaqIrM1NfhFuZTQ+8EazuMkAqBmK6yu/OLwsvfkvLOgbHBS2kFFJbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjydbCDeB5HpqcU6479zQpQNFL9mryyodE0dDbbTFv0=;
 b=aCBJcmSSTjluZTWLn+e6J2TvI3ddfsOXGr6rNIeUCASd1YKyujk0MF9j3x7rIbQlOoP+ybX59679mG+Muiey9MQ9CFBQQwCXS2l+D4zX73eORJiU7SWLbrni8Bgpv64VeU9IVjJZTWF4/HhGl6j6w3WzNSE65ZbIEfDXBPANUEY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 47/69] perf: use VMA iterator
Thread-Topic: [PATCH v11 47/69] perf: use VMA iterator
Thread-Index: AQHYmYd46lo7Z618V0K4nq+DRfyerg==
Date:   Sun, 17 Jul 2022 02:46:52 +0000
Message-ID: <20220717024615.2106835-48-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6ad78c2-afaf-4701-5328-08da679eb0c5
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UrNrb6LQRjGSj/e7h7ZesJKGqro90nKLYY0kYkYmAnY8v2HTZ3iSjZvlFbrZGkyNCxGjmGiG0+ECgESAaqJdOfohKQCjgc9q6SFz/luovfADCLUAlXFTsqbYCpNthDaLCcb0odwAEePIGBx7Fe6/VeG9ZKcDl29cSsFk2G6c5MiV1i5QSdr0ilcJ/tOL+BtvgPWbkA8IkzeWRZGHtVP8hj+fmvGAvwEZWZdSPo8LkEBnyYQxmSzzlnH1Y2jSh3CGPxmLE8zs0KHC+yvi6x2zGEdMYGOTNHFNykx6fnhxi8IMJgZhquu4el192iTNydZiWD8Gu4rEeuQmrOV+gtWvDzrIfVMJmU1PECGxEX9YjfnoZVS43JrsvMwWJauXfPtNzHxF9EjPRacHpcknVUF1Yos2xW4+VBFUxnzoGBCPPJ+K57vzmAUeWa8YsL4Vfz4LkilGqlYpKvXKzl7Yr9kENnNekFDS/wME4xIxKBWRUGFz67z219VhioIOKWYZPjULXIh5dLxVmg8pbG9r9aJHH/fh/qyuWwsOBCsyAJH9ksenpMa0dQtVbVlFTimQZhlqxlFjHg45nhEDmoUE8VvGZvcCPdlO3cj0qOH7IVbnbuSsYeQe/uuOD9R90+WiiCZja1u0QrMDccVMSakTVqMs0b1FVqKHFA7zJjFH05BbB4aXcHTonscOuhrDJgLT4aNlKa2M5QAYqtbWkeuXT2/x+elnrJjHZg9y9qxqRMA6IXNYncW/+E2wqyJPawzj9VNkg07RzPsMaVZXSKJdCu1eX8I6MMbabTSnuEk7aaBikPJ1kXG273NZKEpUT8pmxrcgfNW6qCa1xcfOHFPwxPjQUWsMUz9YFc5J3rE9v/EJ4xkTtWCOlCMTYaz1/gLB/Py9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5qnzuumjk4TblpR5xVG+MHnZg2m2LsrvJIMZS5MWxpD5IvmH1kv1ViRaLH?=
 =?iso-8859-1?Q?Nbvxn27L1UtKgxkbC9OZtaEJUIpk2owGPBG9xcC6NcGbk0GhQ9bxxHDbOX?=
 =?iso-8859-1?Q?KNmGvXUDdxbe6jn3/JMMx6B+qMYHJBBpid1moJhMbpvJaUvcDIRMAAavi6?=
 =?iso-8859-1?Q?GlNk9NeHf1ujV3hHq1Sz+MiWr7yUAL149K3dQIglMCaFozLM9fNk+VzxQn?=
 =?iso-8859-1?Q?H16Scgd7/bF4gaOJl+TFNfjTseu3FDBG0rA7GgPRaUSYNLj4omLOQe8Zjx?=
 =?iso-8859-1?Q?9GCcP/gWMPGWc15TT1JOGDXlZvdDUYhD2NLXUcs9CDayPW0bLB3eqJ/opw?=
 =?iso-8859-1?Q?57bG+Zn43szWWwhWN5BhdOj78zGS9F6mkQzPW+EfqLbk6wGGs9Tf4hAR+m?=
 =?iso-8859-1?Q?P88iJUt6rNq/R07wHtsWMmNwhSTzB0DND1t4Jwz3B+l48WPqKmqTdJgSAQ?=
 =?iso-8859-1?Q?xc7fAQPHq4kTL/w2/C9hj4RX4ZXRpD1zAteAcbqm30DFkEBgE+1qbcVe11?=
 =?iso-8859-1?Q?lEO5AKgnu4PplwWiTnRT64GUMwtHgM1ICczngConousuzZatRriPysx5z+?=
 =?iso-8859-1?Q?zLy9uNe6S4zKmp56N/9vWaHoAXUAKU+OYyQxUmrk1oIUFm74jwohyV9V2j?=
 =?iso-8859-1?Q?m9YopDf+e3nchqpXMjN6xA+fqbbQAE7pd73afYA7GO2qpNhAklFuaq/6ib?=
 =?iso-8859-1?Q?irXql2ZI6E7Pil9XOtjyIcLnDaGKeBGZFSKZKLPmJxyYem8sD+r73fAvNz?=
 =?iso-8859-1?Q?2pxmN7HcZJ4PLSKoBt/Si7OujchlL0bRTZqt1AtDI7NfU7BqqYdqYGowKY?=
 =?iso-8859-1?Q?R7L9BhTMfXmO+cZPPZy9+aZRUNB9PLjAAKUESeJ1qYHUDu1IAHizffTYYb?=
 =?iso-8859-1?Q?EdxB/lTHciZh9noj+BYnGdqYtpiJR2bCzoqfzMpAhl9OUixSTWvpMk1vT4?=
 =?iso-8859-1?Q?IMJ/5+rBFxBJLgwd9Ka78+x9C0BLFVn/vEchy4U3LmRwe5UXpPAnshorEO?=
 =?iso-8859-1?Q?aUPbl02GL4eLr0N9Y1yErJnaT8C9JBr2l3SerXLbCu9YmOaPRORbxHfRUJ?=
 =?iso-8859-1?Q?zfV6cffny0hFtoWdvVcgKd2enwhiFoaXUb3r2gfPXf3Vw58PZMPLRNIioR?=
 =?iso-8859-1?Q?5y0k3x7tL7WBa75d4MWy9lGy5EQ4boC5vgA8vG8beFz9NDIVJotkQ0/Y0T?=
 =?iso-8859-1?Q?8kWrmWwdE73h/XeXRK3Xc1eBd0BtXAx762sbUobetQmK95ICN7AeUq+vQI?=
 =?iso-8859-1?Q?RLCQydwZ2ZdlF9kxUC7+DFZ+AucPFGSgT4wwdtasKfQqWHclBd23eQR7hr?=
 =?iso-8859-1?Q?u+4tFlGXLHeLYFGDzuTDCXHUmFWFDBZV01+S17eFgS2oME00HChqS4XNvW?=
 =?iso-8859-1?Q?Jlnqyzf3TeuYzvmEIb6lvBSNb7osY3tvorR5O0PHZ35SM1QbJykIlDh6MQ?=
 =?iso-8859-1?Q?3LnLJQGQr8onLsf5Of1jKzVFm/7KDJ/ZMghkiZJrqI3t9ftIWKimeUqeDG?=
 =?iso-8859-1?Q?xg8P2+PJhO+DzaUBgbVwIb+E5x1Kfb0O92ksP5ZWDHDWjx46z5B/1VR+0A?=
 =?iso-8859-1?Q?RSbihkzwvZz7v2CWLqi5sX+x4k9LR671mG+bM9Vautud3VEOsKsPxoGnG5?=
 =?iso-8859-1?Q?IbPMVHUhvP9nN0kNFDM/ouHfR59qc7RQUAK6VkOOn4MDSow6/4AuNB8A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ad78c2-afaf-4701-5328-08da679eb0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:52.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XryxOXqQjLnTKF2+n3Ic0Dkbu/MF1O7ToXZmmACuvooKwaKKjYr2vuK1JvEpM3YcP62fJVbtjhzNmqf/lmx5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: 2xKb-dk3WnbcwboBIcqGawXjHwW4JUG2
X-Proofpoint-GUID: 2xKb-dk3WnbcwboBIcqGawXjHwW4JUG2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Link: https://lkml.kernel.org/r/20220504011345.662299-32-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-48-Liam.Howlett@orac=
le.com
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
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..61ad10862c21 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10210,8 +10210,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2eaa327f8158..401bc2d24ce0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1231,11 +1232,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1983,9 +1985,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.35.1
