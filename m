Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A761959E9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiHWRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiHWRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:38:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23175868B1;
        Tue, 23 Aug 2022 08:23:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NDvGH0028764;
        Tue, 23 Aug 2022 15:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=sIx6iHqxn7tzpjcGUTvxb5JlRFWMjLG9NsIxDGkA8M0=;
 b=iIASi9Oy9QTnpynrci6THZN5CWalMR58Q9Qi5VGXXtxQh+hP3kJ+ryEvm8FsNHfputVX
 f6gm8nCw8dVy7ahgDCbwKFrvRGBouSA/W/tS3bO/65VM0IUv9NGS5U7uobFamVeAjJr5
 ZdCD61esp/G9UeinLcN4JjhkyDT34PWuhZgS0OwnShyLnhAHF6z4o8V2W8q/aHDGGsZc
 Y7y9e4zMVTyAxB91eHv1WRJEkuy2QCm12bY8Jk2ggUtLZqAGKkhixMb1EPSAHfJRYca3
 XGtKo6yYSs5GVZcz1aAEqFb+Zw1TS370EHRKNwOGxXZBhyNVQtd3njKR/C4kKQ5xc2hC KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8c2m7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 15:23:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27NE0WPO035447;
        Tue, 23 Aug 2022 15:23:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn5674n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 15:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtBw13A8vc6kbFRQ2gV3TFU+P5HKPfXMN4CkMlgeSnnbwRTFBImqerQvRy0EZKhxdhfR1eH7V1Rjdo6vv/ylD4Z3HfLKy3DscIgO+NqOj9Au4RPfuXG/X6PguMca0cjxkmFGuuolqTtGlXWEodQ/Yzq5Wty6HFvQrpJjYxiboe6eFItafpPqO44DpCoB1/HRYVNw5WbQHIqzo4e5FvknTxnc0asUeCYbFEEC6cEpmpBax7yPajeFJL1eGFt2SPv6uBs4qehhhDErOALkB3CkET0TCr9ty6/Sq7cQTTlxDYDixCaP3xSz67gqYeuT2O+zkyn2F0y6TlXDmlvKH9ktSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIx6iHqxn7tzpjcGUTvxb5JlRFWMjLG9NsIxDGkA8M0=;
 b=PzzI9PwyEuc2j8dEAx2azUaj/K6tzZFR6GCIMSmJI6x7pv4iZkKy2RD4mzxUjOD49C9l4pAUZsp8TvXq8Y35tOO2Z138mUD6T1kD5+376bnnrk3HAoYmau4+Klw2E8AZzXegI5BFfun77YAaqIQNHgIUhFv+mMW/xKiMVCbpPFiSQR7CIGbgrZNzjg1m9wrkMNZgbMPCwKmvpgxaPDYZvl/C0Qx3xRGDj8JDlCvKs+Uu+XMjIUHobfR3cn9WBXcu1rE4yINVUJ+keuiXv9cq1ZhahrJaI9xPcTBKf3SJWkQipAlKuaEurQaxiIUfEdIJ6/wNmm6DF3nfSqMlOOjwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIx6iHqxn7tzpjcGUTvxb5JlRFWMjLG9NsIxDGkA8M0=;
 b=buu/R4FTGBXBZGvKXVXgJORBQlNnFeTNBTSGQ8FPGNz6pO6djYxg30GKXWpmcXpmy0sKA5gV0tpHwz2ZwKi8mjyxbVltcmoNO9++yO/yhYwRwmbayDacGrjsL6YCIADmoZbqe448fWaGO9ig4KD53ntTvlGwDwtfK92lABrW+FA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB2903.namprd10.prod.outlook.com (2603:10b6:a03:8f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 15:22:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 15:22:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] maple_tree: Fix documentation warnings
