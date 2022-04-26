Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE351017A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiDZPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352076AbiDZPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E739B1597AB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT573025802;
        Tue, 26 Apr 2022 15:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+/255ZFn2Dy7ELHirKtQLU6dUv+BzpFOR3mWePFsbuo=;
 b=xvygPsHCbfiquPJXsqW8JniRiHg5Cg/RArLS3VU/XjhF0encHbFTHXwX7iWgYzf528RD
 QC0P086qh2FPzOGtOEWElI1IgUtlkgQK67+9SNGPmhcu3Xd2o/93PPrBzX67DtiNzmjZ
 mfiTpWbkb0OdGQnkBupZCWAcKTo3ZT4wlkDycCsvqpPp+Fuk1xRxRKLLI1YKC9dMlwaH
 ziLi0TdQYnv3f0ZmRL7PjrmI5dBv/TgySmpKCiPLyw6KRntj6THIglkgFhipARqRCRcw
 Pr3r3CpfknYYoDKtBv4NuI6HYdyj2+/ynQS5SxpUna5OlN2Q9J2FQKlT6+LTHNw2Srh6 ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Us2037859;
        Tue, 26 Apr 2022 15:06:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeuadKsBwZDJlQKNADHzN9KtqdUiMTDGMMcNXaes9KbYDmaYSF6kzLMACP08h5C4PHe81yHAadR+fqe6Cnaa2Mee1uPHHzasFzkVs8lZ3t73YBktTMS+T2Bc7lm+2A3bVvQdTSs9US11GZ33yz7Pky2fIdo5tYJOkPR/Yeq2ywb/zx8DHEq0HeBBKc3/m1p9qko+ns94igc/1SSURr07hk81IzM01M5ggdsLr+W8TpOEUCW61K9FcvLzocI26T9uiu2rAr6CyGnGgNtbR0fg9yOOfuIAeGjHacotSSr9BWl+vHm5cMF+WAnfrhc8Wuu1uUrhcY0ONPPq/L1SziG7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/255ZFn2Dy7ELHirKtQLU6dUv+BzpFOR3mWePFsbuo=;
 b=MDXk3FTeLDaGDHNm8QpmFpoyrfXlNCWI0qNIGBvGClaVj/v54k7lEy9UE7y9HZk5aRwltFFXeP7JYwru4nuLMkWS/0ul7q+pBiLNOjobbu8NgICpjlfTV8etiN0tbZkmaShIrNsrSNUg3QhO9fC/eqfaaxVYgBU7quHZwkkD7y0OHfUBFkoktUwzYfUiHSFcr1sZIBOKbeJ7nHNf7Szw8/fNEvZhRH3E8hV6gM9qTW4uRPktSc18QI0UM4jVINAMpvnSz46IvehPoPuvidCT35cOVDXoPsVl8gVcLzUajYl7XyvbOYz1kn73H2PWjGeOS84iwgZSm4z6fwHidGJPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/255ZFn2Dy7ELHirKtQLU6dUv+BzpFOR3mWePFsbuo=;
 b=ir2h4+L/4VBbQQT1fWTXj8ah25fWSkkh+S1rYGiujqeNZBGKUje2+55Dx+I3Yg808/eJjGAMApvb4bnzTG3m1l8NQa+0Wuapekf+2NW55Izs8A+JnebdBMgGtPTLjM+uCRAZAAHvpy+aNPQVW/GlLhC2ffbqo1mWaHSbXD0vV+k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 22/70] mm/khugepaged: optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v8 22/70] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYWX84oewkfdZkHECfnugXoW61Gw==
