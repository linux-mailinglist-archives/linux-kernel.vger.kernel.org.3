Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43A54D6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349986AbiFPBSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344266AbiFPBSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:18:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009E755A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:18:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLpV60029748;
        Thu, 16 Jun 2022 01:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gTOa4sCsowVfnMdwtik+r2rl6y+WpU7ND9MuGs2cInU=;
 b=WwbgqN0jBzUCDRGnAFlAXcMr83worM9p824UDNGTRp9FTl1N4uuzO8PITiECiO9/Xcul
 DJdSEqmGxSxnFTXR/vry5xsBtI5ynC+Oko53ZfD46QhfEZ0vIwvay/o8P89j3lNn2ine
 l7siedgmFxXo3ILD/ICeykNu6F25AUYvWTzSpUBC+SX3/9P0KvNFw6aNsWfOmfA3hCHP
 IohsRipHNA40RFG/R8f9vTGKT7jMK+WUFVMNZT+TtMU2QstmHKDLGpjUkdwGECgAy8Xn
 rzQomfqUCR5LS8Ap81tKyhrBPTpaCjn7qCbe3jam1/raQ22X08FIdBMC+CEvmK4co1UP vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9hr0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G1AY2o025240;
        Thu, 16 Jun 2022 01:17:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbsbqhj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4YwK2tcX25HRqp1w5AiU5dTlT6oKGR0tLdzP9a3ezN6NiP6F4FTLWcHTeXjGyZay+E/Jcq7FWLgsxDIeLbUlPS6quTdd5HO3EpB8UG+1lAgkYFkM/LrKV4E+JpRZ87jaYjrXZs9sdiH+xgAhpiuxn4Rt1sx/LzV+eLRRSrq/HZ8lqJEsgclDHOydpeY0KcSmDt8DvzRNxS+xBE7fFLgh5pl4pKBtD+y6tO3enE2vgwkU0MJ13M5wwMsM0FTJv2U+G6yBdVYciEoGwMg7SfO41JoD2EyGh7QIFbnjqbZc+RggZMJEObIfrSAE+CBhAh6ovzYODB1Z6XO1OyBeIBfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTOa4sCsowVfnMdwtik+r2rl6y+WpU7ND9MuGs2cInU=;
 b=EMoYT0ng021K0ChofsyUVQzTb6EQVyD4BGqTcO3rmcWjrDy4NGkYbDtoAIUMLqUbqHBi8jC/TpY4dd+RtwGEzkPp9SdOndw/zyo8uMC372MqpNxmM7hn0KbdUWR/F5NJotyIagb7U4ana6stxWclUIMzkbAXCloh9NyBB6jZgjjiR5C/OUgMUHKJjK0/ByCL1Oi+ikcivgideup+aHJCUTBFmFgW3XVBO1Bh2N6do//3GnDgETx0ugOEbWSv/IP4t7tqwmULsnjCBjJYtqdmlYQ8eehLCl+r7lkVJ2KW3zopAVftXhXFLRd/NbW7MESpHCpac+X375GvtvzVECYuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTOa4sCsowVfnMdwtik+r2rl6y+WpU7ND9MuGs2cInU=;
 b=f5p605Zi2FlIR8/dCUliPwoQoN8FqD2B5SqTBp82nudMpY1wDwPLKyQ4h1AQ6+iUHG3X1PSkT2i1OeiMPbnurC0JVKcf69+qrUiCFyQhPV8zRm1Atyu7NMBiSlkT3USqfc9cjEK2A0sYaWH6ntGdsEum9sHetE0i+xCu8LsDXdo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3456.namprd10.prod.outlook.com (2603:10b6:805:d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 01:17:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 01:17:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 Fix 1/3] maple_tree: Fix mt_destroy_walk() on full non-leaf
 non-alloc nodes
Thread-Topic: [PATCH v2 Fix 1/3] maple_tree: Fix mt_destroy_walk() on full
 non-leaf non-alloc nodes
