Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A64B5AF4F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIFTw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIFTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E86EE31
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IcnqR010459;
        Tue, 6 Sep 2022 19:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=idoEew87Hjf7xA6pxqvksXr8h04qShGlNXIvgTwfBS8=;
 b=ZezXEZqIs0Ep1pzdqlyAQ/9xTU3KZ9R4tv24CQRgiQ3MXxNw9KfFNze1IiaUYvPjMjlK
 Biw/oKUOAgaTxPxUX4Lj1T/8/AaH7xQoVQMe7E2YHXWOamwe6m8goqNv+bc+1iqaPdTX
 1UWsGRpxdA8O0p6IT1eHtz16h2Lw6Yw68hkYnS9jaBs05T5h3Sml+W+lKr8WZ8iv1dJS
 eKIXKd65YvLfGdPHTYwtvK3sO6BVYAIxBa09Oyb3rZLGeDdGoYSRbl/yQdZvhojlAMfd
 6VHlYhkEnkmZiOZYQvDI9QIvs3UIl6zIaxWMoih5MekgDgKUIWHGtaNfjCct4UP9g9yB ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspxcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WW039711;
        Tue, 6 Sep 2022 19:49:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbULAwpPnNXPA+U/smjBkoWQakbLIir8Mx8XcXhGdipxpELfcK9ICO4AgvFTOSOJZo6w4Qz2DetsJRXaH6WHcW+5Ux3wRN3vJpTHScmpEPDpcdhUBSN1ClEsP9R46yJsvSXo2bqoy4XjRNnihjJpn4sNsh5XxYwLQr0AskTKPSxu8mXR2GnHyKXaH8Az1dICPln2ACsM/5/kjx4O7SCHlZPlnL0XUUfqT+7aYa4CYT2zvjs7YisqAt2vhY+uqKL9La/QJlX06zsRdncWm9ghKmkZf5NjGM+jtIOFJpa1Gl/cRKK1+Z1T0zqp+b5v/lFnl3r6VPIqbpMSvITOgJ5nKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idoEew87Hjf7xA6pxqvksXr8h04qShGlNXIvgTwfBS8=;
 b=HNizMjzNmwLCP3QKUEa2Cwk/KJMAyC8oOzS68CEwYeLFBZEuG7sfj+vVsOV105kEiQ25zzhfj6L47KPsUc1Gasc/BhZd+Nf3crj/Ap1aN74ooq4cOuTbJ/p7FUVoirqXR6m8ScjP/mwV4X+6BD2/dH9E5EA2qVf5aFUyMk2HTtx8R3rpZcoXnfxRY9Yq1PMTOMbZIXOzVG2Wh51Cl2B6gUzJjKaAtjsewr1dEJdJD56mBHpB6lHuB9ngy0KFZixMnigL+2Kwn6nxSjr8CodnFRlW20NhZiAmrjv13iwsVckxesXHGP66RCkETT1MmG9cFyasQbt7RxqvYlQ20sYdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idoEew87Hjf7xA6pxqvksXr8h04qShGlNXIvgTwfBS8=;
 b=YQlq88epQppF44eZIw5Q4NsCg1W4+HwFhvtG5rAwrn1fcV5UlPHGhje3tpxuohaWuKekMMdHBcMYch+S86RIr2xT3fOQY3yZ0yMZfctGHxaxtvIL692o4iY5foSx7iXSJTLnqOSNyt7mOrAPgo9N5n2kFRKf8t0GeJGRHP3Z90s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 42/70] fs/proc/base: use the vma iterators in place of
 linked list
Thread-Topic: [PATCH v14 42/70] fs/proc/base: use the vma iterators in place
 of linked list
