Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED3519376
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiEDBWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245251AbiEDBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3343EE6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KctF5024988;
        Wed, 4 May 2022 01:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=orjPhy6sLnNOiHk+druKmEqFgRsD1ptVVtQV0bJF0rCEPdV14RyhD5UJbKqfsPLaLAsz
 Ldy4H7pABOL+FFQDysQmUmthbNEQEai+dExzkYkkrIWNvhbR0OCYfQn+FspNz78wIstt
 QzUTgnvpNu8Mybu+UItLl4SS1k6ooZgdrek8xm7/f0ojCGYtyQJCXWMV76MCwZ54ulUr
 0NNOduQGTpe7lMIZBEGzjF7nav4z1y579qXL3NXokUFTeUtzuJOIgV6bxMkoWWHXIaMH
 k6EyrtLL2b/WaSnAPPfjANPBAKCoGoPnQ2VHfikMHiyJ5TdCP3ckn85NPlmAC/WMsbma dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR4013207;
        Wed, 4 May 2022 01:14:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNK7tCmzxlVGV1zJaxdXjoTcwISA1L+WXTWjCr/Lt9SfGxCs6AjBl4ZEB944hrD7tp/x0eNqQeeQXE52tW02p3gCCAoQc2DUO14AeK9TtbjMNYT/MLTZKGxfnX8zpWXIeYMwEPqQsncuQJgdUJc7cZKJr+8UDA/4oqF/sM2d3og00SzSsITiXJEUcO1qOVdBjmeGSZtZe0+Cg/pXRux8lsh/aAdvQIkZOzGjAkqQJUoLiDNXGEDlCI0C6dx0S/lFRWHOYjdigjNr+UaWX+LfPx5O65JA0tXWF0wqBKImLb7AarFlATV6IPPrQQZcEz6R10PhnC0+VU7BeGLXbmz2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=VrdAcDq8z2Ji3PLAYcEdaZexelAj9ajgsG7iQuFfLHuU+CMAuahwoqGxVnfKSGLzj9hN8Y4qoNRWvpJB3EFRnWJDoRMn0vxDRGu0RIUKml3FZH8g9eluYLVLTU8sPENIkkhwhkmzex1bNPv/NTyAGNr5ghbkRpUzvfZh5DUoPwUpSnc8gN7L0zh1lk17fMCnbqJpK1F3pbULGeKxVwoXBtJhz1EEqk43/Vqtm8izo4rldpxfMzswkl8rJ5952Jl0P4IAPLOb80jaTvmqi/JliDiCru/VaEqf4xP5Yo+MLdCiYFia0yWG/0tl+3/f/y99xM8E7ZaYswZeY9+4u5Elyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=qrMhHH2i47x5dib3IN7Vqcyf5/ofMdk3ljoiE6DSx/cwEdozBfiePhsNFtxSq5BhuH6f2XIluK91MeEIlgZdbKc2D/GKES3oNl7R3aq10EjSB/fsPVDfVXpU63ae+bj6EmpPOCx4wMFRxiB4kBEpJ9eA1TKmqURtA7N1KJw3s9k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 60/69] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v9 60/69] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYX1Q/PG6zRNaXd06PeWoaIzW1lw==
