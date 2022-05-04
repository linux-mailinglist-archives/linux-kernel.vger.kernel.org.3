Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1D519363
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiEDBUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiEDBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75143AFB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LFfx5018740;
        Wed, 4 May 2022 01:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+UHCW8nFXeFjSUwDaJL/T85wPbd8q1FFGkops0wcf/w=;
 b=Zdut2UGnI1PocxxcIecPJT4l5+o0KN9aVsNli9EN5IIITNL/lMMJSNRV+Q2aAjPDNf0m
 3h/HxB+kVS4bSF6pEzKlsvl541sNJwtNxds1jkallIg9L3F93r+OXaBML54XoPeo+mNO
 O08Gnx+Ly/ySQOMtRw/Kq9yFE/JwpYkqpi8BOBsV7szXPVt505/zXybJZUAKA06Kvm37
 23e7JNEcOGpks9B2FSzOShD8KwwM4miwbiLoYzZhfJknMFR64V2Xzi2Ul97+oYNFjkrK
 3yS37l7LFUpIj5kg8JLi3nx19xgXkyJFcIRhnQFfsYrk1JTHdp2RwMbd32kBaxg0QbuD TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AtoB020100;
        Wed, 4 May 2022 01:14:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5iRcMz9Ou1hZmD+sWZPfSQU8hch5qo04pU2T9VF+G88sKX1r17wiht31MHMB1Hi1vg610cD8fPFEjJkJDKM5uhwKIeQ1lmdY0678dNSNx0DoFQf3SuZK34KAsivph/ZlPcJnJruv+kIsrUfwBMAtuRKSon5u1fglCIh9Hk4wc6RPCU777Xn21TkTYOLADX/Mt28CcQTQgUFSG4SDHR/GaSiatj6bT8TY1xF+VJW+PauZutsIeFma8cT5hk2M8Cq42qsXTuwjCwH8vex/MdP+1S7g1iCT5VEANziSR4fBObBCXu+sqY+g2fhDEIrMAqn97XXEmMGZ9aZDiLARuYsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UHCW8nFXeFjSUwDaJL/T85wPbd8q1FFGkops0wcf/w=;
 b=aOMEx1UbP80mAMGrREAm7a+igqUxEBaaBTDekLzKX44Vcd9qFZ9OKPQVal4Mr5hi2D6JN6S6Xj7Es5L6rw7eI3GremJnDjzgnEXWtoWMgGkzERKAm7oQTXX3bj7FWSw1EvQcq4uvuRv5stGOGwQZv7BLZaJmzi1kdgAuCKyuPhu7PslGkfnzcG8KodwH3rx5QfwUEHbLtNlRkPujJnNUJTvf9JwntkljFD+5ekQ9u95vLvn58m5W3eziiKYVBsMUlhUw1Xvy0A92i8H1CxJYTMeQjx5PV5UNHG0BnfZtdjY9uvZC7Vvf6Qb30znjzko8KdF/WgIxiC1DA6hVASNj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UHCW8nFXeFjSUwDaJL/T85wPbd8q1FFGkops0wcf/w=;
 b=g5U2q/Ki80xzwfN6G1cXroTuJalxkqYwuNNGuqyfBWTNrEOi9qMwzcNAw1PghCLkjkAdh/vmdJ/6BjIWS7Kb0UIcf6/IHckEkiQFwUTQ1zDQp6RO7ODndB2mVuDtA65WNomDFeAFL1TyuQXogqz0Xr9kcKC1M4v5HlfD8g8/aQo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:13:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 38/69] optee: remove vma linked list walk
