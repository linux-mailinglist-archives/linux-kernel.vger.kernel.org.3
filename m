Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972144F176C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiDDOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378277AbiDDOmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6A40E57
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlLQP001019;
        Mon, 4 Apr 2022 14:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AdRqOWQcugdtyWevu8IOPuAXypJnSvNNKa4SUO+Coc8=;
 b=TJvF6o+q4swMMGMHSNqPJFU4piH9nZ6wiyL7Llp3ZKJqM6yQVkZJ1ffPusbxVzp/8EyO
 Shth0BNvBiyyV16OjuoBk81LnOugnNwUOatJE/jQIGgI83NGHgt2a6iG6zoT5rhNAM7W
 WpViIA4yTFDUOVvgzknKRpUlGdeFKLij7e0ltgyC+m0HwqD3+2WnMkaIB6aKOAtfndZ/
 UiQvTWUYpqetV9ls2aXP6OTVx8juiuHxD1565yGh/04hL0lT3+D+I1nMC/drFimTJsYO
 R1L/uwVs0bxrGwjWTQReDR8OCJkI3wLZTKqOqBA7LYnYHRYQuJYIChcUIu6O4FAaqtaW Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3skbq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234Eajof011889;
        Mon, 4 Apr 2022 14:37:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6rXdAFC63xd7YXTuFqlAHt+LZvQY5khDbhNdKOClxbbv8vyWk5cXu/ktremNleC/Abd66uoy/lj4mMtIkDIknSB9THZIOg5wPSmzrSAdjESXfUar1Em/c7A/xspbamfYaHLjgiY4euNchcUn5HeGsqU5MJLXbOThHzU1RCjB6FDN8uoo8OuA4xx6CCu3KKv8rqcYfRre7FLXzy3Z+ZcBvFBNA7WLrGESN4IZsBwbJQ8SrZZfHSuGsotVnBa1PH4IftIVTa5nGQx9Zn/6bbng0GjcMr1tpAGwZlKronynOnsMZq2YDRaY0W8dSsB+yPAmCfPrJ7xHPbZ3knAkwpKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdRqOWQcugdtyWevu8IOPuAXypJnSvNNKa4SUO+Coc8=;
 b=lBG+ODphMCtcqnD7yY3K9AAJLR3VSbn08MdwiGRxD9VEnSnhahHX6HdpaIxkKA2G+N7daPXyXfJv6yI8rPLfb2h/Y0gYXx2jBIpXg6jGOOO4ApCE4sKw680vJ3mvt4zK7v9dIvqbtcdYWmi3EjhQStMqKkSR6o3EwSaJPHhUuqt16Lzmc9rxuCby6a/YQBTpTSLDijXRa7pZvKr6qUU2ffI8x9lly/mbA0rdNjbu0uJfcv+aEpgEAJSDqN7A04IstCcJ7QYm+EKeoy8N/mDq5lMPG91BlmKKzsmbdsYgfIxp620Ylp1aJPtgJeihGX311W8HVdvTCEJ+3rCbiVz+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdRqOWQcugdtyWevu8IOPuAXypJnSvNNKa4SUO+Coc8=;
 b=fVQ/5xw2+GPzZJYBroqvBNauegBbAnnBJthcPGXmTIfVzTYJLQylfRwECZlEnRz/azeZHHNriyBoLOl6UfWFP3hLPfRsO0vdgMuu9Eiay/d4/p0aqOcpKmIU6cYOYpdevRpyzQyaBflCIh6OVQXmMqo9tG1c4mZaE1GXvKImWTE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 70/70] mm/mmap.c: Pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v7 70/70] mm/mmap.c: Pass in mapping to __vma_link_file()
