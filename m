Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307D852A585
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349546AbiEQPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349533AbiEQPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:00:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F84BB8A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:59:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HE3RrX020503;
        Tue, 17 May 2022 14:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=vtFR+XM3AenaWDVVN9kXTw4LpevJYGa8ObUsQjGzyBA=;
 b=lYyVTCAjgaT4OSkfSgh6J7ceATXCGyXr92fTyg+Ixrb2k6Wg1X5gZyspu53jePaMYJTw
 AcriAK4Kj1onv5MUKGlDStkcFZVzcMoKt0klu6nErkl2AgoWzfxAYjbWatkIVanwSoUF
 g4CO79MQB7fBG331xRRV2LyPAybICpyiu6WqqBLavfKXjbBTXJSp6MxQyEnkuYjONYDW
 G4SJ0Vjdl1zf7gnUxvco8durCLac6KE5tZJ0cnxyW+1gbp0F3duCiXUIu7clilO54AmD
 e8QOhIkaoT4m8KhXZy1AOjBRnDiHXJmfHN7seX2jct7tzsAB93XsPpeGWr/XMoKj0SAP yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc6dee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 14:59:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HEtfiC012025;
        Tue, 17 May 2022 14:59:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cpcmef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 14:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyy4XblgbEtUxFUnpMqVD8UBh3WuDuhYKVdFUoBanZQQCBq8jwxw+6B92r3GmpymnBtGnayP2wAHsmXQew+XcXiQi8ujzBo3k8A7AJ7gC3uNglC/8wtiHbNznwiQrel6qYJy6sLz251Q9oiFg9aczkhIc2LNbIngzw0eiUrTH8uRmQW7b3ThsY1QI53xNZ/8w0nX55fUveinERuX0vOconfPHJkKR2NcA6IXUxBbbtfqVxUf8B08KiM+1zWsTQNkJL5bqhboRWe0HntAK917QUdWbO2TZ6xKnUH4l3SSmSxGQTMe1tuTvGVb8t8Hn2YGm+9ksiQ0L649XR4a3l3Yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtFR+XM3AenaWDVVN9kXTw4LpevJYGa8ObUsQjGzyBA=;
 b=cGOg+ZBYQJ7vrfihWPt/P0P35dI++Kxa80BbQG9uD4tzsy1YhALgvv8cu2fUQECtR4MDYiszvVBiuRV3aWmfVJ3AprTQ8ou70uhpl9cfj4GxhqX7I/JOS82q+pm0ts5x7kwPA7UhH13nAnXmZzxGX3G+8BFQKDK4Mg7Jwe6x+bQnINXkoRMF+F6TDx89C+0ZusG2xZPiU5IZTii5mPsYaJCVKMhSgdYWUHRznNZyPOJNQCDQuoszrA7oVD+m+UnUrzPUeqCnFbRuexEMCL8e7O1Bv3HlwOgX4br+1ip15cZ/YSqkG8/9q2Xpb06QlADt8riqt8x5JqqdcJ0Yc2y40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtFR+XM3AenaWDVVN9kXTw4LpevJYGa8ObUsQjGzyBA=;
 b=E3OXwaSuxBBh3kzb4AdAV1OgTEh3oYVOkO7hQf66Ac5SyAkJAYxkgqzBe0XpiMe0wPFY4ut18gCU/YSlVkwpQELI6XpSJdRr42FXV/7ttoiUJTxMwQ63PQM+w0JqeUoiL41GrUgIaDLsrbCUSJX9VnLloHjTws3EzXtbx4lcO2M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2441.namprd10.prod.outlook.com (2603:10b6:5:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 14:59:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:59:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] maple_tree: Fix mas_next() when already on the last node
 entry
Thread-Topic: [PATCH] maple_tree: Fix mas_next() when already on the last node
 entry
