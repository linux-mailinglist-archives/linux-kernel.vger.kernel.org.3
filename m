Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2F519324
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiEDBLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244874AbiEDBLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05D2E9E4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243N1sI8003197;
        Wed, 4 May 2022 01:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=tJ+5vs828owYwljeDpRyd1i+oJH6hrdJXTp9mMUcVPLbuNMnI4hVyH2eMuqZSNQV5W6O
 FsrIMvgrtRDvII4SKPa3OWJxzHaazhqRO6CchnryvuTLmx2vtbipFCGmJqmMOTJrSCcw
 t0qVEksJydUGpXYkB6oG5Dvh1srFlqka4trh7GdrNC/EQF7XbThEYrU5rzEMIuAvDN+G
 4uy+vOkTKAqpby5fe+90Ty5poMQd0A40+lVRbNdpUqY/ha4Wm2UdfXJ4ggtdGL83BDA+
 kexDOCqYhQ3VPs09B8eWxAiFjH7LiR+h7ffiALJ5V4LZomYvNzwEydDOvPkzLagoS82Q 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24415XlS004554;
        Wed, 4 May 2022 01:07:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmuyt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffHyCckwa1aIjRpobZ8CBI5HcJTwTYqaHoezhWAFJKsONVsHfIYeKpqfSUzhK5Rm125fMuwhkUsn2juQVkgfKl6FDjeiD2tRzlYBBbYzjzVN0RC5M8wc3cP75ckuit0UrOSU/OwKlNINbBBj53B6/ehrjjguAvo2fada7rmCMa9VmgwviY4WYif6gx9fnVyNz2WJNIG6CDD7+lEg7YNeK76Wounb/Su/yJSHgMaGc4gNib/nz6lWBWoJwRIeTsWrpwaJ+qwGIO49HPHn6J9wOSKxX9qNveJF0al6PwTtmNkpC05alKKnomRzp4pjlLVC6fwdC9rTg/lt0WvnNTJINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=l6f38PKOOHG2hLdw+Z1yg+4iE72PMVbq5U9ZlXdOHXWnuO0ZdC58AOMvtQ67gUCkTr4gLUphuhBaRCQRfbJ1KHAhHLNGVcx+0LRO1SMSxsKA5PGGWs1VSTU5G0qbs5TK8rSl1ojdBpCDcEi+/AbXSVOK0bNJGJvTUCf+6Gee19Oy2AwsT/r2KVAF5Ju27khCc5k9J2Que31F5kyE8oLFjfWCOJH+z0tomXLsy7Kt0WhFCrWAN7EUk1/Ii/nwQqNrO1TJdslyQAlEcf1rvoHyiuipEUCLiYWHOMWphCtpyBCOLW9If2vaD0+UJDvArJANbrQcno1EpamvHGeFQ4LjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=eOENRtCSodc6L02EWT6zyK2FBThhnMwx7gno2mHi/ZUcERJsBW3oCQc2R6pAqvdkkUTWnJJlqz6IiCwrvko0SgrLSRWgByxPJ2hJBthFRTfkZkDGVQ8M2sPTocfCImGhlA1ffq9uOWbkNa/tvagiqsFSXuHDwrB6lPMqtNXs0t0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 05/69] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v9 05/69] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYX1NbZ3ZsHECzQ0O9jTdMwNDFsA==
