Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54E57ADD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiGTCYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiGTCXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4126F7E7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K119oG017919;
        Wed, 20 Jul 2022 02:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5+F2vYURpnnED52U7mCycaVwvF9TOYJxCnnI5slxg1s=;
 b=ZfUktgYRgIJ/j+izqZRsp2EmRAsinIx6qYoMQGBbVHQvTeQPCM7tSaUR2F/CKinM8D11
 eC7mdDvfDNQiWNUpJinuYPvuyeaXymv1onsJ5pOf/yYFLClgJEbuvwilTp02A9zARawA
 /vqAFYXyWaaeeWo61BM3+EOJK21bsU2VYF7Z0ueObdVei8Ix8mj4+I4DrfmqTPyOSz8U
 Jw+ax9W5xNQ7daky9vQ1uSSt6sjieSukR0F0LFYpCHNPWfDpDEN1Df2K2qzLhRP0KSy/
 wQA/UQBys70qP1TMSahUljuSd8IyHokxv9deAKj4qobfl6Yjt42YOQcrInPCtHtbQ5QH ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNeDsN022213;
        Wed, 20 Jul 2022 02:19:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseb6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSDBr4PlMAWnUgClgj9z5HyuAlKbVmziudROlsM19kh2zCnD3nQGd45cPeYowFg3Rw1XBNSkIbO9k5ay5Tl5cHqa454fMebAPaZ6QEkZw7k3HBBi6j4Cca9LGeY2uBRKgcyLzgo1ZSk/iepDIk9jtwbHTVNXeYh43dKRtxa8Ethl+fyW+Q6SDGe4Z7EQT+7TIQ1hB86kOgaRUs97d1EsKJnW+4/+lyYa9rnfwMckV9Y8b7jiFtojf4whIWw11P5klHFUIsSmQm+xk+Z1bd0jBpllj54k2oShP5REN/XaQbt2mk7VQ3o07ppfIN8sAqjz10YHtvZI8bFwyvdSr5AwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+F2vYURpnnED52U7mCycaVwvF9TOYJxCnnI5slxg1s=;
 b=TVms5/bO7zMyrTcVQTQRwkonSe7vrCehIykA+XCjdUwT9T4lvjG8xCrJaaCWkY4Mswl9qWIooqXeAjoMU2ti7FBVnLCcnAl7lFPlHDzreUzSLTTyPqha6s7KOI+JqJ3a/Bm9/y0WQg7aUcQjZcbFtgzmegOjmOY2qO2njqAoqtvMJpEd5UQYaIr1Ha3ik2ltEAEw9m6zdpN8pVz189YdOUsRFi42/sywmvsDROkgJSv080YULEZY9wFNvOXY3FFHY6f57o16Ff5MKipDtgrEC+AtJYAZmplG4n9w/+EMRFCfGbgDvHJmML5yrz6eiWsEq+p5NoiPoNY0CVQuc3Y05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+F2vYURpnnED52U7mCycaVwvF9TOYJxCnnI5slxg1s=;
 b=HkM6MiAVErI3KRFW7fnUTOvAW0IQDtwghVfFYj32ydk0tOVx7B+XlSj+wTWoyTF+QhRzMu9PdFSBCqXjIAjfh4BiYn9Lw6RaDGzmo6jamcUvKN0BvjJIuPM15n1nWHlYFOoONfp6k0IDJaaQjPyR3k5RcL1K0AoxfhjHbkTZDzc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:19:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 60/69] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v12 60/69] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYm97wqD1gugWT606LncJh78Zvgw==
