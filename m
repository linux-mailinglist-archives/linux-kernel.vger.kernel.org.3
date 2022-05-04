Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA851935E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiEDBTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245083AbiEDBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F14349B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243JuLfp004338;
        Wed, 4 May 2022 01:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=az6kkn91HJ03NGYiK5FWLATuZnCKvzxBoMgqzQtlc02O7UIvX3+SHKCPu/plNZfU989Q
 SLN+o0FSvbxphXf7QSuXLJIODIgnG6h1SUBK48orPwJgA1I0CywzJbbQV58xcnSkTXZA
 uTpQYfmItHcO82EiIk8AcIEGN1c+DVJ7uOZCSn8KuE01xzZG5Z1oi+GofNIyVQdSYNCm
 rdov5ayB+xSaEihMPMBWYTdgT7wSLJtEydOQX6JoNHBeFkaGWWWu9oNB3jg5m7voRDiP
 PtD6Uv1/mP2lJVoXb1m7diBX3UnqBXEnRe9FgqRvLu5TX9ZoupAl39WCR29d97RHtDVP XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f61f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441Ato9020100;
        Wed, 4 May 2022 01:14:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR+BbOTnfFFCN7TwukbX+xWkuzSsqnszBqD9GgLcru9fKakHotn9aswOQWJAewFcIYHbCWwa1nGCigBhIgALYkIZ3/uY9V4Ay0m84ASci3MmJvnV9t0r9iev41zFPK60v1Nf6t7liJ/McFrVYcBapADutBYoNoeRU5ORaRYWARCI6acLqz7H+uvvudHWM5zllgufU6eq3+2iQIBk6mJnPZEROaVYddDa7CCJnLTCWCamoqEkTPosVM526Kf/aS2xU2IuVXxbtzn5uXPlubmeFo/Gaf2jz4lFB4JtkyFDb9clpuD5+n6SV8X8BH2O6mTKvZ0wT+uSU56vXMiBQSJ38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=IhDyyktxFzzaFwdUo+JoTdMPfSYHqexR3Bz9zsD14yRlVQzV+S6Nq590/wqaGyBTzbzpolZY07W878ZxVP3i3V4I4NuU9Q/NXAMkYJ9CTuETBZZ+PtxeCeQucuhFC1So/y+DSTH5SNBTGZVuV06zQ7kYjQmMHng3qfoSZHKTaRVeouDm7+JZyqBG3H2KgInEIyjOai0k5X5hex6mJab/9Ji1m4vROqv3Vbfjgu8GYk/JcIq7OIHnKNoUTugr/9rNWQRmHZOLXwJxeBISP9HlY0mvSVYiNZ1lrC9ScFh8t3Ka9VUZgWRYyCXZNlMWMUsbA6o8UnNUyL1ty4t82Z3wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=GkssRra3q/3OPQS7WeEdSPJcwWzAqyiKFhoVetzpEJ5zfARGCVhjYBQ9nuV+opM9huUwO1Cnwo1jEZuoC3aOp5nmRUPjXmP2q4f4qzuDVCwSqL4YPMBYZfA0dYM3N02LS6FIP+QXmdu3BJFhZSa5GatZc6b3MKoFfP4uEZw9i58=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:13:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 36/69] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v9 36/69] xtensa: remove vma linked list walks
