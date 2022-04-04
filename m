Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400084F174A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378140AbiDDOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378008AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE243FBC0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoUwP014716;
        Mon, 4 Apr 2022 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FgYIY23TOpZjPmmyOJhIs7xgNP9Sfvvt0o0r/9duqUc=;
 b=knkoOF8wywUPDFxEPFynnLEem7qD8MkG6aT+nz5cUX8F3iOtYDN5S8RoVDZ7vytwV/pv
 grdrlxG70S36l7qT4uWJd4jlP1xyN5iUFXr+t1a+IW6SFhFY2NGAdp+hVaqTBeLG7eku
 5zQ5nZO+mG9STIdYqznHkI/RYXZlqqPjw5yh29tcdO05z2JkRnAWKjyizX/hONXbYcyf
 35cnEQ0NbvSa887PhoElEyrPxS+DwzvC2Tgeuf98xq2Gwh5xEbqYtc+XiF4FaAMsDYRO
 FMXoFO6rG8rzJvy+Jj6+ZDx8/wvnxQ1xpYGaa0TCAY5SufY+KSgXegnZpoSAXjBY96wo 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceU027671;
        Mon, 4 Apr 2022 14:36:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1C2eUapLA1n5vue54JsBdfz1G47YlTo9alqanYrtltQAIe2V3Zu27Rw/AkmaIFOYqbsw37BTZ0+62ijXk0yKAKNZCmqxTblJj1uMhSbT3OP2VVyiN+lPfc8NIhJcgObNG1uWTRPM8S9xNJXF/abtrFcj4TW15Oeds/IGCV77ulA1033RJq7kgXAwZnDDqOmECjLbzDYOBy33Yu2SgUrOq85CZljMF0wWRIO8GMvhyXtXEwLMJz7ePK+VoZXOZByQOVfBpz7L1isoy0+nFku0AfalER97JfNDvOfC7OUdDn0103i58enCCnBakKXu8Unqpt9QTj72kRbTTErTGIZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgYIY23TOpZjPmmyOJhIs7xgNP9Sfvvt0o0r/9duqUc=;
 b=GLYoUyk/xD41QFHLOaXvcfewrrUH1sbEKL1rN/9tR/n5lW2OttCU8zFW/RUEwb7tNzgQFVrkyowpO4t1gV5Gc9rID89vfwtEeN229zogYKicS076/sW6spryMjSAi3fiBHunlR8CAqmpwP2D24+i8ZonriLdXl+NFGDVBwOEH6EgSqIevKwJ/No0rGkXuEiFTpnaANcCIfNWcx1vycC8lgApeWU2KkIvKHGClHaNKEzVkFREYKgHgPmlXLZtvadyBdTE3vBd1hqmG7z7Z8lqiAPQ+8R8NKr4/XYQ4F323TabPe404ps61+0cqAB7i+QbT2lp8o08k78Z9NgUENv5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgYIY23TOpZjPmmyOJhIs7xgNP9Sfvvt0o0r/9duqUc=;
 b=GtC/7VUT4Li3pNWHsaFMetcGNH2n1CaIybfTL8evdXEGwol3BWiFhl1mSw+lNclUElcZuimjpFTTNauCkJeIsU4lE7qEAbkkz5TqyFaw73593sX9cL9zd2XIzyxEka/YoFiZ74S64Mx9vtWjErfeSBuj4cjZ47t/pzGB+LxjFZQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 43/70] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v7 43/70] fs/proc/base: Use maple tree iterators in place
 of linked list