Thread-Topic: [PATCH v9 38/69] optee: remove vma linked list walk
Thread-Index: AQHYX1Q62krzGFlVpE+L7mD++uYYPw==
Date:   Wed, 4 May 2022 01:13:57 +0000
Message-ID: <20220504011345.662299-23-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c15877a6-5225-4a45-95c9-08da2d6b5e93
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB372882F111D7E6EF0C4C0EDCFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evkaW6c3P9tCs85k8T4Qjj5HMZRcC51B5t6cULCvJKcBrbGmxjW1hS3SRSNyk5e/F2UGTdKtqkfjLCAunq0hYREpTUKkrsCp9T5LOZHD8Hq5b+D0YVqX/AppnHR1naPH5YfmiD7i/naK4noi879OjjfybXvNK2mQvBTOeVFDW4VnGWbFEhcxoTkVKLrL2HtfF5z6fpZ9kfEAZg7kTnOzJd2Ba9xhXSltjSdq7XUPUe3UKT6LEO2kYjlAxG/uaK7z5xbDCksCCM6Yb4/HgGb0z/WqLAz0Rv9mfIYnP6fvo+RLfyYX0/AOOmR+OPyCeGZ/80jgEpf0alZ+UhZVbvpB0poJ6BZCgcZkGPzF8s0Nth0qjj7dY0DfbCs5RIkG4Y1rmRCV0liaZENfYiOxdDqm8TBRr/PVG7T9C1vG/6ufsPtzhRCiIIIZQVBADSVnpjQDvQgkDSCCmkb6uYBIxms8cGtFmC1b1MVLoSepcVvu22mZCcsmUqn3TcKU4JLwY0rX60sz1eMZsM3O45ulq96S28YfvvBmHj3PkeaiJlXrqMhs2A0U7XlQqSCfg2ILujApd5Fyl1i5WZum4qZSJsmjkTFD2DZ+NVt6mUjy3QnEz9KLxwHYoC9vBm2ZihAx2DH70VJGKGD5JmjfyWr7ookXHQGTLmqu7sZw/smZYQ4bp2BQTpZCuWLV20pKK+lFFDmJu/NZEua0BR3E4mhAgUi2Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mZ3/IAvlmzd9YKelS4/nHe3rEo2EFhskrBPQYWJ8jPTM9TqWnYEK5ea2Nb?=
 =?iso-8859-1?Q?zlIb2ZuZz4QoiIsQjgFceNTqJHNwhISTQ/wH3jkUtxSGH516lKsMlVcXU+?=
 =?iso-8859-1?Q?PLW3LDcppkvDs3obOiTv1wItmqhXf+ATT9/KGn9+Fub7Nn9btf4f74wQPT?=
 =?iso-8859-1?Q?LighDJQNoEXson4RGqlJAiZ9HSQfKyuH6VJnmqTcloi78tq+kJdReioNTx?=
 =?iso-8859-1?Q?DhF7t73AFSsFRIT/nda5OgSnXA4wD/Vx11AfxzFDDBEpCmWK69XHOkKBG3?=
 =?iso-8859-1?Q?EaNmE5nl+XdwsJyVUwXgMyv8cm1l3rw6wszs/lDeR79e/K29fKnCka4bid?=
 =?iso-8859-1?Q?8lZaKOmi8nNgEzdGg/8MsxwrecmGxw5KMnEWadDcYB0yd3veFvV91JnMCG?=
 =?iso-8859-1?Q?BNI2yiq5Ek8lboncki8L9QCH1k/G1Tv+Q2hgRi7XnsGSetq2DzYy2kWIZo?=
 =?iso-8859-1?Q?szWTxCGVYLGMVsZqV9aNM+2/fvRi35CbC51aj3pWym0A04t/BrddV1iwgX?=
 =?iso-8859-1?Q?j1IqNtCQ6scctUjjuwjBpv4+Y+kQZF/jY2ZPY/NmFYa4mXeSnluoDXJgGa?=
 =?iso-8859-1?Q?n2gFVfxES4KQ04LO1+T71vSOpVEZd/X2qpIWuWqwIJtumWh/zNOP7pNmV/?=
 =?iso-8859-1?Q?70PnByrs8Z0sqqUO+wbFCrVpubW5UTK5emKetg8xl5Olb/BLjsh6epxOEp?=
 =?iso-8859-1?Q?oDVvr9do8jJ+1Clcrx1Efc/BAMiUFcT/UtTXLszSi/klD1rx+DeJBl4bAZ?=
 =?iso-8859-1?Q?lr+jKBQckh9QHVudXbZ8aGzKvMqIcIYnfcHMZ4OdDh8+8ae4Xgc3eYrhzR?=
 =?iso-8859-1?Q?4hC/8OsIAloHqp3k9bO/M19WUYt+h7h1RjuM2Ca/BkZ76oXvqkek49iAAr?=
 =?iso-8859-1?Q?FzWJnIBydrfd0MA9aBbrDtDpFXMD74hIq3NiAY3LdmKzYmlDBgPVNLar7Q?=
 =?iso-8859-1?Q?cjIQKT7Y2FN4Zs66b7zRxZW19ZaLsCbL83n1ETyZHxEEhnfqyYm3jZhDhW?=
 =?iso-8859-1?Q?8sVVLjI4Q0YdBywk3O4d6sn7f0nDFuTLkCurx2ef+PHoZt+AT5d/Exh9+r?=
 =?iso-8859-1?Q?jKa89r5inwnMUsfoIDo6/T4/kFT7A+KIiAYTRphhHBUCD/aDmRAkb3duwg?=
 =?iso-8859-1?Q?/9BSHwIMT7K89sfe6XfQlUX/VXzDIgxHz2wfcW0KLuKnJH1lrPK6ai+vdp?=
 =?iso-8859-1?Q?KYhrH8qh58GULhN8DuzDVDHdePWcZDKs4l0aeo2xfpt5c8iZY2U+Psr5Pj?=
 =?iso-8859-1?Q?TV65+U9ianXpuybfL53tN5R9gScc080xr1vx7IreLqxhg3LAmmtzLQVTJA?=
 =?iso-8859-1?Q?+pAE4WApaFZQognZPdhR95YaPigqWu09x5HPBK5Pq6hbX3V3uXjdY5QovC?=
 =?iso-8859-1?Q?zLEXgH3/8pzGTZVccW1CSl57R08eVrkQ64mrv3pmIOYtOEmASEiHPTv4Cc?=
 =?iso-8859-1?Q?37Quo8ha9lBTxJE6MTRGExWnnT8j03IDeyABqTNKUI3gxBHjitkVig99iW?=
 =?iso-8859-1?Q?LogTlG+W+8DO9sbj9IlwtKL+doZJdtFbWbkZGMQUicl/7zrHBo3s8D3vr4?=
 =?iso-8859-1?Q?8ZCrWjim6J0VvI1F1Ie7n84FrelS258OVeusubsqEIB460/QrIBU0Niu/T?=
 =?iso-8859-1?Q?FEDoJdvdtJvjqV2m47LcqEPhJe6KGAlvTQ4ao3HjgtS85rywiypNK5JoA/?=
 =?iso-8859-1?Q?2amCT4QiF+iygKEV3UByk9njD2dO69GFM9erLBn668Z08MWG9XEWAiCVuZ?=
 =?iso-8859-1?Q?Yxc2gU5agISJ7haxcqJNX86LH93iPPvAM3ipzBC+e1tHG1y+RaqjDw/EH3?=
 =?iso-8859-1?Q?TwmlaWawmbpoLrRFoKN/a61jHQkv4q0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15877a6-5225-4a45-95c9-08da2d6b5e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:57.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0SoWpgiCDpi1qSfmgYcTLAUVNRoGy5UAm3hCrUTvERA3Ob03YN+OEaFeIipd4UitjgYIn5iBs3DchJkRlNt0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: COuqWK2u7TyJRRumet1qeQB3nlAR8kkO
X-Proofpoint-GUID: COuqWK2u7TyJRRumet1qeQB3nlAR8kkO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..d8115dcae6e7 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.35.1