Date:   Wed, 4 May 2022 01:07:43 +0000
Message-ID: <20220504010716.661115-7-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d4e6e79-2253-40f5-8843-08da2d6a7e18
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB42148AE4AB6A1A8A29E16FF8FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaqiyQMzlds7zIZoO+4fqqM+gw/6oTwcT4sGB0SRRt2BFqBX0AAeBGhnFZdvTFMNJ0EiZbYYG1du0QHF7BuyVmkONWLpJIyixNJY66ztFUF4IFhz768LGYd5Wx38mQof21AjyFyauTHiJqdKS18EHg7H4j9eeZr+2+ZmFOT2C7FYY3OnG8KrW25vilmDqNnHSo+JNVMoPOvvEd8AY1cazDWVku10HUHmlyIJWCTTD4+G2ubEexpLPnG+2vyeoNwIFFidZSsZ1S+IM4ihFetOEiWs9SA4IZMuKxtL6Klf4marbuzu8kTj6CkQzUoJbX4FoRm0yDkVWzlcPHdXsq5znShTj6vbYqrMTYv+rFkzzqABHhc9pbp4ZL7dWZlTZcuve1mZ5sWqKsqJqXqrLNAKaFWX5pdz1wJXgAN/aCQARi7tslCM1XLzXT5rNECE3oI17IdGXxG6s0W25/PxzdlhmR8jkqEqRBiL9DNgtOQhaJ42DPe8ncK+Bg6B8X8aNQv9S26WZn2qL8Ba3zhsWuU5ks+tNtfzAcAlXNLqLXo9rM30oWxn9zv2KJLkZWuSR1scS92BH79KI20fAVTncKEnYPgKDDxCDLkG49820RzQ9Q6NXyvu5d7QRLBnqHFfg3264iTUN6rYJySRkX/kTIY2VpWuwh+MXBAFfUbikcruqlfJRa5BG8cdpkF3a7ueBdc0Bv4c2/x/x/b0y1l5EXh4MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rAW39i7f51EyOg1ksWwj8RdIvnAV7c1LvjPxr60GffI81WR3rmZ9ntkQtu?=
 =?iso-8859-1?Q?CswSz1Ajywii0p0u6dY0KsaTY0y1R/HZcK9X12m4ng7KhX3Lofy5NMCMv1?=
 =?iso-8859-1?Q?8L9Khfef7PpWPxX/v9M3fkTp4rgg3Gc2p71h/5DTi3UJM5/Qj9T1F8/MRF?=
 =?iso-8859-1?Q?t6rQidUsORcLHKcI3qg7mp1pN+HfH1i2xCp2gQAmI49b9Z9uKSAZpegL1Q?=
 =?iso-8859-1?Q?BA3QASoZownOPuLzXVGhxBK/AAS+czhE/GAFVcQcM7+Sf8Sm/4UydptzR3?=
 =?iso-8859-1?Q?NAN+/D/S231W7E0ECH7GztFRnrRk4MhwUbxqzhnHmjszKt8TOrnk0w4IGW?=
 =?iso-8859-1?Q?wROOiVVM8SKEsR+zrH09H6Lc0sEkSuBX0/IJVVn6C50Pgx4MN9RIKktv0J?=
 =?iso-8859-1?Q?rkR16LDdbm68ElOgVBcNDccGCuPJ/3gJHojql2MlG9VdJUFfHOOs8Q9bWl?=
 =?iso-8859-1?Q?1OQTRp97ReC0yqeAudQjSXHQFNXl7rYwA7/q1H6XbN7xpkYK0q70j6FFnz?=
 =?iso-8859-1?Q?A+S2VHOJLyw38P5uf//FPO6/WU0DnP6BHz4MXKdNirxuQoheWvlLj5lFXe?=
 =?iso-8859-1?Q?T5OK/8HdK6GrIU7eRsK8Tb/RO2nIxlb6yv5nrMjvUq8i7iTUq85WTwOHPs?=
 =?iso-8859-1?Q?m8BmLH8/gnMKCxzrxfwf6vYtYW1fNYGPghWg4UJykcdPPHEjsERr6mIr+g?=
 =?iso-8859-1?Q?sxgu/aY6V0dtSoFdrrU/rzb3+dzmmKlVqNHkX3tlXZbw2QUua7aALUqobB?=
 =?iso-8859-1?Q?tNB3oLLgh5GKqH35EBfYWcbgInBBfwoZwiExBx/PRY1jKVyGgZqgFx8NEm?=
 =?iso-8859-1?Q?ppT4PwG0+KTl4Risv7f6AvqfXvyZxgQopvWO9fDJNB2eegl2IOVSy/IRT1?=
 =?iso-8859-1?Q?n0NLbNdt43IrEYgSfR+uEah51ODH+XfdVhJYXyLPIa2VC3LNdm/Qf7IHPm?=
 =?iso-8859-1?Q?mR/mymAKX1pgwC8x2B2OFtIsI6BxTP0n9wQShcVxDymlg1dNfQCxiInupS?=
 =?iso-8859-1?Q?oPZjBxJLmCDsFXxPZSSKc34z+tBRy447NCV24rh0ysTsXsM+D21VxWWMhN?=
 =?iso-8859-1?Q?1yQXdKUfzeW1AhQBA81VrIek0K/qGV41dBdWGHO+sgUpuipWSyzEX2H/s/?=
 =?iso-8859-1?Q?hMr3PI1zQ1m/Jch1BVeNhfNrfdJpADYvOKqnT8fH94WxaofZctzztxAxGJ?=
 =?iso-8859-1?Q?lHfDR1FqFV5DbgdhWNbDnFPPTKsP+PKEIMM5CojGCmckig6y/P448aSWre?=
 =?iso-8859-1?Q?lqNoGpe9akRpq2VzKL5srUqQCF81zEr0XDJEF6Y+FiyBvkZ8cY5dRcp9mf?=
 =?iso-8859-1?Q?7OI7rGrrTrI41R7892Y3r5ZOZrHxHLiIiUnbjTEPV4HJKK73OBIJvOycUr?=
 =?iso-8859-1?Q?tWOmp3dmNhmMnuGe/AQbzjXKVHHx6nji1Acfz8xJHgkCfYRgqPjBsM77iZ?=
 =?iso-8859-1?Q?RQtIPqbWZdrlUnvtGyx7AFBWQgk00csm7zIU2Lr8VyHLC93n6Qn09QpSEK?=
 =?iso-8859-1?Q?K+VliIJwf8BXl7T+PVihLd3eW04jwXM0pnp2p+/SIFLA4Kw47eCezpObwr?=
 =?iso-8859-1?Q?Ha55HvhWGvKh7sPagvcmMOhEKx5a0nr2tCSh7q48ifaYIHuc25wyzVja1M?=
 =?iso-8859-1?Q?IsytStchRDfEkIMprfAeVNXWdmGO66FDOz3HVKdo4h3m1EK+O6hjgc9LZe?=
 =?iso-8859-1?Q?cmN6pJ0ZD7OengW+bv7zqlTn1ksd8dPe22cSUqL4uyHGdGVHwVv9XTycPp?=
 =?iso-8859-1?Q?Wq+DukSaYKHYHYcKGi/EHU+3plVCVSdcyIZIx3SBQdcq3dbIgldUHRRH0C?=
 =?iso-8859-1?Q?LN42fgjEUQOJwSppi88s5QhqrQlJuwQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4e6e79-2253-40f5-8843-08da2d6a7e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:43.0260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYB+UnrHVrahbPYT1AHxE8YaXBLMo48k7UiPbUq1GGXw+OccDvBkqaBdxYsg3kSAxWJBwJ0z1doNqkvbxd8F/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040005
