Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07753510168
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352220AbiDZPL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352099AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376DB158FA4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSu3Y018603;
        Tue, 26 Apr 2022 15:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WJKkltNtV8GzaLTuCKaT9alazXtwdBT0TYx4uDuGVzw=;
 b=1DeTnz747tVOgd1XU7S34MBWV9Ib6uA6Cl3ghBMmWpgY4IRlV+JWJH/jh4yEuHywauXK
 hleJQlJ2TsgwLURDPQVUyAwwU+IxJx/weHT3reiyh0UQ1Xf2riwNlVZ1SqcEnK0n+HbB
 KSlD6MrfFhT5EMU2y7b5YUYw5zEvJVsB7PUd6Q+TQQIZVL+npMWx/qpcFPw6C1Uxd4JH
 X9/y+rRBJGBKAiN4qXuXJPxqPcA1C0mj+fJBTrJK1+i1a+8kVlrE0hDMZ1KUDYq4Y3jh
 /pWGOSQZDf6kXnQLwYjb70TOPdLKKy86guNWbjRTZjzaKPKSn6FXWeVNKAJ0tRiEq1+s 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxeh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF554p019202;
        Tue, 26 Apr 2022 15:07:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3feud-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hblt5GOY/PN9SxsiBspE+l5hUQKL3sMpWMgSXS+Y4Sidc68pJ2wK/kPEZBDBB/khEEfiGlVoy9Bac1muqvPlqxO9Du7faZApbMaCQesDujOZOKfqVQo4PqG2pgdMO3UrGj/cLoFeTbaxNM6bI0K3TxCk+pt3Lg/95osnxiy55VQfHktTxiABeMsaQzajWwbf7uruV4C+0HcF7z97VryM45N06pJpJb9bAF5JShKqY0iclYTKlXkkuJcBntYgnOQPT78hV0VMikPW7LYEzWgFpkL83uJe8S86AU5OIDuolnhx5CrwlSM4HV51B/GCx23WwvGcEVySHqsLMPqse0BWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJKkltNtV8GzaLTuCKaT9alazXtwdBT0TYx4uDuGVzw=;
 b=g6L8U8CM7l+21B/CIVGV3V6yBvKwo/Y87m4CTw3B9z67qIDZ6sdF6M9uYG5Zj1TCfYh+3pRI+1KOjByITfH36XlKiACeLunW9yB57LjjqIIUwgx0TvIVZ/VQN/nZsdnbJikJcIKS8BIBU/5y4iSoLb6gUzOxq5jgqpAK/dEBCQLyVX7pPWNueeTnNa7khZN2wh8V7hjWCXlcRmlvB32aEdDXlbmhgjiNA3fs6MgMi1tyxJNds9eg2J38MPc/6LBRQkF7YVG19uVoJkTIfnMDTwAnIuSW0HXpwyOUmI+lJxGo3tZ2Y6wiHIzH9nKDsK2zJsJ2zEDgBH3IweaCSFnWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJKkltNtV8GzaLTuCKaT9alazXtwdBT0TYx4uDuGVzw=;
 b=i9f0O0rNr+OUcvsq8v3u7qEF7g4XPQhfYBLmMyAM7veqx+Lt7IOjzy+qkx3udCxNOUQZTP3c4x9NT891djXA5DvmAC0ZvhFqOISrfX1vx4bBBcnFi4xdTZvuQGxkKw3kt8BEqDskXX6j+kKhugD1IrdgluB/h6gU7nqPkyHKSL8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 36/70] x86: remove vma linked list walks
