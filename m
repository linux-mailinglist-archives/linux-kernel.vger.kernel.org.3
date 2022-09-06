Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE135AF4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIFTur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiIFTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D585EBA0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IcraP007592;
        Tue, 6 Sep 2022 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rxGPuIa9NK00H9cbRUVqi/espcWRm011po/a3TU2Ozk=;
 b=oWVkiij2gzaRVhzoXpX6eqAIX0Dzp9ZpwgRzToJq735sG/TQGvaA4E2BsHhrcaYjhkm5
 cK9EQATwRwRpqG+GkYu93swVLYsyexYLCwrkSl6net0o02RvLrzgoo7ai1nWXRHxb0wL
 QOgqQ7EVQVwv3fMuv4GryHWFzmAkCGUgDFoSFZ90Hvrq424vKOHhLeRboVjmCFTzmmTa
 zPAzGKUvaDdc2tNphsee+wxIvXffziBcIpF0Ouo4ML0xMb9uwmgGEuNFgemJ0PNp/syI
 Bgkin/NS1oyLnYlcrAjdvqU1kssxAca5cE/0mT1svPwwre3Eem+vlAbJCPZZIhJB73Hd RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6un0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wd027549;
        Tue, 6 Sep 2022 19:48:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul6yiirNwutYVZU0leeARYWt1861ZCFfpt8pemaAezsMrNsLmsR5BPVaCaFli4k2ZThUruhI4kP9NAEj8iUacGQvuLDlZKO4nRX6mGZZ3EyVppuU9DH5hsZmfeAfyaJ9HSE2IehjGcgUFpnSJWXhu7VOadWLxXpNpfUo3oFSA/r0U5M6szF7UemiT7arTrv8e/wZHk9duyTGrxmomvbfAKke1cvngUPFZYRuddKNLNtTzKTzBqTcsISOdURa3lTLoMydL6VrDpRahCfW4AzsDNcJqmJRPCDdfVFj7yhDXYvR5JRgCuIOT+/JqlgoKQEkqY+LsS+1ZYbcVZ8Thy8ItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxGPuIa9NK00H9cbRUVqi/espcWRm011po/a3TU2Ozk=;
 b=RjXv3ZCa0BwkCKwQmq7bHmoac6KeAdyIPNRgwIeDO/UBEn1CVUAWlDX6rDJidElpqWKBXUV5obbH0gNesV1sqtZCHJ/QLf43ksns+ghIYM88zf5XoYozIi9uQRPPKR628Jn8LIZh6DSHDgS40O0zDji+1ICvsT0aJbGVvAud/QxP/wPoeXCF6yFoY/de/Rrv2ao3/4j4EDQcXBQFkO862Eq3oYH4B2i2uI3yv0qTAu5bJARj80egxYcebfJrnwH6h4OHRJPOcFHhp6iOEAePahK83wqz3bOQvCtVLf2kh2hJr6HlaEFe4y8iLWAVEBYLdjGgi5fzxNKw8cqczBeMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxGPuIa9NK00H9cbRUVqi/espcWRm011po/a3TU2Ozk=;
 b=xPlNjGBuTojaSBgECloQCtXdSpHI7Y9TpAcb5UGyceFz3w2xustgoGZKX5eqbscPPdLX81KGiFOucuS52RBKD2ZjfHL4hnER2RGgh1Uxsgl/G3kJswgXFPS8mbj8ciaAIXlrHx1TGQcdDni/f4En9K+rHyf7Wld2U7wvzgArmeg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 20/70] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v14 20/70] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYwimveOqlOhyDvUKXJWLooyJhtA==