Thread-Index: AQHYaf6xHLWX0jsZ6EaJM30X3oRPTw==
Date:   Tue, 17 May 2022 14:59:22 +0000
Message-ID: <20220517145913.3480729-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704101b3-682b-457c-0cc6-08da3815d401
x-ms-traffictypediagnostic: DM6PR10MB2441:EE_
x-microsoft-antispam-prvs: <DM6PR10MB244177FC6F2950799EC8B155FDCE9@DM6PR10MB2441.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxEI10JH7wP6CEgs49KR9W1X6lmwTX6jEvLHddUsQcOicejT9PHSeMTpybhLV0fi3O0u+hXcWFNi8Mo0xLDC0BrYF6lydc6t0FUePbeekjT2dvFZx5Fvl21jjv1QxvmZ6M77m9+h9KR1UVW2YYAT59wMOUjViCwLWdk/N10qMu/I7xedfAaCyku9UcGzZxXeg/S/deQjIZ0YzfkUYASfJQ013FtN5Vk9Lr8cmxuyBh5sM84l27XykxyEh6FmaWeEaSGBJuJObTSJKWmh84SJdDBHFCVYeWufE2JQ63WYuLhaJ90U0MYvZXv0zaamznI3d4aw3clcfjqsH81hBRAvkZ9akYYHTfSlQO5lznZ5bAnoskw+q+PTzcXOIo5Z1PQIpbGfe0BKu5X1gOPC9Nf5wm0jRjPE243AG3Jh5/rm136Y7juw6JhobMHU5kaVDZL2QADhDnWhYbDxF120DMfGR6Agj4//RQB//C7x6pptJIwCI+4NYvwZorTT/+W/a+sulXJzaSOinyDK/791pS3RuDaC9VUIxPOMjJSZPwHHd6G2aRY8SS+tCqJ8IyjuZF2F1FDT5W6ctOB594isyLPoRl2/5pmIU/gXIvHHox9hrfBFdzitk0/ZoFAFxBbCnxhPYK/SPUgp+aF7M/4YDNNM4YiJkZk0jwcoH25LVgNPH3Sry55m73CA+4RFbYiIqLlTiDAlrT5R7ATjon6jZLxYKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(8936002)(5660300002)(2616005)(38070700005)(4744005)(38100700002)(316002)(86362001)(2906002)(122000001)(186003)(6486002)(6512007)(508600001)(64756008)(66476007)(44832011)(8676002)(36756003)(91956017)(66946007)(66556008)(66446008)(76116006)(26005)(110136005)(6506007)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S6jeCqC569v8ff/2ZCqwHU4FcJNQ8NeLuGsmVc794ApZdzPoQhxIMLnpOf?=
 =?iso-8859-1?Q?h3MhQpoAeLZKSbuTJSXjg1u6JLsmBLlRox4E77LES73eSWTXWAuhNBjUpN?=
 =?iso-8859-1?Q?V6Mf6Y1lk4uRqdTzcBH5GhQo4vedcRSDYu8fX9iGhQk90wYR9MIkIyryz3?=
 =?iso-8859-1?Q?nOGBv2zlnI1rUDe5EGQWFc3aCRHWDUnleOGFVfeLXnS+kukEUd6c3g8ycE?=
 =?iso-8859-1?Q?NlCLkILY1hjdro8rRzA8FROrXHSPN9J1p44JTEDN3x7+1zl+yquoRa0gSF?=
 =?iso-8859-1?Q?i5HtlrHg7FZzYXP5pLow7gC04/ajHu5ououGMnIXmZbtBSjojNOpfeqCts?=
 =?iso-8859-1?Q?lFjZRy4dpSkzaubNrG04w7AAah5zUr7lsn5o96gmXdHVgoTK7HJlir8c+U?=
 =?iso-8859-1?Q?cy0p3rfjNn38l7HvOE0acYfkOooLkOu4H9GgHFZ3HT3p/XraeV4TaeqB2A?=
 =?iso-8859-1?Q?L738fCTTiti8D9u97KfM+ahmJYKc5E2vpIfDCFs2IvTyXHFLIYa953c0XF?=
 =?iso-8859-1?Q?42fHx4E2WjQ49Xm/RzscW4zOrUHhqgphS4O8AhcLHW4Uuj9qw5kOMd+Q1/?=
 =?iso-8859-1?Q?t5hE2g7hHddum87xKZHynyYEwWwj0gJFWouXoeKbleHQJE6OtYnllJq0vN?=
 =?iso-8859-1?Q?r4y9Hgi1HwRz5zuLakzMvcBD7pI4UCWcXQseyM1PBwkze1qjN8618FRqXC?=
 =?iso-8859-1?Q?GAWw2M9QNShFZf8I5aGhfuw3r7+U/WMEf+lcxPZDhEnRlRKwMmo2D5RtDj?=
 =?iso-8859-1?Q?x2NJ/IXAJ0vrlVZrN8k5FzRHuZ3uMy56NXHXUTqxb3kpMJK55Sfwtw/YY8?=
 =?iso-8859-1?Q?T3E5Q6shhNFn2w+qZAIKCrVdjBHTFTxET7Ifmhj14T4cmNG0kOLXIBUCBt?=
 =?iso-8859-1?Q?EPNYRk5ARBMOfAmtbUObIz7BCo+Idze5a819H19U8M6G6MTjHYM6XRx0Cz?=
 =?iso-8859-1?Q?L8dEgLbBL/swxNkIAPCX5N3FkT3Rm7NyDLVcukMG2sCMNChlznIzUt+Pi7?=
 =?iso-8859-1?Q?+VuDWrgLxKokd6OyFdtJ13jzxCC/cnXXMC6Ij9r6ssbvxKIUeYk87Sk3mr?=
 =?iso-8859-1?Q?nUwrr68xXtJpsIfUonhqsbR2qkLSky7Lsg3lMRcVcbZVvToY8MZFK/9aS2?=
 =?iso-8859-1?Q?JeBvO2cT3yyg6a3lUUMx6XhNiN9a66feh3dUF317VYjTlU7gk3ha4UJmJ+?=
 =?iso-8859-1?Q?Pr0K8PR3FhCgF71V/odq9g0hAhf7ROC8uEPWQLsAbodFPGtHo7e/8ICS0t?=
 =?iso-8859-1?Q?zel/yYRQVXApWfCNCxL04mnl/fUyJ38i/ZrOaR/IN1/ViC0Y6pwG7IG8P9?=
 =?iso-8859-1?Q?Sd3wwSZjcVIIKHnYeBnWDs3ehfVukYHr5d96FJRMWdDGuiLvsuwJf4DQuc?=
 =?iso-8859-1?Q?S0+id4yZOLitWREnki0cfa7JeYUE5uVBWSQRgqIKB7NItNeRA50vruqSo/?=
 =?iso-8859-1?Q?o2DAHZad9Yu3Vg9cjXEmMxqEhVa4aGtXZCsPdzXq+yK24FMLqQ1CC/KNU8?=
 =?iso-8859-1?Q?aW4T27f/L9ON9ZLLJ5O/tfd7fe6/F7fKZh0oHdVwkbAqtEAtHCuUS16Bar?=
 =?iso-8859-1?Q?w4ejpoukZzWQAi08dPGw7GVzChs42YEO3emp30LqnoOBqxsvQEV4YQqqUv?=
 =?iso-8859-1?Q?FDG3t2zYxBvrHdMdx6rOAXc8K/qrK/tiFbuehzk8VyVy6F9j+ZIzq1JTWh?=
 =?iso-8859-1?Q?xAvrnh0NtdMoVMPpO7mPY1IZm6Inq6CpNDqvlerkI8mNiDua1BerFSjY36?=
 =?iso-8859-1?Q?cyXczic4CUutHJicbkAJW3i1a59h7x8iFa/B9phjgFUBpzuZhq3tSXoj6o?=
 =?iso-8859-1?Q?7P8HUg/eOEg3TOqG63sOMZ65hSdll0s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704101b3-682b-457c-0cc6-08da3815d401
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 14:59:22.8028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywhZn4SeFgQY2th1dtoe8+XFfieVPhtYygGqn6aK2h/+QlrLsrux061G5QLhVrV3k2nDUcsNVd3t+VWXA+p/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2441
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170091
X-Proofpoint-GUID: hptB_MRkkelI4nv4L84zeJevY3nr6g7d
X-Proofpoint-ORIG-GUID: hptB_MRkkelI4nv4L84zeJevY3nr6g7d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to return the metadata as the next entry if the last node
entry is already in the maple state and the limit is not reached.  Check
for this condition in mas_next_nentry() where the node end is returned.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 967631055210..751aafd01c42 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4547,6 +4547,9 @@ static inline void *mas_next_nentry(struct ma_state *=
mas,
 		return NULL;
=20
 	count =3D ma_data_end(node, type, pivots, mas->max);
+	if (mas->offset > count)
+		return NULL;
+
 	while (mas->offset < count) {
 		pivot =3D pivots[mas->offset];
 		entry =3D mas_slot(mas, slots, mas->offset);
--=20
2.35.1
