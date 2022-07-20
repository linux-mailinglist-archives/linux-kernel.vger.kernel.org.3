Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B947257ADA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiGTCSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiGTCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B047B9B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1WMOM016723;
        Wed, 20 Jul 2022 02:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TXQ8/+Gm32TX8vkJNXf5IlhQlb1Ipsc/UTSB2QMltKU=;
 b=pe/d6t8Ii2ThbgKtQNqYyK8aGNsAlcKdGETJNASvAcUaIomtFJN7QMppPg5iWva0j3EY
 v4QxpDZXDP4r2pUHU+4TIBp/+t7VH2eS92zFLQpJsqcCJ/+gobnwCLmRiV0DikxyrCSQ
 DwkE06OGocBd1J3U1H1h+MbpdCT+//up1S1GV7Yn3GZZUfGuLfVOV1KhpMuW7zXEYb+i
 59uCWj4O6vYvEGWaVUh4QD7a/4U+c0XPeFobAnxq5XowzKM16NQevQtZVVSWfpssmIck
 SdSCZ/qYJAU9Aqmtga6suv0jWgv4Sim47rdGsN7sp5eBBy6gBecSb1+wn9Djp+BzzXQU VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g53x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JN4BUL002654;
        Wed, 20 Jul 2022 02:17:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPO04okjT1OPNKk5HvfneuxczDsFSjBaY6V20CUDd7xvvHzx8IEnorD6OLWtswoLSMl2VBCxccXrkgozkFBGlhOWXJGPQOCRgl56cEyhoDQHNds7Vqdzx/qBfl7tVFYBI7IxwIyDohp+woTaoqAB72NVuCnqcfiWSnLqoZWTZtme3FIqqpkX58g4Lo8EgeyDKu6Yr4oNwouyXyiD9iSUlV6sRVc9zAVItpq1Zk+CCTKuFIBKk/xkXSsTiDduvNBAwjXN8qqD/GnQdiWOkJ6UwlTtT2ZDldVUBPKwexWBF9HDrEC8AWe84MJ6R2sbTqoMxMVeA2fqpSrS5FnV1mjqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXQ8/+Gm32TX8vkJNXf5IlhQlb1Ipsc/UTSB2QMltKU=;
 b=lYfEHQEel/HjbnT//+N1C5FyAf8opayFwYOGiokSi/Hg8Kty/P9O6QxJeGL8k08typJq5V9SdwQwOc2s2Qq3hIsn5CNwMZhssD+x3SomE5nza6HBEMja9HG/VRoQ6Gj+s/2kbh5tvjafT0XqTv8XPcqcI8pdexUPAQHMMFX2onEkVHlKYB5kbrSV13YV98wbMUw+Ix9tgAdBx9OCajsvvQp5u9BpTAZPJ13VcSEiGSkEYKpiKd2yZNx6zzHPy9FZVAPVtVEvU6YwE0YoXqzz7k8MeYaJlVJzFcNRF5T5wLeECeqjz24nIPeEdIbzN0VjniN/Uk/wJ+m/VnSGTBT54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXQ8/+Gm32TX8vkJNXf5IlhQlb1Ipsc/UTSB2QMltKU=;
 b=l9NQFN57v/LCFZdzVIs7usJcnmn2JT962y9wR68qb5dSlX6Ak8uSqNOgKVfp4M9L05JgaPjQvkvN2TllkhIXUJRgWVDlmsZjVoP43P78jp+2ycDWdskPmQAgEpMfOLZDS3ZBgn97LUfWNa3VO32XpWYFJzPlr0hARJYE4UADnXY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Topic: [PATCH v12 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYm97j3l56Kz1g/UiDzcq57p2Pog==
Date:   Wed, 20 Jul 2022 02:17:41 +0000
Message-ID: <20220720021727.17018-7-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b2ab14-3100-4daa-7914-08da69f60686
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fF/vnuBhbUFBtWpQH6basgRIHrZB5GgCf0egm0dK2uBLBSjpm/eGSkdLfiJ8a9g+6pYGJiKFCQ4hefBsVvOvvFrUEIbcuP7AXpftOHBmTxey/wiSaHhyV1l6K5uYu9fLWXMKeohYearWF42b9S+D2ctzNe2LZLCpy9OPrM8vLH+T5/3HpPi0xpo9Klg3wxviy1DXhb1pJj35ClCXrj11oFTiO4Q42mmdQ+yjiRA7y3GCX2n7NxOwYUJ6SWfWRVgesX7ydZek6vDZDz9nCDOSYE/v17cTe4KYkQ5p0BMHFWDeNJTCQdKU2o222RtfYv/yrpdisccrHGBmcpy/lksqM12hWHSR327WJMpchwm0kLqieVShaSG48HeMnXcRuTnUYEZKsTUYWbaKH5axdAO7aS3bqS8hJckvQu+Jxo/DN7ItfViBM2kTY9Ur7oHIaB0w7ZaiAwCadtUaGnhkvwkgH3cTq3x7SEKbQbyk8gVcoi9EHt1dnASq4zddLfpnrE6cNu5HvsGLY6vBDNVF1a9SiYG3X7k45S4Ins+/jVfE/uLm8EoZGc4hDTrIBzsTFPKg9lgsZGpbf3bc/2yt66m9clZfBcXMUofAHY27ofCv5GjGFZQINvq1OzkO06Ox3E/KQ+n0GJDppdxH2jGDjqlZssmCLQR8KDGgoeXCELIOvhJTUf35ResyYgLJqgavHkR2k0vV8j/h4zEXIOAcGB73Jm4fH583C3iwuRuCtcXY7QURovmXiasvyOvsim+/Lbza1y2HQzveY8JNoeZMGxwga27vhe2e2uIGaQe9GtkWxg8qZUer4cdk2HbCU8wrnbXICYTHbK2PUN3y7s8yn9Z8TLk6zu12gt9xKZLz0cFgfuijJ5SmZIQQgsUorJE924FI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(4744005)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?quoiTiq1rglUr8NbxI1mksv8l902vo0GO7v+cqgvtvV7/yHVw9I5nHRwqS?=
 =?iso-8859-1?Q?d+CI0BhIyFTUu+pBo/UvAf5L6d7Jl0EkTqKWM7+JWb2WEvhNRay7Pr9XeK?=
 =?iso-8859-1?Q?B4HgS9grXgeCv9aD8jdrvGfugFMd3PaALk7qyE4WWdZZ83dP3VbBZuV3qs?=
 =?iso-8859-1?Q?zbMVycziFit62In0Ft//VCkhtl9FsnjVmTQHL4mn+bxYfKM55EOKMjkP7V?=
 =?iso-8859-1?Q?Qea5cAuaSxczjWRHBelA6OvHyRhGCdT092cq2+wNP2RO6O1vh24mQQhnZb?=
 =?iso-8859-1?Q?p6xMimpwgmQNr+eMOuuaumni5pgGSkyNR+HUCaWK5pQTHXPHook/yaMtl5?=
 =?iso-8859-1?Q?DTKGVQPI0eAyD3A/rMC/2jUnESX8IOfWcIp4M7B2pIFW/kn/jcIq/l7N2z?=
 =?iso-8859-1?Q?kdmISQIMbK4I3gw8D836ojBBNUZD4YHc5gsKLrBxMRAGP1dGbD2ExBSMgf?=
 =?iso-8859-1?Q?YNcx/NafxBvBjKE5wVAd2Ga1FPMCYRvmr5p/2IS+WtDD66btY91JJpEJW+?=
 =?iso-8859-1?Q?6Q9IzCsppxwqUU2vEOw5QFax9+gIex4bGfZJTafLZ5SY9PDn/gSRPxbmej?=
 =?iso-8859-1?Q?0ic7wTTvMfTcE/xjnEYuPTUZ4nVDSm7CrDomVG+75w4OMzMxmy5OZu5Fm+?=
 =?iso-8859-1?Q?OIFHbNNgEgrMLKoOgP+XVGXwa7SoNOctPH/qt7A51Bzr1/UAIC6QKmEf57?=
 =?iso-8859-1?Q?7gE8eXDLSWkPsSpyaPDLEzLOmtj3GqKOfda9MeE28Mjx4cl9rW54wg7ZTh?=
 =?iso-8859-1?Q?NRXVG1mlAC377J7xlTjO+RAQ6if7RGLjr2cV7inySZGDS4cosMsWt/B1JV?=
 =?iso-8859-1?Q?Vm5p336aMshNmzafiEyC1OVHHYBwnL45Fm8Gzickd2cM/g+EnUIB2si/Cm?=
 =?iso-8859-1?Q?JY4uo2KT+/Rw86ZyhBEJzXl/+O3OVoVSGKjIfcn7ALxKl2HBfFefF2uJgb?=
 =?iso-8859-1?Q?kppoDJqfcdX6/aGdzQRiJIT90mHmWxYPUwBXCReMs5uP7U/XfPBdAZNC2v?=
 =?iso-8859-1?Q?7Oi/wd3FBoGof1piS+YZ3stIq5pcWHJPbxyFcL9V1XYlrX1FtYt0epqyTu?=
 =?iso-8859-1?Q?Qly2jbve23hBzczpU6oZUMtNctVE9g+7mKc1JWmwEmk5qOmb7mSq/8I5oL?=
 =?iso-8859-1?Q?ry+BWU2ykwDd9f4UIi7+WOI/wVkahZiqwtLbhWPqlm1lRr2t8QqorEWy46?=
 =?iso-8859-1?Q?uscc9Y197+xLdLcPhaMPm4oGIkkPXXqo+AgsZcTbLtN0C+QDYCabM/Qprc?=
 =?iso-8859-1?Q?5hV8Co6a3fyEAsld4luBZZEVPT/fo29JknGt0wX+UXmMqgNzAaWZArGVfi?=
 =?iso-8859-1?Q?doTak1y1bcJOwunrGltye7Zcp8nYuitgRw66IR2L1gJSR5eYjAvpUyX8d0?=
 =?iso-8859-1?Q?/vD/s8fXPY5TZWYTUQa3q07tvEftp+EKXxFPjvNtUfiffFj4bOWzlz2nPW?=
 =?iso-8859-1?Q?JKCB2nRFRn/yRoGvg2BCjmqxcTdVYy8D5XrpRUCOFvHvgNbziBdXdlj7yQ?=
 =?iso-8859-1?Q?1uF0EadiDgRTQwGOEITHACH/AwDzJqN5MtIhZLKCryg4oo6PUMPa+Vg9nY?=
 =?iso-8859-1?Q?AvtNqZ6Goi0EVFEPkFKJ6u8MNLDZ/eNHz9xCrNWUpeDupfUjwHBozwZxN0?=
 =?iso-8859-1?Q?1DQnFxWBtZ+9D71N1NQ8VhFTy7cJX13UydHHTWqy98tv7DagcMIWowlA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b2ab14-3100-4daa-7914-08da69f60686
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:41.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RkvmxzzLq8Kna/1U7htld2SgTwQWpoQvFp7iQgxw3HGVzgBOkL+Ac90IsD1H6m/ZPXE+IZIqHu17/dQptLJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: j6mDi1InDNODMXfQuz57N3oFn6i2FBPE
X-Proofpoint-GUID: j6mDi1InDNODMXfQuz57N3oFn6i2FBPE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

maple tree uses lockdep_is_held, so define it as external in the header.

Link: https://lkml.kernel.org/r/20220504010716.661115-8-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-7-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.35.1
