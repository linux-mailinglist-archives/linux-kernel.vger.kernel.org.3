Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6E57ADBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiGTCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbiGTCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:19:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB4E66AE4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0mq6Y017914;
        Wed, 20 Jul 2022 02:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GasVp0MRu7HB1UclPEzd92SEjI+aNKDzhhpK6X1UsVA=;
 b=I3vwP8JfeTISMO9FusZICGwcuwbRxUyE1uJstteJJ8Jdry8YCT4CXSVyD8QnoR/18IR0
 s63JMnxUXYiJntXqmtobFBZT9sRKhRXIrbEY4lFmw7vvlhFaeD0LNSU91LqnIWVIDWJr
 nWoOFuumCu+kBaTKvWFvT3OgVyujbjxwyg089gDrdiCWV3Sw7Y6TshpWhrxQNCIBeCg+
 QczIdmdulTNE9Ef1jwsuyA5Kax0QTE2qDBon6scSLanDyJt0JwjesdcTynjpPylTNfCu
 2TE87FTfF02nSM7Al9BAsjBborQbEbZBzuV8H+ChIrpfaUrbJ/bpX7nbDYuPFKjDT/2i 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0bGE1009891;
        Wed, 20 Jul 2022 02:18:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ng-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTSWAlFv4jyd/gVbdIOJ6Jsa9LsRhTSrcV7ROSWxyT1T+pa6vJkf6Ue6PkTAtGpPekpM3q5dmY5D0QAmRaElGRFmBPToA/K9I5LMastpA9yvHnx2EG4ywdcQCt6s9+Bs/BgtSq8SPMICSb/3KmDGAA6stSX7ZaVpnsdulED6nuPPNivjSUz9nCUSFcNpkmbUWVTRZ5deBszmJYMa/YKoWNt1Q+4f1wXOXf8tUQs9Ywrq4U1B0M6lEYyoRLa15zzbtAr99607bqtfBqjnV2b6Q8QKaT4DFF2rETcYDQD9WUkb9yyO39Zs2gmmaGR7IpTZxvI9YrKVhrWkeTi61iJDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GasVp0MRu7HB1UclPEzd92SEjI+aNKDzhhpK6X1UsVA=;
 b=BAdnIzFfOD16BFQIjuTfwo0wBhFFKWdSGLd+z9HKErlTdbDtLENl4ISuCpRbOzQGSPF5cylWyHn3Px50twzruU991Vogl/3YBPR9eVWRbi3dWhCkIq4IN64uqh7P7Hacuf3GFEajPuzRnXGGqlRywmWwIAtPh4X058p2QQxar350ww8vQ6UHyqG3BHd/7i6aF2nZXb8mpITsxgsm1GuqZqdt45ZlnGFm4QTsVRG0wsFjo50y0ziX7lNhggMgAybMrAut4HH6u08MlLQclq3vuFKDj78TOHD2LVlCZ51r7PV8ewdvTNcgkZSX5tD7qjO5A9JKEbjXVO305MgrU5mlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GasVp0MRu7HB1UclPEzd92SEjI+aNKDzhhpK6X1UsVA=;
 b=QLoe2SUAxi9px1PZoamLrFEtq5x/brg6LH4cdBjUIaLJ5o1mFgd7qeKk8WBntB+stF2zYZELIIkGQoGA8lofSYrZ3Z50xn/IYE3rIpAbjm8CdT4TJv6BkqhxHXswImWB92aMFdybv95blsVHR+E1kUxospQyGhqCaefgeUlQESY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:17:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v12 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYm97rV+vsMAZAXUSeszcz3Jtpyw==
