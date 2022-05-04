Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925F8519332
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbiEDBLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiEDBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E331348
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjMki013507;
        Wed, 4 May 2022 01:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=pOvPlDQHlAhgKGrSpSf/ZIrEuNFOaC6OR2jOyDBGirOf528+ep0w+tz4xI9lZ0wsdiBU
 a16bDDetl2H/UL1R31HIysmD9GwfBoXmb2Yncy4kXHKFtK8TQYjlhgC38OQ7JDfsPOqJ
 E2DbbVI7bs5n6jaIzHqO7C067sVogQcTK5ZMKUfTG3EkqSTpPWMOxOikTBgcYvKPZfKF
 K9/QxHdaX9wMZLkBlI/ZFgAeoMyh1+VixkaXnOrYj4spPnByS8leRbeIe/Ay0C2JarYR
 Lfx2912Vl07TWzHQxF06UnasMH8cUL/AQf+inw1Z7ZX4v6ZOpS7dGbeE2jSsRf+psBk4 yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf691-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SuE039134;
        Wed, 4 May 2022 01:07:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdk7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3pYpc9cxF/aw/lbQUHCRCCyCIDOag3a/e+nMFCVF7Wo6RGen/mAK2ILZhoWUJUWkwV+OtUT4htEVvVw+jx7taKr7BCj+m8FHA0ilZeTc9yWlVNdwxBfK/7BiIO2rEisIDWbLDNtiRHiYe4wnPm/vDjNNqDwUlK9X4Wx5VSW/RSwzCeXbSvv5HVPhc3k+rXbQT9vGBmcIpORWLpE8KMHzrBxuhUIZpLE40BO+6X2yIdVstRRu9bOHTj2zeZm2tMrd7/LB+OAtGDcWV8rFZr5qZEZ8WhdZ5r0t1I4Z5TKXrzOhVp8o+HRfCdpqf/t1poNI347vHZDmT3tBdtJQf1eGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=nessnaooKimh4HHgfIGovxEQpFd1tl003oviuETvt4sHlgRGvi87XDbHoec3s9lGuc2pIsHjSZeQclTHnAtNyLU6aOjtTFZA3Rfcq9jQUUTxmi6eP8PyZfXuFcpKRa+xbK3BvYaklhKdph+vwt8oY2h4d16dudtZqJ/J2hwYW21KrV9vvcBiOwllk2+PV0MH3LlrQxwdUSrTo/fPWMyf+L/ol7QQ5ynKXTv/j+kuKDGDooewmnoRV9ZKwvS63EU/8SDBOHuxSCbMlIrqq1k6DQ2rffcXuHiRpTufEoIaMiXsZzdMIIvgabPm1U3E90MLLqGKtrxWd9YKHUdlUzpFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=KYNB3RFbEm0Z7s7KVjNbnt3t8BCBzjxksKRRVVvAwwb/BG/J+quwPDC3C6trz5fIb3OnK1/kmiLhXQPQLT+nejds46le8C7WwnniNfAIYLhM6D37AFXzjhD+c+MryIaiSDVTY7ADgxZKnluBKaa98qxhRXX0VwdtEY7PGtDNHAE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5445.namprd10.prod.outlook.com (2603:10b6:8:27::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 01:07:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 04/69] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v9 04/69] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYX1NbfHeL2jzbYkSiMQiHJdQk4w==