Thread-Topic: [PATCH v8 36/70] x86: remove vma linked list walks
Thread-Index: AQHYWX88D5AxfxbA7UKZ5+DppX12IQ==
Date:   Tue, 26 Apr 2022 15:06:41 +0000
Message-ID: <20220426150616.3937571-37-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfb71ea1-ec45-43a9-a564-08da279672b7
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929C5CBE20844AEDC177FD5FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1F6qrVWFWvPyilmfZW5nYZmgi5mTP5rXquf8LtQJzYffX1EwfN/6iCsIudDanEUE+ALKa2svDazgZO6Jtd0Hy6245As9LqLSOkSrnPjxPz/KL2mNdn9ZQYX6F5WPH1wGtqXRfuDGVHUQRtlFnOV0MhUDgAiyZp1uaV2XtlTT2o2Br9CmL3Lg7hVeFx1pN0epaOJnktL5TN4F6XzZWRCu1+lWPimV91QJFysyfFzHIdXnSjbqw+vndrQLEoDC5pGyD/Tuea1Ta5UGcALlyfdhSLJ+YG+GtJrYW2TMpJDSTFzLSPyIUEHLPVM+x6MXmI15VW4kMm/6HRgTLgcCOesSAnuk1VrimECIlv09PVRyMgirprEju+f+rqtEGJkZQlm1Hg/hNhm4XSR29GSTZzE933OdeOq9I6pTBIV3SocJDBRCeNT1w5kQHxoy77IraNwoRxWURjb4nmg/BHyF28SWSOhlVd6KCpj0Oe3KzneCvb3fBKUWWlDUPbH9p2qKC9o1OJsrlTc6rD4ShCx6UATNSuQo3qQObX1d8LAOZ5rmzgn0c+pRA9JxfDZiGTYFnIY8sa16X7S1a6Zd2Yhza23uYhJ0kJsWXC0i1oj2gNYZgW7b6YWYzCAF98mlx4sVXPh80KYoK+hdXVzxMlkQml113lPLZ1gBcD6X9L5aYq6DrX7P76rrAMkqhICNZXubm6NwTXHeVmrQGNqjXpH5cUO5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9dt7W3F+d60fWENef5t0mwFg2u0qBr7rkbjUen/GyoTrBnIS4vp/06e8V/?=
 =?iso-8859-1?Q?j+KyePQiXTySBePsUkOevY1bP42YIONw6JRctZzYDGO/pZD866o7sG3pUJ?=
 =?iso-8859-1?Q?Vs1//BAO1rrO+vKC3ycwRQez2G7iSo4tDAzyJ4JNEI7kzKdcFIJDZnNshl?=
 =?iso-8859-1?Q?c3XFYYs8NI3mXKnjIo5MyFBKjOQygFQo6IwQnu1Hd2PbkPIz4I8LpzwY56?=
 =?iso-8859-1?Q?KSmJug8pxRiWMFi5oKi4Sj2Qs9XCtrez42ACli7aHQk+czGDVamo/geAgM?=
 =?iso-8859-1?Q?TvCONhjjuYPpc9avRrU1Sd4Hx0SPx0tZmxWiqoYagfzY6MwrhGQdXjor5g?=
 =?iso-8859-1?Q?4pppKczT8Y7jr/VAO2jp5q4xW3BgcTzLFOTieGODTBFoa1b0horiB8/BWV?=
 =?iso-8859-1?Q?7Gqu5hR6Y4ATTVDesRZrGwRtREp87KxvhcAcAWi4v8KL6WXGIk5V1W+RKf?=
 =?iso-8859-1?Q?z2bOFcLOwzUx4cCWfls891BttqwWY+TGs6Kgg42O0S8wrZncgw0ibRMO7y?=
 =?iso-8859-1?Q?yKVxWXGokCZBWID/sneDMu+GJvSDXU0KI2Fr5y6r9jjkpg7PqC5diTPVDo?=
 =?iso-8859-1?Q?Pszl5qbutJ63S9RrnRKYTInKABNIpuGsRxtfhbWgAp6uX1jk1jbnjfVFlR?=
 =?iso-8859-1?Q?0GQfOvH6DACsGID5rEup5ToZqEBFE5fC13fz2HM9zyd2dCJrAeHjZ/iNS+?=
 =?iso-8859-1?Q?IRfhBG6qbIcclIrRbFMCbJ2d+PSM4Qa3yy1uvduwBore1y5izFQ6oG+DAC?=
 =?iso-8859-1?Q?c7FfunhHvJghCfUQ08QNqxfMTuqY+fyHjeKnmgS90vZEYFk5wIt7PjxN5j?=
 =?iso-8859-1?Q?AYyvpjgPdZtQjfs/wu3lVVgO+QHwvMQX7eD3x5t4aSTuHbbkKP3JEOTf6x?=
 =?iso-8859-1?Q?maM7jswwG+cOJrdSVLyA84ZLyWDl5uOo9nddEP1f77zJ5QlLfyiaP/WMLa?=
 =?iso-8859-1?Q?RIgVgvuj2Arvo9n6r1XwZhxCLfEuEw0WDoofmwqHh6sg1u229WlWQumbbc?=
 =?iso-8859-1?Q?t5+wGENGfuTQwaXve9PWBEPjESx90bGPoGqndChcjCK5t67MWg3YqhgPsf?=
 =?iso-8859-1?Q?66smDaOYcbQy0X877QSymtI8S6GMm1IRh9pR3SkqHf8mC0SnDsTVWl4YEv?=
 =?iso-8859-1?Q?4H3XuTVYbNr8eC5J8I7TFlbcaB6XwptnVCpfklLmWrrDYHZbi7zvD/L43x?=
 =?iso-8859-1?Q?2GpUVORynHbmWyKuAEDFTZuIKvaZEte02ZfUucwJsfHzJlH+3qjw/bSI32?=
 =?iso-8859-1?Q?BtWd0GcT0QmGpjGpf6M8ouXkRKFGBIk9zALu4jlLfE6hXClnMmtxdUJX/E?=
 =?iso-8859-1?Q?+ejHrGpasIIbzD+9G5ufL6dhQ1PqCozPGTf4hzbMEnc2wyVa3FoPrQYDU7?=
 =?iso-8859-1?Q?u4PZbAwAc2COTCyOWT0ZfmuKyQh4CFs2tX+Z+3UUOMr3maPgdrhGR/ot1a?=
 =?iso-8859-1?Q?/kHT73wHdsdK1M04hpGBvAlugltFvpGFRUW6cBtxwOKjSMuS/WyVbX6Wus?=
 =?iso-8859-1?Q?tuOkaCUF6wrqUR1AjUzJ+8D4F1GjKlY9JDD7XHf87+rksRS0YO6UMX8wTq?=
 =?iso-8859-1?Q?kM3xj0yMpjlmt1rfaK96lNj0uUd96Z482WQYmEesJOzL3nUSpEaI4x5vvq?=
 =?iso-8859-1?Q?yC4NASOSJOCxIsD2SSBC8bnuY58HwfwfXTqiciEy/L2Ky608ofcwURkYnx?=
 =?iso-8859-1?Q?NVC5vLuaOfkgtkD9Rql6dgCPSjncHXaPHMmFQrXJBo0QNNi9LrO1YBG2bF?=
 =?iso-8859-1?Q?2N1JVGFeSqjl9p6Bo8ntaaIg3Z6rm+OmOYdSgRIFWPfOIUZkd7HxPgMAUf?=
 =?iso-8859-1?Q?WaESg6ib14bnntBQNtL8n7wcWDdt6Ik=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb71ea1-ec45-43a9-a564-08da279672b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:41.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eMF7O2OyF08w4VGbj8Eo2CRbjlf5cCZS+99U9s0igLZN0ePv76JduHMf+lYlgQSmeV4dpO3u83wqbOb3MhDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: 9nMB0R4m-GvLAC8oKqhtM5ipytFDq6ne
X-Proofpoint-ORIG-GUID: 9nMB0R4m-GvLAC8oKqhtM5ipytFDq6ne
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..3883da001c62 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.35.1