Thread-Topic: [PATCH] maple_tree: Fix documentation warnings
Thread-Index: AQHYtwQ68MfgqUtaeU6oISDoywHRnw==
Date:   Tue, 23 Aug 2022 15:22:59 +0000
Message-ID: <20220823152212.1795380-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd712ce0-f07f-4a2b-17a8-08da851b5cfb
x-ms-traffictypediagnostic: BYAPR10MB2903:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6VbXWmOiRl8xLsO46I9gZqI9iFMOur1r1vRKOxZM7CNpaJ1y86fLVTjY4v4cjmzvWLt4AT3wA+jXkruapxW6rKM7ZILFH1fkyrAPIwJdqOZ11rCoae9IjBMuAXvr7X5qzWEZnB/8B4NRz9WQB7/pA+HW04ohT4vuAAYCe+yMekJKvPj/oxS9Gqy5lzdELs6k+fcTGdyrlI1kYdAI8k3NZu6Hly4XdTeoKZ6hBtIalQkXqURtM1b8aZe3+o3Cmx3TC25ptIvg30NtjnUjhKhPWyX1b0zEz3AjbjijobkckUuSauT1vC8SYqom42oz+/t2nDGNalQSr76AdOz9qDnHZCGvsZvKQ/97LxS+NtfMwW3e3Z97y/xR+9Gqz92iUSimkcHQLpJYHoppxjE/UkwB6u14/seLKzRlajbcdyoHnCps+SvcVwW+77+LZtqMMu1BfyOjAwaFkYTOSxr/EjRVowlvony1/8uifFaUQE6eafkxGfthuTbAWmGdYK/4Yr30Wko6TGVm+/9KCN82jrSGcItHCIXN7PyrLErKCZxBkR+n99LBXUPSF8G9TUFNfcDT0eZ0aGhpeXAZ0RSFiM+LwuVaIjNL+tj/gAS2xV4y8KoBbg3hy1H0a0qjcvMNb0p3PXSGYoxD5wAtrQ52mcAPIz9NbyHB4BJVjC83jMg3vSHvtzbuGlYLQveCMIH+k7KDbArDX4zexDMs6WCBg8mtlsHyJiAv83QPXVpi+Bcz/k6yau3gD+x1sPgITrqGcNusBPg4s8j1KQCCo1H63Ms/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(2616005)(66946007)(4326008)(66476007)(8676002)(64756008)(76116006)(66446008)(66556008)(316002)(110136005)(91956017)(44832011)(2906002)(5660300002)(8936002)(38100700002)(122000001)(26005)(38070700005)(86362001)(71200400001)(41300700001)(36756003)(478600001)(83380400001)(6486002)(107886003)(186003)(1076003)(6512007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qDB9cKBmrlpZozbNP9t80iq9DKNnbDgsp+kXDyF+un7sVEBjPM7Ea50zXb?=
 =?iso-8859-1?Q?KSmOrnZgwy/BmMgqjO1Pc8tfPhrkFmv/43UWHSUN/c52OHTgc5MV3bbJGZ?=
 =?iso-8859-1?Q?1GFV7yjG//kenwOP+78c4rVJ3va1/r0hk3FTewEwCgevJR/FxEQXMlmGQz?=
 =?iso-8859-1?Q?AHY73Xox+Q2ByfdjnLeVAqaR4d3Z6wrZ1m+NbM+ymJVBPZ+rT6GvH6lpZX?=
 =?iso-8859-1?Q?iuKi3lr4xbVs3hxaoAK/dDFR/KfNOXDMvaczFGQsfeH2u02X+5+agWoehY?=
 =?iso-8859-1?Q?AqefMCLI5rv+zTfEdkNEnO5CaXWVbAY00cJ5VTZAPSbUjG/qhCSWQJ6KR3?=
 =?iso-8859-1?Q?DZnor4SQugW1lyAYwc8RH1MCAYuvgGhs7K48dmCeKM83ZY6DdMGTtR8TzC?=
 =?iso-8859-1?Q?wZUO9sAfdqfT3hrnlHh6J2NhBQWfyM2GVFC1Lb2GeZpY9+jAkR2ZWY4piP?=
 =?iso-8859-1?Q?OBZRVliPPTsFJEscg/uOXPzNA+vP+LBnsturcWkmRYcQGvRCDeCripjhZQ?=
 =?iso-8859-1?Q?FcOfwZe7of4fzaiEHdAxh0S95XABJ3GQ3pEJX7xuD6GYhfl98CtWdJ313S?=
 =?iso-8859-1?Q?6cCvOudRMoNVanCHvKzd/le7fX7VrZfYV+NmngwReAedQWgfAmJFqMkxuM?=
 =?iso-8859-1?Q?p++ov9nvFp+11UUjq0TEBtwIRRFQuXssGOnhEE6LQ9sqtNpnj1nHf66XDW?=
 =?iso-8859-1?Q?VBuydkXWMgMNh6nF1WwjAnaUIKaJtVrbt9+YA0itOMvfevoE+aX3DEb3ah?=
 =?iso-8859-1?Q?zE6i/owgoB0y0yodaYJb/UEhAMwS5F1CP0mO4zn1cSPZ6KfqufdT+W50pa?=
 =?iso-8859-1?Q?yvJz7kFiy/CDWU62yxjiYujMA4SD3mQnViLBOyhsFDwtP1nXjIL7bnWRi5?=
 =?iso-8859-1?Q?Uwfci8WZikgTXY4BN/DHr4QiIwxUfeqlr80O7BLn2dY/BmjSk4hkGDB0FZ?=
 =?iso-8859-1?Q?5vW8iKmL2vd/Cf02fZ3xB9eE5hUCooQ7e/9jrT0sbt5ggEbgneA2rvjil5?=
 =?iso-8859-1?Q?3cGbHwyZ5XJo8IUsqGpCdpWKU7/CtR+LtRlPEBzcOsr73rsJseJWf8ssDE?=
 =?iso-8859-1?Q?JKMNReoAjItgbx69t1nSe2At9CLUho3u+EpdCmJjjqz+FAnkeIhJ1UghId?=
 =?iso-8859-1?Q?DLxmpybK1pcanV20pqXyGdJo/mhDGBmjXiPoKZyCAH50uDHVGmPM4ORGIT?=
 =?iso-8859-1?Q?YnXy/+vDN8gfF8HAdDHOg9TsZRJbx5RGw35pokxDG5VqY7Ywdta8msySnk?=
 =?iso-8859-1?Q?Hy5qYRmMNZw8r1UDn9eLL+jlCqtaDgiUpht9XQVrXO3OLzIeHx+qtRW6pO?=
 =?iso-8859-1?Q?/JHlcA9JOS2XZnB/oI2Ibp4a81wZAz/Dy+7rjB8iT4Uuk7MDPD85dMsgYM?=
 =?iso-8859-1?Q?2WPjotrlNrbW8qJdg0k3XEs2PgD0vrBnJl5w2hiZOcxy+KsmY4WgMxtNks?=
 =?iso-8859-1?Q?EdfPEXT2FoN+/+u85icXfZbfFQvR75ds+HwXvgOXfbAaTk4TrlOdY7TyEN?=
 =?iso-8859-1?Q?P9MG94/59BQl8yDSLbPr4GNBCVSBz1mPPOi4r1XJ1aqe9DOKsu1L7CJKlQ?=
 =?iso-8859-1?Q?9RvuHg64b0BBGqIG7z1FYLX10jexnreMPZh45EfwFbwBv5ogzuG17rUh4q?=
 =?iso-8859-1?Q?dG4Nf8YCEwT7Pt3nSfaF4ow4fJQNN1XB9h3sUxo/Rt7CdJdN0AhZ0t/g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd712ce0-f07f-4a2b-17a8-08da851b5cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 15:22:59.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iEJAYPsIdHUALeDIHys0/fCldMMRxaYBM2A+MWJBvyaZkRMaVYpCqvFjeyYpj6uHowwfPAuYIbtwP4i3THEQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_06,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230062
X-Proofpoint-GUID: ej987uDbBwkNJjoRdt2wuG91FJNFLVkQ
X-Proofpoint-ORIG-GUID: ej987uDbBwkNJjoRdt2wuG91FJNFLVkQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the argument names in the documentation to match the functions

Fixes: 96ba2a9525fb (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a30e03b06bed..2effab72add1 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -220,7 +220,7 @@ struct maple_tree {
 /**
  * MTREE_INIT() - Initialize a maple tree
  * @name: The maple tree name
- * @flags: The maple tree flags
+ * @__flags: The maple tree flags
  *
  */
 #define MTREE_INIT(name, __flags) {					\
@@ -232,8 +232,8 @@ struct maple_tree {
 /**
  * MTREE_INIT_EXT() - Initialize a maple tree with an external lock.
  * @name: The tree name
- * @flags: The maple tree flags
- * @lock: The external lock
+ * @__flags: The maple tree flags
+ * @__lock: The external lock
  */
 #ifdef CONFIG_LOCKDEP
 #define MTREE_INIT_EXT(name, __flags, __lock) {				\
@@ -509,9 +509,9 @@ static inline void mas_reset(struct ma_state *mas)
=20
 /**
  * mas_for_each() - Iterate over a range of the maple tree.
- * @mas: Maple Tree operation state (maple_state)
- * @entry: Entry retrieved from the tree
- * @max: maximum index to retrieve from the tree
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__max: maximum index to retrieve from the tree
  *
  * When returned, mas->index and mas->last will hold the entire range for =
the
  * entry.
@@ -646,10 +646,10 @@ void *mt_next(struct maple_tree *mt, unsigned long in=
dex, unsigned long max);
=20
 /**
  * mt_for_each - Iterate over each entry starting at index until max.
- * @tree: The Maple Tree
- * @entry: The current entry
- * @index: The index to update to track the location in the tree
- * @max: The maximum limit for @index
+ * @__tree: The Maple Tree
+ * @__entry: The current entry
+ * @__index: The index to update to track the location in the tree
+ * @__max: The maximum limit for @index
  *
  * Note: Will not return the zero entry.
  */
--=20
2.35.1
