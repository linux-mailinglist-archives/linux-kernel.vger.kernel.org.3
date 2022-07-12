Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60DF571D58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiGLOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiGLOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:53:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864CFDF7C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:53:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CEqsnr030909;
        Tue, 12 Jul 2022 14:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=W6LhCbBLPWU4N7d33MafLJ8sBmip0H8lx2NpnOh2CnM=;
 b=eyMjceE45lkRYk5IBiornsRXVZU2aWtgaIoK6fXtQDxhvOvBjiJ/lfRjuvVSTTr7oiIF
 nKRwrNEl0GC6GFhd1dDu9p9/Atd8KYgsj7maUnrAAm4HcO6mlTANQY8Xo9cgW6HLhWdT
 uvw1Ol0Bx3OtqZcJl5lNCzv5LP1L/HlJeqUQhvfzwC0dNVTZmbLEPihde7wnM7pd5zw+
 bLYr5yqgfTODyCbfn7LSOJ4y/wXSbP/nsFyPxSdXVCI2f35kJaAy+o+vaUIIcHvzChQ/
 a1oVDi3i65CTydgI428IK+ZWGKYeYdQUOXkxYYGWjCKm/aD2TBuNtk7f4BBF2ILjlfD8 /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1700r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:53:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEobkG034870;
        Tue, 12 Jul 2022 14:53:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70433tan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtPcj2QEOEfIDHu0WV8yUdDbBs+eZew24kHymDBoUsKH2wBsk6TJWnJBKatg6Kp0ByMHCOJOkYtDNPveaXwSz1+8WCGFDzWrYnqyj9ZUI2dfY8m1qJFdUAjy5yhs7RlOdJuG1ycDFnwF2WXugWFfoyw9TO6V8vyfsRspDTATuz6r+KPS7DkHYdHyBz6q4VqYXqZqGzlpcIMROYRTNHaUUpzbrxaXu5S4MMU3aYDHCReMfuOcaMHU6dOKQxSet0nk8+xemmp2++3+HiFhBTZzwuBG7Fehtof1g8Go7lqpng7vOkeYU2h4RxTtQMOQvpAkSBI/stv3pMcApWmmeTL4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6LhCbBLPWU4N7d33MafLJ8sBmip0H8lx2NpnOh2CnM=;
 b=j1Ie4VXLbDrPgHYpCJMzKELWSosbYFDKh/4wy0koVmSYtlCBoLNPzNFao290ey6A1629iC/U1UKfPdY2oBkRWCzDAnR7CVQLiyv9Po5bC3XoVCwAjCmqhfeHMtOcssCjIi/XXQIfAk0AihrxZ9VZYNC34VxIu4HZkAY3mUnnBb8IQ+Et1YDdL+4IXfeq5Vu6jkL5UL8pQJL/uAvowlP674s9L3+/I6qoeW197WYe8gOxEY1jLJEGQwBOKySkkeZnEolG5jwOn2VaN/oImvdSOedU7M12QFyGHfGh5EIFC5PITIWGG7VsXXgNPivuVwZoswwCuo3YzM93ouq6NIMZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6LhCbBLPWU4N7d33MafLJ8sBmip0H8lx2NpnOh2CnM=;
 b=Qz+0nyyawNJ6FqEe51eqdE9pvQXjtuet1Glf79nL/W6sD/GdP5CI9VWGLj7ZJNUjVMwd1y0Wnst8Qra00IW/4c3NSt39o5Ta8/L3AdeBjyeemvAUXFHY4Jl5Tq6yHar4Cp88mzMDMHVkDJSJM5dgcBWFYEP041CQr0MMBF6kk2s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1585.namprd10.prod.outlook.com (2603:10b6:404:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 14:53:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:53:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH Fix] test_maple_tree: Fix accounting in check_erase2_testset()
Thread-Topic: [PATCH Fix] test_maple_tree: Fix accounting in
 check_erase2_testset()