Thread-Index: AQHYgR7oTco3DccjcUe2xGaJZEub+A==
Date:   Thu, 16 Jun 2022 01:17:55 +0000
Message-ID: <20220616011739.802669-2-Liam.Howlett@oracle.com>
References: <20220616011739.802669-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220616011739.802669-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdb094bd-4b82-45d9-f784-08da4f360aa1
x-ms-traffictypediagnostic: SN6PR10MB3456:EE_
x-microsoft-antispam-prvs: <SN6PR10MB34560CB217D3FD20FA0EBB6DFDAC9@SN6PR10MB3456.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFUCRbhoPmwORp2K+tTaRxvGVHRPN5ENehJYSy5Brw9kVWKRkiK7PW6dXvyAqfo6xn1K4voFY40h07en3zOVIcURhOcXcYfSbF+UAdM3BDg/0TV24/3+0vYi2TNMmHP+qNNermSpwBItQ31tcNfYvjAIjOGJ1RGP011DePWxGpx9uiDxCWOSd/4iUdXEeEqGQx4eEUVtWN4sDjrG0vBazfoKuHh0ZQx3sqf4JsiqZ2HQe+1Z90IRTodlrFlHQb54uMYgj3WRWWIn3BDUCqUp2EiocJkh/sV3CEwWgD2ZYS0X3qMIDU45P2T1m3ZOFgGViOU6M32mY9+7g1skzlaFUHdAasqhueF6YBloKrduE5LoFlLfL7G2fqMg6BgaeEIcjQY6sj/WbLYsAmjmM9GocvRIONLK0gED7O5WIX+aMsL8PUE2evLn2yxHgRUOpP2LS2UnYR5HrqKBh0Tfgcvagq4IQSfTk4C8RNyx47CACzPJdaCMjI+nkMjb1iuYIkx9cMuvizVzILElduikkvD13eFmajYePtp3o4kjPlnE0YZtcj03C65zqZ4Vh5Rbo2iWOwkkf+7njTJw5wzJD3TN6boDGRmjALKVJ3GoAn5QrFWeOHFpDUaHClnU0IGf4NOupOM56/bM3oyARxyTeFyx+6Jg3GdJxafok+gQiXn/TdL0WkyIE9XoqKBC8s2X8UvyGFsWx+DgRtvbVYusHVUCgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(186003)(66556008)(6506007)(1076003)(6512007)(2616005)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(76116006)(91956017)(316002)(4326008)(8936002)(508600001)(6486002)(44832011)(36756003)(64756008)(5660300002)(2906002)(66946007)(110136005)(8676002)(71200400001)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RjpsR+W9HX85NCReePOCfcqgRg5Iz8JU8vOT9j53XeAd18O4imi6aHOX7A?=
 =?iso-8859-1?Q?xcJ4Cte6fVJFXkuZxrQfpFFfo4/xVVmbllBmh0KRAHszIwXrPIO1PhpPs7?=
 =?iso-8859-1?Q?Ht/CnOsusKzJYyVzWje3/4BcWB7qfp/bhhF+RjbIW6O4UAr8eOvd4gUdjo?=
 =?iso-8859-1?Q?NAkjnrSxNrJ4CI+PjjZSn0IRexCVkrbiM5YIgnz9kUZKFYyk6e8voy3bKo?=
 =?iso-8859-1?Q?fDsW8FmNvyV000FjIwjaKsOltFjQcgoXqruffhhXhF26hQbepBodjKt/4i?=
 =?iso-8859-1?Q?ghxVy2QCCQ2B9meTnzUfYBPBbRoWtrmUMLt/Mwpl4UxmU9laQy9zsMSXeD?=
 =?iso-8859-1?Q?793cxrf3JJ/h0bjyefu+xVKzBSj6D7KLZJ8J4+rbvi8tWf9II/rBl+hzjd?=
 =?iso-8859-1?Q?SuOXMH+eJ0CwvAKNtTqueUyv7fgBW4xEglX70syfX7dvEVeYy07x5ijDeb?=
 =?iso-8859-1?Q?iKYxgSHQyuqoYDJoJanUy0PAi3w+vwUN/DgFIBsTQEQoaqJeMg8V0fE0P5?=
 =?iso-8859-1?Q?RPGkh0033p0Q9YkXbXRA0c6SWUtKzoGzlALPQNdDSR8MF1luYyPtfiBeVn?=
 =?iso-8859-1?Q?yMfJVVhf5nA97OWWCYFZIEP4ZD4wjeOO5a+jqDdZRbPq46hSS9hzzKInI/?=
 =?iso-8859-1?Q?JKQiAJOQvH/NJF/3b/negWc1VM24q9NuumAr/XdnUZtt+jD8G8ffs3JOFt?=
 =?iso-8859-1?Q?cmATnCmXoMTTjb9pOV9t3VpfuOyYuB7m7ajPKq7ongpqi0CdAVlNqCUYPJ?=
 =?iso-8859-1?Q?NspVh8oMh8L2lFYkepOK9c4+E9pH6sVPHDmt0qkR8xVEOih8iTiSiD6BQU?=
 =?iso-8859-1?Q?V0jtYoWVJ+45yrt0k2NqEdRuGfNjoPWnhRs1kIlZccpOAutuesYiauMJeO?=
 =?iso-8859-1?Q?ygTeSS8LPKtVOJnoghEhjH/K23a+ShQIDPYUzX7IrtThJCeMUxgce8qeoj?=
 =?iso-8859-1?Q?yoSGT4jyKelwWL2mLhULMmpIK02/TgYsXKa6FwjdiBLo9+hC7t/bnFgAx0?=
 =?iso-8859-1?Q?AIjApqqJc9rRMQ+2rRXugVI47MIiOTMTxNUATmwufZZa5WGWO+YxnVepu9?=
 =?iso-8859-1?Q?GWxI8EscfTyeBh2xLrvPep5QOf9w+p/H4RWbxNQ7v+3BKpJ8Y/5bLeHHqW?=
 =?iso-8859-1?Q?XWECjN/4DF6PJWdG4QhKky8wEb6xIU4x0wuoVFrPZtGmvMnmY337Mv2Qbj?=
 =?iso-8859-1?Q?8V/ZLucBJcZhBN/e/C3ttAH/lGVasWVsK1evKiAWr7IiMy3rG5Vp4zBOSb?=
 =?iso-8859-1?Q?Jyq5z2GLHOJd1psz9LdBC6f7P3lMu506pbLon0JSNiek4ba8h9AEzRHQBJ?=
 =?iso-8859-1?Q?7cEbVIX107q/Wqfb/RLRAOGYQ+Qwcuema5HBikLHAB1WEVpAv29XkKwKD8?=
 =?iso-8859-1?Q?NVz+4rfRuU0dHcnP/+ddEauit+P+Bo2Ce4S+f/UYdBBsEWVQ/ICegp97gl?=
 =?iso-8859-1?Q?yytNvDNNjXPN8PfRObtFUVGt3gU2OEtqAR6y7oDfp8BuU7+lhjfr27k3Ef?=
 =?iso-8859-1?Q?mVBFudgQQ6lRHWAkmOKJhGu+3Idec0dv9S2gYoD4Sul9RsPjJ4BtLm9B6T?=
 =?iso-8859-1?Q?OdCay9B8tmJ9Y/xuht3wowZo1uSHhBDwvtvbbtmm5Swjiy05Xf07LPJGON?=
 =?iso-8859-1?Q?M355q8YpoLyUDmZtS0I1F3Vfx8vIcHN01MqkTV0hmP0uT5Z2BjgWI0q2g3?=
 =?iso-8859-1?Q?WFPn5LX6L4BIHy6FnN0wD/pos4M9zmavlVRGQLNEL4perJqdIWj27gseYv?=
 =?iso-8859-1?Q?rV03xHOXsebvOZfnowy7vo/nsAkhx/wrPNnH4Lu6ueWknLn6NyqLa4Z4ST?=
 =?iso-8859-1?Q?DSXX5v1dlsHRPgKE+AnuBafaGGlWUyg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb094bd-4b82-45d9-f784-08da4f360aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:17:55.0936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPf7czaI440CaYMENE0TM3rEaTCbPai+YeONdB2+Es96tg2CfayTM9Z7f+LTC+2UAc3ivfPn2yJF2Bx4s5glWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3456
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_08:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160003
X-Proofpoint-ORIG-GUID: NaYCMUcC0OvvXIrkMoqd5xWpfnEaYL0_
X-Proofpoint-GUID: NaYCMUcC0OvvXIrkMoqd5xWpfnEaYL0_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to iterate over the metadata of full non-leaf nodes when
operating in non-alloc mode.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 80622741c6b8..a1035963ae0d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5429,11 +5429,15 @@ static void mt_destroy_walk(struct maple_enode *eno=
de, unsigned char ma_flags,
 			goto start_slots_free;
 		type =3D mte_node_type(mas.node);
 		slots =3D ma_slots(mte_to_node(mas.node), type);
-		if ((offset < mt_slots[type]) && (slots[offset])) {
-			struct maple_enode *parent =3D mas.node;
+		if ((offset < mt_slots[type])) {
+			struct maple_enode *next =3D slots[offset];
=20
-			mas.node =3D mas_slot_locked(&mas, slots, offset);
-			slots =3D mas_destroy_descend(&mas, parent, offset);
+			if (mte_node_type(next) && mte_to_node(next)) {
+				struct maple_enode *parent =3D mas.node;
+
+				mas.node =3D mas_slot_locked(&mas, slots, offset);
+				slots =3D mas_destroy_descend(&mas, parent, offset);
+			}
 		}
 		node =3D mas_mn(&mas);
 	} while (start !=3D mas.node);
--=20
2.35.1
