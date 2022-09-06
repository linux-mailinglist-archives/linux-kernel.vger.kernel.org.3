Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942EA5AF4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIFTwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIFTuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F185B796
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9bS020014;
        Tue, 6 Sep 2022 19:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YMj3GXtekin3jgqPLuCiCeXvpZpen2jvoaIRZr4+a8U=;
 b=HWi9ug7BSv+9UCHqPDJA5b59Ecl+vmwAzKuprwKKHKHLmUlaoVlzVTtSucma1CxxZOUb
 X2LTijjnYhWaJ+hHPb66mmQJHOBNMES4n9lsFXyv+p/nSTald6v58lsBKg8F5PQ9fZjV
 Ef9ZAMm2XP9FWFd2TUJCzUQa4v/3NtAIYLmFDdOesW+ZqwOFMU2zYtnvO26nXGuojc1f
 NZ5VaVo5y3DC6MiLiWO3FQerj8Omxo5MCVueSpDqnOzqewdOk5c8jJqKnrnsHRdAVsJA
 MLmAs+WEMh2uGxX760ROrKCjIlIEJIfelFe9yuWwbVZGMoHdy2GH+P2BEdCzeOfyjl+/ kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JLGjo039722;
        Tue, 6 Sep 2022 19:49:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7h2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmmw5mu2XGFpV4pb77sE0QzN0w4+Djny15JxR2plQG6Gge2xUkVev/+K1HgDB41qAWzU0CkxQENiCdx5EsEaPtINhybNDC0kSG6eO/jysq/3l0PaCTr1jX2HMPqt5NMn1oYUe5sWKeodf+8MrfZpnI1i7s8diivIKhN+861uUhjJUDPz10xT11NunEzWyoVnvBUxta4wLrDdalSh4tdYpSRu/r4/eddehcZPBK0QG1wb9Za80DtSWSzaZRIkD9pnoDecmqXJ7PHG22xAsd4qRW6N9Niy+rNdpvHZZUNuqBsHf5FcQ6I0yf5WW4HhHdQt2SfZRg8NLaZ5RZzAheFu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMj3GXtekin3jgqPLuCiCeXvpZpen2jvoaIRZr4+a8U=;
 b=U80lp7q4PKPhpQiZZYN/Do6OnwpNwoDeZzOUG7KVZRUGDRYpz0j5ZEjuFmEq/yFzRUadfhDG6ig6P+C7FYroUUGoQh3riOIjgJhwjjEQIYN2lp40q4jTX3qGp3cN9B/2HnKNpk0M1gxczmsLNSvnyRFW+19b2KIFcU0zkVKNysww+yehS1zPl4v9ffOeUx+w9HZo4BHRJNAVmoC8OZ59fQ6gi+KW/NaBJ+oop4BWtQXYQ3QQeKhthEyxqhsl4ffnAKCfBdr+7zZGkF31hWPN3KxctSl2ltC1N8fioWbV5XwhftErR8KUGIlSYBfjSR21WgjgP/hVwz/b3TSrIse90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMj3GXtekin3jgqPLuCiCeXvpZpen2jvoaIRZr4+a8U=;
 b=hdTdNSjRRq/dIi1IhttJa/gDIF3DdQLY+zJmJmwn8zKR/uCC35FTjhxriU2Go1MxakoXFfed4nibFKhojJxwqle/lZrUm7pyuv//ShN0SEYY0WyPJ0KiQe6KfaBvT2qDEnttNnolKGN3GLVS96iIYPs6iuBcrUvTSwh7XOYCKhw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 32/70] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v14 32/70] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYwimxiIRH/grlk0iNCqbjmGtuOg==