Thread-Index: AQHYlf8bdeI0TAIbz0iXnYHg7oghBw==
Date:   Tue, 12 Jul 2022 14:53:11 +0000
Message-ID: <20220712145303.4191493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b92b988-a54a-4c32-c568-08da64163d8b
x-ms-traffictypediagnostic: BN6PR10MB1585:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNyUDZ/EBz04DuB3XUtPISfvtTkIKqshivLwqysoZUx9qQ6GKclJ2brafwmBOsdgnak6ZN2qK4nbzwFv8hmFrfF3ITzLAgY7CjUGi7ixy/9ESSu0cYosKu3uvsxcbzF57bD6rr/7D2MMiMEs5QFPRSP6ZgizW3q7hJtlY0BYuidC5xNd7XdB+FhSRg1rNMJmCeHZrFnLP7rdhtyOheTducK+XAyB18wKVOLUc3TvxNF+ClQ064j1VnvbzFahvSuL8zUlAe9aOQS7B+M8hRhtZKh4hfljSeJdJRhbV6lY5FWdSQ1Xsu0XfGdaKFGZxgNGcheHGi4MFGR/3LPcs7nzQFRW8VHpHjyBhZfBTBok3j7u5BfjQkTRuCgpUGHs37Jl9NSEzMAVvPwPeu7tR7dBsK2PKegLj6gTEY2ZDdzXof8fAAHkJ3v7fETeisr4JP3kNzp9Rl86Z9szowYR3VhYiAe+jcwAxvo4l6SO/571Vm8i2aeg70yJlYW1xfp0wbZst1lEiU8TXgBv2edJixBasxnNo0/yW/iKMEhTMtxIDoUhAayGjiH2UnZwzzK+EfNexE/uMilKG+nRoplE8zdfiicAPu0Hkj+iaGgAZ4vT/AuYUg88I1GSx6zJtQV23HaM6E4zS8DRCuhcwEsOTxT2ylbKCj5EjuKD3ZIJ4EYQQYP/9l+/Qhj4ZlAPn8V5mF0M/rD905VAIW3RVlb7IWzQdNOsiHWpCwPGVBd7rLd2lBOcKYhZHAT+glbmrOPAUyXdW9Zx2/zI8cffPAf+gGZ6zxg28qHesUIwLQ8kT0vVxAc/cFwFjacpOa5PrCLonv2p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(136003)(396003)(478600001)(6486002)(83380400001)(8936002)(44832011)(36756003)(64756008)(4744005)(41300700001)(66446008)(76116006)(66556008)(91956017)(8676002)(71200400001)(316002)(110136005)(5660300002)(2616005)(186003)(66476007)(6512007)(26005)(2906002)(6506007)(38070700005)(66946007)(86362001)(122000001)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?En1+27STvEuCg5UtEHHKyG02463+BWlfLQCmQ7QTiVqejq3vSsdfQyhwTv?=
 =?iso-8859-1?Q?vAoyZ26OYXAuKLCsYZKyeeek3lS8rME5kKtMG3L6odSzk+x0AzAgrgQIKt?=
 =?iso-8859-1?Q?RdSvDmVMaz/cMjdlXp6TWf8uEosapI5fxBY5+mchtFE/tZtZP2hfzo3m/R?=
 =?iso-8859-1?Q?Dp+C1+59glujR0UUnv0otzKP7247TFA3scID2JTxuJfkl1RzlygKXdiYJb?=
 =?iso-8859-1?Q?7Wb12cotrgD9V9hn06/Slhz8piAbLXXrMy7BKVSyHXLIUE6Oq5eZFMScZ3?=
 =?iso-8859-1?Q?5+4/FcJiOWslY/X6wyf8KzoLuZZ3+DalFYSnndpUJW9FjleeFrCuoxbs6j?=
 =?iso-8859-1?Q?vI17ITfg51hMyUy0qmMquq4QnVw0oph2KPIQ/UYuECxLMVjBfT4FyClovW?=
 =?iso-8859-1?Q?lR6Ttsa+KUTVwaL4wzJ2mbl7wb1pgr9IQg07W+5wRGZGjB1PnsBlMCys0X?=
 =?iso-8859-1?Q?kGioFIMb9XEXWQ/TSU0C2LOWcOjh+qKzrbtU9xccb5cuco4JRvLHlIeSSC?=
 =?iso-8859-1?Q?pk60H/91yDcxHFdZ2Fz6vfdMYdhybTCafA+GiSo/z8/9guUf0265qx8vk5?=
 =?iso-8859-1?Q?4IrAaMeyfiIgx8Xeqwb8qJz62hf1pLlQIX9qtnQ/E4k7zbEWZQv0fSpBFy?=
 =?iso-8859-1?Q?KamAUjt9bmZwyqvhRidhSYfEpAX8UIRmowyUIcpbP6uKoBqWRBhGRyMH8E?=
 =?iso-8859-1?Q?83c6+o1G8mk/hN8NMDcy3GKkA/5WCBZRzQjz0Nii+ncHI+p5JAgdxUCPFY?=
 =?iso-8859-1?Q?aKMwh8OxkzygPJMG9x8pISbsnIjfM1Jr7ysCdk0A3z4h93UGqEuk8SwzZi?=
 =?iso-8859-1?Q?OhHuF817O8kVx5qvCTU3rqe1zdbAI6PhYPwQbz1+bgJnEvWEavBBhDf0o4?=
 =?iso-8859-1?Q?LYUhsBHLjJWscXPurH7FsBpga6yKx49chRdwZ657/BO/CHd+o4Skmy8QTD?=
 =?iso-8859-1?Q?NzcJd5fCOr/lao+f8OQKo66Gw7wR5QAm4PFPe20/Fg0FNPXqELTN/VFQSB?=
 =?iso-8859-1?Q?QCqQiXBlAd9z7Av1QD2+OeDv9zL5n9qb9cJC2jMT6fjE4ucjrvLgzUNCvp?=
 =?iso-8859-1?Q?brp35z7vKwRL3JYDD3FqnAE7N37lMzfN7bt+5Yk9INed8yKUTFhZ8ipM6r?=
 =?iso-8859-1?Q?IZBN6grso1s3rsNt8E05QzYKP83b8recXkvOu8YriDbJXQfLebwa1XrPuB?=
 =?iso-8859-1?Q?4sxhd92nmUQEMxgiAIJ0h4SKHrPSQnj/cwBq/5fOESFbD/RrRKCSjUNb3S?=
 =?iso-8859-1?Q?9+RkNsrBkAbXdvDPhmxyTADv+GessDmeXYqss9KyzXdb4Fc5jvDp7jaIpq?=
 =?iso-8859-1?Q?4LeXs5PK+RI6WAyUN+rQpRZzLiHKNUGBTmm2dYrvAFb+gYGdL86FsQJSdm?=
 =?iso-8859-1?Q?A9g5hs83dqWR9475JcSmKcX2OW79Rh39G+A//boxT9Vh2u3i0kRq2vtxVq?=
 =?iso-8859-1?Q?kDXmPMNXDXQMQ8en+rcNFQjZ5kCzEzSTKCGfTjzYZmoOL5SWcRmNKvAQ32?=
 =?iso-8859-1?Q?dP2Bv1qzDrCRw+z1Bzc6Ykfg7pp6WPq9OGN/maLsTkL1mMZNn1DhJxN7Sw?=
 =?iso-8859-1?Q?JeyTqUKn2EP8PrJR3NxIJR/KnYHNliTDzaCh356nZiA9w/bm8OmaVauc94?=
 =?iso-8859-1?Q?1CTEUpqgUsEzf2JPPKN3PsTaIn3yvIHklJz4qY6EBO8XvyRrOLld6SLA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b92b988-a54a-4c32-c568-08da64163d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:53:11.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6NVrlgRc2eUDQneqlLxdndV5Yw3dZ5XeczgFqWsDcWDLFzURjf2f+lj6/cvoSN8kqobxnFmYQpb7x9U1OPLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120058
X-Proofpoint-ORIG-GUID: T7eLuc1Xapic4xoZG4uHXWyLjpHQJLK7
X-Proofpoint-GUID: T7eLuc1Xapic4xoZG4uHXWyLjpHQJLK7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When overwriting an empty area, do not decrement the number of expected
entries.

Fixes: 51282228cdd4 (lib/test_maple_tree: add testing for maple tree)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index b028f5648857..c5fcaa2ba054 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1486,7 +1486,8 @@ static noinline void check_erase2_testset(struct mapl=
e_tree *mt,
 		switch (set[i]) {
 		case SNULL:
 			if ((s_min =3D=3D set[i+1]) && (s_max =3D=3D set[i+2])) {
-				entry_count--;
+				if (s_entry)
+					entry_count--;
 			} else if ((s_min !=3D set[i+1]) && (s_max !=3D set[i+2])) {
 				entry_count++;
 			} else if ((mas_start.node !=3D mas_end.node) ||
--=20
2.35.1