Thread-Index: AQHYwimzOQO3t1SRBkmj9rzSbIAvnA==
Date:   Tue, 6 Sep 2022 19:48:56 +0000
Message-ID: <20220906194824.2110408-43-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91bfcaea-be70-47c0-5cad-08da9040f02d
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fZawat5jDu38IdIcR3VrptQhS1MIW9gQieydTLEyqq5rKAr2QnOtvNi8PqGsDy2zoVax3mByVx6qZAlP1TTZKvcZ+3OxFuE2UI7jRcZTmonT1kimk3AyG4wWE+L9cOK/1+lRFxOmGUhuVI44LR2koI4rDpNPWw8w6C5Jh5J+hhLErtJEnS5JaLOUQmfbTnqafNJh1O57T7omqax8Rsi4whn0eq0NO0xOGkfB3QpwNBLktmFgsmIh9GWDQeqRqgkzAHIqKilbYJBltmJ/W5XdM5wpHUFdtjWXBpEdSbz9gi96HQ+ZtDvK8XqhEw4h6dDHa4xPp+S0MqfjRnu4NJqbeNtpK20T57VyYjHTMPnPqWga0Cym2AjS8wddujRumJI8Ij5WyhNotucRlK24jYl678ugbNHYlBco408xX9f4SCmhedHsoIiRsABVfvdBlIviur1zspEQQzAb/eK5rCk28M/oHcljWNxcXG/BBJoqDpBtpxqD6cN2mnMfCWr/deJmmiFZjAWzIDrVBviC2DRoUWMJi55zExlSv4zF0/d1JIDj9MbOirdy9SwU4+O9am2I8fYJ+717bE9XUkGabCZmfTnAVaN4G+KkQ9tOAzLK1OZgIKRxnSouWLZe0y21Qlz26RDHC73xxrkhSasyjrAELpOjftIrNBin8QhOFXlAhLUqM0iddGuLmyucFPoINIJAjwVwnekwhFTazNRj94+wVwfXjvM/pcub15MWE0OE6SNOzb6UFTnziJ7H5DZPG+wwr6Ea1A/1iQAuMq9+Rs6JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4744005)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(107886003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VSU8ITFL005sBpMUCRlqWG3jxUjrBa3AHVsMjHGmbuh4VaojCY0zs4wiE0?=
 =?iso-8859-1?Q?NtsxQUCN21bUh9WgKoxWHDeEcHc5ftTF6iU/yM1GxS+iwKSAp70IcrtUdh?=
 =?iso-8859-1?Q?h1fWJotfE0bta/UDF8l05Bs+hx8jRkt8THy/f1OgeVtGbhaM3HbwkDpZX2?=
 =?iso-8859-1?Q?N0+FPjjyzGuMf9OyCDgRk/B94KnX34O3UEbD1ccIevjfPFS24Vro9WfTG4?=
 =?iso-8859-1?Q?NSlC4FatlU7OivZDhWnmOE4RJJClBgCalvNsIzb8RIHqunWK9e395rnbKK?=
 =?iso-8859-1?Q?GzFMk9e/VOPTT0HdgNt+CKFrXUPmlsJlko09uyjBgRJ1FBEvejrnbFsfJf?=
 =?iso-8859-1?Q?ODfvWImaqAa40KyfjUauW/QKl+dOkC6Dk+HZOohWP/IMoSPXlgIsEkLTzu?=
 =?iso-8859-1?Q?9vuWwi3pybn3tUTbktahdgOejVuPTWbK/IiGbLc9Nl1ImM9UWr22BgWQ87?=
 =?iso-8859-1?Q?jWEvr3ZMSgst1QYNiSnTUJbwJjhEg1TOBska7FRoJDFfXIeMlzJLi9FXQI?=
 =?iso-8859-1?Q?oCen57UpgbU1MsebzegXybV3ZPL/HxXdXxZksk/Pgz9+6cr7zqe0htzXrf?=
 =?iso-8859-1?Q?LZ0kpOAiR0s3ESAsIpLcBvB3aq6MdFpJ6+VRe7ZUwizsl7esmCWnFJuR/2?=
 =?iso-8859-1?Q?COewVpaCimw5Ncym04FAphH/J+tVaDZ9muEZcptaOoPaE+7BSpOsOCEUWj?=
 =?iso-8859-1?Q?eeut/yh80ieDrtCjXuoWudPThQ7yLKi92ei1NEpY9E8AzDQngUGmcbvCLT?=
 =?iso-8859-1?Q?kKjLHrjwFYD6HyeaJ+xTdZYWSn4wbSIy4b04p+qzYmPuYTeA5iBeo2b6+P?=
 =?iso-8859-1?Q?qF0dJK5KD+wtroiHEJiRdKYUijJw0vVSIaXP0LYxs2VEdlhyGOoeOMqEXG?=
 =?iso-8859-1?Q?zpm4by5juG0L60mgIgqU240dAeGG7KQo7pOAIlRyfgaN6dDHZesM9AsfeO?=
 =?iso-8859-1?Q?S6qRhrgPOzKZYFTUkGkBZ4dpu6neNgoj9PtDs8AGDkq9Uqc/yoiV0rv/Pu?=
 =?iso-8859-1?Q?oszzcSeO5rw2HhMF4CBG2OIHEJQ/nnrCp8vGgKgGntp4mg1WxfFdeE9z10?=
 =?iso-8859-1?Q?wUVIn6sxcnr5a44DwTZkIRkSbywfHjizMEqTVPhvMPgPGZ+dCpcYS7ZwAt?=
 =?iso-8859-1?Q?4ccfGeY8Rg99EEhI4xEWyB4QQkJ0iI5VOhqA9vn7J/Luuh/ODYSpnfGOOO?=
 =?iso-8859-1?Q?ZpxJkmLGqTUrmnxT8pNbTl5foG0LXZtdotQzwjO1KItqJnZrggfi76Isbl?=
 =?iso-8859-1?Q?huzPif8aEBTy2eJ6sp+ryP0jT8Uv6QhHEqELpaGbkN+Y+WJxnQjqmMoo25?=
 =?iso-8859-1?Q?2lOfnyO4ty2hds6LXZKZysVl/uqzpMmLOYsN+LaQC2nu+1SVr0Z9I+x97m?=
 =?iso-8859-1?Q?+EITi8DndK7AAr9JrrgJqFN5DVWklXqLjphdXbXTGzJ5/zS0sPnw/VGb9p?=
 =?iso-8859-1?Q?RYPyuQ4oB2rNipMLg6zDPLa5Ig2zjGBHBV26ZIZHl+uNwd/v6LkczvKjHV?=
 =?iso-8859-1?Q?1HY9pqMzcw/kJTxBFYKQBoqa/7O9VK3fe+nJJvjdINJkVmJSgaNsUX/1GI?=
 =?iso-8859-1?Q?JUvQqW2HF+EdHe2vTNoLBnnM0BT77E0Frv1qliRdv52uPOFyN9/P1zj0qb?=
 =?iso-8859-1?Q?DFo9jdbVv/DidB+HmG6MAaSeUs/8YpEQhS2AIxqn2Bu2UFBYC91j/icQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bfcaea-be70-47c0-5cad-08da9040f02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:57.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEdK0KgxDnmsjDwNjbrqGdL12CareC18JB8RulTT+4P3jycINRyzkWp0Nsb0SWAwR6HIY0cGWxtuYwmSCnmb4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: lBYU0hGrZIldRPVxUZVNiABElUcxJhnD
X-Proofpoint-ORIG-GUID: lBYU0hGrZIldRPVxUZVNiABElUcxJhnD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator instead of a for loop across the linked list.  The
link list of vmas will be removed in this patch set.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..12885a75913f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2350,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	struct vma_iterator vmi;
=20
 	genradix_init(&fa);
=20
@@ -2388,7 +2389,9 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