Date:   Wed, 4 May 2022 01:14:05 +0000
Message-ID: <20220504011345.662299-45-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 273430a1-e3c5-45e8-24ae-08da2d6b769f
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688C6E52B23B31AD9688F02FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zJpSWpj1q33WscTKM7hXH5Sgm243yS/PDODrmhpajxXRr/G8mUeIgfAuzvZCbbO1FL8ZekAPXggEHvrdoYK9sCwJJz6GZGFcuC2iblxXZVdyLeKMHQeR4Nrt3cOCL0kxscY8zu8lm/Tzc+9tlTOAhcVOdIpDvaBG6WaILQBdhMA0ja5Q8+f+hR1p6wXtAIgdy2U1Eb7mQ1lmrcrhHDXMrpPXN4sAYo1zdznFUwUIBTIFiCrxH0Zo+x8uFDxMAqRNjSbZ+Z6qf1Qr20WPt28Wgkco6vHJflzaUGji0SZt4+61acqyeAQLuDrVf7eKylNiMpbtMHhmXVNJq3pZRt/b8hRZIhrLDRdRTljSipTcbQVNx1CLhoi51CwMdGenpdxyvs+fL9RCbEF4oefs3HkFlbHmBSjlxOdRI6xGZMGiZcT9b1/9IyyLNzldodbV+PZUkjyoQZxTgtZfAO0zbkN5ZyxmzoFhGnDukBStGI7f1t8DxqHt6ZbUhyQNYsCkXFexsbSxPAk+3a9dM8renWMdESV/qlEANGBv9IRZtKcVBdndQ6ZnOyrvBVZDf0RcfzSplznBDwD4k6KarQ13dTSfDeOOqsgrjdSFKryQfOz/cgFcpuddVYOxMb6rbBfcK3jzDy2w610306Hx3gdFC7lmwo/ZssexDC2i/HxWMmaWuPNQ4QYAe2pTh5gq0f1gs5nv0la+gvyuySed4DBCubhrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b9mSfDQpZAMA+DUrSR2/KKNFSVOJvdwz/P7ghc+3A8HCulJjD07NR7nRlV?=
 =?iso-8859-1?Q?LQLfXtqA00jHl8jL9Ips6jpLVZQMH1bVZC6ZXDxgrvrEskvZXF7cRd5zWy?=
 =?iso-8859-1?Q?kk0PrfJs9xfsUP3z3xhsZSqWC/SRpiGu7CtN8+OCq5uBajCUsaJNxcRxM3?=
 =?iso-8859-1?Q?ApdBcZYKfTvdO+O08Hk8BNdsrfQyU5G78cvBbTGtIdwohWdaCX6FyQIZx8?=
 =?iso-8859-1?Q?BForaPAiQqRshvvJ4oAmkl5BE5erCz43pB7E22JP9or6BMWbbod29j/0Ah?=
 =?iso-8859-1?Q?G7FFx5aHPsEj5jSMuAfcAOeBwYrRvFPjVShYztivTNbVleqahTpgsp4Pt9?=
 =?iso-8859-1?Q?5N346G4ZacMbj2qXQvgRFxAeYEBLY/I7XGL0+hk06tPEvDalLWABHk0BZt?=
 =?iso-8859-1?Q?jPaWPFPjq2C9zOFiuQ0fzHJDP3amVZWLyXUw/Zv/9wpCsFuaOPbrcGbjDp?=
 =?iso-8859-1?Q?+n2H0QFQpbb645Tk/iuFBuNg8KurGdOmmxEp8yJ1BrrbEjaNt/YUYS4ttJ?=
 =?iso-8859-1?Q?QSS+80jTgcOUn6lZFKfO8vWBxBJYz3yQWT+jUArNzzzyRxPXO/5G+yGQLJ?=
 =?iso-8859-1?Q?XzQDCLqbegEDCbZpvri+bVANMznaVunsOeBaIT5FcqvNabEPxXhgENBi6Y?=
 =?iso-8859-1?Q?eQG8Yl3GHrVP2DGZd1vTxCXLR2Ee10tMQ4EiY6u3iWBTmLr6/O9bfOJwl3?=
 =?iso-8859-1?Q?3u1GcxHpzsuIw3JoRacpRe64YAZtsqwuyBTD0GzoYru8fj6PuvPKuorpEg?=
 =?iso-8859-1?Q?5cjR4FSn04CyzejTh5z+g5N9sTUnpEPQ5KFW6z2XRCHUxUc1jXbW5Mo/B3?=
 =?iso-8859-1?Q?2eUz4JVr1b4RViW7FHtdj+1cRVVh62OAuuXHSBsRuOTU4cdIwr/rUr66pW?=
 =?iso-8859-1?Q?cWf/TbaUeihiaNbooEGkmYpATAVwodL0rgYi5MkGPToRu/dynYJthg71Kr?=
 =?iso-8859-1?Q?zpQUURne795TUNtMLrVjEyVbWmgyT4Coq00UmQ8Y6tBe2o8g3mZC2G5Wx6?=
 =?iso-8859-1?Q?B1oY/Bc2nHRHB4YSDshs3wsu0V/zv0YVPzIjY89+KStFb6Y1oTUqg9pwQr?=
 =?iso-8859-1?Q?ZJcQ6jzgljn58nea4m4k7ka5+u+kbhbfP37vuq/NO+Lt9tqsOUaq47MwDa?=
 =?iso-8859-1?Q?oh7OlpZCm7NIM+Mv1zcpe2cQZIgkvQf4N2eXUx7IQajPBCwuHw+fSFhDqn?=
 =?iso-8859-1?Q?vUNhpob6cwvgTF4HosNCwd9tqlXJVa7y95VpVyAZrrrCjl9BCzkCpZS97A?=
 =?iso-8859-1?Q?rsJo0QBE0kJOde2f20eaEZ+4LKKrXzqYPpMrHjHw1QOJNjEcOXuV8MXPC7?=
 =?iso-8859-1?Q?kDkjFSHxjXkUsAnbzdtixs6r+UW28flgEbJEM4kNYR8MyGZ4vnI2FwpIr7?=
 =?iso-8859-1?Q?R0VDYGxAjZzcBnuraDi7Mv+u0TLwo9FqD0/Dg+xRAtfkCqJpktt+aICKus?=
 =?iso-8859-1?Q?+Fnhn6pSzHetefvHSOdnE0z93cgepfRs5q5UF341zOA96UvAGw+AeyobHS?=
 =?iso-8859-1?Q?uGJ5+0QYl94KlrYIEY76IbcCknmqSEj12EE97TJRTBJG27CZCSGnNZDdMk?=
 =?iso-8859-1?Q?qZy6aFm/O+oM1yx/5NSeCTihDPxTFnPTrbuBMHnoyzohjY5gxKY/1ZOghS?=
 =?iso-8859-1?Q?1IGF3RhMlVTsAW5l6mO6O+XHVoBNOCNfNTOuNhU2tkk0GCI9XCR/jVJNrk?=
 =?iso-8859-1?Q?YMv5PzPUd5GRZ/5EtRszTWlchc01NnG2T9CGAYKi69k1W/q8Gs2GJ/6uWD?=
 =?iso-8859-1?Q?dmTsHOjc7XS5oloxTaE6DUq2deBPWi+aRgTtaeR9gwKKsdW97ks/i6ip8G?=
 =?iso-8859-1?Q?ZB8wVYYevRRl5nsBEBCkyBABl0yqdYY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273430a1-e3c5-45e8-24ae-08da2d6b769f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:05.0011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIhZtiDcb5XV5tm5EUYFXKWejp56ez0qUzjci+63K8L5aw1uyzIv/HVfjJoW0nqovGHkiBK4An44a2BYKPDhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=932
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: MiPmH48KvbpPM4Z0rw7N2V7wvtwQbT1O
X-Proofpoint-ORIG-GUID: MiPmH48KvbpPM4Z0rw7N2V7wvtwQbT1O
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.35.1