Thread-Index: AQHYSDFHRYKu3dLW8UWe3EXVvJoohQ==
Date:   Mon, 4 Apr 2022 14:35:49 +0000
Message-ID: <20220404143501.2016403-44-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a98aef53-3956-48d7-b7b0-08da16487eee
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329791DB941FF8F997D04E1FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMrfBZOaQzvUn9WLUj1Ub0McnbfRz5sBeTxwWuZmID6MD4cAiP9w1V4KJ9Bv8U1bSI/kH6kjymAntsv+xBI1ufoaP7WmtyIdLm57IwYu0YQbmEBsmVL6BHAEIj2SQZDGl/FDETfiLoY3ia4SbHSBWoxvXyhUbF7ExWlin4dhUGoXxhiWUt2JcdY+LrlVN2A9j7+dHzQpXMSghWFK1DQc+5pYJFn4HX7PF4q3gh4S8ZXaxzSly/UvqbzbYy1WQnPamcRgrOWOAH4K0zQh164AIl5DJLPzemCBQCDw3+RB7PUdsfbmARUvU4QeUY5uoJob4S+TA+pACY/l5C+Gz0DVxWLfuTy2x0asTPI9+lr7O0a2Z+diDqETR6aUcic2c0qdDvB0xoXoW21o3vnLE33cBl5Qwj7pA93pLWEfCZqgLXE/CmsQ+NlJwEixY5cXrF6jEkBpC6hnnIkLgeaVLyYWsa5nPHrnaalaDp6OmSojl/WC5SOhbvCvknNz08QW076tGBZJzy4mM2w6GF1bn8f4FQdLeQUAl6MItWKJZhc7u785JoeypzzZtNFdyMll9IccDqbJI8QjQs+KO8mqhivZfiKqVv1j1gG8vQ27yUZl62e/gO3b5lA9TB/x1PwqUGg7w7L0RsACUSznuEjHCejQgqdMLQHsWVrUQoAiBwVe/YjRlVhqZAIpEXP2SJrnMBaqSZ/jDPbwUmQI+RAkXrlToA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(4744005)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eTszvUZX4N7z+2LQS8rPgoVXz9sdFJiB6hzO4TzreL95uKXq6HP+1Y+ScX?=
 =?iso-8859-1?Q?1Ro+Xn1d70q2Li8/zoKam3wTN+D8VkS0eTUDwr6pxI29pjsHkI3ACtb2IQ?=
 =?iso-8859-1?Q?h9WIzX4tngeP7WjVHtx7kSK7Ze32sc+VUOCWhYKsecWDwxHK13yfCdrZzL?=
 =?iso-8859-1?Q?3Nj8AYdgaVQSb3w9e/TrAnlgwEqIuqdvVvz8hizdUMLeCkKPBK3Nrzo9N5?=
 =?iso-8859-1?Q?UbNjN2UXCLeSUnYKShsrl2yKEBmSxfpdddzurfICxYuhJTg2F4n9q/d8qh?=
 =?iso-8859-1?Q?f0UhB3jYCjIbTezKFEcUC2rA/iKv2A07VFFjZam3Aa4+oEo6eyYUeFAPds?=
 =?iso-8859-1?Q?FOnsCQ9Ad1TuWK5rJ6NBK0J2RpmtLT2zTsoDh+z7OxjdBF354SeMjMaPyO?=
 =?iso-8859-1?Q?kVhxs9PeaLSDSCzEQKi7ny5yQRIJYJFfT0iIDX8JJAw7UtzqqUY5xwDlas?=
 =?iso-8859-1?Q?JJyXW7pTGg90E8KZZ2bIhUexBg1ZoMI0gJEtH0wkGlgvqrHwyAjIFALDcF?=
 =?iso-8859-1?Q?4mVXXb97NNse6txzbkMKj1GRciJTQMIXFPV46R2qeKNbryPmjVzmoIKGXi?=
 =?iso-8859-1?Q?40mekPj1Jfp87pIi/Nb3LgRa15O8lewX8E64MspiMpxoKXdGJ/AgxxYG2C?=
 =?iso-8859-1?Q?xtAIHA7vc3HYha8MmsLsRyDgIMp340/kjHPvyGY+KdoYAQgyU6O4zghS2C?=
 =?iso-8859-1?Q?71ZiiN9oZYCMxE12z6myWtH+dYo9+26fo145xsw+BRhnS8U0m6lJTSrmUc?=
 =?iso-8859-1?Q?yp4H886fXOQr1ah6O5OSfxDTzYdWaJVelWFDyKsQq8Q5YIbY5DhEYV5V/f?=
 =?iso-8859-1?Q?mc4sq0o4kcZYZ1P4vS95cu3AzRj9qIMIXaRpZImSrAymrDSdYSqnN4MqZw?=
 =?iso-8859-1?Q?nGjBphPsxnBpwKmGXl0MDDPuk+5HuvSVvsPnu9brzte1/Phu6uKvZBEpqr?=
 =?iso-8859-1?Q?fL7Q3UDP9yb/NjEqerWWR3P+5iYp1VzNg6PxzKdm5kBOKO8pk6mJSepvDA?=
 =?iso-8859-1?Q?FADrUSKO72dVGpS/7rkJmwSktUCE/8Ttq72PjH3sg1XMYb1XMqSGEK3uW0?=
 =?iso-8859-1?Q?7G85eJAdI2e3ocxf3cvFzmv9+MoI8z4hHotPXAPwbweYvrCDzpCpa7/+39?=
 =?iso-8859-1?Q?IksYTHjrZMQnpm23j1YvQlxpHj+OGxBkjorMe0f6Pfyz+0oQSznE9lCrCS?=
 =?iso-8859-1?Q?jR7zwT9RT2H674Hgv3JFtN5HohFKzK9VnbN+Rg+7AWKSWLN/sH85ZshKFV?=
 =?iso-8859-1?Q?UuPjD/u1yiyw9ZTgyDU/md8e+mRlEXPyl7T+KMjPNQjYQkv+9azGUuquNI?=
 =?iso-8859-1?Q?M4WpsjEOO+yynZu8PqM2fSrOVX/PSuSWc77Jh933oTEjHtkyCBfkJtbP8L?=
 =?iso-8859-1?Q?wZEWoJW2wOBT+8dIvNjL94OlsjzbaHtPzSlmJdhQ0/Hk19eXtb4S8eNaBD?=
 =?iso-8859-1?Q?q7EjgBOG7FiNaIHH0bmbXY7ao7LAaqYPjZVTS5nb0B9QHl5TKQslsiMHBl?=
 =?iso-8859-1?Q?0DBWhoNk8ldDRIHVFGfV4H33MlK4EDZhuxMuI7O+g+lD8tMjwSjSY7vKMX?=
 =?iso-8859-1?Q?A3i1CIo6HYIL2XVJG1NmAGzyH/xeCbyDrdvP4P85NTzRN6EpCPL15OoKDc?=
 =?iso-8859-1?Q?1Eyi3fidNZYYmhi/S7yLA96s0vJawOPsxeUvLkXhsu5yA0BeypIjfd78aJ?=
 =?iso-8859-1?Q?qFIWQvv+8fy4fANuhTshYe0VC+MRBr9Ke0BKxl9v2jERv/1VZSWV0ivKPG?=
 =?iso-8859-1?Q?CQhJ6PPg5fZQvVrE/dUBd6v+A8CiyhHHT+7oT3QneRhkGPNxbKjpoCBqZr?=
 =?iso-8859-1?Q?zyWRLLY8jWsIl624LI0E6M2BDZMzAtY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98aef53-3956-48d7-b7b0-08da16487eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:49.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ziwv1AOP4c+XhbVMCzkkrO6pAGRFLybGUgfZwOTBmTyvyDjv6ULcKEXSirVIkmesnh6aTrEDmftlYtpqrLuObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: AKEqQYEEbI0V7_FAOtI0ZhBX9tcofiML
X-Proofpoint-ORIG-GUID: AKEqQYEEbI0V7_FAOtI0ZhBX9tcofiML
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..bf85b85cd572 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2322,6 +2322,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2349,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2360,7 +2362,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.34.1
