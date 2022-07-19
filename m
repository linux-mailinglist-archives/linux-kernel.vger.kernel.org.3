Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EEC57A479
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiGSRB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGSRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:01:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EC13E749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:01:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGv4n2002392;
        Tue, 19 Jul 2022 17:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=uEfojsuFXzcLc6R/vzkmcxQuRnP6qSPfxKNZc+shJQY=;
 b=kY1bSbqcWBbx7OOaCbBnIKDNDC7D5YfhaWxLyf+VpxLSFhko/NQ58YcEhlk5jvRYEUjZ
 nTcynTFlk8KUn9TtAvfy90uP6wMz4J5M4Eu2fPWl2eabU4ESjkldcPaJwN8k0qaNaS+C
 JQCLqmhK3NvjUCtomOTQZLXO0JiWXlOA9sf86mUhEgajlXN8KFyMF+N/8r3bNazG/MJB
 +lP3S91LYpt7mLVdtmF1FlmW9ztrFRiFlII1Ju7ISvPLtFMhhk87MfhhDpdfcuUOOMk1
 U39DPXNZItkPxn/cnM0RqnOPR4Q6G2/XmM3625b3iI8/kZSjoKg8npvjG/rJ9pIZrx3y xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a71xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:01:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGcMM9009872;
        Tue, 19 Jul 2022 17:01:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ggpbc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ1wlbFsaFP89g8avALtX7vyrDcArFTge88saHdJ6JcoN9pHOZumNlVBdQTBl+QOcNwM08OIg0UgI7azmqHHZsloUr6vXsRGzxgk3FMJI+RGJQxEuOt4/wyKFlfJoYqza4UJSta0xI10YpCiBrkXRcohnY2qDt/+NZQLlbISGJMQbwZ/xoAcQXxbm8UzcRlC9ENys9JEhO1RA1KnCFNplww0oV2n9b/Rqvgbgb21Fo70/MQGGYNb9eypx1eJjW/gMn+qIbn8CZOiiJNSQlB4wNb8T/7Wipfd+yP7V68jbfzbaIy0EAGhOnLYnKOCaal5X+TZ1sO0aqBt/pa5D2RuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEfojsuFXzcLc6R/vzkmcxQuRnP6qSPfxKNZc+shJQY=;
 b=bB0N4d5Xdlf4pPAoL7HKdLk+RDaSc98wIeybtt4xwsbx20ZY1gRH/0qEaqlZFLyKnTqlLZ5viNDkM39f6Ky4sr3T65NTMGRuc+tH7Q1W8MdOgdWKJhNcBx/cN6PHmWDRjxGU8TgtDW4sbb9678r2BWFZNBU9odQ1U1GGZic9vhHxbMYukeR49xymGhLXcO4LUnG1ZqjXLYoaMQGGgEd+XkM0DH8DtNUy7MeUvFrj9AIHd/t7kopnxiakRK9XcEYdZvqOq/2FMB0jjBSY79hCrl9feikMQ6d7KxKUndHvTI23Jd+fwLj+pYaigfPOlVuIJ/2n4+4y42CGpFwvBph9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEfojsuFXzcLc6R/vzkmcxQuRnP6qSPfxKNZc+shJQY=;
 b=XTPEa2ARLnuItCBbrQWCxcwbz7qo90GHozwQnOagJOG/Ems7rPir90AboxUuL3JSMWpiZFjssLdPWItzkS8rHUREQ+A/R95+kRJo0JyQ4/3WuDuGUOM35YUxvTp+BssmSrb47xNV/jVAO/sdpG23NzpJXbyibky9pzdR/UE2GmA=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SN6PR10MB2846.namprd10.prod.outlook.com (2603:10b6:805:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Tue, 19 Jul
 2022 17:01:30 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:01:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] maple_tree: Fix mas_empty_area() wrapping
