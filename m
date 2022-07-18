Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F495782D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiGRM52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiGRM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:57:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F272ACB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:57:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4XXS029439;
        Mon, 18 Jul 2022 12:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ywxrDhPa4NEC5eNtZQfN/DBnjejU8Etb9pl1L8kmtAg=;
 b=TsALNTTQc6m3nThQHNv579Inqw632UmTw4UkuJ2w+MnuANVB6xvFsQZTd9gAVOyH4hcy
 UCDMIg6b83ErNCn3gl95skaF4BZGAvGwhePxPHE/J1az2PSNkxP83xrL4KZwd9omGPdJ
 cZy2qvMDnkPm/dC2oaXGN6Zr5FP9vT5B1BunjRcygVNvCUzYRI3UQjsSgJebUzthdino
 FsBCTWagjVcoVlnGoTDvS1dJh71h3xOeom/TzJPLiHdmWrUENhiko8AOsvyd2o5lqqov
 Rn4AEvK0Tx0Z+jYyM8fH+w7YfqwfH4VVUhg9SdrbVAMIgbWrcZn1+RxQal3L+ZALRK39 vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0u885-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 12:57:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBY0ZM027924;
        Mon, 18 Jul 2022 12:57:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ma7tsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 12:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMqHM+2p8dlyj9seG1/A6ULHZFf1bmqsugh69ELFIeOFJNfPE+o8UJRUXEVSkB8V4nT7mqYinuvA14Qr9dxujYx+h99WeUObCqDp8Vxac6CoE7rzjs4oaHpkYhjf7gDoGo4PkOfCIer4Lgz3auckTJyJnj5WEo9dAcmXtLVZTLnyQuPUr5ovRwXDMq3a8Vy+gp48RPm7QNf85PDvRjaC/3wy14fyokIatyJQBR1f8jTQGOMHdaFcgnxcoKy+5bail2DPRn/bb0lXHvjHuxF+6O+5vNkFn3zvsl86h2Hvvq8Gkf72nDYkf6gQxkA18lsGAmRff2gx/fZ1tin+T1XcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywxrDhPa4NEC5eNtZQfN/DBnjejU8Etb9pl1L8kmtAg=;
 b=gfUWCrYaCYvVEg4qtvnOvaXT8nXDiQjgApSjsu/xaGWG2bWupnmEdvH6v6t4IP5JfBxXrmTFvzgXFivk4jMk1uRBLhOTg0U+VryIweJyB70dlbFTYL3yyB4kZ/GYdpRBxmgew5y1p9oIHOESUAASMCAbxbQjMsR2s6vZu7wTBbe5kXE+d/qpXoLrdIOyOsNRkYoDhgBQTknC7N+bOIlwMNNGUPIbNk1irSh+2BOCXEXr3dCq24RmdvRwkdRmg8U0sE9fDHcWuNX2lktjl9mz4Q3taSmV0z7xeNJPCJ/63ZHWxChP00fpf/v89wspWEz/6xQA3PufaThDD0LamVrk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywxrDhPa4NEC5eNtZQfN/DBnjejU8Etb9pl1L8kmtAg=;
 b=SjalFodA1lqrqGv2D4TIEQkN6CYZFlcBzRWQ5CVYF8hPrIRZlyB8d0AmBy9AwYnaUm+9nM6jSQWC3V+C5OLad+TqsM2OBWm0IBgI81h5hvce1VjgInNQ3mAmXN6o8bzSnbvGIF2eCbjmoPBjKwuhQxykWLljDdGtSzllUPnMSLU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5301.namprd10.prod.outlook.com (2603:10b6:408:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 12:56:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:56:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GAgANG+YCAAzbDgIAAXBAAgAAh5oCAAI39gA==
Date:   Mon, 18 Jul 2022 12:56:55 +0000
Message-ID: <20220718125649.cpatlh7ublgf7bvg@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
 <20220713132926.3sl7gs67dyjj7kit@revolver>
 <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
 <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver>
 <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
 <20220718022718.wtlw7grwp6dv5fcp@revolver>
 <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
In-Reply-To: <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3ab119a-8af8-45da-a78a-08da68bcfea3
x-ms-traffictypediagnostic: BN0PR10MB5301:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lWap6gfubPa69uYhFKLMyr1SjEow+dTx6IN9BVUirJ82W3sZXUepc9hqO89hsFcG2G0j8hxQrNkNuvcm3c/McZxsxn07aJC/fvvlKwgldIj5VGNzTY0i/CfSTjVlhGXFQQ3c9wBAmfCEMfGGjC1BZj9HHxTBh4dQZrms5rFIef4REQ8OfUWmpC5d7eVbzky3wAjkw4PlgzkfWI/vb5T5wp4lz+LQ6gX3ttsSdIoWl1WFrDSTZjVzabKS2h8hZZMugO0hoEoj6Gp8sCCLckWIDerk1IJlWnj+2XcU2LI3F1n9CFkMKn2KLM+VqDQYS7fohOZYTKYrLQfcK8Gi+PlcF41GTDqaGlT1R1ZctqTOeUc72izVcrhF3L98tgeyMhiSU22gA2hhP/ne1Q3PBzPp4rpQXrZ4RiYDCP4DEPA2DCYCdwx+Zx6ASJq6jIdRaDTROFUkuaG1hE7MIbhKztNEx5d1EFL8k2dgyvx3yYTItYAUhBYBm89m80ysGP8LaVKHtFf8eXCXFb/vLGKhEbHOBPlxY3xjEvXdsSJmnE0xBWGapAIR9GO16BnY08lwAmhJV2lUGVpPxwY9v7KM948XQ9U7r/VmcPf30VBkERrIazw3uTPqtRx4qADowCwiAnEdInt+6k/qjOzhKW3oIS08GPFiZbn56sLLA9MsosLeO3jeIxqZLPaKgYGkfXpIieH4Pc27PA2Xa5Qr48ESrl035CZeKSk6OF8YMOfm/EvXhYH9YgCnkbKxLD6Y+ru4ScfFPhRay+pRnk9lz0ccG2aw6gy8VYQAfz1t+kjaGnZ/A7nCpJ9uJ9ZhfxXYAyJ0P+P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(396003)(39860400002)(376002)(366004)(122000001)(83380400001)(76116006)(38100700002)(186003)(1076003)(38070700005)(86362001)(6486002)(44832011)(71200400001)(2906002)(478600001)(6916009)(45080400002)(54906003)(6512007)(26005)(41300700001)(6506007)(9686003)(8936002)(4326008)(8676002)(316002)(5660300002)(30864003)(66446008)(33716001)(91956017)(66476007)(66556008)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HArQcQSTobKEePWElcjt3W2mw42m9ND30k/U4OVkWhIDgTy5PN/dB0W+sKGA?=
 =?us-ascii?Q?pYXfVj2FqWbgtbM6IVcxOTNcJnD1c6LQlRn+ssg/pSyt25ryDL5ItyuTltC2?=
 =?us-ascii?Q?Qj0EyHoMlxBK5GMem17ttTAEe6Z+H4BFBUpaWojw3kEVjdRs+DpMTHjd97wT?=
 =?us-ascii?Q?PDS2GfetO4zLzTb/Dr2QE4kXjiXrLEqF2eSf8+rp+nB+hoJVrzKfLbJ6bWVt?=
 =?us-ascii?Q?E2hkgMT+cQTN1x+zhVxFBt3fHIeev0qWy6jmsdjsm2tZiCLZfZPnlkawgVNj?=
 =?us-ascii?Q?Z5/NtHfftyLqjhb7dgviGQCWw7oJKFJFDNVwxey7oYDp2j5Uq1kPkE6SIN7W?=
 =?us-ascii?Q?c2KRwBi/YsX6cgz3hN3mx+CfGTK7/JtUkNTulb8EW/sQi9+URyssw7Bu+G0L?=
 =?us-ascii?Q?akic2clmYWuFw9yErv+WrK/QxiebnBaEUEDN8prNYaAqY9mXZETZ0JvE30X+?=
 =?us-ascii?Q?4tR0+Yn13iSCC+AkCiraSlELhe2ELKpqkrV8HPpgLtNmUL1Yiimt9A9d7PrG?=
 =?us-ascii?Q?uiuCwB5CwEeYIWnLSA6qGhYgGjjZnhxKLXwT0FHFRQZWnRqvbTkF6aIsaAM/?=
 =?us-ascii?Q?HqL5APGI36+YO59Jac7TEUVv14h703hUE26WHMZ8DAN+3YZwCtzMQ0AKac1c?=
 =?us-ascii?Q?xOUr+od2BzvPC/qBDuCD4Tjg8Efr2Z1K6UzGtZp0oXXASstWNub/6D1YNnNr?=
 =?us-ascii?Q?B9rXpjkiKlH2SEldxLws5btJ1zeGWa7rz/VmW3EeRCWIBbKFtnql23m5zFt+?=
 =?us-ascii?Q?c7F3ZT+aziyza7vWsfVUgjMZyYVy8qdrILk9AYz8SGgqLiJblgaWPS+n91G7?=
 =?us-ascii?Q?exaHen1cfu5a9VpBLiUB3LRLOVbKwXg5z5KgYAcbR4+/0aPwL389F5mRM+ps?=
 =?us-ascii?Q?UnthIYHTzV8+1/uQNYCvElQF2stSuGvzEIWU222lhLf9rigfD1L9tOjoJDUP?=
 =?us-ascii?Q?WSciZYEAA6ZZVLreYXC/r7wanmRahMYWI3KgwgN94lFhaJoUkQusoC7t+b3y?=
 =?us-ascii?Q?fPJq/ekHXf3nQwnzUkRAHApSid0kYOgu8Nat7SsUyrSqIHHU2Vi3y/oFwlj3?=
 =?us-ascii?Q?jZpgWRd4lgw/UamqmU2oiuIDEu6K6XLO63zxtQvNA4HGMuoMEE9y+OLy9WJN?=
 =?us-ascii?Q?xPfu9bYSzLPOQ943+9GDrkUGISnYhJs+TJyflQv9jldQBHCtNd7hgp9aZSHM?=
 =?us-ascii?Q?pff2GaluSf+2uNp9toEz4JlgHf/6LYxm15GQgi4vCmPhQMvXS0yRNurTnLqE?=
 =?us-ascii?Q?iqwBjM5mc6WaNSGOjHjqifN9h/q3wOeJCtSAbm1XqN71IS1XK29yxn1Su0bw?=
 =?us-ascii?Q?vosmhDwvwkYOWw3COCgrB7ReSkmTq6lnXQwUp9mNoBe2TrtiV44x26ToZYIe?=
 =?us-ascii?Q?wZY3mmY6NLqqa5pXFPruEh6M8cJoRwU3LSbPOu5k+sgy9l2YUx2emCBTM2Ge?=
 =?us-ascii?Q?g4h3TeAcM5oNf2oNTmAEMVLZZL97R/sc/sPeTkUC08MgvrTUfdIb6eHzILMk?=
 =?us-ascii?Q?q+UBJf++RpGzNEBQGvOfC94tbrjsBOW/VOKy32tEHwwY8g1e/pIRAHCYPKrH?=
 =?us-ascii?Q?GsbHdZvLm8Jv6D4K6E7v2d1XohO+oIvz2xHd9cEJX7e2vFsqgreziDSb3lFs?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24CF0878E7D0C847B60549D89B3BC00C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ab119a-8af8-45da-a78a-08da68bcfea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 12:56:56.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4rDqrhcGLuQw3VIRP8D/969kvphwb1LfztXuq6liEWsysBA3x9ljHNHm4P6WkydyGl8aO/5iyyy02DeA384DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180056
X-Proofpoint-GUID: sS1imNvb1SmsdogCkXeQwvDX7_jWTgGr
X-Proofpoint-ORIG-GUID: sS1imNvb1SmsdogCkXeQwvDX7_jWTgGr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220718 00:28]:
> On Mon, 18 Jul 2022, Liam Howlett wrote:
> > * Hugh Dickins <hughd@google.com> [220717 16:58]:
> > > On Fri, 15 Jul 2022, Liam Howlett wrote:
> > > >=20
> > > > Please find attached the last outstanding fix for this series.  It
> > > > covers a rare failure scenario that one of the build bots reported.
> > > > Ironically, it changes __vma_adjust() more than the rest of the ser=
ies,
> > > > but leaves the locking in the existing order.
> > >=20
> > > Thanks, I folded that in to my testing on next-20220715, along with
> > > other you posted on Friday (mas_dead_leaves() walk fix);
> >=20
> >   Please drop that patch, it needs more testing.
>=20
> Drop the mas_dead_leaves() walk fix, or the __vma_adjust() changes
> which you attached in that mail to me? please let me know a.s.a.p,
> since I cannot proceed without knowing which.

