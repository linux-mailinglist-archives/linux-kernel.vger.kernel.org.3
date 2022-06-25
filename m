Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47055ABFE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiFYSur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiFYSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:50:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A52B10560
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:50:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25PDEJTf013365;
        Sat, 25 Jun 2022 18:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Noxy1KzQ1V9QeQ2czYogkBHcT5PGhq804ZB0MMEdgQs=;
 b=DRvz8ofthYRmoH+KaE4qwYmeSjlbJK++I+1BOxXPACbVa22s9k7x2Bf2FMpJzx5+UA5j
 GMuWg9/SNO6yeFdYQ++P4ctBw7FL9t/9tTkduhWqbykBft2wmn0IVL33U8BD4zWZsk+n
 gUG2fe1ZhV8ldIYRT68xnFTbeCpXJp+c2nEpDzLc5Xee/fWpjzGqMdxbuk7UJXa40xcY
 mamvUpicHhBd0+AENokDUQx7RMuR8xIVHdJGXtndsRn8YEgVQOcJIERUDF5NPV0MG7WW
 KmbXj0mJJiFtShqkAbmKzdmnDj5+YVxBnenTxojh6p5PxuQALfkQ36fjljrj43xfou9g 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws528q7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 18:50:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25PIkvdo017671;
        Sat, 25 Jun 2022 18:50:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt0m9hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 18:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAmxEuarwUJvIckcvUl1LR7n9qIWhRJyl2VnOEFHsNi0gZmLyEppFCVmk6iwAR5FEAQsss9FlwtBSKi84f3mghuMDRgXO+3R5O0NKhRbqI1m0RWZLST+O1ue56kFa/G9MJwwegIDvHi+Z0ioD/jtk+Ut1NCNQTnpaWwx4qT2arU4VKhcb8hIi1E8Urp17TkE8XNfqw6ouPaIYmJqXl5EHEwZcl6ORvdrxiMspBNfK0lc2/BJC72UtC4OWGF9rITogM8CWcpQl3oYQT/R4DkgIPIO6VLdez09A1FgY/HRGwX+yURXEnV2wuY8ijD2ipIdDbQjKVq7x7JUGIb6vbLB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noxy1KzQ1V9QeQ2czYogkBHcT5PGhq804ZB0MMEdgQs=;
 b=oeikQpOWJznct5KrMeBoiBFW3Yxzhv4pv6OXdvTmq4cjePclqywzZpjKilI+lFBHjiKsvBfvhtRlqbOWZm7a3gJzTL6+fZMAZobRVZMCGg5eIgtSFrW9ZHu8Oyk9G5Xt0jLzAUH+FwtnlNeA4jot/irmHM9g4iXdFv1u2X4g3WvdqA99H7uvRSieQorh8W4HhbyTrRLklIcYQMfeMptNDfq0HM4EtaR9FohNUp2AA0yhiHO4TnvbUb2BVkPWuTu8ljjxiHEP0DQpplwn9CXT0Vw9VtDF2VfxMI19LNN+YtxZN/AGAVWP4b/4WHgbZ6he+IUF8l7GuAWdpP2G7yuiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noxy1KzQ1V9QeQ2czYogkBHcT5PGhq804ZB0MMEdgQs=;
 b=wYD6vTI/dLWXzN9DnZGcTcBt3PfJgEnmo9M62aHTQuiUOy/xIJRXc/movJ44ZmMVDC9Cyu3UYdeLCl/fmnt80rW4G9jf4LsI85dV+TQowypnVBx5Ulopd64XVcMNwHmIGSTqJs390zy34ffY82mSQAXcOYv3oRAjmIUwc6x0Stg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1443.namprd10.prod.outlook.com (2603:10b6:404:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Sat, 25 Jun
 2022 18:50:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Sat, 25 Jun 2022
 18:50:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB70xgIABL6QAgAAImQCAABIPAA==
Date:   Sat, 25 Jun 2022 18:50:30 +0000
Message-ID: <AD7B3406-C1A3-4AC0-BFD5-C7DF7E449478@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
 <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
 <20220625134552.08c1a23a@rorschach.local.home>
In-Reply-To: <20220625134552.08c1a23a@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 674a5028-f53b-4b03-ead3-08da56db9418
x-ms-traffictypediagnostic: BN6PR10MB1443:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Psx9jv4/4aPQSqYNVUyPoWZKYNXVEkrAFA1DpyEoE2XUlOJWDosfS5hAMmZih2whOQe0CzTRImw/cdpfAjq4YfoVsVjak8hm1sLK/WANoQyD+g35Xa84DqBriavyiWS/cyEuaPxkzFImyJ+Zib+DM9oKnA/v2efqeU0MT+7m5AEkKyLVNZRzbXSwo5OQpbo2RA11caUhnYDXI/QuVfmeJ+sf0JKD73t92SPxfvqzr1ItH80FQ611gzTHjvBk5KS/0cOp+kpZsRVXjbZ8QSNJDD7175dr3d2zf9Pu6zJx/aZLsTR0O71v/TAYu+yonrydma7kKO5s8hw3Z2U61/0ELnY0RddYlNPQi8CUcmn0pcehyIk1HsrENKP26DftjvA0HBlDDjDHBmiQkzsx4aHBlUOH3WbRPI+LrPaOtNUA24Ca9LeKLusr21293HWEt/FZTK8OMmX2JKAgxpID4mfgQKKB/5oztwFDhMWCnhep5uY15uP1JMm7roAiYAVEsqNGbq84pKoT/90rihJ+0fCJwEfJrAyuDdwbytmDCg/eFD1NiK7Anb1z01WsD2/XVt6UKn5OBaVlMXCnXvD/45DCTyroqfrItvHGO/15NDeCwToUw9/aqWwkHSzSYm8RgtgZt6RVX4o9t9424fq6MHbGwPhatVPKdX7+L4Xo7vq6lCD/RHpd7zNt3WnOOY9qZ3mv34D/3HRncBhUrG+hC8/H+UxmMkVnTMPXmkNUtoTRzyo2vp4F0D16vqsMETc+d9l54Yo9XQZUDzJxPuP6bwRk0JCbbItcTeEtEkHIPRtxU3bFfqLBLA1foiEtEQBmpk9kw+zTZKHIb9q92zBi6cR6/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(376002)(39860400002)(8936002)(6486002)(478600001)(6506007)(26005)(8676002)(4326008)(54906003)(41300700001)(38100700002)(86362001)(2906002)(33656002)(53546011)(5660300002)(4744005)(38070700005)(122000001)(2616005)(6512007)(36756003)(71200400001)(186003)(76116006)(66446008)(91956017)(64756008)(66556008)(66946007)(66476007)(316002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zUqUrBmidJmPSrwfAZ86u6+CkGqTz71u3kbt7JR7xEEIJgT1nmCmCU2tG5f1?=
 =?us-ascii?Q?cblKMG6zRaqq8dwvOTvqLnnNrD8FUeWAYoERV6vKoejotL/woBWmsbuljqqa?=
 =?us-ascii?Q?4PQjI60mM9Y6P19iM2RwBPmsbk23zXH0Wog6j8taxMUZnHBRa9kJrmf7t1rz?=
 =?us-ascii?Q?IRJI7+T0GYo31eAIzOkoz7P6Ow9iSGWQBB/F1kdjLu2TD1+qlXKMkXcvhleu?=
 =?us-ascii?Q?zIXGZ/WnkLn//hDaaMXJi2lXMDjevq719nYbfWLczr22nSGuoT+vZSGZ6xnO?=
 =?us-ascii?Q?g3Tt0oik2xnAyjzOU3BYNIBIILmizMhZjSYU4XdnggoTGBLOVh7OuwmrUZSO?=
 =?us-ascii?Q?haI/2OyOfI9YaGB3lsJ7pL73QLhzsIpVV0RUOL8Dvgt3Pl4cMEZ1k42Amzuc?=
 =?us-ascii?Q?/qWZuY1oNqGcVm3PxxKCrij7YRWfDS2ns/wGhWaPZcTBeQ+EQX5h8WRd7TrJ?=
 =?us-ascii?Q?H8Celr+Hcw//jDQ0s+KjSnEcQgrK9Vi0r2tFGBjEebRgQ3Si1zT/yX861HRl?=
 =?us-ascii?Q?mVUfFLSbi5loNjNweVKrcUkUz4y5trFN+J3LkWpWCXKEF1nR2JXeIB3a/Zy/?=
 =?us-ascii?Q?PClmKjNktYkchuquM06DeVy3NPnsLgtwqQ6Qvuh+A7MErK/VGniQl2ASh7xK?=
 =?us-ascii?Q?MGriEffcH7POkd5oNVX4xRpBZHFtlGbF3iUDB5BmFrblxSYZrmvGZy1ID3yg?=
 =?us-ascii?Q?eO3FcCE/cDWKKYFClUg9a/MgPy9Cw87sNx5HLggHGgRJqQN3emEmp/VaYkL2?=
 =?us-ascii?Q?3nm3NqSO2fjhLy4qHla+606MBlkQ3lTLdG7wzPxfKTUUCA1LaaNB/NUnpb9m?=
 =?us-ascii?Q?QSfuIY1qQNVCj2qiZhE7M51xjlJk92hnYRwAPixCbjfvgG01tVOoHndDpVHC?=
 =?us-ascii?Q?NpRvs2VVhlGcsfjzXmg4hq+u0Am/rZWLgLSw6Uj2qLvu2m5pOuLGbSNUNh9h?=
 =?us-ascii?Q?mGfj9JpYyTBHFCw+1+WA6WOGTx/dkw6Fm5bBW+oq42BZZjFq5pxi06G1Z/yk?=
 =?us-ascii?Q?rP765QnlbtdWERtxmZCuK4wJvprLThfaP7/ZzgMY8ct7Yv5zhHQKTywUtMcZ?=
 =?us-ascii?Q?LY9n+HwCIbNFxWgiIGpYGZ2rFoSsA5nMF7o+UBZQZsKxgY0pXY7NJB07yLrO?=
 =?us-ascii?Q?BBGk9TbLWvMilTpo7x784epAw5f15qF5G9TSRMx3TmQCZkiJ8GrB7yQ1QAtJ?=
 =?us-ascii?Q?Xfy99KeKqHcbgqmYL2V3GGycEKvCtfuwHNumXwwXOIUbH580XIQqrWhgZCtG?=
 =?us-ascii?Q?DOIEHz21w5Iiy/+ewsBf5SPLnrxndMkreXpkV0AnhpsyHj5PJiz0xNN4SKZY?=
 =?us-ascii?Q?W0bFIquVQy0uJy6hD6m8NIJ5gAbQqfI89f3KjsjGP3canDAT5IGskOnXQfS2?=
 =?us-ascii?Q?Ef3E4CBoLRK7JZrcnQvcAhd2fks4LXdxmnLhWOw/QM/Uzwzh9g5F1Gp71sbA?=
 =?us-ascii?Q?X5uvLkuy2trFCGQTPoIzOne2ZyP86hYdzmGerV2pI0EdbcylqerCsOcaIPCf?=
 =?us-ascii?Q?ZsjB+3CoGcp0Tiepx+YaUGH0pSMypmdCmAtY8hmfvlV43nnPQob7XcfdLxWz?=
 =?us-ascii?Q?ggug/ZlgkpztQj/dRLhvb0Ak8tybcYud1+x+MXUCO/EKY/GI+ByQTUhcvV4j?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E350B4408DF8C4DB82DBE34A2D8498E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674a5028-f53b-4b03-ead3-08da56db9418
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2022 18:50:30.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3b5WTmnq/GTMgHW5mje0xYxkipU9rBLxjts9B373tzHQ639WsjTWKkyita5VBjxw4ZpqLN+e4zJe4+XhJ89fdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1443
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-25_08:2022-06-24,2022-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=939 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206250075
X-Proofpoint-ORIG-GUID: wyI_Vy5waF5lIIOILkTWIY2wj7ZZcO09
X-Proofpoint-GUID: wyI_Vy5waF5lIIOILkTWIY2wj7ZZcO09
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2022, at 1:45 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Sat, 25 Jun 2022 17:15:07 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> [root@manet ~]# cat /etc/redhat-release=20
>> Fedora release 35 (Thirty Five)
>> [root@manet ~]# trace-cmd version
>>=20
>> trace-cmd version 2.9.2 (not-a-git-repo)
>=20
> Ug, that's very old. Fedora should be shipping 3.1.1 soon.

Right -- this version doesn't recognize get_sockaddr either.


--
Chuck Lever