X-Proofpoint-GUID: su5urL-hJTK4uHGPwA5-Qj8YkehqpW5R
X-Proofpoint-ORIG-GUID: su5urL-hJTK4uHGPwA5-Qj8YkehqpW5R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to the
radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/include/linux/slab.h       |   4 ++
 tools/testing/radix-tree/linux.c | 118 ++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 0616409513eb..311759ea25e9 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -41,4 +41,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **list);
+
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index f20529ae4dbe..2048d12c31df 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,14 +93,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, s=
truct list_lru *lru,
 	return p;
 }
=20
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
 	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
-	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -110,9 +109,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
objp)
 		node->parent =3D cachep->objs;
 		cachep->objs =3D node;
 	}
+}
+
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+{
+	pthread_mutex_lock(&cachep->lock);
+	kmem_cache_free_locked(cachep, objp);
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	pthread_mutex_lock(&cachep->lock);
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free_locked(cachep, list[i]);
+	pthread_mutex_unlock(&cachep->lock);
+}
+
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		pr_debug("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (cachep->non_kernel < size)
+			return 0;
+
+		cachep->non_kernel -=3D size;
+	}
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node;
+
+		for (i =3D 0; i < size; i++) {
+			node =3D cachep->objs;
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D node;
+			node->parent =3D NULL;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i =3D 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] =3D malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i =3D 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&cachep->nr_allocated);
+		uatomic_inc(&cachep->nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		unsigned int flags, void (*ctor)(void *))
@@ -130,3 +200,47 @@ kmem_cache_create(const char *name, unsigned int size,=
 unsigned int align,
 	ret->non_kernel =3D 0;
 	return ret;
 }
+
+/*
+ * Test the test infrastructure for kem_cache_alloc/free and bulk counterp=
arts.
+ */
+void test_kmem_cache_bulk(void)
+{
+	int i;
+	void *list[12];
+	static struct kmem_cache *test_cache, *test_cache2;
+
+	/*
+	 * Testing the bulk allocators without aligned kmem_cache to force the
+	 * bulk alloc/free to reuse
+	 */
+	test_cache =3D kmem_cache_create("test_cache", 256, 0, SLAB_PANIC, NULL);
+
+	for (i =3D 0; i < 5; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 5; i++)
+		kmem_cache_free(test_cache, list[i]);
+	assert(test_cache->nr_objs =3D=3D 5);
+
+	kmem_cache_alloc_bulk(test_cache, __GFP_DIRECT_RECLAIM, 5, list);
+	kmem_cache_free_bulk(test_cache, 5, list);
+
+	for (i =3D 0; i < 12 ; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 12; i++)
+		kmem_cache_free(test_cache, list[i]);
+
+	/* The last free will not be kept around */
+	assert(test_cache->nr_objs =3D=3D 11);
+
+	/* Aligned caches will immediately free */
+	test_cache2 =3D kmem_cache_create("test_cache2", 128, 128, SLAB_PANIC, NU=
LL);
+
+	kmem_cache_alloc_bulk(test_cache2, __GFP_DIRECT_RECLAIM, 10, list);
+	kmem_cache_free_bulk(test_cache2, 10, list);
+	assert(!test_cache2->nr_objs);
+
+
+}
--=20
2.35.1
