Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E052F568AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiGFOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiGFOIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:08:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073AB13EA5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:08:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E4QaC015768;
        Wed, 6 Jul 2022 14:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bLzFxfLVPMsldMeaP6ADol8eB/iumlup1b+jMigAxO8=;
 b=luIxg+58fx/nuA24ww4RPvnkuOCf9IVQhblkW3Sww1Xe/+Ld40s8Ehr+7gS3m/f0sUtW
 8qkUk5ztvcKCcG2aFgtZjw+AKxfPtmsRSvMPk4jItDuY5min6Qh+lTeiuahpsbBv/bsz
 HxiYBWU0GUReEM2sy1fAsZ4z05240eXnFfp7IR7IoRQemBSfF1XpD0JbbpqSI4SVda/K
 oBsv9zMi/WkfchDkcXWsCSnIrK1oHCI5r+VSOMnZ/f7BSGsdQuTmBLH53w1Eb1T+iP+k
 boxwHx/d9rPjgqPUIjKbiyhJBEQ1fpxXxhtt/R2MLDhlHkksaDtRDaSiXrjYq4MGUdQ3 xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyj4c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:08:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266E5XKd036870;
        Wed, 6 Jul 2022 14:08:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud83bm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMEQxQAtKvk69k06yijoc+JlJ59xdf2CXhruxbvAzy0E7GTbsrvN/XeIgSCPo4xDNA9T+u6nU8mF4evgptWes1HXfq47psZ3/TXrfygM+TMq69gxt7tWpKwcq/8RQYrlyYhJVXU5yf10MAj0dxxtfrgmzig3S01svKfZlexv6MmTD7qOcB3vCTpqWeN3LjsEgLv2642ttSL5alW6/sMoIsBNGAwm/F5B5wOwpL6Pc3BTvKWuH6h4nUWGf1M5tirKaqWZ7d7PjDCbhHpBMV26OZ+q+PS3teRy7o3b0dfr4PLTKNNvLO6NsdpkrWHAk+Zl4bUSn/5LYleax/AiFYA2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLzFxfLVPMsldMeaP6ADol8eB/iumlup1b+jMigAxO8=;
 b=ZqIyH+H1Ww+WKFkk+miVfhWCaV6kdS9EIWgHA/azBft/FtCRSI245CjTl7897E1ZfQHfIZTBxQnpGxIadc/sVo0MqSaXDphB/Gam8DbY82Dbf2keb0ZEN6cITNxyhKA1L0z9Wd+wKyjG1R2r9vv383wkV69gvfmxhOf+TAju2tHHPflhLwpSfuFU1pevmt18aU780iY+cUBKEjtMKhV0l0GIVAC/Fhwebv7JbqKTzs5qNt6NqZK2YRUD8h3g2bHWf0Uq6y7jmc/uZogmQ/gHF+G5N09JbzUB6B4nunu0rBJl0ySq2jDlIgzKLjSfq3CqlyMUO0GYPteboS+b+ZjD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLzFxfLVPMsldMeaP6ADol8eB/iumlup1b+jMigAxO8=;
 b=G7mIWTEmG5Dd0yzQj1JnxMdtu1M5kW7GIlLlWMTiMmlq+KCc+iX5z8sL0EnIYTjp0pzc22U0D5c67s9TgkBqiApPI8xYUgHAfJnThoT5iJ0eROwtUVkUf51eWQ+a6NLGFrZlHTgtGbA6wqxHXTCblZ+B8cgVPwh32yn+cMDQEXU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5463.namprd10.prod.outlook.com (2603:10b6:8:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 14:08:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54%3]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 14:08:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Thread-Topic: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Thread-Index: AQHYkNzinLp2ekiGvkSjFulTKej6T61wpgCAgAC78AA=
Date:   Wed, 6 Jul 2022 14:08:20 +0000
Message-ID: <20220706140814.hjf5d2hbfupd6kyp@revolver>
References: <20220706020526.1869453-1-Liam.Howlett@oracle.com>
 <20220705195535.a32ce0de9b45fe73eea72c82@linux-foundation.org>