Thread-Topic: [PATCH] maple_tree: Fix mas_empty_area() wrapping
Thread-Index: AQHYm5Exy36AdhZ/tkebA+FAHED6dA==
Date:   Tue, 19 Jul 2022 17:01:30 +0000
Message-ID: <20220719170118.3296447-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f7c25e8-2482-4e09-57aa-08da69a853ba
x-ms-traffictypediagnostic: SN6PR10MB2846:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxXw4p5A9tqCon6C1dsr4vfqw36AEYQ/0j35Kvl/UbugoT6oz8OWV/NDaE8cW1k0KoZ8skSpce1OEBaGkxAiByM7eykqj8OpXAsdmZfl72TcQoArGpuBF3R/U2bL9jt9+yaGl6fH0mtZw6XpOVcusTldXTAlLPI5sZ5BPfSbGxhAYH1Q+jUOqDMyKAJMS6mFxJKNqMsV4vchG2Jhw5UR/cwc1NJ7MjG5lKEBE/oF7ZBvfCkjUhfFQYwwoqokey5WcEiZQY1OQuQ3QWE+ywQTYVaysQldwMe8H0DakQ/kKOySRsfXG4usKVfnu/v5/nTdx9+pLkTXmvRR5FcckeudeCB36VeJ5KL+HCc2OavlyeI7LHWG/aYyce2UMFo5xow75NDmCwHzuRcoF1lUnNrMVIyd1sZ+QDjw5/xlm97GMxPkgwuAcACcFVGw1pVWfE56BDZ/BsM6b7+jQCyt0W4/9IIS+wyvVciJdIJ/1iOKvRgmkoEGHh1t8EmkPPd92Fr6kxcIlxz/9unJ3ZZyeAmHFqvarSt1X5TWkqbWABtKS0T5ds2jmV3CNSLCU+sauSNCFdc/7+hvhx/AkI19dTmT1y5pu6pLmjcADnFdyQRh4pHh4wHEwB/MZhmGmI1a6nby58aGgnicBapeyeNggWjX9vYATxVTH+JkjYJn0D9ioBJdlXK7xVDSpWT8qD5nFu2utnSuwCZozjlomOv1EpnFaTurAntaAcICre2V8pFf4sEimKUR9TyvEmSZD+qKQ9HXH2+tuIphyrV6cnHwJ7IfkiDdaPqaYUkjEiv0MplVvSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(346002)(366004)(71200400001)(41300700001)(66556008)(38100700002)(478600001)(2616005)(186003)(6486002)(86362001)(38070700005)(1076003)(122000001)(6506007)(83380400001)(6512007)(76116006)(26005)(44832011)(8936002)(91956017)(36756003)(2906002)(5660300002)(64756008)(4744005)(8676002)(316002)(66476007)(66946007)(110136005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?03jKAJXQIi0M0FylKnharf5zTywDQqS5Q12UctgAg07dg/LxYiNMbFO0ja?=
 =?iso-8859-1?Q?pKnZTt/+dXZbtTuWFPoB+fJxUM1lM/OaeEXkGpngCickgg5v4JYDw1koEP?=
 =?iso-8859-1?Q?7levoRjupAMmKadzCoMSlZUDPwKT4qRQDRciUbwv2GqXCrzhGKSkC1w6q3?=
 =?iso-8859-1?Q?oglTUgcDUNx8liTTkS0fZ5pZU1SO7Ifm3GOCj1Krb+JgOWj2OSdnPWMZka?=
 =?iso-8859-1?Q?ZJT8uU+ulOpbpzUkqPxxX3Ilir6n8fyL3m7mF2mFKwmaf73Fb5gLJYmV5W?=
 =?iso-8859-1?Q?EjUlUHvv2n1B+ejeVXWgANz+IXxjwXYntIVhi96LDuxMHJw+90t80s8m18?=
 =?iso-8859-1?Q?8kKLWzyr7gKjfewvCfjHX6JI10zIO529XN42zLR//m3zPgtFPgRZzXiS3H?=
 =?iso-8859-1?Q?CGcfVy+vFebcZTDHJ6HZmD0x84ERgd43SMsWGnc/RSNR/jsl/0vff6wlyW?=
 =?iso-8859-1?Q?d1zF3hr3PM6Tg/Iptea+TRWov+o4jVzVHPqWkRURVjWz4HKjYwZhkdeekx?=
 =?iso-8859-1?Q?dRQy2hYciHEazxVKyld2ZLv40ZZ9hxT/QgLjQqjm06YsoQYiHhh5IfeO05?=
 =?iso-8859-1?Q?yF74+jZMND4dAB6VXvSeRgTw0zNrdhtHaBmuCSDiLUnWemQkqb+7iXyL0n?=
 =?iso-8859-1?Q?JcoDWiHQA7kzoGEHZ6qoHBktWv0hObc1K6XsYF4XQaYqDoAYg61UatOkxs?=
 =?iso-8859-1?Q?Yb05M234Xg33cUMrS7A6OWzK1euhuqGIyCd+iqx/aTUgOT8TfbjoWJG3UJ?=
 =?iso-8859-1?Q?M0MomIFf1L1BrYTZ5xAr1Wvp0WCqIZde5I4jRJT2ti0essMvXSWh1qyIW0?=
 =?iso-8859-1?Q?Hj4UKXfApJzNI/1vv+LDY2PYLRRhQ9gMwEeRL95zrBgX6rTGA0rzGq+iSy?=
 =?iso-8859-1?Q?UZhm5GADV2KBkGXUlqqvhT7N7RT8xJ96z94GUaeIw6811DGE8MqyY/K5CC?=
 =?iso-8859-1?Q?ws8J8EOe2GhSZ3LY8EF+w69Aaj7k0diWKV4pFu1rabAy4oaD9c6L0CdTzK?=
 =?iso-8859-1?Q?Ua3kUvAHnC+M3WokXqBHMQgDLNBDmWaOgc7W+be4Hz6Ournmm6oPYByj4U?=
 =?iso-8859-1?Q?N06ePQN5REqu4asiXV4TDptY3onFpR2dJ1QqiM66OpwjXGXbnn/9Ox5kQY?=
 =?iso-8859-1?Q?WyOJi8i7zrHeVEknDZoW/FvI9Hfi9eJu0t9BfUEphtDiHBj5Mfy95mAL7c?=
 =?iso-8859-1?Q?s/vcD+KMfx4qqtzjgVoW93/ZuHfJYs5bjHstj4mimxRcaSpkgtwX9rGcXk?=
 =?iso-8859-1?Q?b3Z1xwCOMYiO2y/4trpJKBNNIzjLpqlSrGHspv2GzFhfLG4APPUcOCVhYc?=
 =?iso-8859-1?Q?dxdFlVaLd+4gootRjN1fBv4QjChIrPKpVothpEXbAYIGUZ1rCIbRwcoX3h?=
 =?iso-8859-1?Q?JWNNeVvLMQgPbhn7gZ2X8+M4qbaCBVwYQu8OgN2N9aa4z0fQ24sU/KYMZS?=
 =?iso-8859-1?Q?rJ+9Z+q0zmFtvsxoEPrqBwDAL1FvSjEdlTCyBaBt9ZdZhkwHbduq0JZJNi?=
 =?iso-8859-1?Q?jEUtMuPGTWQb3LvnANyz+ZKDwHQc6yfMvcbmyVdzV2YcfaBECNkeXLCz0V?=
 =?iso-8859-1?Q?J8LlaU30p5KEflT1NzMnWEr8hMuYgyz7c/XcqyrnBVYABTEh81hD2R+3Sj?=
 =?iso-8859-1?Q?3mRy6qZ3lhdPUB9fj+9KTbDKVXtYBE8T1fxwXUYKyVTLMThO6GJMI2nw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7c25e8-2482-4e09-57aa-08da69a853ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 17:01:30.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKn8IVYfIm3HGzZmO6vaUm9466fIYoSf3Z9Ezl7C4xqOpJHsLIrYpxOGe4QCJBIq0kO1pPW1mW2WcVVZzd+sIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190072
X-Proofpoint-ORIG-GUID: 7b9H1J3GKHBbQhU5d-vlGOaROfm45Mog
X-Proofpoint-GUID: 7b9H1J3GKHBbQhU5d-vlGOaROfm45Mog
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the error code correctly when at the left most node and search has
been exhausted.  This was an overflow bug.

Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1b8130f19c2e..0c0bda979693 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4994,7 +4994,7 @@ static inline bool mas_anode_descend(struct ma_state =
*mas, unsigned long size)
 		}
 next_slot:
 		min =3D pivot + 1;
-		if (mas->last < min) {
+		if (mas->last <=3D pivot) {
 			mas_set_err(mas, -EBUSY);
 			return true;
 		}
--=20
2.35.1