Date:   Wed, 20 Jul 2022 02:17:53 +0000
Message-ID: <20220720021727.17018-30-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbe67a3d-01fd-4aae-9dc1-08da69f6108b
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WkDTOhj+xcBCgft5r/Trm01JJIkPoBuMnZa+XrthIWNWE3hBZuNqv6F6fgXfPViiFTRhGEDO0DUaLfPAgv1PL0GZXYJu1+7XToAfjTSjGH8UHxYOjw8OsiRjjRZwCOUzwVR0ZRnPWtc6z9WQpBhBrwTKMaQwsM33HDf8tY3gzpnSo8YVh0EuTbQUPY8gsqnIlFK3raKP6E5fG4/018uTr0RPo6tEoMs04EOi21O0rWpHutfwjC7IEMgm5Bdg+gmHRkH9spwR8D49ehc9XmoGt4/iLgLQX5ZhMtS8NYx+ksik1BeZUNvaADgc7oBBfH+Gxit4GZ1u+iT4Xe5ii9HF30Zn7PbDD5tiq1zraiqU5+EGQVQsuSqtGl2ReaIfcBqwTzLCzOHLZ339ow/d8CIONVUv6nkVP3WUgmXEdCcxmIrGjAGaHxS3YPjcauyS7hnCknRtyfZgT2X1/U+UNoHt8W0kjKrPC4jwbJ1t472ZXWvO23vCBol0bnToDCb2bHNF+oDOuxxokrv4H6ugVeTIWbYoeMs1rzJOPBEklbeQD2YOP6wlCL88JLGyLC3oJER+Z7wS+tnSKPzLXImkX4yrlht1XynUZ7GGjuQuEO6BHCMRPyy2lcdWVXsQM/jubNLVI1U7gOrDbDuBZ9ucRiVp8PYxRSAhdQGvRYJuMwakV8d9r6Ks45swszHIEhaqcyIqMjD9D5ImYMaBSUFhKIR4uG+pHqfaSgZX79UlNnTmX9jtmLEnBYbU+hqK487RWfWBcyZXiOkgeaZFQKJYLYoaMY9+d05AJZ71mBQmca9XxkuV0bYPscnYGu5RFBoGhxWb1CdKEHthxER8h+TqYthPjij9d+CNrTGZQZ/NRhCxhMrxXHLENm0FsyGeNOzTrY0V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sVdRplEnE3dSAnIARXHLLdC/2GB72c3WniH/5Z7xZGmXDskssOvGgc7PR3?=
 =?iso-8859-1?Q?qgut+X2A4eXkjgqRrubQcF11+oABFBguxwvt5Z/n39zaE4P7pBB82oPuvS?=
 =?iso-8859-1?Q?Vp3OdYSrE+iYvVFwRwndDnMBJUzqruvPM9VbwT15k9JbC54t4TJzxH7xpL?=
 =?iso-8859-1?Q?oTvby6v4ifYlQH9KC2auh7RZTvtYTp06xTwYW7cydRBaRH94v5pT648ZS9?=
 =?iso-8859-1?Q?ZVG13Gd7Psum0ovLPYHFw94GlanBqDHojlrUN+7ALqUws9ClA5y4YkfzDN?=
 =?iso-8859-1?Q?Z6IeatvKpuuIaBZrisL3RCM0j3I/gXIRPWqULVxRPx33PhLR7wshXJLTao?=
 =?iso-8859-1?Q?pdH6oidVQyvzp/NozhxJjh1K6rzCXMxf4Soa177QOgsox6JSQ0jcUkjcHZ?=
 =?iso-8859-1?Q?esG45+sG681LTdhazjSw0ZbhimKsZZ0YOAT6KRKs++6uoXKrsEWf0A/Spn?=
 =?iso-8859-1?Q?KXxRgs8xR/VQUOIgqq+GyDDybSTl104TB6/GZgAE/fmQdCHDuWaOPl7hjM?=
 =?iso-8859-1?Q?mFzqcmnYaojN6CQhJ5U8w/748sMZW8itkI/3AxmizbICcJi8uKbhQ9fqyN?=
 =?iso-8859-1?Q?o4ld4d1sCBZZC4nVJ+63zRqvfDa4nM+WjtWS0vxoVk8f6jz6+AKopKO8wB?=
 =?iso-8859-1?Q?OC6JnMU47AnaNNeGI80QLYfUwrXgrAO3DLr6ohFVduXWHuBM15Lci5RqKQ?=
 =?iso-8859-1?Q?Ak1yplWTJkZ72Wnigjj+PDK0GUNIycTvopBSZ8ZqqF+yEt54B1wz/DCfRd?=
 =?iso-8859-1?Q?YwPmwfOXNk5RlYF+NLYSov7YI0NR36x59j7bQ89w5l3AyI8P1yLY7TqBCJ?=
 =?iso-8859-1?Q?QJQK+OH2kQZkLcHc8/jsBDrt1Q2YKNRCEiysLACl2Hb/VsgTSSBIB9Qu/Z?=
 =?iso-8859-1?Q?Wq7wmuO7zprXC0UcvUP53d81qtBmSdglRI//B+BaStYdvXCP1lLULER7sd?=
 =?iso-8859-1?Q?6r8J4iRkQxi+hLew+V4Q5lFmAu0DsXTlq7InICqQ565XvLHAI+Dt4vGC9c?=
 =?iso-8859-1?Q?4C70B7YaT4SI6EaC7VuorGBNUiRDrD1LXrXMiITAnz8ACRtrViyZ2L5yrO?=
 =?iso-8859-1?Q?bjlh90G6SE5wr+/+ImOcXO6Ytj2jT8NmzY52ahlonK+OYWTJ2JEaQVo7BN?=
 =?iso-8859-1?Q?8N4i5Ite+tFh9Mad1/62N91vbzryTC72y+dcTsWLUyxtLFJW5kDAUI4fCg?=
 =?iso-8859-1?Q?Ek2YIZ6OoSbBFa8K2RI0b6B7Cy8Q9mzH0bN23gHevaMIKSUcQA8ksYb3Hd?=
 =?iso-8859-1?Q?G9zenzubzEoILXpZQNtha/auhOOrYx71cFIanHjvZRyU+YZTjxloxKYR2n?=
 =?iso-8859-1?Q?e939I7+b/il5u5Zm8Ii//+vQCgYDD8KwGYW8hWshywb9VuFTrOGtJpr2Cv?=
 =?iso-8859-1?Q?epQXrx/MAeCnw+bzCwCNxpKRHVG6vmxR/3qSAvgizMOK1nmUsccfrw5vxD?=
 =?iso-8859-1?Q?R3AHYDWNYcSCmboO/GPXdhKKVo7tMyerbwHHKoRoDjjgqPHlCIzc7aApw+?=
 =?iso-8859-1?Q?e3wtaMwcKVX2MeFxdZj/iPcHL81JeABWlq7w2rtfYtgd8126Q08UG9ZnFA?=
 =?iso-8859-1?Q?+aKq/hg8Ipt2j252/U7yYDvPCQg3rEE9PwkA0r7vL36qeqX4Yb1DNHAho2?=
 =?iso-8859-1?Q?xZ0Yl70yi1S1IA7juFz4ECgr4SLI5GxylDW3oQ804Gt8ELbF+h0eH7nQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe67a3d-01fd-4aae-9dc1-08da69f6108b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:53.5714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23hHUpyKY4cLTXqrry4ZMCs43gjp5duv3/gzG1ewzoO6KIQORpiYuIN/pd3WAROtKEEej+Gr+o8fov4hRk+Yqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: O_XGW1j3JpAP0hrwOGHKaUOoolWRZsfz
X-Proofpoint-ORIG-GUID: O_XGW1j3JpAP0hrwOGHKaUOoolWRZsfz
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

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Link: https://lkml.kernel.org/r/20220504011345.662299-14-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220519150509.1290067-1-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-30-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 280fc2d2854e..29494ff6c0e6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3085,7 +3085,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+	ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
--=20
2.35.1