Date:   Tue, 6 Sep 2022 19:48:53 +0000
Message-ID: <20220906194824.2110408-33-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5842a511-8158-41b5-5662-08da9040eced
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lV2ia5z3ppQGT7ibIhYshQDZIeASZ4Hlku2ThV5G7LOxcX58NeEK3C1n4l78BKIehyyOASY7dhncDdO5r+n2lFVH9Q5FYHwik7fsftqWMc+pOVkg8YameJLVWpKfFoTt7BG8M6ZYbB/0dXKMEDy3u/ndF7CoaMrXYl60o1sqAXv6soIhLAbnDJ2Q2/J0qEG123kUQmeflRR4ieZ5XjzcRLeefrpRxIx2PXxUQxU8Xxtg1OugzyzCUsxsVUxYPs2jgEy5gGgE2dOAMKA+uTlhztz6shQeCT/4iSRpgAHm6vBoT7BYxFjCu5yTc8eqroGEhyyg936YZ2Ha+IRnjedKeYjN5TOLznLWt3IMLhcrFk9fCw8lVaHBF1TZjwgtamVCkmAj19scj3jcoYqq9DbNX9/60VrVVgve6I2UrK3DEVvkpvFj1oQFdAfmGeZKZ7MTKtxmG4KRkOPpcPV3PXQWBK8J0XrfR44s9AinZOnVaVUDGqfBNAnfUA2sx7ojUd6/l2qO2I9QAFRq6YmxmX3q3xMNIK/CAQjso7FCSs9GCejGkxr5hDv5kWg4UYLmqOLyWYiKHIZP1KX+ZQu5aHqBkJKEK/6wLD9zbN6XYIULWmYe788W4zFSMlvciYsv8/eD02kOnBHpBEgdwT0MWN1iATFu/+XQCaddd2YHbKZ9GFPCsMFpMXx4frs/FPW6OosVrxeYGrC2/tx/TohQ+cglQ8I3h0DgNTw2dU8ZqBqthhtV5sCU1a+XFOg8gyQ3DrYHTHwmoV3EhGnybqUpNZt6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9IKeaveOku8mghwl0qzUOc+nNu2DQe4XKON0s/6NyqCkmY/k9INHwWp2lP?=
 =?iso-8859-1?Q?caRPfLmGtUdF2jO11I9D9LP0/+iaKoGP1LDMCzGwchAAMXki6TI32e++D1?=
 =?iso-8859-1?Q?WQXa3T81liRxA+Go0fNdBnV4NYFATuTGSiHPyTIS0FWttMq1uUzJXZnYxL?=
 =?iso-8859-1?Q?9HQOeqEYs0PhVcywb1pzYOuEvq1rUTWh/iWr61R4Ld+xW8fdjocCopQFUj?=
 =?iso-8859-1?Q?41bvAq8u8kFCK1Az518UOFTATxpCvMVxzf1jJ3zUmDWicP5LSfl9jq0Dia?=
 =?iso-8859-1?Q?BkdCdfBq0sb7KcgHoxVCVBMJi7RM7ZjLUN25tWfaFQERxUkNAaMUIpbn14?=
 =?iso-8859-1?Q?TkUzyvHxVwKYbD0PUrZzz/sAqXzRS7tsspz819wNXUqTQ0/NHqWEQEniF6?=
 =?iso-8859-1?Q?5PGj4847QUtpuKLfCGyhz57PMm+jhSObXD1XDegbjuCJIGYSBrej6xUw+W?=
 =?iso-8859-1?Q?5qhh42bZzMK5eh9rSb0rps/MHC2EW7onxZrGLdcfhu4ABKbVurmbAvY1L1?=
 =?iso-8859-1?Q?PQp8yB7aYe1D2S5AF39OgE5GPYr5/QwqAz2ML8FiAL5EiGl1azIdX35FhX?=
 =?iso-8859-1?Q?3FuE19FChRmEtwjn98rbDEmL3wX1yNIn12cbsK6szvZFZ4iAVJozE3EH0X?=
 =?iso-8859-1?Q?1FPLEeQ4/2zhOT23LD10PDjxm2mXihLM/qv6UeUB6WeeX3H/w8kp/enaYF?=
 =?iso-8859-1?Q?2chIr2Dc3mpHeFdzgF8FhkzngeJblFg1HoZQkYKBpnxRjx6JVh+/xRbjXL?=
 =?iso-8859-1?Q?LXWG4EcR20MlY/ukyCE+eNnPibHzbFbpz6LiiegH0m5KVQLtVNyv4DShaY?=
 =?iso-8859-1?Q?Sn0yAp2iGB9DLhoXrvQTIpzPD/3rMI6Wif5bS0tb5aYjWvpCGE4I6iPk2W?=
 =?iso-8859-1?Q?a/xYUlYniBLBi/KXy/3pGsPQKqJaTEymFwpY2yq0jJ3a3KGbclBpkGobPy?=
 =?iso-8859-1?Q?0lkY55oIu77FEGUKTSrBAOVC0HKweodANyfUBCiuIRrhaWVMBEjjPjpt6K?=
 =?iso-8859-1?Q?tlXVLnlxXbHhc6hACgco8LQjjtEirX+qYThC7t24I3rI2QPQT1XzV3U5lS?=
 =?iso-8859-1?Q?MpVD6EkDBZueO1QYuXjudW7EK1j6EYgEFCsUdY6Ket6NE/0V+ZO2VDtHGP?=
 =?iso-8859-1?Q?A2aAd/xxHwdlGauEqHlnJVRrLnFMLJjTc0ojg2dHw43BQaUc/Gd2YKz4nv?=
 =?iso-8859-1?Q?omKmkG7OkIqpo5icPwaNFVbzMoqAWVA+YiizMOdcQvGhz7hAKp5tSIEaAK?=
 =?iso-8859-1?Q?OhenGlVxCancxw3u6zXL/uADqJQCc0viXtRFzIhXkcSlo8nvTICV88kety?=
 =?iso-8859-1?Q?pCXndnpC1LPV6OVtu7UJG6ifSpLjwf4mvqass3czZs+UcBjk6Qu5b8IG24?=
 =?iso-8859-1?Q?6/obhiKlbniOfYC2ClwadigxktITvkJIa8aC4c9MkxI3pmABxIJ64L/SNR?=
 =?iso-8859-1?Q?z5R6vDdZ4tuFu2LWD+/0h7snuAG+eOokOHnTsBE2FlspCBEnOIDB7xFdPx?=
 =?iso-8859-1?Q?r4yqBCyBDYrBNuQPrtiZmyyp51V0bOAmi/GWMFSVRj8FUtK9w+Mdj24G00?=
 =?iso-8859-1?Q?iWYXeoTMrqCIGHLweJ+XR1BgOQGEH3TE8moAZF7TfJVUvZdelEtWAmtyIW?=
 =?iso-8859-1?Q?1opXWfp03QAb9TcFViKzrzYOaH2roB8z1WgsyrASqoMEkpv+wjwacWpA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5842a511-8158-41b5-5662-08da9040eced
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:53.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqdG1KMXxU73b4Am38GmnZUdFDfCox9dX/bhjfw3DHVCROHaJPv2ULfqdZ+RvVFY0Eyl1LUzNJBehLSUoFMeiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: Il6qHXq5clslxiMkC9CDAekFys9fxJ0I
X-Proofpoint-ORIG-GUID: Il6qHXq5clslxiMkC9CDAekFys9fxJ0I
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/parisc/kernel/cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 3feb7694e0ca..1d3b8bc8a623 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -657,15 +657,20 @@ static inline unsigned long mm_total_size(struct mm_s=
truct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma && usize < parisc_cache_flush_threshold; vma =
=3D vma->vm_next)
+	for_each_vma(vmi, vma) {
+		if (usize >=3D parisc_cache_flush_threshold)
+			break;
 		usize +=3D vma->vm_end - vma->vm_start;
+	}
 	return usize;
 }
=20
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Flushing the whole cache on each cpu takes forever on
@@ -685,7 +690,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	/* Flush mm */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
