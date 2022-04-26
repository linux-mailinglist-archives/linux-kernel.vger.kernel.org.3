Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AEF510190
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352331AbiDZPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351900AbiDZPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034A13BBCC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSwlb003693;
        Tue, 26 Apr 2022 15:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=sH3FGbQp7oiuIcHRuP4yjOeRoxqFHhal+cK6s9V3cUf+gLsQQbkGmqLAYMMyC1pA2L1O
 u+suemMMMeGGvUz/89PUPE6SHsaCxMJ1lhbILJiiR4oquWHhcNpoOuFSzyIY/nWLZIeX
 yXabG1CSSPjb1Ro8P+FzEebx+xloG4BVTy7DoNNDziylhLUhitfm2Zsr3mjps77PaIFR
 T93dBiyG9fP33I3jWfp/gvI0OKeA92jGcSNDaWwLWJCVaGx76hJqNegqjH9HKSPQPZq1
 mSbrwXX+Yj1jVJ5VvbQlF374WcS4tnfL3+Nx5LLXq0/NkAdCvhJVQkk72IulEWHr9p8M 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4p6yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63Ea012545;
        Tue, 26 Apr 2022 15:06:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXkbh8ZpmFQrVqypsEoGxeXvIsdDrZV6KpLrZiOjE/mM9Mqj3eG7GSYHMCLsOUgQ4wEsENjsg0xN/hL7zUjf2uPgtqWeEpMWOP1CkeIlIemI02Ux8p44oBeftinxoBWHoofYlHwXVZLzo63h1abHpNE2qLCHpdrtWnoTyIEFEvBYT6DmWpv7B6ej39N2eO14fBGzhXozrVN/brFn21TV0oQXE4dfcqe65rFRtT+BRf6AfZW2aP6D1ODc4/Hl255s2ymGCKWtEjfDRQC1fou3fIpTlZ2/uoXvxqcq2hOqr3pLqOL/C2pfw1FBHdSgh3vioJhiMuyK2Jj0hKRgjYxNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=RGpOLb6+RYLBhtORsQzjBzYfnrbFpFomAxbzHSVusiLnEQuDMeYaX5DQ9FJmIBmewNE3a2aiAVQV4D/E7p1g8BG4C1bvg+MWTz/p/LutY+trJp8qCxNyqaaJ8XtjwEEZwYr5NFNqnriIMILNLWTV7nfi03BemJ/zVR09Aq2LeDSXNU43bBMsjeis6BTU0l9VCfYbD7hReQy3euRuSWTC5SultsTTfrCZx5rSeqGywaqv7iEG6vVIxisC1pFarpG19z2yuxyFXRUlZDdv4VyqTQR7UXkFmYUWZr/079ml9ISI4TeGBAjWw7ted4OWzmt7KxHXC7Fc9v5vyosqcFOo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=FswToKG3soLwC5WEpIz8xpLiCK+C3uQgp9arADyiEhRxt1cbLaWHEnBCikoxiQxl989ggNUUdYdVlzBuSy+8RkNSRgKIWb6Y+Oc8CSxRBJfDgabPq/R9B6gISMYeVGmvqjEq/YcU0qQy1e3l3kprbCqm5ZMRnet0uH+OBaJIIrQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 05/70] radix tree test suite: add lockdep_is_held to header
