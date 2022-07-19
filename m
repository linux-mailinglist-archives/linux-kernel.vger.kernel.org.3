Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51757A4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiGSRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiGSRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:10:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D26222A7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:10:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGf90P015097;
        Tue, 19 Jul 2022 17:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=veDiodI1RDkC+g5XfNn38DSHhwnXhS8UeZrPIT/Fqac=;
 b=Gsxs+/8ORicnxgBwkWtbmoK4xMzmS+XW6psE4Aul8BeEPJtC3+ZdPix7DgtaZ680V3+g
 A7nKQnFmcINWLesTbFn7cKA3DLJWlc/ngCcxI836o5XKdCFfegig8KYq+TtYr2sw8gL3
 /T7TEnUdLpsw7ID0rtKUN6GqodQiLPEekHTg0WYqyx+xcCsDmUev9BIa4rG4NXO4B9ck
 y8puWisaK2TU8dqIVg6s49mhK9Pz3gZW5EBDl8/SSOhQiC6z01cH6hT7t4W0Q50GD75v
 ttP7kROAdccL5Iy/e7IDkXX89qwTaAFtAiZcPSSyFz9OoWV4rgAj8jEINpFzuokrKMHX kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42f6xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:10:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGGehK016425;
        Tue, 19 Jul 2022 17:10:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1emrfmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7Cm6lOi5QBYm82Y5uRp++6VbIvkQLFxnfnj/f3QddCLZ+yWxzHAO4xM2aJ+/as5MmCS8fpidkhiZkGcv3fWQgam+Yr6+hGRgYJcIpydXO1VfN5aymgAe8ue2S1y2I82j6/LzTVOupKtlZjJ/N17i7zsj2dOlveESi7d1brVZL7lFQTwmu3ZNABGiVHmgCHtW3VphmSUPxOleHWLC1yhhbEESPmcCWnuCcpvAJlWTULntbu9AG4F1TiAoOqhdQ1YfqYLHc8C4QvKwGdHWXydw+7ewc+5FJFFGimUJsLhdaFM4hiXuu437RZJXgcP5zCaBqjaCGaqKpimI+bmW/UNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veDiodI1RDkC+g5XfNn38DSHhwnXhS8UeZrPIT/Fqac=;
 b=nidEwNKGgZlJ9g+lqdG6qDnFW22TUcsDiCjhBKOqjqoVCDhP/+iJWkvMZM7U9yCQpneiJCztDqsy+IX1BZEA3KzhXbMBgHfOQa0//Aidjcs6yj8cBuZPJlUgKOll5rkewFJ+nqp2wUPMLf0UHTZQK/RzpkqJiBEcQaTBV/cAuMoafkKW2fPmZ4f/SITN71VRBCU9vMZ34YRyf8Q8XxeKipP5pyM7wcqcWrkvgGaxR3Mn7ms/ywNZSA8KZE0BvH7wTm3zDITrSeqTlDW+/Jc8xjR67+uYB2OQCrCM4oIG2NsXZ+Nmv6l8PPAs9x1rbNatFp8xnVx/6Q1uGoFpVj+jfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veDiodI1RDkC+g5XfNn38DSHhwnXhS8UeZrPIT/Fqac=;
 b=a0wy5rEC15M0rhpu8aZ2k3UUg1VfygUfuSgsfqFuXg31i2FZ6aY4peJ4QortTftRuFtVCVHzKVId6LmpogTptJ9xJAGbMDT3CHxw+njV+d3ZRG4CZhHWMqrTuR9BgJD86BlaV5xkmIXqtVbqFbLBNkrw086VXaI2YSi/JT3lgfk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BYAPR10MB4101.namprd10.prod.outlook.com (2603:10b6:a03:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 17:10:15 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:10:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        Li Hongyu <lihongyu1999@bupt.edu.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] maple_tree: Drop typedef from header
