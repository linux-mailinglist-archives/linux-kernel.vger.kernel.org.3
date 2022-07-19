Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D357A704
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiGSTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbiGSTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:14:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E0E4B49F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:14:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGccR1031777;
        Tue, 19 Jul 2022 19:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uQjsLwoXXn5SP5QCO2BYUzT3uohZ+BrtV3fomiVnliU=;
 b=F2rHkPEW37xhtWffJUvPdODsW47Km1kd3/TuK8+/245EvZF9gt9KppWwmWu/d03rSd4E
 HbE7cwziaqfXHUITByNwhAYPQt8GLAd2npysWkGy44yFCWIA4yudjR1gHSL1jZw8zaMo
 +gepDUaS/6/a5qWWe8S1avvIeGSWNtMzirUkaxq1iR+76hC8w1+5gbs0xos9pgPMpueg
 IWPNPnPy7GcQUReccNmPNGcuYEiT7VlVitTzo74bup/pU2+c+ZFPZJycfS/dB2JJs6lQ
 nqyHrRxblSVzJcqWPK52+MTiuLaddFw4Pjula2i22C6NpUcSVTXrb+JQ5IV0XZSp1CX0 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtfh5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIShfU009880;
        Tue, 19 Jul 2022 19:14:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ggsbfr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+ori3yuftmuL2ZnlIIAHQ1W7EUzvNBh0jtyJ/r52G3Xdlzs+sfDiTpxgzic4+vFEscUQGEeFYSFMBeM8zGqOAAhT0FEImy5ZyO/KiXC+BqPgEK/fpZi73o5jQudlS+gweW3qQmg+G5j5rPXg/ZR++AQ/kdD6ILvMSbxY6nNwVkwUmfx4YCfPXcEAuRhaFhkkZxW/fXalttbYEMavv3+4nz0MbMCj+goKY/yOhfbrXqZoIS9K9l0o+lP9LcU2Up4NiDjvMVMFXTPFo33o7GL12a/ybdzk87037quYR9Ug8xV/0pi0Nk9SMGCNB+WmqwrPZHf75iM8DGOeUzpqOnfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQjsLwoXXn5SP5QCO2BYUzT3uohZ+BrtV3fomiVnliU=;
 b=NdheDV92IU3OdKSO/68ECK8QbarQNJu0hbgfOb2zDBZeJy8c1jlgOr3CrAjJFOnnAUr17yxgIbRDjJBmcMe9zKov8oBfTjjQOTtH7M3p3jh4B0VC/GbWpw0BxtsLcDeWZ+pY29cVOFSfwm5LAJo/z6IXS7cH66yYeQrkPz7+fCKmwPyh6y8/L6Mv1Oneod7TSHFiL64kUtvQlvtVx73jMOj5XF4FGTese1DHAQSwSk+SlrDzv98TcYX8ZEuOriYASRABQLn5JKh7+Zgx9IUewmWFPSferyKK/uBnJRwvfM2s1QX9q9SlSvzljeKjLB18AaBypKtNpJGVqy5h1iz5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQjsLwoXXn5SP5QCO2BYUzT3uohZ+BrtV3fomiVnliU=;
 b=f3gU6boc9RxAbuOXZMJQ5GyACIY/o62FwpWagy7UxRY/hUfL24PLzNCkfBYuxHgIUIvtu7zXt6FctVSm5ZI//mLjm1mOt775xUX8Tzi3LfOyq4dGspPkmW+0f2t0aaPJDEzjN6uMGLdhHQejHY/Fj8tlEWiORw60IITECQzV/fU=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 19:14:04 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 19:14:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH 3/3] mm/mmap: change do_brk_munmap() to use
