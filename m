Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316A1519375
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiEDBWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbiEDBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D844A0A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:15:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LZnIX026110;
        Wed, 4 May 2022 01:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EWIK6qKWZ/V6EYNw6fkVsSYlcgbvaQmiyWRAPDMZk/U=;
 b=XrLCDKqiUeZgzHzM8JIaf4gkv+rqUDd71qHcjAOovAvbcFrCI5+8ePtkdR5NoIGtsGnU
 6iu5IFR+Kbkh6MuoFij1NO3+95gcGuxzoHlvINIB4Aedl+YL34UM/Z/IUkMjp+gYC2fs
 KfpVVQjQ7FaGH2upiTF/oNYgWJiv2PSFU4gz5rXe/4/0ZFR38CIgsAIkPyaAAx8BGunP
 lwqErUMqAUg028xxnThV3LhfSTTg0kde0dLf84AecotPCfh8JFbRFB5HsUtm7eTICUhy
 7jZLQ68WiaKlptevXVMlk2f25uZYGD6JoZSXPz4hMlpmxHF12bAkp2Y3XMSeTx8z6lNt Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BJT3001264;
        Wed, 4 May 2022 01:14:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a57vyf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtS8BGIAYQgdWiagZXNIPNelNYbyGZlALarzd44/Vx/JuixASXWYZlmC1An+3yR6iP0nn2Q4/ddVtKsEIRrgDDVht6AeVpcDUIypdj4XWdoiUjzCTmt50GXt9hazFsdTKdJUm0ufGte1AHf/STDY2ar2uGk0dFOqYERWSVM/LS+FhJmyRR5GptU0s0PqixCR92wuYbszy8ITsQ1pMSEA4KrwpznzYALC5j8B0e7ypcLzUaCWD5PDxDVkfB3lExHHmSnCCGKjaU8zp4YYdzzYeG1Qa8WsWiDfHFUUbWgDRv6gt0aVsE8h6dF+V33X6KLRjtYwv4voTVUz2pQOttSHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWIK6qKWZ/V6EYNw6fkVsSYlcgbvaQmiyWRAPDMZk/U=;
 b=E7nKH+CRGg8K8yJH7/0IM9ziJ8czScFEfOkEwi3qfLWYDtjjCKcBn2Wvg+6n1mZxVOAVprpawAfup2pRIPeMlTyOXyee/3cf7XEM+NpG/9xfASQ0k0khP9C5Vg1xXd3AWQVeRWpOk/+Tv3oMXtiSw4CStgdQOaPH3WUvNo0VGy3ePbXaMBCzvZsZyS7XNJM5PLbJLpcqD6cscseGIizY369vD0WMb2jRgKmm4PhoJ09HYvy4ZQlBQPID54FyoFo/5z1UPi5388Jop157mWE0UzAxJM1+qapDgFlX3eF5xzMUmsOv/ZxUSQD+pkf3oX/qLGy9BrEXsqzzj8oWuGk++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWIK6qKWZ/V6EYNw6fkVsSYlcgbvaQmiyWRAPDMZk/U=;
 b=WwHC/CCzF04I/Kf3eng+l61uT9S2aR4ktTiOsuVN9CU7/fi9vr/8LNW5vOHO2qtHne6U45DMsJ03mLnAiRSz181TYAmcipOcukpc53GVrn84N5Y54IU0+L1OJ+H2TcUm5zRXl8+6htzl5yv631wl8Gj7x3JUyxa+Mkyy45nqSkA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 63/69] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v9 63/69] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYX1Q/SIUkFqetw0WOmT9h3DTsfg==