Date:   Wed, 20 Jul 2022 02:18:02 +0000
Message-ID: <20220720021727.17018-61-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41198f2d-858c-451d-dd50-08da69f63df3
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEM43tuHN0mKaACc7MD5yocjKFZR48KxnHYGaIy7ttgUD5Qb3OrAegkyHqchT/+oBLHSOIiih83i3ybbn1RsmislPxBHM5E4EFgOpj7EWjtxVtZqn/XJ5tlawBOm4kQpFUzoW9dvg03vJNSOdYzO0SvHTsL0WWMPunxhGiN+acH/aufq/ayJ0KIc5CMg83Xa3lOIfG0jY9aq2w/Lj+KBuEDn9eGOh9n7X+w+iTk+uPbcaPrVKIiz2eAZRAsJFL+IM+hzfKBdLkp9erliRYNhiYyO8Vmc5rHSgYy27DZU+7Ai+W0B8fkiWHJCm3S6ycbqVak5TWgAOwS36oppcyS5/5uKCAp7Ae/7JieUImk4XwFZdDCtnsuW93K1YGshph735F8Fe/wWteCx+DuT20pBG3zTVKWfDcOx4as0i3YrEDAHehQlD+FZOfTza+B0ZJER+zK/E1CciIEKbYTxMtZwSwmUKgPDf6qQu+WX+Tlak4+gmLxzMbKd3ru1NBbZuTKfp1bnZTmPNf8hYZeRhngX9ANjcgunK0nbIlhs1iOexbFW6mMDr+4BW1cu67TxViZ2QOqMiXDdit+w2WyS3KvZdiFMuoRYXvdT2OPIYlx6WxIqVIoX1qTKd+3wXU0pGEHtDJWrZC3ypsFXVNLcabqDRWniFdNojyS5LEFAb7pCRypedY/o7RaNvzIKRXaPs8wLLRfF4QO6YC5KW4X8m4nnlhUk//PY2GHJe25oKIoX0QrAnsbEfLkAATnUaPOHyh7Ub8g1tlfW863sgebWYlj7EDunxTReNKhMpxHDBgzGy2JWtK0dPjzHbskdXjRMNHtqzqfsgsqZFF1oA0x79DobW8vs0b+/mcxFUfZVmeLrP2q1tKkyTNoL+bP2bSn0EtI2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(4744005)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kUDNi/KWCqAGVs8ndbpfgW8HXl2+QxnJnQ+Ahifp78FpYXS1g+ZAdJ6bE6?=
 =?iso-8859-1?Q?Y/MTR7GwNUjJnnOo2vRkPLDbmnGqjnd/Ts/AqBOlcTnBuB83iwifKFhjX/?=
 =?iso-8859-1?Q?vBngpSz70M2WZTSlskT23Z5B0XX0rvsNavK+4zNdWyX8LJVZ7oBPmXQtyG?=
 =?iso-8859-1?Q?I4sO+rzjWF4415hSPJZONq6Lw1kUTBQxCpxk+88WMqU1eCfSwxvC/A6ggr?=
 =?iso-8859-1?Q?NOw3/esNW6a+hJYjYj+6GQC2mFe7lS9lch+7PzRTBy4EmM1toEbtkIRWpn?=
 =?iso-8859-1?Q?thK6+6V42AvlT/TvgQxKlo23csAJfCNbQJUjGc2Yt64vKyVRFJxp9PVrQ7?=
 =?iso-8859-1?Q?8phH85ajK1vb111p4CXrbnY2Y2nQZl5629G8YwjaT/wxhZJ9gz2ivSf6j6?=
 =?iso-8859-1?Q?fMnQx0NyhHFus2s9RJTDDZh19UHWiAM8R+J0mokz/kfckISqPrWdgbSSoH?=
 =?iso-8859-1?Q?d8Zm1RlyJ0h6keSKxFVAnfQJmRE1+1It/1JjaJx5s8zA0mwHxnEqjfHSIF?=
 =?iso-8859-1?Q?AmsRuVG/BGdvfg+J0x6tTpsbk9SPVy7cB62wuOiNx03dBTYqx+cmh/yAZM?=
 =?iso-8859-1?Q?V/Zg7mqA1GImJsGcj2t9G3by8J9jjP5g1KL0I09xeC9Kz1zIuzzT3tSaJb?=
 =?iso-8859-1?Q?W98XOzcMjYirD0Udinb2rPcAqk7hsvaOCjdZpCrMEN0bD3oMcLfAda1cGz?=
 =?iso-8859-1?Q?L8umnhhQ5hgBHbLkfpqbQYOW1InrSyRxDQPJvQzsmu1Hf8Hf5ooVP04I9g?=
 =?iso-8859-1?Q?tfFZhXwGdsJrG13//b4/OVc9hnTIudV150g+H5ZdZJxDiotmMtS/+KUbc2?=
 =?iso-8859-1?Q?5ttoh7ev28cTh4wmpneBBYQNXQLlCUIbYoT1E599Zrw8Of8B8OxrzEjBgJ?=
 =?iso-8859-1?Q?CdEYTyWs2qmSlUYOjCrF96DRB0+A3jLzjAAetsR2Gz6vAMerKhnj0GFszI?=
 =?iso-8859-1?Q?OrsMTT6FUlA6+pYAkkzRQ6aM5qmi/7E/gLDXt3OlJ31cJkeUEbUlIO/4Ek?=
 =?iso-8859-1?Q?ipqGiCDXS25jUJQCcSz6YZuHYSc3AQQEzzJawfqMnYVoyHHde5RKnBa6tS?=
 =?iso-8859-1?Q?2xn4IAQmIobylJsXK/uoxeu+zCts0vL9pSfQdxBsjuCWsgNyUPJMfyAOYL?=
 =?iso-8859-1?Q?dTdZQkqxotjfsOj44JQAOA59ZqERAEqBaFIb73x0eIPnwZQwv0IOuBWSTN?=
 =?iso-8859-1?Q?T6356vnRPrzdI/8k1o4WQwQO61HsvkrJqY7WU6S4Iqz0vr5WG/oBFeBIzC?=
 =?iso-8859-1?Q?wRM7Qsxjn+533+uD9gZKjWk/rYv75/DDnfDbVJ3trAGabYa8HEMjm1EEvb?=
 =?iso-8859-1?Q?HBc2DaMpyPWWLvuenPQk9l3Xv3Kgps/j8+m/+21vY28Fkg4MIkof4stXYB?=
 =?iso-8859-1?Q?xx+BlZA9xkgsMPkV4dlo5JggAUIVJPtDKtM9FKScbSmgMTd/+ZFrsEkny8?=
 =?iso-8859-1?Q?kZPNSyAIGgysKYmDPGhY72ZZNMtA+mP7sUHn+7GZ3MGo3WpluDTY6b0ELh?=
 =?iso-8859-1?Q?xvcqbReNiX7sVERChH4eM0ZtkDVWClH1QTtKx9kU0HUcyz3RxXsdAtlhDA?=
 =?iso-8859-1?Q?OGcCMHHalnHUFfvQejXnh/dvUXbrcfpmNTLJ1SW8+ssYJpSTxW7lXzpRAX?=
 =?iso-8859-1?Q?iXaKkRe4WGoQKz06ZaVOSmzEfJ6nFGL+cQldD/yGGe3PAVFbqcaoR/zw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41198f2d-858c-451d-dd50-08da69f63df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:02.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6qS71DMVACgOJhhdCIOZKoSTgaXf54GtAkIaftuZbAY66X13TdvOgJUazH2CyGD0t9Efi3uCjNPnShtWPcXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=909 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: wDqBPp5pC23NsvziwlcvJJYbCsUFb2cu
X-Proofpoint-ORIG-GUID: wDqBPp5pC23NsvziwlcvJJYbCsUFb2cu
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

Link: https://lkml.kernel.org/r/20220504011345.662299-45-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-61-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
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
