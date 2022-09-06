Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD05AF4B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIFTtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIFTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA097B04
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAiV024665;
        Tue, 6 Sep 2022 19:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=FmMp/qj+SUlGyPjC7AxkYLNEGIS5X72t7VEdY52frUlVnGLi0nljO856l2N4tYEsxTpi
 PlywHomt5MVjKbZgSfoO9ICoSYs254sD/6tWx0zfmoSNjOf7IVDeu+CfRqEVvZL56HSk
 p5IXxrUCzSiCQdZkMWdtKVCbu9E44D7hiTYbw7jpDOeYUuy7ItMVgOGHEZ0BlpaI4Zdw
 bmz+8Z8EbZDo6uuRaGeEW2Hlo8ztcuaVtsMKYJIjVp1eCLsmPH3cWl3d31jjKfyV3Wif
 TcCpCB06/K3K7VswHsxMpLckE/+/oW2RY8yZ17Z91+Du+X0H5I1FVWQN1s1gD5e2kUex 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HHdKM037489;
        Tue, 6 Sep 2022 19:48:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32vns-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTyJTHZoZmvULpQvv9p1RfrZIPXawQjfW342bYFT0ZlU3XS05u2P5JZU2RqpouFo7MWqnFyGi28a0hXeGxA7LABNes9uHtgvlq/NmDUYpPYT/wN69oLA+Bs/Ga6RyONd0OiLcMN78RRt7i+MHrMNvukK102OP5atnB9qnsWF7rWr3yIWLfWuX/h1XajceEBSSBgrr44IJ3bhb2RXS+eMaGR2ym+JY48WJPt/xF2NODr0RT7AIqHXcwtYOUfngZGdlaeNjdShGNWRucfpeohdINioyhuFd0zdoCC9RAWp9q6yVdCGAIowoQo7t1Dw3t+pkHeCHkmmpBEw0TSeqTjviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=kH2ErPcOKyFTCJWfYooe8XUn1hYkc5+bCFyvWLGKeu4A+FA/IlRjovcGB7SRukQH1TZYPCpLya/4pvrMZa04rnzwE4ijkAVlvJbXhTT7beBPgtrCrhq50TdqgmQc7x4VuRi3e+NTOp0Dih34cqTnIGDuD3ns3oc5PUYYOn6yQbKYVK0FykIhBs4ZlLgN2tNePFVbAXF9IHFhymCXAzikt8+IAXloACh+agK4ggNlkeOqgbggx3j/MVrBdqKg82MPkxvVspbf67PSoLwDe5I5BDFp8eAYVI4qE5UozBB3nH5vAgDEjx+ib6TlnLPH51QoR6K3wrg9UjUoZiS0CtkgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Zfz471W6ukNOyhk0Qf2GGR9Z4MieDkOVdFAcoHHpI=;
 b=ma+6m3S72e+1KNeu1p6xU/LJaQLxATQw932ZrhAe8AGridxzr5f6tuavKx5CFNMfivZupANvb8obKVvvmDSeljCrqgYDAytG1IpXcsnBwof9hQI1f/trOlEpLonnkUTX8QJrcKlJkWFPe2ymXjK1BycMGfTEX3yopOm18rCeuAw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 06/70] radix tree test suite: add lockdep_is_held to
 header