Date:   Wed, 4 May 2022 01:14:06 +0000
Message-ID: <20220504011345.662299-48-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c990b925-ca9b-4455-564b-08da2d6b7735
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26880E6A72A93FEA21D4AA25FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2bCYeAIXufJiqIC+rtxbheRlJGPXqgqsuuKyEEKk9+UM2wuvuhpZF9aud992layFVbCESW4csU4Jb3ZcPcbk5lQNgYKrMZYJomME4A4mfYBTcF32FJgNmeC9uP4pdQ3KXnOD1lrH0eFXHeKp7zrgQOP3ka3iCQwY5TnF7raHhS7Z6reuCoMRwWQ5wLslcPHMPi0eUyJABs6s3LyvjcnxdPeRYrAWPpDdIJkjXq1POz1rFOAyeQzH+wqEKNLiAjbAklWIYj/RYGEDPSYOVV9zcKA49Ycb8f91DN201zXig7Rl3BJONNrIi3HU+SE0s9aG+lYsKiwdUoHRH2hl2RkbwahSZC0QtidXOToJ/pqPEt+AQ6O22rrZJs1J0Fae6DFBJGH3qQI6qlnLdJV9TH77csxYXb3BnE4yubZghYHWcB6CB8Iq3gdZt4z1kVfJOJfUF3xhz1JyIcKqdmB7RYoi9t1ZBztL37SUcABXwzo1/eoqTmAo7kQblzvlaGwpSAWo0WYJtMhMGKK2nK2tK7UXmjo7MktRJYfaerxXwGxGSXTa2JvFWly+w9SoRHCIZfHcYOMQUyxsmgc3aqL6PzfFUw91zg88GHWbfdyE+WKJZSFS0bUCSMQiaW8Oi34jWFHVFqQMHkle/9CHNrzDhx86vX7y0Q3KZQqLQcD9X8AmNT+Plw1HXCayVQbjOAezB86/dRlDXf6nn/ckBDXJ95lgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F60WsdMr2drJrkyhqjpnB/NlBKJrUMAFBQZ9fU+uj5HvpaS198b4bctnZF?=
 =?iso-8859-1?Q?nu3U7Xbo8vDkVxpCkgHmxdrNKbCAPSot8p+vlBlVMs4g1aHK39YB5tnhsS?=
 =?iso-8859-1?Q?RxpyXlqUI7zMPtATHd9mSHHgTciejoy5mp3CrHsIjr2qjudZ+WM1+gYNgM?=
 =?iso-8859-1?Q?76/23614xEEy93XXP9nNcTe7zjXA6ZM6rxKPEzNsgI+ZepE14fYV9Rxp2R?=
 =?iso-8859-1?Q?CFjxhSQyHK4qhxTYPeGR2P/1XMGW+GoMzYsSeol9DQ+GQ7263xlfZyWGQu?=
 =?iso-8859-1?Q?xsRbQXJ2G2HaSWliDZ0a11tgtkUDfFtATdP4qHnq1lERAYrOKHhF54i0jw?=
 =?iso-8859-1?Q?zVh5ahbjbfipkf2zfzxtptb3HyHUIV3kDS3KokFwyG/UaAr9KSvtZVpgm/?=
 =?iso-8859-1?Q?t/Edi04E/yrM7ig8CsGxi7AGh1zIYeKS/uOcBNv160QhW3Es3N0Hb8p7ME?=
 =?iso-8859-1?Q?UNtJuiUf+ryKoSnCRLwBSfzxcU4zpUMZL99b+17BjQQSiLdKZxiYfFrk8b?=
 =?iso-8859-1?Q?R+hFFvCQpHZ0deAukyS8OE9K3iXbamlYRqbmpOBf6kwCNvUtYcp6HgvnmN?=
 =?iso-8859-1?Q?mlLsH1gv3R+ezhNQ6/qf7fzVSoZsg6HjvQYv1m5/xDbzqKKHdFf61ffNPZ?=
 =?iso-8859-1?Q?BXtn1npNBtFom2HtMv7D/bVz1EwJfG/5nbNXsaPnGVT7AdmB540UcRPLDD?=
 =?iso-8859-1?Q?iWEls54C8jLuDGd8y/oHLWuDLnvS5UWL5jxc2jW9sqogPBfnxIU1+NJ1FE?=
 =?iso-8859-1?Q?fr8Bo7sw++pFnaCEHwiyvGkh1fBlQhLhwaveFntJqpTmZNb29YODjldQwY?=
 =?iso-8859-1?Q?tV9JP0MNJS82747e9bA/XoHFdNxIEaSAX550de9f+2x670u35hewxcxYoT?=
 =?iso-8859-1?Q?MoIUPFYeCqGDiUjKWFVq6SZk2hoharJEw9E5t3mifvFSEAUYBDf3ATyv++?=
 =?iso-8859-1?Q?m3Ies/jPAH2/KlL1tX9gksyAIKrfXOQrwDHAZAt+J4N9CQPeP+um5kmV99?=
 =?iso-8859-1?Q?XlIM/g5AJb9EVR8lRN068ZB2kqa/DOtWTU/r8o0lt/uIyQeEuBRYHyqgty?=
 =?iso-8859-1?Q?lGd1WdNthQYTMYUZhxbZLz/Lr9T1vUXtLgkKu3eBvjWHCHELsHGLKgXknw?=
 =?iso-8859-1?Q?JpVSqHn8y+EVaKm+z/9BgapqKv1Oc6HhfNNvVaQNCkc0hLg6d+0XZYPMsm?=
 =?iso-8859-1?Q?2UVfN4rwG9UnuVyI2lDOQ9IWydPpRpuuF31bK0dJV+RkOv49KauftK5TRY?=
 =?iso-8859-1?Q?UhRMx0pKByQHGYoQ1PRdEz821tvMByFJ1jNyDkfOUHIBfRBI93V8lk9fx3?=
 =?iso-8859-1?Q?Y9ttv6/G3iwUrGjBn5HLv558W7NECYhujyQiwgNZWQAmTYqCKGRto2e4xZ?=
 =?iso-8859-1?Q?CLTuwu7r0psRAjtrV0Iuvha780mJDrfqhLWuGAK7IZJ7g23/GUhuyqI7kk?=
 =?iso-8859-1?Q?wXPEYInUkpa55uN/hEIGBYDl9/kiOd/AXlZIZt4qmaX0w0l8bsOa291oJP?=
 =?iso-8859-1?Q?ZqkuIqF/CGhXj+WuglqIiVHAVKKGnMY7lXxAS/RXHUVpzp+mxKJj5n+v4Y?=
 =?iso-8859-1?Q?32N+IltxrQ2m4BzKup0/+Kv1AF1XrEEhFzWFTUUg3CG2sg0Qo6jHd2rQJD?=
 =?iso-8859-1?Q?mfJ6xndltDBGNHvV94ZTyNoYRkcvDGH6ivjgQaCmDVdjZnEwkmFV581cZ1?=
 =?iso-8859-1?Q?sKpczg4h3qQUWXeF2ASCjSmP0wGWFBNyBTnxiwPf5LzISQAh7+zuin4u7Q?=
 =?iso-8859-1?Q?UuMKL1/JDAyEEEqx/x8uQs67czTXeU1J5I53WZtjC7oEYY/Br7gRITGZfg?=
 =?iso-8859-1?Q?TWLuyAjhl16ebGCluGx5y/ijU5eKYxo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c990b925-ca9b-4455-564b-08da2d6b7735
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:06.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6fRuOs9R1V8KMLJJLl4USbGLYYLezJrBJzo+K4hOuriBw85uB4n9V0W/f8pHHHalQzgasw6bRQR4AYLUdbP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: ozjFOBPwKIoTZ3uepPWKFyE0lA7-y_l2
X-Proofpoint-ORIG-GUID: ozjFOBPwKIoTZ3uepPWKFyE0lA7-y_l2
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

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..392bfffc30c9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1968,14 +1968,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.35.1