Date:   Tue, 6 Sep 2022 19:48:49 +0000
Message-ID: <20220906194824.2110408-21-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a6831f8-90e1-49b7-7a8f-08da9040d61c
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdUfQ7OatdGCC9NvrZ5Y1Tdqzs3n+47CADpksi8siZ6JoVTQRPiMWFFaeNyB5FOTxb1AGxZBFAENcJlRQ8y71aZyHhe2yJXLH/POnFTLF2ogDdKCIpJw2PAjTJVYKqCDHP1umaqmLDxj1RrMeQ4UsVO6mnKrwiXsGv5yHQzn7p71dCSnXW0IEKVVCnkX+wrh147PbxxtG8+K8T52x/OqcBFb9/OrJItQC0+ZmgIZt3p7gtfXtcFiUmRRKKFCa1MqhuVZk5SEuNjl0Xmb9MIB306vMnYAcwl2dhXRVVXwwfQM8kGe0SF0dnltJRCBFTEE4yDFx38vrD1843QxryuWT5Ksm71o6hTMIQyEzDg588G9eebHko4MtDUOiFMpE33z1b3+IGHDnJb+9oh0bUKolsNv6JZy7ADTNz/BqacCtaCk2aLKpnxRTSIH/6jVY9v6Drd02Kbtf4IVNiKWW3Lm2rJk9DTZ7L27ro81UTNGuLcMy0DDsEyrUn1JV2/Pl6Xc7Ti82cyYJCl5EhXOl6cZb7ZcFr0jPa5NzMRCYYXWAEtCjdi4Gg0eSavbc8Anhj8Zr+ipVpDsdmgtMNCjjC8iIzpQzYu7r0kuJNfFgqxVytsTGQdhtfnp59ctqg3WXJsXJ3Ti05JoCxJQe5PTQfg/rmAZPdiKxC4ETu/umBeM5fP6G1zQ5ZH9luphqSU7XdhuyMlQQ+wgBxatVbte/xAwV12PSGPQqm4Q8NJRVSjJuOIeXe3+inpkd/Ipj+1SFpI4D+LLD0pTEEjNGl5wvpbedg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(4744005)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o+EInF6TL6duixVvGOlNGfXJncDhGeYtnroM20E++uvYdJrG7sHQpF4gLU?=
 =?iso-8859-1?Q?X4w/VdSw7QX724ddt0iyhBPeBKOjs4Wrs6fCfYwrOwac70Tv0tC4QM00Lk?=
 =?iso-8859-1?Q?px2t6DC6KgptBy31uWyvz2KnhEw5xB3rRV68/5mAOeduj1/KfvOMyqBe0C?=
 =?iso-8859-1?Q?oWTgEscm08gaCtISh4wjmcizVNtqOwb+UOIDkXgnH415Tq8KQoNYYSinaR?=
 =?iso-8859-1?Q?FmB1owgei5m/83jbUNBaCCHa/QkNynMenVRzvZB2d3/OqLNnRttvWZQwbO?=
 =?iso-8859-1?Q?Bt/wQm86VGptSduIwofkn67yXsSTfldZNfZ8fiWyByRep8GB9XKUAy+KFL?=
 =?iso-8859-1?Q?WW6ulxPh062cHqKO72525K9zw7HooEs9YemiLl/m74as75/HVVk5mRBCUH?=
 =?iso-8859-1?Q?w+eecogiKsOKh84b+w3iFPbF1hAG1cE++qhWgbtdNoZ956jvGxNskJ1/8W?=
 =?iso-8859-1?Q?0SgVXLdNN8bGXOWfdRx+ppnjytJdZn2UA6wl9qKw5xmWRzz9fhFgmMeMpR?=
 =?iso-8859-1?Q?qa4F4yVCk0RzguFPai0akWrLRDwLofi6Cd1EECVaXvJWSFlpIeAHLj/aG6?=
 =?iso-8859-1?Q?bUAg3lcRChQQMlym8bG6EWC0WTjHWidIoGOH1+4TaEZndnbLtDekHiRIPJ?=
 =?iso-8859-1?Q?Ls4GqXZSx7/VDWfq0T5HrsQ1fdm0TjiKkHD7HSD3Z3xjZu7E19mMaQkwn2?=
 =?iso-8859-1?Q?xhHmb022dQuaabV+Js4uq0Rl+i4BF6bAT6eNLTolaH58XFajf4fiu13XDN?=
 =?iso-8859-1?Q?RuQmLYPTbey/jmkDLK1amC1sCfFoDkrmAOLcK2MkfXguPKgw73AKl01X3/?=
 =?iso-8859-1?Q?VC4IQ4YV5o9o/95eFKKcrP2MN2u+L3dxbm01cHbYF8vgfIXq2X/c6lGuRP?=
 =?iso-8859-1?Q?MsSluQhpphv+PzGorF+b+DwQ24aUq4I+jQGvjhSqxlj5jZxCvZCFunIBmQ?=
 =?iso-8859-1?Q?S4vy8HvvSZWdcrElx0PIFE/hYuwHO79AA2VPenfQ8gfWUwlxvX8HQq1JQV?=
 =?iso-8859-1?Q?wne7PGFGO7D3K6+Ha7QIaM+7V/S9Su/FDF6WuP4gJwNN4nCkL5F1za4GzP?=
 =?iso-8859-1?Q?F8pPlGixbSBaB7Fp2rPGx8qdiObNG29tHcE5M/SkAuFHXethwO/336gKVH?=
 =?iso-8859-1?Q?Xdpl8Gmik7CcCZH2uiP5ra42M+nH3Tj2Geq7D+sVIjGECCvi/V1JO3HeVl?=
 =?iso-8859-1?Q?4v8PBPeFjuWx+mY8hZR/ckh0t9SV/fAvcNrmGtyTm+MxyyqvxkAGVozCOM?=
 =?iso-8859-1?Q?3xD9Q2WT4gK/n/EPt+d4XMpdUKi9aNg8sqLtg8tRFOpsBk0Sh4K5onAdOC?=
 =?iso-8859-1?Q?xa4R9w8yN6ZWxSDYIqf/a5Bwj9JULGaJJvtA8KH6y/zVbnXuXxxqc6jpJg?=
 =?iso-8859-1?Q?YowYqftFQFi941FrwMqO9ZuwoLWO9309dktUFVfoLGQSdAOtmele3aCtwS?=
 =?iso-8859-1?Q?1czxeMW0o0Jcmw9t9uhixxiyO85XztuvPhacyVkBXsI6N5O92V1hGyUXKx?=
 =?iso-8859-1?Q?nVkz+eNIvvKQMGxAWR1wgYfuuX9EVBh1zttrwORFzGnftmV1BIFsRouKWn?=
 =?iso-8859-1?Q?GpROsVQKCYG751c0UNL/OS52TPZj9ShjgbMWdRO2idUgVtsRsqFDJmL2Cm?=
 =?iso-8859-1?Q?XFsE/Reo2eNK0j2DqLav52mWzZJpehVHh24VvE0GP3gXw5cCVUnv6jBA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6831f8-90e1-49b7-7a8f-08da9040d61c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:49.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueZHfbqGcNRxdJbLnKwCDz3Fi3/ugZFaggkGGhjRlX+YLpP82bnlbUIUnUZQ2Pv3i+Jtp/6adDKLBRkgPlV8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=585 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: mKHb-O9XQoU_b2HQZ5TSlGeuP6lNz-mY
X-Proofpoint-GUID: mKHb-O9XQoU_b2HQZ5TSlGeuP6lNz-mY
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

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cac845989bfd..3f9cf513e046 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2854,7 +2854,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.35.1