Thread-Index: AQHYX1Q6a81poYYDo0mZzBgYfFB8lg==
Date:   Wed, 4 May 2022 01:13:56 +0000
Message-ID: <20220504011345.662299-21-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7ae5482-499c-43ca-c682-08da2d6b5dff
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728ADCCFC4E296520EFC9C3FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UnxHNYWQP7V3ZLvzhP5r0o7YUht5CT8p0U5kWq58u4+xc+Ut7jpsloRideTCuy2jx+/QyM92CSSVDqu4+3Wos/YWI6xf4OmQgfURNW711Qw/aDxswwkrqVUwnYgNe0b1N8YIthMmrPAoa/3vDDobB2ZGpwn7fOLJ/MUD0i9os/QaJKld+m/MjIyCGBq48G/lWx2rlKV99nOD28Q+o6EkdvAh/5tyjY0kFhefWAGh8VD5zMel3dVnjdrBGuKG60BPcqa/S+iPGgEDo6e0R/t75qaFB4W5TkxMyJh0XJ4GSeewOCxdwDN3KE1DwOxg5FPbzfd0UoLBOlnyG9BwQ7vHSe1zDvRa7vqVzMT6RG1V4SDy1bJVY6mayNmUnUD3YavBmhFEb6lmnrSu5bxUrmLDvm3eDYlrVPE3pQYQcfOcuxO1DG4lE/RxykDK2H1iZVzhCeIc9oTQDhvvRNaHsQLBo3+/1jpbnPXrQ2IgojsHJcD/NInlKHRffqcaffPtbha04QXzsrRpADEmiNHv6fz8nQteCtdpYj+5ZqK4yc5Iq2K2GmaP3XOMolS+bbxhAk8X6EwENg2eD1sNjLAvWIep22OFyn2GsripjssbZ/u5/R6TVIsXEoCiOEIY0anBi0NW4Wcfp+fOm/qiCZRke9+Mu6VMA+7JcOAGx5IDyf8IMF8rGYHRHsS22HQXuQalU0infUH0zsk304GLORg06FqcXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J8eVd65qjPAdGv1OUbqFdfRJXtWTuTsd+UaQmmVaFZ8x6BZhpxJz3F4Akq?=
 =?iso-8859-1?Q?ztK5AdX1f/Zy3RY1FgbgwASLd7144c3G4CTwtyCllc5sona9rqjopbitpn?=
 =?iso-8859-1?Q?foiFMhv35WN0nDsVIhO5Gz+euHMEX8oxeYeOeYTwHTIb1ugxBh8SgqcS7Q?=
 =?iso-8859-1?Q?oEfH9z2wxJcUwwKKl+Rp+vZ4vMqCHvSQLCF5s9zgdupxYGAbA1WQCvvB6H?=
 =?iso-8859-1?Q?uoReWjwCy+8c5L9YElVV/Q7g7e6mZ+s7Hp0m6yEXyfMnaGcNVy8S5gS7Fs?=
 =?iso-8859-1?Q?yCWNCyCtWWBKmL4Q3EmskPskTtOx+L+ntiFU3NPrmB4NupJkgsmba16ZKs?=
 =?iso-8859-1?Q?jOw7DUwYdBD7SHP2o8e7ZeKQoCrJlevVYxoDauXy65yAe3hzCZHdnb2ocr?=
 =?iso-8859-1?Q?rRMZANn7M/vdW0WbHisWcr0f7K7Oms7ANo+V9FdYcM1I1PL+/8bHI6k3nY?=
 =?iso-8859-1?Q?9+U4hZOw5kO2E2sLl3jqsn2ElzlNTxZIhKqT1NwkaN5BjRSEqIMdr9dIIR?=
 =?iso-8859-1?Q?gkjJBrwPIWe04mwUHjRGEL3iJ16u3WYrZcyIY5dvQyF8s54UIr/KkVEuWf?=
 =?iso-8859-1?Q?jj1uP5Mi9JURXwCQEX3SuqLEGA0v4ZZC6T1dEHnsnRa59+mh42bRA7jJII?=
 =?iso-8859-1?Q?88wy4fCmn+gzmY8V3qZu0qrlibkyIuVFiaxuyqYtCleylj+EU/mzZbcQ+t?=
 =?iso-8859-1?Q?nhq8gSZjtRpGwz7mlroaQt0gx4Yr4b9PV2K79jgHJSJBSafhawhwRMLEPs?=
 =?iso-8859-1?Q?v9Lww9NWX0OJLwK2Zl77UyQR+siyNbSlZpj312PTT/XmbCAPCZIuNeB3vc?=
 =?iso-8859-1?Q?eIAJ9vbv9R/yiE6i+qE1WA5RAgZLM7YbTVyUbONwXIJ2qulbF+hqMZ7m5s?=
 =?iso-8859-1?Q?N1VFgjmzm7AmNHnneYOv7dJ24bjKG8g+DNWcoakCizam1EXWPSwMNoKbLl?=
 =?iso-8859-1?Q?hg0pEdb9ll7cWtHd8MdCZsXLyZvORLBnR+1GmXao5P+VgtxHRza4tRISLh?=
 =?iso-8859-1?Q?7rIlbEiNkCVPWFbndcKcF2SYilLgnv7f4oBvCZT5rv87hhCW4A49WyCvkw?=
 =?iso-8859-1?Q?74Cb6gnNvDLhXzZZYwUXYgAE51cl26oF/1Ypq1XtqQ9HLP/GHLv2pLQpJJ?=
 =?iso-8859-1?Q?8Me/Msq3AOxBOXxtlAI2eeO/cEt61igLC1l40D7eRPlkKPtIXqul/tdQIU?=
 =?iso-8859-1?Q?UL16NxsGuxTYUqFqPse5JPlinKb7r0Z4q3vmxxQTntZtXKJ/eWh9z12Vb7?=
 =?iso-8859-1?Q?fwo7HBsh0PL8oD+5Gap8QX0tyb6BNQew5R91gENywTn9duoCeQ33c4f0Qa?=
 =?iso-8859-1?Q?tQxu2wsfDL2tqLBM00KugByoDmEA7SIANQxHgWzf8Pbg8wxwCCn8GHfBdO?=
 =?iso-8859-1?Q?K5viDGEM2W4pB53ZuUzqWnSHpZ7e66BnqWmsigpJMxw71IAxIJSlBhGk0u?=
 =?iso-8859-1?Q?WFqlpZljgzAtoG0MxMyD0WDKmFOFxx9x4z1+4vuSV+n3lbE7dp1wLyBat0?=
 =?iso-8859-1?Q?u4Q1EBqQoQK+UG9kN8v5cKzhCzO58IhGNSn0bLc8/SZTUoshWnjCYvzWL2?=
 =?iso-8859-1?Q?apUVvYO56LlwK5stfkgfPc0HiBLTHeI48c7FOvLvzy7e9ziaGENa7fljON?=
 =?iso-8859-1?Q?J95KrNrYQby7id71TErgq7ghKpZAgLXB2QJcyXNHP6fXxq2mQMcW19NU0D?=
 =?iso-8859-1?Q?D7uba9ISqvPvpn3fVxzWkKmNy7dbvTOc60JUXeSlDSybF7Ajyi9QsTPhu8?=
 =?iso-8859-1?Q?RebjJfvuQnpJ8cCJy9lnF6EgJDJhHb2/mbE9X3Eq9qWvs2HrgPQXv+EiZp?=
 =?iso-8859-1?Q?/hkskq+dU4XdtYGtOzpuiy6mWVTeAZk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ae5482-499c-43ca-c682-08da2d6b5dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:56.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/Qkh5VGnx/6a01wK8EFLDA+Npc4hTvFfWE8YKpl6l0WmO/KpNi6FESJuRcSbkq1seuvddNPAHo9qtvDSTEieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: BufzCxdeI6d9E_nr5ZdbOk_P5uA9CDSX
X-Proofpoint-GUID: BufzCxdeI6d9E_nr5ZdbOk_P5uA9CDSX
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