In-Reply-To: <20220705195535.a32ce0de9b45fe73eea72c82@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de064b4f-55c9-4277-8f43-08da5f58fb8f
x-ms-traffictypediagnostic: DM8PR10MB5463:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxdziBos2cDTHW4pIeT1v0sglaTkaQoy/iTv9xN4tK/2utF5LZrpq3uBw/M9L3PZ750FVrWge1M7WK4JW+8ij9y4QHv/K6psxOtacqI8oiEQfCSADG6xjDyT/iKzJXQKYFNUVlg7vjL6j+cTMHDXoWDwY7BBgrakIV+wCOFwmwbbtX6D3sU1QX0S1G8yaEYZqNE+cds0XJR6tdQrmFV0stUMuv0g1y0U0Pws/XQ/WyeMH87oaKIADHJS4oi0zfroR6tpq6JJBcdj5z3mat7L9VcufWYvBrbjYLrVxvzNieZZeMZ5yArQBnVcpikGKdHz5W4Tzw6y965Ne1HlrUKGl4OZJXSIDxNW4DDmjXPbJaQE5vWNzYpcDUIjhefA1FKR+Zfhe7Y+0XVxVfsxaks6Z+E3PehU4uyeG19tn/H680Ju+0BJ8LV2MyOXMDodgOdUaPs1gLYZJta8u1sTEicgqYSd05OvSISS5mSI/br8b+UObkZaDMgdia1DTSMU+Rs4A3ewJAA8fOrOqgOK/kS5kGa4f+oSJQyBuw0ekXBp1mII1/Du1VZxMrbW2cwPQ3QdmjroqNAlshOAD1pPSCge0432ow/AB7RgTgCDbJrt/L4MEKG2yqWRmt6Hf6eii77msACp11r7ffRESxdICmHHFOvlHDHZkCdYbH22/Ty2+qx3N6Qchtn5nLLQ/KojYiT6NSzzpNXh99Y/TVkU0FdNKZ6GZTjs3z+Lrrc/Z39p3vjC0DnuP8K5dGr8Yag5OxK8+jFXXyji8Ur1qpR+/ddTGbPHL9aP33uexcllcIWgefd0adz3VhxZ8fUAaw6Ye16n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(1076003)(26005)(6512007)(6916009)(54906003)(4744005)(5660300002)(8936002)(9686003)(6506007)(41300700001)(83380400001)(186003)(33716001)(38070700005)(122000001)(38100700002)(86362001)(478600001)(6486002)(2906002)(71200400001)(44832011)(66446008)(8676002)(4326008)(66476007)(64756008)(66946007)(316002)(76116006)(66556008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7GPNxiIweKvzelw2Eyxo5WEUkKY8ouJxiZUFSSwVIr/OD65XgHOPCKRbL8Ye?=
 =?us-ascii?Q?o5cgYEHb76YefE5wW0CIerlKd/AKLlhbvjj+5DVVxXhZ7UWDxw510lTuIYyo?=
 =?us-ascii?Q?h/CNMvQp5Mxfsp51Ph9A6P6EVRlhvvhFfQ8bU2+7GrRL+VVpgUjlcD0vdSBL?=
 =?us-ascii?Q?WS/EyMNFZiRP1Q1OxxvNRpNS4XyzrjpJwDoVsmXEbp0HQ9s+f8lVHDpld3SU?=
 =?us-ascii?Q?FEtE2R8d4QTm08JWvXTtcBorLnXQGz/7ivnxT12xnL3mjx6VFog+/0HSqxgk?=
 =?us-ascii?Q?Uz5AgZ8mvY1jp5ymLwm/urRdwmXRnP4nngrSF17ogUGB9i7h3jr/Hz3QM9HD?=
 =?us-ascii?Q?eyojZj+6rW03PfG4zZJ2Cdoj4si51oiMWNdU35sBXgk84anvaIUBkYe6OHJi?=
 =?us-ascii?Q?CrnDqYZBjCUFgOxdrydOkUsGnJdCFRV/u2ct7MNrgAwSWSeeLJ458JeiKIHU?=
 =?us-ascii?Q?2aLxjc24b0E2AtqRIHk831sXf/CbJTcxJqd440lazl2py6Lq0fSBNdwa/MHx?=
 =?us-ascii?Q?lgYHjUY+ul8MR62dImwQ5BE1l3+4LfYsiiVcohXBIcu+5Ds466F8d2ucPWme?=
 =?us-ascii?Q?8AW0IlpRQ17jRkmGZsV9otrLYmA+6mII8pkONcFa8Gintqx+4TBqAumVFfFD?=
 =?us-ascii?Q?io0HssrL3mEUtwkWWF7YYBKSwjWX6L9vkjyx5SpWyosRQp7nZhlKpbftzUnk?=
 =?us-ascii?Q?iiLBqFdV97/c+KFch9h4XcWqXAdC0hkVyZB3UlKCfzW3F6VK6+FXZoGuhXEE?=
 =?us-ascii?Q?rYzf0qNK7zHwtJiogzwoy/rC5VJHT8WuKQcPGeB5+KOtfcj6TFyHz4kn4n/M?=
 =?us-ascii?Q?3zvGEh9dpYhUyUGmgufIMgNNcxdG8GmDAXiJ43XBnW2YhZsrRCrdgy4FmqHS?=
 =?us-ascii?Q?RpzI7FCzv/d2rE0Rc/pidnds4oWDQR40pURcuajAgXXVxy61CdwidQ12YqD6?=
 =?us-ascii?Q?V9hxPYnMnupPvoIc1lCJex7TcpHEsqKE0s+mY2DXFR2f6hPxRSNIEwl9AirL?=
 =?us-ascii?Q?TsADn8HIS3F8HKYn0F1LRWzhQmL/a8vYhj88TpRA38ZSyz5VW9eyfeJbOCqR?=
 =?us-ascii?Q?lllQ+gGUhLTHqo1wCRln0FdbxJVZWXBOEJ7HkAQqPzqt28XCl9FggTmXn2yE?=
 =?us-ascii?Q?h9YAWhElZVYWr0RGplYBvlcLrCzsUASjL7/aeva05fHeqzK4lhL2BEFW9IiN?=
 =?us-ascii?Q?SviFudaHiswvXXRzHdYE9TMveXvtN/ws/B6T5qf/OFWGNJZcNIIZQ2lREKZa?=
 =?us-ascii?Q?6QRx5srd8DQJf8eIiNZyVWLQ5GBfGtJSM7ZoXx2F6VzjgXFFhbBSthL2AhQg?=
 =?us-ascii?Q?M4HqIG2Oma8+W52oIn5vQbuQmAc/ZeRG8k2vNAzoqciUpEsCVcFt3ThehYk/?=
 =?us-ascii?Q?KL/ja+90y0tm8V56KUcSR0bvVfqIv3//OIC5McuF1Hjgfn4er0SIqqokylOy?=
 =?us-ascii?Q?tS35SuueBP7DlX53mpt4KqQcJEVAVIlgIKnBFm2Sr33AfTLcvOL2g8MN6haN?=
 =?us-ascii?Q?XN2IV1cVHpos3x/g678rjzAZjvt4+ipWknQYPFINHuQE6o3rK6dBHfAKe0Z+?=
 =?us-ascii?Q?gJfOX0d/wR1nMo7uYJ2NwFmR6Jf3dAJaAEQcUg66ZDrIloKMCvfo0sE3ri6s?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFB37C782AD0EA4382C7E312E83F2E20@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de064b4f-55c9-4277-8f43-08da5f58fb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 14:08:20.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 619rF4ugecmPUMFoVnGgdsjcP/Sn+rcAaDXgWe4G2L/JaAwv2dh5z36UHELdKvp0qCh2yNjcpLh/yUJNr3ZYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5463
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060056
X-Proofpoint-GUID: WKg98tFQWYitjr9XFMg0lDb6WRKFhl0a
X-Proofpoint-ORIG-GUID: WKg98tFQWYitjr9XFMg0lDb6WRKFhl0a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220705 22:55]:
> On Wed, 6 Jul 2022 02:05:37 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > When writing a range with a NULL which expands to 0 - ULONG_MAX, don't
> > use a node to store this value.  Instead, call mas_new_root() which wil=
l
> > set the tree pointer to NULL and free all the nodes.
> >=20
> > Fix a comment for the allocations in mas_wr_spanning_store().
> >=20
> > Add mas_node_count_gfp() and use it to clean up mas_preallocate().
> >=20
> > Clean up mas_preallocate() and ensure the ma_state is safe on return.
> >=20
> > Update maple_tree.h to set alloc =3D NULL.
>=20
> Cool.
>=20
> How are we looking now?  Any known issues still being worked on?

Did you pick up "Subject: [PATCH] mm/mmap: Fix copy_vma() new_vma
check"?  I sent that yesterday as well.

I think we are in good shape.  There were two outstanding issues I had
and this patch plus the copy_vma() patch fixes both.=