Thread-Topic: [PATCH] maple_tree: Drop typedef from header
Thread-Index: AQHYm5JqNBsrO5Y2yE+CzRXXmJMrqQ==
Date:   Tue, 19 Jul 2022 17:10:15 +0000
Message-ID: <20220719171006.3299123-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 536e00a3-f5c6-45bf-02f3-08da69a98c91
x-ms-traffictypediagnostic: BYAPR10MB4101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwnwrcxm7sa0vvOSKwb90jAXIcus35KXPhxmpN/Q0/xr2CmpadOkUN/04KOlJ5k4D3zoBSybETF3DQys1Ply2h911SJDnWmsPrBtgwZI1vjakbRSG626/bBAPxSmpWI+JkkTroFlaBUpamdFNPN15hGqTweCfxz2kFfoI5ROoNhkUjGDWInkF/gRojZXApE0Pyboirh40vlb7uDqpIjt0KSJSc+eMZDkZfRlRGNiFD6yX13/mMfuSwkXmcJXnRZvLJKk2MH7dxoGZlqNk3ka2noNzmrNOrSWE4me7Xhf0d0qt0vl8PowJCVuvXOjaV0/kw95Qdr6wjnlf2PdsSEmsJVWrdMo7UgJSgnguDP7V6qC2BS6CAvh5QLtbnxWw7QQTYI5kHzJ7N8RNTVxW3gD9P1hdYXpA7+OB2pEuoaw2bUZIqBeO9mSQlaWBwRFkFI4UvEgNU26fZycGc6HZgIr45q/I0/hbNAOvm6CaV9WnwBoi383DS3JSX/S1kRj+p95URyPuO6D5h8LIS8ZGnUOS0LUFFmzcigmI02puJquauUkO04ZqgWQTZvtwsZaPJSVBi1WZvy5CThqrlmK2+B/BauHSa00Js52pegYw9YuWkfMeLiunrgjVgHpgPKelRgkxRqCwdczoow2SeD0Bp9kPQsx17If1uLs8nOHU7E+obDJrsKhIk8OS22vsH6Iiv88qLt+cmZ1YPEvsz7kvgiW0rV7uT+SmKb7vJECwULZPzvh+ZxbrjKypfK/5xpFWw8s0cQRTu+8UGTB0PKWjFRpEDzLPafv047OVJy4Ylo8/3qRcKfR5RRUCYV0iAt4LEqe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(8936002)(86362001)(66476007)(76116006)(66946007)(8676002)(66446008)(66556008)(64756008)(38100700002)(91956017)(110136005)(38070700005)(36756003)(6506007)(122000001)(316002)(44832011)(41300700001)(26005)(1076003)(186003)(2616005)(83380400001)(4744005)(478600001)(5660300002)(6512007)(71200400001)(2906002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XZwekpd94AOzFetZ2nasWNszr4xRnfCwO8QRGqYS1qPk+1QAYYkDUENQl+?=
 =?iso-8859-1?Q?eMVzB6/g2jqLHzRyTxRLwEKzNjzcYEPxihvHpkLDhY4hrVs1rZTx+cQA4j?=
 =?iso-8859-1?Q?eHV+cb1ToefGNg5LKOGokbJ4s+xt8m9IUBOSIoH5AVlAT2LyT+AJfIT5vA?=
 =?iso-8859-1?Q?5EdfQswowGHtO4g9emLru+39LxIyi0BYqyALJ9f/YeW7FCMDnvy+4X81OE?=
 =?iso-8859-1?Q?M0wuZI1Y/dPmOXMIg+IAtgdWHGMQ1fmrEn1TEcGNHO2gmb2fWQSlQL7LhN?=
 =?iso-8859-1?Q?aD/FMABF8dhP01Z6dFxKxmddAZnA9vGd70MnFGLrIQxrUsI+g/ZyoXdJY8?=
 =?iso-8859-1?Q?hDBeVyOMAHdqO36bHmpD0t0/dIrP/PvShxNhuJM5avGBnkc321N2gfq/BN?=
 =?iso-8859-1?Q?jsPKqbry9rEmpd6UZJ3qux52/g/YNBU3Lft2jdJ5LfnqwYFa4oLVdAWlA6?=
 =?iso-8859-1?Q?NQcpuJuAJgmi/Ih4vUCV23nAiRY7q7MZikXw/q1lmilSfAepKOVy3ifIsq?=
 =?iso-8859-1?Q?30EXggEYMlpJ6LDUa86RUlD0Hukd3GknG/9UEbGRS6g3nq6clA9DCM1xpp?=
 =?iso-8859-1?Q?sWFRhKJFhn0WQlLGgu/N/s6pJ834AfFTxrJEhIlQMjsdDWDZa9ekbq9qu/?=
 =?iso-8859-1?Q?bKMlNQa4eZBk6fh9ttbBfjTyDvYuXTT0ql7xIDbDV6swtTMV5dXpSPvyip?=
 =?iso-8859-1?Q?7dPtM+zVVH4H8popkyR6JVA2DPrVir2PhhFyFcFb2eJLzzGCwQpKvQGtkz?=
 =?iso-8859-1?Q?7do5SZlfj3HAFIk2UYPq37Z2IBMxhxaCoJ2+hcv6VKWGEJOmFykITEwEOT?=
 =?iso-8859-1?Q?e2Nsslrs10dEmug/TbO5rExrkXzjPz73JEYl/RkQImaUIDYK9opo+isqzp?=
 =?iso-8859-1?Q?RxpQ6pSFsegbcTaRzUip8AYRXvqIR92/PkoiYrNZUdCIy/uTsZiHwxRgdr?=
 =?iso-8859-1?Q?wD2SnYMaUW59bbHEeQuBK6M/og57PwBLMtS+p50XlhAJFrVYgDEM9EEKN/?=
 =?iso-8859-1?Q?d27KNrmgtRV6LG0Xm0XO5sK40JwRJUkwwSeyhHv/XdPEZAsg8RGN7+V1eJ?=
 =?iso-8859-1?Q?e4x2MDDn7VgPZDVSkxaiRLebUra/3wf/7hFv/49vTUQB3Q06XSv47ZSfnq?=
 =?iso-8859-1?Q?3J70LNhWfUMSjakNo8+h62CBb16XYqD7jjTWCBandZpro9FHwqdtXIMt2X?=
 =?iso-8859-1?Q?i5OneBLeawVX1dLzrHOERRdCYTpDfsu5N11YnagyFenUCoOL3nqVjpo7Ch?=
 =?iso-8859-1?Q?8cXJMO61sPdeuEJ1D6xveXDXWfeGz5N5j5byHmZQaRCtPWfdRYF6axeROG?=
 =?iso-8859-1?Q?bq+xHdYnnnXXiKRNuhnZgfHoPj9xCvJkg5L0//zDqwVKlVud0p+7bmus4u?=
 =?iso-8859-1?Q?2AGgfn05Qy5fNeux8TdVJ1kNv9n4gj2J6Lf7yYnL2/5joNzF65jY7iCsrg?=
 =?iso-8859-1?Q?KjUlZ38Q0aTiPw8HDZUV1/tjv9+boIpAgR64tjFPnMrn4NS+sBN/MDIl73?=
 =?iso-8859-1?Q?BGUN5S9knfaDQmZROAPeUxqEZGnDxPtsOevYHCKnKSw3cGd5F22luEMbvI?=
 =?iso-8859-1?Q?JCd6lxA7nsIb0wiVRifdJXnnKIr1gg4bKAnjhiTSAZFuLMGowbn1Uxr8Iy?=
 =?iso-8859-1?Q?uiqWTJkKoLQnjXzW/GK4OFRD7XGNfT0nAWyA9bipJq6DcWE3rEBekrRg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536e00a3-f5c6-45bf-02f3-08da69a98c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 17:10:15.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Vj+2BrF6/xldVEL3HZUNNEh3tJZw0seMP7RTgnXEVE3jlClpVSP+auBIvGNsXEDL1KEZIi6Uq6xuDB88eiwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=956
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190072
X-Proofpoint-ORIG-GUID: sTOoMSSk13kjguuu9kM6Hhi8BYy2N3Wi
X-Proofpoint-GUID: sTOoMSSk13kjguuu9kM6Hhi8BYy2N3Wi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These typedefs are not used and cause issues with rust in the kernel.

Fixes: fb7297e8a66b (Maple Tree: add new data structure)
Reported-by: Li Hongyu <lihongyu1999@bupt.edu.cn>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 258ca222e145..bdb891b0d2b5 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -72,8 +72,6 @@
  *   0x010 : 32 bit values, type in 0-2, slot in 3-6
  *   0x110 : 64 bit values, type in 0-2, slot in 3-6
  */
-typedef struct maple_enode *maple_enode; /* encoded node */
-typedef struct maple_pnode *maple_pnode; /* parent node */
=20
 /*
  * This metadata is used to optimize the gap updating code and in reverse
--=20
2.35.1