Thread-Topic: [PATCH v14 06/70] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYwimqxXLoN4eu0Ua0eRnV+uwFyg==
Date:   Tue, 6 Sep 2022 19:48:41 +0000
Message-ID: <20220906194824.2110408-7-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cc36eb6-2db6-4143-9574-08da9040cd30
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqHuYGXQvDBTkI7zoLd1KkWjRIppVzCl0W3lg/GwAYMJEL+2Drw+BqHXpELBD5aT+l3gEvPYkrQVhgVNF9YF93X6iveWrPi+FVRkCac2N2CQu4tz/hn6pxVn01zJEzlv1IjM6fusxbjSGP9MusJpayqKmtrhByeRxqZg16WBMV1kjHIxd4W87j00z3OUF3m50yFF5XoVFXcp0eUeNkiKIK63ckilf5bdCrN6lc4/l6i+GcEiifwuc1S9FoVYozqi7a2PkqrKAe5kMy94Ka5B4bw1XEHEs4dEJgQyYiwIN5TkH/hY53bfvZa6T0t/2eHjv4WRAmGnPhpnwCqX2zK3lhSdFMTRrZKSh7aaGe5aUKrkKzfH99/fzD4rqiPYQRqA8zfI/2DNkXUYC0p3jTvZUY8WQpj52KPhq1avpNBMasswG8JcUqjOzQd1EoABLO0hKsrKz6CEAQGrLuI6MUiBQw9Ao3WHbIH1Bo0QK0GRM+CuHm+AZEQ9tr8F7/b7TWKNMSYYYiP5/yWEhRyfZAmKiG81/rF0LGdSe52dHJfIQPRU0kmyn38ZWjLEYlApkP/iTDtrbjq0AexPVg4VH1sCb63LEMuC8P4q8vsKbKkC0Fagk3m8RUWFbUJUykl9xvzbte+n0frSMIjX77x++EQTAnsQuEpC0QJR5DF4PwtV6wTwhMRi7Phz+82UZy6OWYrz4qw+IHaHG/K+6yAuh+OZyxNoZ0l4bBzk53ToLdDn9TU7p24sd3CSHK3befd3r+M1faznPfCfKernDy6/xJYe/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(4744005)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(107886003)(86362001)(1076003)(110136005)(44832011)(71200400001)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JG5n1z9WxqNUDaJ9THJM+Or/nZO6kIZLISxEEYTKunYWHM+M/NSkqUGgc2?=
 =?iso-8859-1?Q?6+uEIHveK6Jnvgw1D8yMULk6W9O2yANnUNnhHRpGnE5H/zM5RiINF87YpB?=
 =?iso-8859-1?Q?kjhbbJ0I91sY1id5RmmHYsYNJuAsIjK51GGlozaQIJEs0AW4rYq3m14OIt?=
 =?iso-8859-1?Q?sx8xob0NbEE0G/mCGcmvyPprUt4aN4t1/iXICog2x3pGk6s6ku6Y0Jrvv7?=
 =?iso-8859-1?Q?GGtTitSyDQaVtBpwsIbl8E6emJCjCFGPk3MqfAOMFKv9zCNrnjCrwvx/8Z?=
 =?iso-8859-1?Q?7s07mUpzKMZXCW3JtIyRpByepTQphSdEHioVwa5HTM/2hnT6zBHlQDtpV1?=
 =?iso-8859-1?Q?8uqfLDkDW1T7YQ2xR1A7McTSVP+EADnwuMAPv4kOvbTJ3INkuc07sjzVh/?=
 =?iso-8859-1?Q?VFwtE3ntX3R3HCe19p+ZLYkpjahzPZsvh7iPAcOpZyuXp/ztRC3H8shZdO?=
 =?iso-8859-1?Q?bTWOGHjUe6QMqUv1Lb1jFxIEYUdekElhW7H5/Vb/HG21fZTvGAzzZIc16y?=
 =?iso-8859-1?Q?xBL6O3X33IlRTG9809ywhtOTaHa2tgXYdgcsD8DbyexDe29P4FRCRU5TLA?=
 =?iso-8859-1?Q?BLNY5UTLWYb8YWahm6iIjKOhuVYGItP8zitRZUVYdujKUsLMihl0VpTtW6?=
 =?iso-8859-1?Q?qOdMrLBTXd8wv5ckL2F45xOSsCzAcDfSPvILwy5R0qCFDOVaCi+7ZoNwl3?=
 =?iso-8859-1?Q?I1YBSZdWS5BHjzE+oSb78cjF5uL0GfMTu4DmDyb23FtAWExPd03m9fFU4B?=
 =?iso-8859-1?Q?HH0oZYiVZG/I3U0upkE8lgzoyOwJO3TbX0XLVfRwNKUVWaL9/njOJJ4Aaz?=
 =?iso-8859-1?Q?3I3EtlMSfyN70y3pingRGj14fYFu/U3I0NI3c7FT7qf8oYpSkEmmrjtSNu?=
 =?iso-8859-1?Q?iVwWM1DE9LNLBHkzEkGeP9Mmr1h29meXqg6JLFNtE0OCMekvVS2cwUfDE9?=
 =?iso-8859-1?Q?pZmUdpmMIkEZzfWyiN8IBi3I9+P0XWl61aTn4vLqiVPpY3KGn0izIRmdj7?=
 =?iso-8859-1?Q?CbyJDfAI1MePChBZSctQmsMqllC7sYVQA1Fs0u/w/38ILqz8bxVfDXr2Sg?=
 =?iso-8859-1?Q?Ao2jDLQiipktvDwzC6R8V7DFDkFoa5RgEysra21kg32Fb9PObcJTm3xIsY?=
 =?iso-8859-1?Q?9WE4/0scvvL0ftcuNzh6NqmSHSi0XD2IHC1LTtn2482DjeJkL1qchwXKLU?=
 =?iso-8859-1?Q?AqDTT2JlS2wVyr69IOwLuUw9R+pb3xjPxk6dB2I3b2gaR3Q+JCgyGJQJrA?=
 =?iso-8859-1?Q?QAHpkyZBn1+ncxaCCZKGl8ixvUjUKxVOTtouZMSmUkFGTem8n1FKeboo/i?=
 =?iso-8859-1?Q?ASFEN/LtMXAU5AZwtqZ2amgrA+L2HZCvUAIf81jGssOEwacgTs+hWFTrCE?=
 =?iso-8859-1?Q?Zzn1TlM0xE9iYCAhgrw052yji/JjbZrwdjCHY6CuvmRQTD0mpo+BJTLqVC?=
 =?iso-8859-1?Q?SWkrOtoV9D0I3aYKbRKQitzXytH6aTHV67aeDJ2EOUVY4+RtVdhdCLeBKK?=
 =?iso-8859-1?Q?h2EfL+02LmnwxaSmn1lV2EKbqPMKTt4CnxuDYXI7gy8PD5QnpQJQqXBYT2?=
 =?iso-8859-1?Q?iN9ZddGOYYs0JWLUJ3aLLoO5/boL6CuJfBWhp3HvayT47MEupXLYZOzRs3?=
 =?iso-8859-1?Q?XZIKHqnp5t1aJ9W9d02wih1O9pz7VqEwDOGNHIFCFqskXxtPY3j1klGA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc36eb6-2db6-4143-9574-08da9040cd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:41.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gE24YrFvpJczvjujgp4qF/ZtRsBAM1pW1fXcYEcTTUESBRBVwdkU3q57e6qd/nj6LO0DKt+mekc62Iq2ETbL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: SdlIL4q8KswUJkpUpavYB_afvG8ZzwQi
X-Proofpoint-GUID: SdlIL4q8KswUJkpUpavYB_afvG8ZzwQi
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