Drop the mas_dead_leaves() walk fix please.  I responded to the patch
that it's not tested enough.  I'll respond to the rest of this email
soon.

>=20
> >=20
> > > but have not
> > > even glanced at the v11 you posted Saturday, though I see from respon=
ses
> > > that v11 has some other changes, including __vma_adjust() again, but =
I
> > > just have not looked.  (I've had my own experiments in __vma_adjust()=
).
> > >=20
> > > You'll be wanting my report, I'll give it here rather than in the v11
> > > thread.  In short, some progress, but still frustratingly none on the
> > > main crashes.
> > >=20
> > > 1. swapops.h BUG on !PageLocked migration entry.  This is *not* the
> > > most urgent to fix, I'm just listing it first to get it out of the wa=
y
> > > here.  This is the BUG that terminates every tmpfs swapping load test
> > > on the laptop: only progress was that, just one time, the workstation
> > > hit it before hitting its usual problems: nice to see it there too.
> > > I'll worry about this bug when the rest is running stably.  I've only
> > > ever noticed it when it's brk being unmapped, I expect that's a clue.
> >=20
> > Thanks for pointing me towards a usable reproducer.  I should be able t=
o
> > narrow it down from there, especially with the brk hint.
>=20
> I'm afraid I cannot point you to a good reproducer; but anyway, the BUG
> necessarily appears some time after whatever code is at fault has been
> exercised, so it needs thought rather than any reproducer.  It was not
> obvious to me, but I'll think it through again, once the other issues
> are resolved.
>=20
> >=20
> > >=20
> > > 2. Silly in do_mas_mumap():
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2513,7 +2513,7 @@ int do_mas_munmap(struct ma_state *mas, struct =
mm_struct *mm,
> > >  	arch_unmap(mm, start, end);
> > > =20
> > >  	/* Find the first overlapping VMA */
> > > -	vma =3D mas_find(mas, end - 1);
> > > +	vma =3D mas_find(mas, start);
> > >  	if (!vma)
> > >  		return 0;
> > > =20
> > > Fixing that does fix some bad behaviors seen - I'd been having crashe=
s in
> > > unmap_vmas() and unlink_anon_vmas(), and put "if (WARN_ON(!vma)) retu=
rn;"
> > > in unmap_region(); but that no longer seems necessary now do_mas_munm=
ap()
> > > is fixed thus.  I had high hopes that it would fix all the rest, but =
no.
> >=20
> > This is actually correct.  mas_find() is not the same as vma_find().
> > mas_find() uses the maple state index and searches until a limit (end
> > -1 in this case).  I haven't seen these crashes, but I think you are
> > hitting the same issue you are discussing in #6 below.  I also hadn't
> > realised the potential confusion of those APIs.
>=20
> You're right, I'm wrong, sorry about that.  But then I'm left with the
> conundrum of how a class of crashes went away when I changed that.  Did
> I break it all so badly that it couldn't reach the anon_vma bugs I was
> hitting before?  Or did making that change coincide with my moving from=20
> DEBUG_MAPLE off to on, so different crashes came sooner?  Or did I fold
> in another fix from you around that time?  I don't know (and I don't
> expect you to answer this!), but I've got some backtracking to do.
>=20
> >=20
> > >=20
> > > 3. vma_adjust_trans_huge().  Skip this paragraph, I think there
> > > is actually no problem here, but for safety I have rearranged the
> > > vma_adjust_trans_huge()s inside the rmap locks, because when things
> > > aren't working right, best to rule out some possibilities.  Why am
> > > I even mentioning it here?  In case I send any code snippets and
> > > you're puzzled by vma_adjust_trans_huge() having moved.
> >=20
> > Thanks, I will keep this in mind.
> >=20
> > >=20
> > > 4. unlink_anon_vmas() in __vma_adjust().  Not urgent to fix (can only
> > > be an issue when GFP_KERNEL preallocation fails, which I think means
> > > when current is being OOM-killed), but whereas vma_expand() has caref=
ul
> > > anon_cloned flag, __vma_adjust() does not, and I think could be
> > > unlinking a pre-existing anon_vma.  Aside from that, I am nervous abo=
ut
> > > using unlink_anon_vmas() there like that (and in vma_expand()): IIUC =
it's
> > > an unnecessary "optimization" for a very unlikely case, that's in dan=
ger
> > > of doing more harm than good; and should be removed from them both (t=
hen
> > > they can both simply return -ENOMEM when mas_preallocate() fails).
> >=20
> > I will add a flag to __vma_adjust, but I don't see how it could happen.
> > I guess if importer has an anon_vma already?  I added these as an unwin=
d
> > since I don't want to leak - even on the rare preallocation failure.  I=
f
> > you don't want to unroll, what would you suggest in these cases?  Would
> > a flag be acceptable?
>=20
> I cannot see what purpose adding a flag to __vma_adjust() would serve.
> If importer had anon_vma already, yes, without checking the code again,
> that was I think what I had in mind.  But (correct me if you've observed
> that I'm wrong) there's no question of a leak there: a vma which wasn't
> given an anon_vma before gets linked in to one, and it will all get torn
> down correctly when the process exits (indeed, when OOM kill completes).
>=20
> It's "nice" to delay setting anon_vma until it's needed, but not worth
> any effort to rewind it (especially on such an unlikely path): and
> normally, once anon_vma has been set, it stays set - I'm not sure of
> the consequence of unsetting it again (racing with rmap lookups: may
> be okay because of how anon_vma is not trusted when page is not mapped;
> but it's easier just to omit the rewind than think all that through).
>=20
> >=20
> > >=20
> > > 5. I was horrified/thrilled to notice last night that mas_store_preal=
loc()
> > > does a mas_destroy() at the end.  So only the first vma_mas_store() i=
n
> > > __vma_adjust() gets to use the carefully preallocated nodes.  I thoug=
ht
> > > that might be responsible for lots of nastiness, but again sadly no.
> > > Maybe it just falls back to GFP_ATOMIC when the preallocateds are gon=
e
> > > (I didn't look) and that often works okay.  Whether the carefully
> > > chosen prealloc count allows for __vma_adjust() use would be another
> > > question.  (Earlier on I did try doubling its calculation, in case it
> > > was preallocating too few, but that made no difference either.)
> >=20
> > mas_store_prealloc will allocate for the worst case scenario.  Since I
> > cannot guarantee the second store isn't the worst case, and could fail,
> > I cannot allow for more than one allocation per preallocate.  I thought
> > I was fine in __vma_adjust since I preallocate after the goto label for
> > a second removal but it turns out I wasn't since the second preallocate
> > could fail, so I've removed the requirement for a second store for 'cas=
e
> > 6' by updating the tree once and removing both VMAs in a single pass.
> > There could, potentially be an issue if the caller to __vma_merge()
> > wanted to reduce one limit of the VMA (I guess just the start..) and
> > also remove one or more VMAs, and also be in a situation where
> > allocations could cause issues (fs_reclaim).. and since __vma_adjust()
> > is so complicated, I looked at the callers.  Most use vma_merge(), and
> > those seem fine.  fs/exec only adjusts one at a time.  when splitting,
> > only a single insert happens.  Did I miss some situation(s)?
>=20
> I don't think the fs/exec stack moving will be any worry for this.
> Did you miss any case?  Yes, the "insert" cases from __split_vma().
> I have no appreciation of when maple tree actually needs to make an
> allocation, so I don't know whether the adjust_next case ever needs
> to make an allocation, but I'd have thought the insert case might
> need to sometimes.
>=20
> But I'll admit to skimming your paragraph there, I'm more concerned
> to go on to the following issue than fully grasp your argument above.
>=20
> >=20
> > >=20
> > > 6. The main problem, crashes on the workstation (never seen on the
> > > laptop).  I keep hacking around with the debug info (and, please,
> > > %px not %p, %lx not %lu in the debug info: I've changed them all,
> >=20
> > Okay, so I tried to remove all %px in the debug code so I'll revert
> > those.  I use %lu for historic reasons from mt_dump(), I can change
> > those too,  The tree uses ranges to store pointers so I print the
> > pointers in %lx and the ranges in %lu.
> >=20
> >=20
> > > and a couple of %lds, in my copy of lib/maple_tree.c).  I forget
> > > how the typical crashes appeared with the MAPLE_DEBUGs turned off
> > > (the BUG_ON(count !=3D mm->map_count) in exit_mmap() perhaps); I've
> > > turned them on, but usually comment out the mt_validate() and
> > > mt_dump(), which generate far too much noise for non-specialists,
> > > and delay the onset of crash tenfold (but re-enabled to give you
> > > the attached messages.xz).
> > >=20
> > > Every time, it's the cc1 (9.3.1) doing some munmapping (cc1 is
> > > mostly what's running in this load test, so that's not surprising;
> > > but surprising that even when I switched the laptop to using same
> > > gcc-9, couldn't reproduce the problem there). Typically, that
> > > munmapping has involved splitting a small, say three page, vma
> > > into two pages below and one page above (the "insert", and I've
> > > hacked the debug to dump that too, see "mmap: insert" - ah,
> > > looking at the messages now, the insert is bigger this time).
> > >=20
> > > And what has happened each time I've studied it (I don't know
> > > if this is evident from the mt dumps in the messages, I hope so)
> > > is that the vma and the insert have been correctly placed in the
> > > tree, except that the vma has *also* been placed several pages
> > > earlier, and a linear search of the tree finds that misplaced
> > > instance first, vm_start not matching mt index.
> > >=20
> > > The map_count in these cases has always been around 59, 60, 61:
> > > maybe just typical for cc1, or maybe significant for maple tree?
> > >=20
> > > I won't give up quite yet, but I'm hoping you'll have an idea for
> > > the misplaced tree entry.  Something going wrong in rebalancing?
> > >=20
> > > For a long time I assumed the problem would be at the mm/mmap.c end,
> > > and I've repeatedly tried different things with the vma_mas stuff
> > > in __vma_adjust() (for example, using vma_mas_remove() to remove
> > > vmas before re-adding them, and/or doing mas_reset() in more places);
> > > but none of those attempts actually fixed the issue.  So now I'm
> > > thinking the problem is really at the lib/maple_tree.c end.
> > >=20
> >=20
> > Do you have the patch
> > "maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It sounds
> > like your issue fits this fix exactly. I was seeing the same issue with
> > gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The logs
> > you sent also fit the situation. I went through the same exercise
> > (exorcism?) of debugging the various additions and removals of the VMA
> > only to find the issue in the tree itself.  The fix also modified the
> > test code to detect the issue - which was actually hit but not detected
> > in the existing test cases from a live capture of VMA activities.  It i=
s
> > difficult to spot in the tree dump as well.  I am sure I sent this to
> > Andrew as it is included in v11 and did not show up in his diff, but I
> > cannot find it on lore, perhaps I forgot to CC you?  I've attached it
> > here for you in case you missed it.
>=20
> Thanks!  No, I never received that patch, nor can I see it on lore
> or marc.info; but I (still) haven't looked at v11, and don't know
> about Andrew's diff.  Anyway, sounds exciting, I'm eager to stop
> writing this mail and get to testing with that in - but please
> let me know whether it's the mas_dead_leaves() or the __vma_adjust()
> mods you attached previously, which you want me to leave out.
>=20
> >=20
> > You are actually hitting the issue several iterations beyond when it
> > first occurred.  It was introduced earlier in the tree and exposed with
> > your other operations by means of a node split or merge.
> >=20
> > > 7. If you get to do cleanups later, please shrink those double blank
> > > lines to single blank lines.  And find a better name for the strange
> > > vma_mas_szero() - vma_mas_erase(), or is erase something different?
> > > I'm not even sure that it's needed: that's a special case for exec's
> > > shift_arg_pages() VM_STACK_INCOMPLETE_SETUP, which uses __vma_adjust(=
)
> > > in a non-standard way.  And trace_vma_mas_szero() in vma_mas_remove()
> > > looks wrong.
> >=20
> > Okay, I'll be sure to only have one blank line.  Where do you see this?
> > I would have thought that checkpatch would complain?  I did try to,
>=20
> No, I'm not going to search for those double blank lines now:
> please do your own diff and look through for them.  And I don't know
> whether checkpatch objects to them or not, but they're bad for patch
> application, since they increase the likelihood that a patch applies
> in the wrong place.
>=20
> As to whether this is or is not a good time for such cleanups,
> I just don't know: I see Andrew on the one hand intending to drop
> maple tree for the moment, but Linus on the other hand promising
> an extra week for 5.19.  I'll just let others decide what they want.
>=20
> Hugh
>=20
> > regretfully, address more checkpatch issues on v11.  It added more nois=
e
> > to the differences of v10 + patches to v11 than anything else.
> >=20
> >=20
> > Thanks again,
> > Liam=