Thread-Topic: [PATCH v8 05/70] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYWX8wCEFnCATH6kam6zB1ABidYA==
Date:   Tue, 26 Apr 2022 15:06:21 +0000
Message-ID: <20220426150616.3937571-6-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9059839-0df2-4039-e8d8-08da279653e6
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4659A5A601E5F0AC68DB88DCFDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9CzhttZO5DCXA/OEiOVnjmItosgSlW9ZN9YJpjs//aj4CK3gSKBTANl2VLbWJHj6UwFEl07ZeGHgmEvLGmCg/MlXlToyw00nj+9RuZw0r3FJiI1uCzOC1tqZVG4XFAHhbFLSQOKiVMdUQD3dV0qOyC/R1S8a0F2eYec30105HOF+Kfw7iIal8xR8O/4eByz3Wxb53+H/fMq/M7vkItWUIDwpjPiK6Uf+Rq1IX9NR8CpAHCagDzjGPVDbflp3UwT2b7TRKH2ojUkpXxlT+LiVPovxcdUsJy6uN5gvu8p2S84Qd5jDJQlnkeJzOIc5QninZmxcxM9fJtsezTrajogohiuh8728XXBeDJBRH4ksWIhds7xEW6k8aQ41ahkqOZasGJjbK1KV92Nm3YGdy1NDgcaHYObgwa6YdVA3TUT4/p0xbV6vyOFMtuYanZ1/+XNEOMCshhhFhLANqX1zJ2P/uhtZNYt23AmLMI8Qt8AU1pEb+bWNtiTHoisr0SmM9xI07A4DycqbsJY9kVCWRS6ki7C0MZOPfpJsaAEGS69dC0YWRLq+ay0ztX4hRRf84CQQwpsq81nj+9+ZIoN+e1atO6RIGDKD6Zm78soNyWL2L/+RaJsu8uLSl9ihpWCO82pz8a5MFQIOclY8voj++u3o2eTbIwwP32ch9ox9G0N4c5yo1nQfs4TR/j7XHfU2Niy65poiMx7TqPfteSLfkNfPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(4744005)(76116006)(508600001)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PXf6MvsqjCzC3Zda2lL5JIknEHka+Ccssc3k3gMF5cQR8nj1zrzRzSiqpi?=
 =?iso-8859-1?Q?/EJXClrwUibI5fSU9DbQ901lI+ZZpL9dsSpQCQ+eoFJ1A82GR5v1nilc67?=
 =?iso-8859-1?Q?Cli23GZ8U4Ot+dxAbDBVu1TqMj+IDkLVxc2U8Cmf3CphdhztfRUZdpy9uG?=
 =?iso-8859-1?Q?I41xL/U0dXy9Z3TsehsYfhpX8PYY1333wOJ9vxUTeZefZ96ku67zvg/eVG?=
 =?iso-8859-1?Q?nogW7aT5/ZOY9cYvQMSyPXoGq7nbH4UgIo4KixkTtgNzIx398nuwLisgwS?=
 =?iso-8859-1?Q?gYXd37QQkAYe0ozUQtWixUrc7XHw53SN8McCCUSsGekHsSUBPzj+Rl0W+y?=
 =?iso-8859-1?Q?DCblYq6vXo60p/OZ6tzEr4PwK/tve24jiSaqQ7L8hIo7D5zEMCTRlF4yoe?=
 =?iso-8859-1?Q?NKAvvNf7xUvHtHmGVs5+DYdQ65eWn55xhmEJuGzlA6nqAZ64mkaXRYsjll?=
 =?iso-8859-1?Q?WIlXh/9b1Bgqp2aJAndqZ3uvs4zF6FWahtjVN08q/hHyHcfpRY2Z2T/CID?=
 =?iso-8859-1?Q?8dXMD3hDw6y0mCbAxIvMTqf8G3GaZ7mcP7iz3xiRVviDU8Hocm8DNABYrg?=
 =?iso-8859-1?Q?yAnfGulGDETuTFwix5ySneT/1hm5fyaW6MpuraEFvWawT7cth/bK1LllUM?=
 =?iso-8859-1?Q?28e71uChh8NAg2Opsw2z/WI59UmlQzipRXOJ/AFGH+h7mN9I2f720eWBj1?=
 =?iso-8859-1?Q?DuVH378Mkv6Vig53FlBg4hzXdtUydw3T1Qf6mvQqGjS+AI1DJ4hnyRQLr3?=
 =?iso-8859-1?Q?wJmkBUezQM5UKLD78pw5vTiMwk2M70R9fG/lNHEAtPYseRMp6qhD6Y2qU5?=
 =?iso-8859-1?Q?eY+fpv8CJDr/juUxksYnLVCSgPkpdGD/XRmVLnYxZo1Vrdy1yaF/mm6/y5?=
 =?iso-8859-1?Q?x/727XRflpqgcrGby0Le+sn3JesuMy2H9riWdaT161nKCJpydyVVtjtBam?=
 =?iso-8859-1?Q?52SqFTZ647q6EvJcFZtbsF2hMmjrLsxi3KSN+CyI8Fna4oY75KRDaZeETi?=
 =?iso-8859-1?Q?rI5RAYMxkxwY6O8wt34Um+KFC2tzUbTEdBuDKi+6t+PCoZMf1oD6UgjO2M?=
 =?iso-8859-1?Q?vzILEQrSndOwUZa94MHr2sGaiMcRPzBMC+k3yA4EqzFd+ONq87UtWchtoY?=
 =?iso-8859-1?Q?GTjVoesS2ACtm5mct3xLzoApuiQdkJ1EsYSZXPWQJ2zW6bpWEi8GSW5+Er?=
 =?iso-8859-1?Q?E58eHwCSczHGvidCNFYE7zBfMwIQUVIv+iLJNIH/bC1+KsLjyzq7dvx2FJ?=
 =?iso-8859-1?Q?w+2sKnziXqCnttfU2Uh+7rk1voSTnr04mb1tFC4ies0CQ8OwneSbGx+ETn?=
 =?iso-8859-1?Q?Yy5m2nCGAAPPm+n75suA4CINqFvqlNPIhbU5N+3tfVdmPbhYlLp09Zt3dq?=
 =?iso-8859-1?Q?kwU/dzVfVSpgZi0yp8o4ii8tecBOo9MjnegaUFjtv1wIEVzx5n6JH3Zeg5?=
 =?iso-8859-1?Q?K3cb3TH/tH1osFJsMVGa4srLiAbMeNv2sG8RliVW9uaweBexo8wkFnUZzj?=
 =?iso-8859-1?Q?XCx67XEku7jVNJOH47oVGuibf9vLyGW/9d5TnzB4DTp5fO856L3x6La0qe?=
 =?iso-8859-1?Q?pETsspwH7u2DeyuNbcGndKI8xlDeNY3dyctLLpSdw6g5AjpyfGInTBMfxt?=
 =?iso-8859-1?Q?tUJ/hG+QqNdUGVx1DmwXJGkGI/sUpF/+GvhLFYqjhXmgFaDOJ21v5T7rsn?=
 =?iso-8859-1?Q?b3fC0ENUl19hwFhV7ZNI+pxt1iUTTb93kC91ujfv7JaE8PA1q/hlqTFvBr?=
 =?iso-8859-1?Q?PxLYJp5/KPaYx0SwOBjC9oDhfHiaWpKON1KJmqNDQL9jkUBI9wUowzIPS9?=
 =?iso-8859-1?Q?XiVwkBI5VM3Houx6NrByySpaO5gGagM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9059839-0df2-4039-e8d8-08da279653e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:21.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2zIfzJflsracHnXHZPgBGBHB14GrxwdZHt52Ln0YAS6fZJbGvLwbx1MttD2Ujt2R38DnodMV2ea8YpNHKdgUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: ut-RQtNegynhZkKvl5A6G4okZCAFZco8
X-Proofpoint-GUID: ut-RQtNegynhZkKvl5A6G4okZCAFZco8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

maple tree uses lockdep_is_held, so define it as external in the header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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