Thread-Topic: [PATCH 3/3] mm/mmap: change do_brk_munmap() to use
Thread-Index: AQHYm6O1bKoRuJ9fK0eWoMj2rSrXUw==
Date:   Tue, 19 Jul 2022 19:14:02 +0000
Message-ID: <20220719191352.3366482-4-Liam.Howlett@oracle.com>
References: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81955a46-67f8-4364-f63e-08da69bad89a
x-ms-traffictypediagnostic: MW5PR10MB5805:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 013xdFkE/encm/S8biPz6RnKUutNKQHNvtxHpwnx/+IWqil3eUuQabnOkxUOSKDNXit5Ov8yEb8nwVw9LrCBD1jwuSIJNiWO/JIXvKRQN3d2yCFfLa69VLMoS2WzUN+EhT/u9yrCruD58pzXrM5gpYElAxVEOtUa/S+lrF5vwnU/uDCoZN41KPF8YiQRqXRuj495ekZJKvUNlyHOxErcXg+DZJO0K5mGYWDThllCPUN1GzkmYxHk2qQ2llqfNDH+280hnQLZIFzgWsDC9+VOw8PyTuTqfZCndBEZGXDlDndA2o23nFwXLvNAUQSnCNE9nnSVpyy/2eTa9R3gUY958OiW97KcAQtnOlgPXz7DI0oaoxxKgYRUHMWH8vggLmywWv066NBwCd9YXTZ3HCP2uCpPDQZDAj7L6ydwV46pH6pUw/fp5HUw4lfgNyeYNqkW5Tt+MumemZKMimvcKB9q+u3aTMck80hvNS1/+LZuuO+pnPoYGM7EvNv/1fh6dAQKD8b8xwscfhhm+mQ84Bj2H3ff0Yr7h+8DAe1DImU8xaqNM224osYfekPvymIuPAA+Ikz8P23jqP9OfRAFn+9TV9e7ImPW53KsdKWsBxPs+onmyQ5LBUed9LsY6YIfmFEMWFYNHoKZY/RGRP/UqZieoiVV454F8sVpxKZW666eGBh7Ay6wXGVzm8BVCT3qTIGyEpK2QwDViinbCBKRWIr2S72K9I6tcCCdUwckuhhT0L+8A47HFOhQA4NprK7Lh2Lm8d54h/JJknW0TjsZ9hcrM6/R/4u4nxrO/amyRygDQwIKjDTwnuDy1N3tuPvPn/mvYWYwGdhXFWL2zNuCBURhYiNgWVrUVvLgaIkbCnjUH9Qy6lb4LQM5slsV42UMcBvP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(376002)(366004)(2616005)(86362001)(6486002)(26005)(6512007)(38070700005)(1076003)(41300700001)(8936002)(2906002)(4326008)(38100700002)(6506007)(44832011)(478600001)(5660300002)(122000001)(110136005)(186003)(316002)(966005)(66446008)(76116006)(8676002)(71200400001)(66476007)(91956017)(64756008)(66556008)(66946007)(36756003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eCLMH2NCU4tMvk67yuajKxzr3LhWX050tMWCx6TQQJTPx2cy/QqBnubb2d?=
 =?iso-8859-1?Q?+XMPKWgf0wO3AvNlEUxmPL46al4+dNKVrKrIzP570/uxKAHyikEnofNJLI?=
 =?iso-8859-1?Q?mVvio99XnFgIS1GZnwkOIGX6zi/RpYPeXqfBA9l+UOLDh575RIw1f0sn08?=
 =?iso-8859-1?Q?4WI2GW7xxl/lr7ZDEng6j8hOz2d1aQt+67wZq8Ae95ljz3YToEH1dblhv9?=
 =?iso-8859-1?Q?EyCIXSpJVBtBHlmYQZ5aBhkUcZzM1r+RhtlocwlNuec5jeqVRMnnRn0Xzw?=
 =?iso-8859-1?Q?700pWe7NtZaFxCDMIw+IgJih2OW/v8i5AMSqpM4rihhEoWT7R+trhXyXaZ?=
 =?iso-8859-1?Q?ERHRcE+FmUUadIGgYDMV6uL06hTJQzhxNzIbYwmy7dbYpvLzR8t19oMuGG?=
 =?iso-8859-1?Q?cm5Zhf6pQDorK3sUgFqp28K8tbyCYGmhIz6WcyCTyaifQrT4vxwzQh7sOD?=
 =?iso-8859-1?Q?cul6TGQbCR2fZA2a7+wB2EA3BMGw9rDqEAQGNgPMdqAIJpRAUkqjlfOUvO?=
 =?iso-8859-1?Q?TCPN7//Tg9VdCf1WqcRK0My9CJcYm7Is0hHZ1OLo+30Te7jkii63cZXURI?=
 =?iso-8859-1?Q?N6C8M0tekiVV87EkewCdiyBF8D1z3szTVFq0fQ7xiy1lvweuFrBooc6FYr?=
 =?iso-8859-1?Q?T0OgOAM/Yy2gQCgVsYCncZG3Vp49ZMcr19Uhn/O6pzH/m5aMQVIzvawLev?=
 =?iso-8859-1?Q?8PQQnm+UDWCeAHmq3MCijdQTnEdwosyPVeRxiBN7VaAuVbWX6kTTQtVUN+?=
 =?iso-8859-1?Q?yWjr/OK4tNVMEuW+YwHU2ppEISjR3db+WaYanXvl6gbgAa0o4owubfF7QZ?=
 =?iso-8859-1?Q?5MF5GA1J20h8+LhaBu064S0q2fDkt3Bth8fzaCn/sWe8t2asHkhKIeUPSX?=
 =?iso-8859-1?Q?zYdKfyQGedQRzR8Toe5wD8oQEb3DsPX7ZDH1PnfowcK9fmS4rQA2tTe+qf?=
 =?iso-8859-1?Q?YMxzyeIwOeqJMXU1YIPrLRmvyNZ3Knfi+7seGhMhjn1qCA49dwRc1W5+F+?=
 =?iso-8859-1?Q?Ru2gVQA/AUSYXJTGKbrmn6KwFXdsqlhgJdEn+FpF3eI2Io3cv5TJafvcP5?=
 =?iso-8859-1?Q?ZMDokgPHEHt1edg7z3DgAmPbLZSvhs71k/yxjpRpKc7Z8GV/js5ctMQGKu?=
 =?iso-8859-1?Q?Wh/e6QK1FgYyElAIThV9LjFWlRsk0ICZZko/MA5R09sOT7wpQmttjqGuBq?=
 =?iso-8859-1?Q?D6bXORSdNDtVLErSpV+4lHnLnzTuyLpKzu/oImDUhhCJ23Qw3YvaEtn3Cx?=
 =?iso-8859-1?Q?zNqx5YRtCgAzROFyCBCWbsiCnn1Wnph4z5UJBfF2uHBVyNt2mnwrUFKnWZ?=
 =?iso-8859-1?Q?GJAV+rQ455UYu+5/DqWJ1Pq/AfdVB61XodyH1xeAkRVoidcs94kcciEDvt?=
 =?iso-8859-1?Q?hcaV7Dli1f2Mx2TjaDq4c6UCYAM7ix3jO3tPu7dvS22xMVwq+e6VKbW7K+?=
 =?iso-8859-1?Q?ypPw3hAVncVvHQd1SZCXEId4IRSB5I0xo98Td5MvQ/CWxG/Ot+67qywn8S?=
 =?iso-8859-1?Q?wBmA+ZA5eAA4Z6F0d9ruGDpxbCqcEhvvKDx3C8IBku2GBS4FSKq3/KQLAj?=
 =?iso-8859-1?Q?EQQhZXuU4GQxdzdUQorhLGo+Z9yWYsnG3fl8cmVn5biyEIYtHg8rX8sGdm?=
 =?iso-8859-1?Q?8jrwDmZsorFigIzP4zKcHj181LrgYV/6hEqZqj5EVNfmqgvmfqD5BPOw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81955a46-67f8-4364-f63e-08da69bad89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 19:14:02.7871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QuIEPR7HH7OhpOGD/IXQsZkjqYNyPlkL4POCQbypg9mu/t/3m0Cys8ADaFKauwlX9RLC6ttBtSh83Dk7htlAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_07,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190082
X-Proofpoint-GUID: DJjD6ClP2mfMokIGy1APfeU-fxzkBoEl
X-Proofpoint-ORIG-GUID: DJjD6ClP2mfMokIGy1APfeU-fxzkBoEl
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
index ddd5040ecc9f..10ea2f146d4f 100644
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
