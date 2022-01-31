Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15D94A3E83
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbiAaINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:13:34 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:20296
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230124AbiAaINX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NnxIL+SQFIPep3WBTtHlDI6JP2df1FwP475e+qiSNU=;
 b=BvI0Guh5e/EEbKNYluEY6EBPr2MmZ25xvtqwLYRblcL1ml3Yco981z696c2hdGuQQeN2XoGSEBMJU637szOoRWKbgqQAzzWlJpuZzW+EuSHERrITKsrQuezwuqGDSMYhmB3U6UsBEy3+RczL46OTxGahAg7uE32307yKgsvNBG4=
Received: from AM5PR0301CA0028.eurprd03.prod.outlook.com
 (2603:10a6:206:14::41) by AM6PR08MB5543.eurprd08.prod.outlook.com
 (2603:10a6:20b:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 08:13:20 +0000
Received: from VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:14:cafe::51) by AM5PR0301CA0028.outlook.office365.com
 (2603:10a6:206:14::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21 via Frontend
 Transport; Mon, 31 Jan 2022 08:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT036.mail.protection.outlook.com (10.152.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 08:13:19 +0000
Received: ("Tessian outbound 1f399c739551:v113"); Mon, 31 Jan 2022 08:13:19 +0000
X-CR-MTA-TID: 64aa7808
Received: from 27c54c7ad817.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B320A10A-5BE9-446E-A1EC-668816BF7A8D.1;
        Mon, 31 Jan 2022 08:13:08 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 27c54c7ad817.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 31 Jan 2022 08:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W875wnnJMdM0KStKQxYOcZ4N6fzFzssHUhbWJdHnml3W0o154xh1376DDFD0Ca8oiThbLf35udGWlPF0l05AdkqCpjnhjhLa4+2om/NbqN537HD/yEvGRp0P7Mznqdg2eOZeyPHRtypZo5IPfFaP/sfLio/ve2j9kBUG7X9rUfi0s2V9HOKDs35xWWy7xsPyJBQUjC+Lacrc4KL6Z4euE+4XYM4qd0zxjDXU5Ygv8eXx+QiJOjmjJ4dbMbv8Wh9Ltd4qWxSiKteTAYE8LRU/pRCchVPaae8eKmaJ167wMBSb+nNnp7IksNC6tztwZS2Oe3pvVftFONruxDll0/BMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NnxIL+SQFIPep3WBTtHlDI6JP2df1FwP475e+qiSNU=;
 b=ftgy0r5c01KjWtL3RG2AYN5GcQWdVsZaBaOGBAbMrDKde7U3KxDE7uKoqxIb4yDd0zCZ7/0BlVg60acwrMWAnM7feW1aVuxceQB0vOXD/6f1mLRgzGxUJ+YZ/CsTF9GkyN8opGETmczg8hkoag4evSfNAIesETzOC/H686ohMINhcNlB/pczinty5j3b3ZqZzLlVsbKTIrCtGluFAwYHqHnp/pN5F3b7aMJXBK31dCgcRxr0E24wLwvmxctVoJlaVOl8EgduxRxGZ4JHC52f7HX6y1dVVvUWlBXy/8P/+/b5eQzSi5P07qfWR6tqlYp9O6hUCVji0ddedAQwhqBo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NnxIL+SQFIPep3WBTtHlDI6JP2df1FwP475e+qiSNU=;
 b=BvI0Guh5e/EEbKNYluEY6EBPr2MmZ25xvtqwLYRblcL1ml3Yco981z696c2hdGuQQeN2XoGSEBMJU637szOoRWKbgqQAzzWlJpuZzW+EuSHERrITKsrQuezwuqGDSMYhmB3U6UsBEy3+RczL46OTxGahAg7uE32307yKgsvNBG4=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB6866.eurprd08.prod.outlook.com (2603:10a6:20b:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 08:13:05 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%7]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 08:13:05 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>,
        David Hildenbrand <david@redhat.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, Justin He <Justin.He@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWCAAGL4AIABFwGwgAAjrYCAHXF+gIAAR6QAgAAGaOCAABRIgIAAAXgAgAABfiCAAAIvAIAAAEEAgAFJh/CAAGfSgIAAA0QAgAX/utA=
Date:   Mon, 31 Jan 2022 08:13:05 +0000
Message-ID: <AM9PR08MB72760D717ACE24811C4EA221F4259@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
 <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
 <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
 <AM9PR08MB72764111B775352448D75CD9F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <65fdd873-1f93-56e3-c7a5-98d621c5dbd8@redhat.com>
 <7eb4bc77-c1db-99c4-4c77-ae9ddd159abb@redhat.com>
 <AM9PR08MB7276062BC7B474174FFFA11BF4219@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <ca62449b-7ab0-0e18-ee5a-b46b3f527385@redhat.com> <YfKRVJlWrgluqD9e@arm.com>
In-Reply-To: <YfKRVJlWrgluqD9e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 678F4802190FA54E8C0ABFAA24DD1E6F.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 11145a12-4c57-4962-fc1b-08d9e4918ada
x-ms-traffictypediagnostic: AM9PR08MB6866:EE_|VE1EUR03FT036:EE_|AM6PR08MB5543:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB55438A0E946DCDAE4474BEE4F4259@AM6PR08MB5543.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r8rQMinuI3obOb0Sx0lfF8iSUk4GsMVKs89KrfljF85rckEqwo47yih76w3xm1C5xhbF1mPvapDuTFccmbImmojmKuwyRD0LZeEwOoy7WobuI3T0ejl+XvzC0dxaTOzith52RhHjxDhXJqpOEJjCsxSqV4TqkQTEMB0f6sEyurAu6gHvIkUak2TG879ECGvbhLVhhEvggVIS1GfJip3AYIgowroOpJQ1tGCIu5g1PqV5akCrwPDWoWnlrov4o8jpatDh3Rx8m1jJ1rvVYZTUVbU29q9vm6pMI/Fq7/Jb1h8DHh865lQsv0tyJ292keLMm/QcsMLy6I6Qo3KItzWqyfh7/vYsY0DJW7D/SA/sqvimAjMq/Hgm+JuVz3dRqgHqTBib07gzRytRossCNsybYuqB7vWv+MgHNxnR9+f3PBVACKXgwxhCtsnOQteIYuHXFMp1YIz/p/RrUEB9VY0nSdD677mXTfbHyufH6QORH33VIUdnl75+BYvb71U0iOeQug84i1O3SWht3z7uuFQJNihF6HPhZCpt0RtGKgqsPOD8ujMvEPFuV5KiIdbDgmnXNznvurav+q3vcbGNnzYD/9llu7jqIXA9975S3JZYaQoyG68M664YvZMtTeyn16vbmPo6YFw2Z/qPd7tXFvLGqITGMd7CYsT5hUZd3y1lXLdnPFnOXWnO86yjFsZ9klztQfYhlefm/lAHf9ZH6eq4wQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(508600001)(71200400001)(83380400001)(66476007)(8676002)(76116006)(8936002)(64756008)(66946007)(38100700002)(66556008)(66446008)(7696005)(316002)(9686003)(4326008)(6506007)(122000001)(33656002)(54906003)(2906002)(38070700005)(110136005)(52536014)(5660300002)(86362001)(26005)(53546011)(186003)(20210929001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6866
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fdef300a-e368-4bad-835a-08d9e4918240
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //d6WeJPBRoKYzCRtDGRUGXzajV2GaCB5obZ23JPig13VLKWD9ScBtxRci27uVzvgY7tnK1nUT36C4WYi8ckYJf8rRmIByj7q1MHSoGsQGeij/gU5WWwjNDVVBW2XgfD9Eev/x+SThfpX1e1v5bBQyi5noLpgCNQ4XflTSShInR1msTZIbPh0WuWVuyx7ojvD8qA2l7s9z2OdCU5ifdzIz9CHeSN3LfUy7NDanC/srfE+sgwHXERuVuHLQ2abjC30HdPRomqYom8KU8JP+TAKKISPOisHIDK+LtwWOyOqvQgZeQ5Y1JVblJywYLoP114us6iNrXVHXXh0ucYH/1Y9PSa5CGDulLWLigVIc/RGVaQ9ODwypZlv8wtLGEJOk49QqKQVY3tzxA48uirg4lKMVVCebu6koVI1Jj6LTyGCAnsLqsQmrZFo7srw2MSavg02pPoSWpMpdOKVQ4HGnR0L2qrZPJI5W2PbfJCV5YU9+tnTiDHbNhjFxReD90nenfs5LozRMc2kOAEm/bBOTi04TorskAVzaWKUXG/cJTgkMNv6RqwhopcC6aJdlmCtctEPvakGjOcDflrVlUM2fLSY31X0xc8ExiFTICwOZgSw/ak6o2zoDiLp3GPcjpK9o/CkBoeuCjHOW+S/YVJYr4T7uSXhFd9BsOJMR3V0uhdlQFKtCD6Qq1fFbKpUEycfxq8
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(186003)(26005)(2906002)(336012)(356005)(40460700003)(86362001)(82310400004)(36860700001)(81166007)(4326008)(5660300002)(9686003)(6506007)(33656002)(55016003)(70586007)(70206006)(8936002)(7696005)(8676002)(508600001)(53546011)(54906003)(110136005)(52536014)(316002)(47076005)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 08:13:19.9580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11145a12-4c57-4962-fc1b-08d9e4918ada
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5543
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Thursday, January 27, 2022 8:34 PM
> To: David Hildenbrand <david@redhat.com>
> Cc: Jianyong Wu <Jianyong.Wu@arm.com>; Ard Biesheuvel
> <ardb@kernel.org>; Justin He <Justin.He@arm.com>; will@kernel.org;
> Anshuman Khandual <Anshuman.Khandual@arm.com>; akpm@linux-
> foundation.org; quic_qiancai@quicinc.com; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; gshan@redhat.com; nd <nd@arm.com>
> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> pud mapping
>=20
> On Thu, Jan 27, 2022 at 01:22:47PM +0100, David Hildenbrand wrote:
> > > Yes, system_state can roughly separate these callers of
> __create_pgd_mapping. When system_state > SYSTEM_BOOTING we can
> add the lock.
> > > Thus, I have the following change:
> > >
> > > static DEFINE_SPINLOCK(swapper_pgdir_lock);
> > > +static DEFINE_MUTEX(fixmap_lock);
> > >
> > >  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)  { @@ -329,6 +330,8
> @@
> > > static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned =
long
> end,
> > >         }
> > >         BUG_ON(p4d_bad(p4d));
> > >
> > > +       if (system_state > SYSTEM_BOOTING)
> >
> > As there is nothing smaller than SYSTEM_BOOTING, you can use
> > 	if (system_state !=3D SYSTEM_BOOTING)
> >
> > ...
> >
> > >
> > > It seems work and somehow simper. But I don't know if it is
> > > reasonable to do this. So, any idea? @Ard Biesheuvel  @Catalin
> > > Marinas
> >
> > It's worth looking at kernel/notifier.c, e.g.,
> > blocking_notifier_chain_register()
> >
> > if (unlikely(system_state =3D=3D SYSTEM_BOOTING))
> > 	return notifier_chain_register(&nh->head, n);
> >
> > down_write(&nh->rwsem);
> > ret =3D notifier_chain_register(&nh->head, n); up_write(&nh->rwsem);
> >
> > If we decide to go down that path, we should make sure to add a
> > comment like
> >
> > /*
> >  * No need for locking during early boot. And it doesn't work as
> >  * expected with KASLR enabled where we might clear BSS twice.
> >  */
>=20
> A similar approach sounds fine to me.
>=20

OK, I'll send the next version based on David's comments.

Thanks
Jianyong

> --
> Catalin