Date:   Wed, 4 May 2022 01:07:42 +0000
Message-ID: <20220504010716.661115-6-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f38cc3-f335-41fb-29c5-08da2d6a7dd8
x-ms-traffictypediagnostic: DM8PR10MB5445:EE_
x-microsoft-antispam-prvs: <DM8PR10MB5445DE3B61BFDAC7C956171FFDC39@DM8PR10MB5445.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxOd/FfBQDB5gScWWt7cj1OoRlBYPHTN7jzMdEYyFysqcgJBgSvM6Z4p3rF0DIcBBW0YZ0dhBo3kNHlgm1SpIiorsqiOzBd+6veypZx5b2HnUHK1+f8/FS0nveTpk3aFOj8PD+0XsDo52XvchIz2YKSzWhCrBh4inUO9bXU+CSnyu+iFrLfjMbqKG2mvcdSW0zhO24nlOiIMS54ubePjlSEH0o6HwRIv3fx9NDjJKJaLgy0+HLqWsRcHS/txucGoslbpDvygmQawFVfQx1IRIUrsAAIxtnWcX0Wto06Bvm27OAMJlX4coL5i6jitLkHVn5hyO88/PLeyS263AQlOyOWxPyJ/yYJE6lJ9EDc8BMcCQdTtNcXPDlRvcpt88wZoxPjYa+p8c+boaMK6rBEbWDCmXleDErOGfrH/1KjVcgny58JHuoimZxqcfsffpkIQfhK0C7p4NiLpnyoNApnoYAtQcDj9LHBT8/jJDnzx3u3fmqLxZV64nYBO3XbOkfZjJ9F6rYMIM1TZyDVuCzZ/XdYEOo35NXz0FEu3cbc0WxJ0IWkolENsNHxYHECsvT/RJhQc9RHH8/Y01S1iVnoRceaMEG5Bc9HyVzHWMS+9fZuaD91FtiY1o7xH3qk5U2t1ChdnxbZlTFN94pp6mWuIZU3Lp2QNF3W+Ffg7QAinGWpho0Lc2zRmgWrFU863qIuv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(6506007)(26005)(5660300002)(36756003)(6512007)(1076003)(6486002)(508600001)(8936002)(38100700002)(110136005)(64756008)(66446008)(8676002)(71200400001)(66476007)(38070700005)(186003)(44832011)(122000001)(316002)(2616005)(76116006)(66946007)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gB34ad3zRmlNIvcE0yluqb6ZFfeNEu+SwRYTdbOfdaTQZcTi3WXkB9ikl8?=
 =?iso-8859-1?Q?sR+0XFPWZDSRwwiwJAj2jA/37z2cQFdCKF63yWYKZ65GG3Jv+Cne8AQ5B1?=
 =?iso-8859-1?Q?K9RR9NZL/h5ohMmGYYZBcgKslMXNjsMxZRgObMUv5OsIWab+x1HE6TerON?=
 =?iso-8859-1?Q?U53EzQrCLg/3ghBQvxxyA29XGnGCDe4RWiPN50O61Oy39vtTE+a514urGB?=
 =?iso-8859-1?Q?nbS1ZU+4WwgcDJt74GolGAuC8jR2ETscRkYqEEl4BZDUNTlkVNSwn2XmQr?=
 =?iso-8859-1?Q?L2hQD6yr4Z7vla73wZrSpdQfmZceWP98i6bXuOthAUqNxb6/pINDJij35k?=
 =?iso-8859-1?Q?YY18J5t+kYQlZ1TBR1J5k0OneLWX8LBRdp9KNnmgNby63STzoz5Em/z8Nv?=
 =?iso-8859-1?Q?a4ap09EEYkro3TM0RgOWWk0OQZRvJqE2/v0YSwd9F9kUbapVHKWM3sJHPD?=
 =?iso-8859-1?Q?F58aryORzVydh3od+Unmgeo6FRCxVlQjnhCUkTMZuUf8jyAlWP4QZIDSuw?=
 =?iso-8859-1?Q?NnV04rrzO5TTpUqp6cYVPZB2+TrZgW4CEajtBLBUjU+kleqyzNPdwpBMy2?=
 =?iso-8859-1?Q?7mq6GZ9wXDvsLsun7L/zkDePYN4U3s4kQFX6XmrSyGrwnn9izSALn+sKcF?=
 =?iso-8859-1?Q?v8c/cBJfZ3G1ES6hXxulJ+pCfwRGN38ijhKkSVBgvN/DwJY2gzknpq8Q7+?=
 =?iso-8859-1?Q?SHhdl3zNbJ0ZVBh0EUUn8f8h19/CQIBZs7AAavtZtXwo2fd9JRMCSwaP2S?=
 =?iso-8859-1?Q?fLtiRaBdZ4KEBwPNq9SmKHIJ2mswqeUhfkp0Ff2uPton0mBupDuiwglRKU?=
 =?iso-8859-1?Q?vGw2fl/wnnd3sfpJwQvQEuZecRxrgkYuTU8dZq7M5IYvttH353NATMytWZ?=
 =?iso-8859-1?Q?GFG9+g1Au5ytJMSLVLnCu3529Azo+JOlLbXHZSr0nSX3Ff/oEV3dX+RbkX?=
 =?iso-8859-1?Q?+WeWUOMqGdaNzI4uq9fxNougbKEcc9q2GjQ31p3p+uERoDxoRtvWXOAcap?=
 =?iso-8859-1?Q?EPuXHF4WaND762he5ZUnn8gPvwA7Jdecc2nsIgncQq+Sks0eUo+xZIjN7k?=
 =?iso-8859-1?Q?tDPWZrTOTOan7bNuWtDvfN5jV1vv+QbWYPnEa89ou1x6y6IeZsb+g9W1ao?=
 =?iso-8859-1?Q?K4dfzan6dmMR+XWsn3yePfY2gizEK4ZZjYFSWma/1otpJfZW/UaADeWfcW?=
 =?iso-8859-1?Q?WMgkb9FHNM7ocXAJdVnOTBe1jA0848GZFmIKAIQKhVEz+pROv5ufI8cNor?=
 =?iso-8859-1?Q?sNpviVFDu3encDdXS2Uaa7tmOAfsZDX7eL9+R2Vll7geGC3ewfRZ3TBwDo?=
 =?iso-8859-1?Q?MfMCuOK2V/ppvsrgU1yavM3n9wia+07yUPrSfvxrcHBEnSq9fSjNqZi01q?=
 =?iso-8859-1?Q?08eOdSGIRCx7h/X1bsvHd9CIo68GinQiCX+aaRVMhPBoTAr8nqh4GP8Ar2?=
 =?iso-8859-1?Q?nAHcJEKgE/i7pSwzrXuuyMwkNAF02YihGgjQeCcpH9ss2PeI4/Nx0tWVV1?=
 =?iso-8859-1?Q?UgPpykdCFqg1b2c0jSHOHreVQxYXS4kjAaOkzl6yegPvnB0250MTOYhbnu?=
 =?iso-8859-1?Q?103NngeLJJCn6tPHGWNrlrZPabvF4hN2SsesvBqqOMX4/EXCGNYlzop7So?=
 =?iso-8859-1?Q?A1jfnK7o0K19hSHxEK+fL4pBe4o19Cw2ML+/aCl0vdInM7+Pf3+S3gRX+t?=
 =?iso-8859-1?Q?RZfhYwF5gT62WZuwCGZmtscljw0mMx74gUe6e9yoZksNU9MO0YyL9nmDcS?=
 =?iso-8859-1?Q?9z1c1dNGFaJCiy1rFu8mhN8TrbaR/+j597+PM7LHRO9o0ejS9KFindxxG/?=
 =?iso-8859-1?Q?NBNYBqEB3Qx8YPaNJzWIRVVmrmVIFYQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f38cc3-f335-41fb-29c5-08da2d6a7dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:42.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rk+CmBIMn3AJxdbggTY8tSpEDAo9KUZIs0z1Kwm4GzDXwI86uZNo95KkiOtna1F0K5gUbEOXsljst0aPx8ZNZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-GUID: uX5N2vGEesA553eLJeULEgA4ptgkQzsD
X-Proofpoint-ORIG-GUID: uX5N2vGEesA553eLJeULEgA4ptgkQzsD
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

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 277aa8b70abc..f20529ae4dbe 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,6 +24,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -31,9 +33,28 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
-
 {
 	void *p;
=20
@@ -64,7 +85,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, str=
uct list_lru *lru,
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -74,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -99,6 +123,8 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.35.1