Thread-Index: AQHYSDFNotolAyUdSEmRi+OR7NpGMw==
Date:   Mon, 4 Apr 2022 14:35:59 +0000
Message-ID: <20220404143501.2016403-71-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2d3c5e2-6575-42fb-5939-08da16489961
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742D271E8EEFDC10DC804C8FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auP6Oijd1zsKgTcE/sSUBOjJTk2fkQLt7QskRuGbT5pnwUiAU+9gOr58onipukrnVpW5Q2wZHSfJgf6pYzYouHrh4nNDX/gWV1z/9dnBlflJrCyiRPQb4yvvgiU2bySTIrbQJ9sRYoj6XbJAvyE78vz6oHwzudBTN0PpvxkMQw3l6aSHbzvTz265DZjxqeJgc55os4JhjIF0K58JlahGXk82Hxb7N7HrNSogJHkrykt4zkzF0V/7YSslab27589FaLBWMRbnoZ486WKG/Xk3j9dH7/SyZ7TpwlRPfg6iHj5YwJ5nXRryDMrVgFtvu+H7aItdK/CPHqsXUHpvKeGcpb91uPv7GOrg4NnUiNiwEK039M4kgX/8XxqQDWqUhelRWw/5PNOvlvSgdJP6BDmHVcf/L43kKYHsagEgNfpjebwmpH/KTZXFt5GMPyeVxzbHzPnvoNxiwAJlGTyqdUPwSf716A5vQENyd5eSsYojcbIupY7hhRDa9lmw0tAeovau1j8MC1fa4y+2G243UZcZR3pgolVV+n5ygIPZ18Nwskip0VhAQxd12kg3XdTaMOLu44m/dpmHfsmeODKhAIP7jrI6VP1GtnpCcPw2ur7Ea5oZ8NY2RZus2anL2viMt0cs6d++fW5FugipGq8nF6l30tmaty0mT32XyimO0j2QovUfiJnTvSrstmmKRd3DryR7gQmbwof6svGh8sSsq3ZH2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KjwM7QuU1Ar3Ia6ZSzOc9acE4AngtZS+niUwvL2a4URT4s+Uu81orXSUxs?=
 =?iso-8859-1?Q?PoMdfVh2ZmDuIEiLMhgINIqtimwDZ/NMe5CKpWnlHben59ndLpIzuh6jAs?=
 =?iso-8859-1?Q?OGZ39+BupqQ1FT2Cg1JEehel5pI/wTd4tpobRC43hja3vgYU505HUtRSv8?=
 =?iso-8859-1?Q?eRKZnfJZhKrm9oS5BSH99KMlYQ/IAkX6tFsMxb9Rq4FyfbXm91N3SzsZkm?=
 =?iso-8859-1?Q?b6Mi5ZwoRDEYSQDBESmKBXPXnzTXs2NhcbYBInj+wFQkQeQe9rwm/yNMXX?=
 =?iso-8859-1?Q?dzQab0XPB6ZvUTwTYSOx8rnc1wy4GWUp8SAr1Xwimp9p7ukBIuGo18hxue?=
 =?iso-8859-1?Q?m/AOFD95xT50HPklJmJ/pmhPAcPYkTG062ktWjr0FjNplECBXsqGEnpG4H?=
 =?iso-8859-1?Q?ppEmHotDLKig+YXRDEZrerumNM+K/NDvKA4rcbEybKBNsCju+kS1Dy6zTU?=
 =?iso-8859-1?Q?gnwpavGtOJ1zOdiQ/cggApjHl3gLYj/XmekT8QZJI9Wr74vdZc8Fs9ofo+?=
 =?iso-8859-1?Q?/+Lc560LTJjNb3M52dyNiHtDH3zZnT+xPzNGLdt08g3VpYomYJPMOZVIYi?=
 =?iso-8859-1?Q?dCp4WR182EBKaDMKfBl6epKMSKxqGW27joDrgVC5HD2wOlDmp7KkYDCxU0?=
 =?iso-8859-1?Q?NqlO0UqshN2uKENtvWLcmb8TpJ0GsqhZb/A7NQJvztq99idBuWlPxDPzr+?=
 =?iso-8859-1?Q?yqby5IsISk6nPJz/iWxPNIznWPAg/6jkP46Li28MQu1D+ryaTdBq7q8WjV?=
 =?iso-8859-1?Q?22+Ic9DQkBWebHQbxJL3hgf+iYAFUn/9NexTJWVsQVsadqH0hpKCNG6Qbk?=
 =?iso-8859-1?Q?cHOai7lhKqFSjhwDuoyGnzJLwcLGd1RNuFwt2BU3LjIxsTkXi7pIYJfcbx?=
 =?iso-8859-1?Q?OWvEayqfQge0RkyMB5E7pfxnwbzKfNNy8xBrWmJSigw1OlrysaobjMS8nC?=
 =?iso-8859-1?Q?DIKKods5uGLRcVW23Qai5OcP2h8tn9BZ/qzvjrUB2Bl8lOCYNxkTlp1Clw?=
 =?iso-8859-1?Q?b/3gap7cur47A+1o9YYKLdjM48//+lWlHDSRptXQWH9AErgzM6UOlVsrsF?=
 =?iso-8859-1?Q?3UaZMypmAfYJaa8Np0c+vxAZf1GocASCx1LdSQ7U6vU8QHsn/my0w0bbhY?=
 =?iso-8859-1?Q?IIM7WjRO+1ncphRW9AYzhN5HwG1Pc9KVYV5/QVc+Hn4rEss3ILqS48Thcx?=
 =?iso-8859-1?Q?O3WYNZTbuZXnKkMdmPixNYzPYDLaDlxxlzRGPYw0pDKtKHCri0P8pjPwMR?=
 =?iso-8859-1?Q?V3VIFg9T3Ed3IqkMnF8okTHXdv3QaMNGd3FhZlGv/inW1OGEflo9f6qtyF?=
 =?iso-8859-1?Q?FpTuqQRXukfErB5p5nZWyb9znSns0z8ny7p8IU/91hNFidAfANWc6XAyOE?=
 =?iso-8859-1?Q?4Ihjvu7I/aug2A+iSFDQ0O2D/sD5puXVyMjmOqdboh/6MLMLmtu6uvV0NP?=
 =?iso-8859-1?Q?k6d+4pRWksVJf5z47Z1v+T7I1BrXk7BeArgwmmlRPzfTxS2LSMaTfv4zZF?=
 =?iso-8859-1?Q?AJclVlcK8thrwlTdnGu9emN+0rmO4seDofhmnDEmaJCgva5Wbgn6cCff0X?=
 =?iso-8859-1?Q?sgJ/7GYZ/lJGXKoXkM43EVopMk+GVqYgLW7jb7QvVD7M3UI4tjVJ+Bjgv1?=
 =?iso-8859-1?Q?cedlA8B4ajJje4OzuzBo/Yz+PU9+AhAA++CpWl2MpKrCxMrbYq3SwTyVgp?=
 =?iso-8859-1?Q?+B2pgiVlWcWUQTZuyZiWstVyOfNBmhAzn2q7Lci/NAG9c5NyY5ppTXSZ/s?=
 =?iso-8859-1?Q?3+fVaBEYhSK6Fa4Yjw6z80gU2R2oYIrEf/uzuVLZzEJ9fvS9NQ8K9ODmDI?=
 =?iso-8859-1?Q?+r8lW6IkqDpRltBwEiwQMIGYTg1A1Lo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d3c5e2-6575-42fb-5939-08da16489961
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:59.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BeXXh1YWY1YIuBOJpHQQY4uErI+WgVwpDkj3jx+vCBvc56q0OI1tfzfJj2MehcOdMBaA54GbLl0UYbgLe1XpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: vXLMv5FL5U2rqDWQUAiZ2-iWtFlTNVj4
X-Proofpoint-GUID: vXLMv5FL5U2rqDWQUAiZ2-iWtFlTNVj4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 119251fa2d53..7365e32f1f03 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -449,21 +449,15 @@ static unsigned long count_vma_pages_range(struct mm_=
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
@@ -506,10 +500,11 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma)
 	}
=20
 	vma_store(mm, vma);
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
@@ -742,14 +737,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
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
@@ -2958,6 +2953,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
+	struct address_space *mapping =3D NULL;
 	struct mm_struct *mm =3D current->mm;
 	validate_mm_mt(mm);
=20
@@ -3013,13 +3009,15 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (vma->vm_file) {
+		mapping =3D vma->vm_file->f_mapping;
+		i_mmap_lock_write(mapping);
+	}
 	vma_mas_store(vma, mas);
 	mm->map_count++;
-	if (vma->vm_file) {
-		__vma_link_file(vma);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (mapping) {
+		__vma_link_file(vma, mapping);
+		i_mmap_unlock_write(mapping);
 	}
=20
 out:
--=20
2.34.1