Date:   Tue, 26 Apr 2022 15:06:35 +0000
Message-ID: <20220426150616.3937571-23-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab3d9cc0-f5d7-4f65-d139-08da27965b6a
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB46795D49D5F60E6AF59B49E9FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFHHsT61Fkz2MKwAFwOx36OkJx1bcakctHSlQmtBRQr4F4gaNluCQZMs5W9FTJ051uUKDZPUwExNIXYXPnGVFO2odLgvukygw0/ngBs2sexhnQCnB+wgZIZyxm3cYKiLugi9j+xQIZMFkHhf/kzUXEUNsWmpXqdchekM1B5KYVIpWPodm6A866rAfyutYUWb/lsPnO7grCg7adRlUzXgZ7XEPwPTvnkDeOZ0AYCbIOCYARIzcWhjHpwvQaDCBkzBi/WYl2eU2yfBKu+dsF6EyrNYKDEC1s61x8J4U+Skoofhk6Lq1TD7VgIsFwlRwg+Ltcvx+4c1QHRM4562B9HueE987JQOcGhfKEI9uua52Idrjr08RImi9ET/LX4zqiMDSZe4FdqhlcQouGsz8Of3D1dhvmYWjL7dTZVv0zDxIsiLUn6HokhWwGwDbR9n7RvtfYOAtozorzrImyM+/5/CQ465zMHUpGr59hZc81MvJ4jVlGa8cv3oEw/1JlcSRKdyizgosm6P+Kml1rCZiC9jdFnTaQsyichxjTzNNe8noMPqjaCuJ2Cs2y8fleqn1AqHwPBkLoTxOGZ9yTnS14wtNdcCor1YMjY80fWwhcKdrxpXn7omo+SvoAbB9vzjU0HxgOYz2qftfontdZniN5+PAzF/IodvBNkcoxqh2t8Slfb234lq+RZkcP7/euWc+xMsDg89wpSRkRBZs+t4xvXZ6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(4744005)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fUMFeDlLIPBhW3X56seuwL8ecEUN9/PlK0Yv/w43ZZArSN8wMESRaJEjko?=
 =?iso-8859-1?Q?mO6CH4cWqznzbp4ulyc/kPBENCZBWQgn1AWBx3ASvOtCeEvqrpifetFyd3?=
 =?iso-8859-1?Q?qoCkH8inhVpS+m/t7ChnMr4r6vZvVLEgob7oZdGqjEqNIlYaRzZP1xdBUd?=
 =?iso-8859-1?Q?hRUvcpOUyZiOR5bcCAB9rDOKpxc/Y6VV4Lgejmc9gVJoedXAq5Yqe1vxIF?=
 =?iso-8859-1?Q?Avf49jsR1r3SD95T9KWrGYRXSpbd62N5e2htxpP/YPPmaVvAWN8UiSMhsU?=
 =?iso-8859-1?Q?ud7ew2LaA4OTh2xNh6vIhXz659O67VA5VJwcIvurT3y43uFUgtvJynM7x2?=
 =?iso-8859-1?Q?vsjax9Lk9+2470rRbVCY7U8UQuWDXv8ieACM8VrWbV3eMHyyDxWkSiGFAq?=
 =?iso-8859-1?Q?3kdiqM6k1sOU5AKnDfWiRlVSxFjhIb+RjhftLar62GQYpVJd1vj2WS4bXM?=
 =?iso-8859-1?Q?CjNYOIs+94EKVg0mJcmoY9X4XrwYEYhMKLdryYzrLoV6dBztAgxxEN1I0I?=
 =?iso-8859-1?Q?VW7wbCtDSovxRjn4uQB8FpI+iNiGquqdLp2XfbIUCbgMCV14s91SowDZus?=
 =?iso-8859-1?Q?3RLzndwaMziOSXBc7gb1Ry9kzAeGrmDDdfbAvGclg5vmEQw+IgXIiwB2Ch?=
 =?iso-8859-1?Q?pqt81PzP9lTp1htsocjzLl5/HpewCLjfZfUzHp7POGA3229weDsnJgm0qD?=
 =?iso-8859-1?Q?rm7GUWCxrSwLkUY2x1kIgDuqH2fbTeLtexQ4KmlmLPVDDHbcwXhHCwvhEq?=
 =?iso-8859-1?Q?36Xr1TpvWiSWzEnL4T8924WZwm59i2abpmZ6UASI8bYnhR0436PpAnT2Qw?=
 =?iso-8859-1?Q?6Lhi2SdxMBC6sptCajP7KLpnSli9A3yEXMca1HTnSk6WkTjsQUttSHtHPt?=
 =?iso-8859-1?Q?zr8nQ1xDRQFDe6RfpvKEZlFST+qRmMwxf0Jhw8IqpVKhHtBbmtWnF66g6N?=
 =?iso-8859-1?Q?y6GZwiW1lPhL/J+HJirsezJVPR/MTg50P5J/5Ib0qEWBBrVaNQtjUb99el?=
 =?iso-8859-1?Q?BSDuxG5qBsu7FBMpcowuQjwcDDjAlWB6xYQkEdHHu3nbI26mj98HAkbXPa?=
 =?iso-8859-1?Q?/wL9jrIs2gXxGgZq1UtMwdzcaHmq3lN7oROk1M+/9Q88VaLZj6RLku/TQD?=
 =?iso-8859-1?Q?GG6QIGa4Nd75Dixu23ujmKL5sLSGInmQc1DPQGPb3UemozQLuQ5JxozMG2?=
 =?iso-8859-1?Q?mcEmL0wug5Q2ZIHMDpMfTp1lIxcWDUYNUYcygrJMq8b64W20fPMGeSW33i?=
 =?iso-8859-1?Q?k3/SOLeGLYcyjDwcvNRl3PGp+lws6VIuUR+KPSyNsAmOBzeZ352bpkeAt7?=
 =?iso-8859-1?Q?i6VH7BNjU9zYcj5bNJ89hLfO7V9Dp4Y+tJf6SLzYGx7EVoL44N0tATk8DP?=
 =?iso-8859-1?Q?D3JbT6dMzG7zQFYfgFAr6FrJS2kZ/Re5vSTXJ9n8C4RvGEwuME1TCkhgaa?=
 =?iso-8859-1?Q?J8VYe6jlNHQOrGfI2hxnESc6J04e0jHyBYdDe/A3YE8I4N2Fhehi+zGhl5?=
 =?iso-8859-1?Q?K5a1pstm05FaFYdfX/SK9YoPdNfeYZTz0Ay7UyRFhmdX1E5C+GwJnHCVpL?=
 =?iso-8859-1?Q?y6HEmh2U2+TqO2+flRQOlEiucknTx+qT25t8CaTGaPgHOhn8IOtqvkg7yz?=
 =?iso-8859-1?Q?p6Beem81oLx223PFVpbLm3P6JM/BBqXcas+9FCBOuoXUoCf6rQPvFwdBRk?=
 =?iso-8859-1?Q?104dhyb2ZyzWT+QJlJ01pqqJK5TmiP9syZg/Y5Ss9Re9hoFbTBH5MZEpZg?=
 =?iso-8859-1?Q?tWNXEmlLGbGgtebgQXkNypRMl+2CRF9tZi6kq6ZDJuFUMrX0+sRgiLGJow?=
 =?iso-8859-1?Q?ibEiasplD2OdsiJqer2VkVz6ffItioE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3d9cc0-f5d7-4f65-d139-08da27965b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:35.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wf7tXnRvGPinqx7uzFLMlbCASX5Z2dn7tcEHFI8gQ2C2+LMi0wctpGvok+X7dGEIraYkXXKkvhVksb/8QQKl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=852 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: 2R25wEc7Z_Q9Ip31y0bjqqluXxUus63R
X-Proofpoint-ORIG-GUID: 2R25wEc7Z_Q9Ip31y0bjqqluXxUus63R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9bb32fb7ec74..2f6e4d6ffb79 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1435,7 +1435,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.35.1
