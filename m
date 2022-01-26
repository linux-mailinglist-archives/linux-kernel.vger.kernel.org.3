Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5444C49C296
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiAZEUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:20:45 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:34561
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229671AbiAZEUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5udjvca16ja1RFWzlM85YwIsPIfNoqhO0msQD7F9xRQ=;
 b=wN1be5URUMOzGCvoF2QHrRT7sLYd9UxlQZ1XfmMSEPFlXkcYtykPNOOQ5FY3MltuMVNyyflBVzAnp8rY+pyU4nHw4KBhzjTESOhYKao6SGdihXwY4swYng9Cb9q+862PQYWjo/nPZC+krukVVdNZaETJC+wkQSgio+YNur8Uupw=
Received: from AS8P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::17)
 by AM9PR08MB7134.eurprd08.prod.outlook.com (2603:10a6:20b:41f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 04:20:40 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::bf) by AS8P189CA0003.outlook.office365.com
 (2603:10a6:20b:31f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 04:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 26 Jan 2022 04:20:40 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Wed, 26 Jan 2022 04:20:39 +0000
X-CR-MTA-TID: 64aa7808
Received: from 550012c7bd30.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7A819430-2671-499F-B2FB-49A26B1C801E.1;
        Wed, 26 Jan 2022 04:20:34 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 550012c7bd30.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Jan 2022 04:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+LijzYoTTQVxO7/h3UtjN+iu7lsKe8+8gde2e+QWE7BqwBGOWBqsWA+53YHoX6oOAxhkRpBU5rxzr6ths27nPdNWEGor7sefXNx3bejDtTRDiiR9u2BK1B95Rsh1yGVqMYtAvfigpu+T5KhpiNIA5oLKIJn4uGo1QKSgy72e2GhSCQvIcjOxLsFro0wvtENTOPpVuw7G0O7z7RJkIoZLDV1sInPyElzSGrAssP9KuZr2Go0eY1yfWPhZucL+VZJ+XN9rAAinxWw2FtL/HnOuA39jFDC59tUWhSci3MM9VFHLfO064qEZOhU8VIbybie3BLpt2Sp2Bid5X0/tCLKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5udjvca16ja1RFWzlM85YwIsPIfNoqhO0msQD7F9xRQ=;
 b=kxCogmsA5Ck/2km+PZ1DtYk8781SzVDfwuh6LWPLCG7WcLhfNQbi5ujMsOHY6sC1GdURW+es/YNX8WRlNVBtal4QElAL8qSa6ydtNWJS+yvEWOvEXujuR0zBoTAX4RF/tLEJgNE1oxced/yd5EPXEWIHlfVYGu7iw0wgHyWc6XSLnTw8UYXkrkbg2w0AgLvDg2I9rXi9pwgXpSRqSZNFmEUDC03Dtf5lSHPcPzyMn+/AdprX14zpqpcIrNdhqEA3oNsqomLOij/S3S3NYLTyE94SKp3oy250dODXT2wh9HimVOsGI3v6Vd3h4AnLTz46AFIHx0nja5COHURviLb24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5udjvca16ja1RFWzlM85YwIsPIfNoqhO0msQD7F9xRQ=;
 b=wN1be5URUMOzGCvoF2QHrRT7sLYd9UxlQZ1XfmMSEPFlXkcYtykPNOOQ5FY3MltuMVNyyflBVzAnp8rY+pyU4nHw4KBhzjTESOhYKao6SGdihXwY4swYng9Cb9q+862PQYWjo/nPZC+krukVVdNZaETJC+wkQSgio+YNur8Uupw=
Received: from DB7PR08MB3737.eurprd08.prod.outlook.com (2603:10a6:10:33::27)
 by AS8PR08MB6359.eurprd08.prod.outlook.com (2603:10a6:20b:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 04:20:32 +0000
Received: from DB7PR08MB3737.eurprd08.prod.outlook.com
 ([fe80::f10e:2718:7a22:3c12]) by DB7PR08MB3737.eurprd08.prod.outlook.com
 ([fe80::f10e:2718:7a22:3c12%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 04:20:32 +0000
From:   Justin He <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Jianyong Wu <Jianyong.Wu@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbtE25Jxomi6EyEj6gGYJIT7qxU2ImAgAEOxwCAAF/yAIABIQaAgAAZqICAHI870A==
Date:   Wed, 26 Jan 2022 04:20:31 +0000
Message-ID: <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
In-Reply-To: <YdgZJ/mBG+BCxmEv@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: AAD9E1A1C98EBC41B5E9136E1061ECF7.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 61bdc757-769d-427c-8552-08d9e083360b
x-ms-traffictypediagnostic: AS8PR08MB6359:EE_|VE1EUR03FT011:EE_|AM9PR08MB7134:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB7134F2E48A91716701BC9C7EF7209@AM9PR08MB7134.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m3hjmEs/qepCDVOKYu+YK54ZFJgLsFODoVMa/8KsxTrOWn1axXWolw33SnnheYN4Q3BPUKhey9opGPWewtWACTQQkUyoqnfNlKwNAwH4YL/A9Lzexw4nkKmysfZ5zUEdKFUOTss7ZiIfaPnWvFrwykshbJcqK8Mhau625zuTtbel1GrfbUd+zfreomQ6o33IkWJOeO3NVFvJvOON+MpgbJMRMazv7gwRXgZGT9soRwwZ4WSuy6by+HKWYQMvB9iu2GwI9HJPAhYggkWjgBsKfrr1rUNdQbPEiYFtbhA95h2cYf1LfLIQOT2JGVmB2FZ1grFt56aUnHY10EmISJCEvOHi2NhMMCUG2k05BoeIVxM3VGgq2rTWwaNuC5PbJBXfXQWKqGJwj+TyCMeykZm9MBb6k6Typ/yzrCdCqSKJZPMk+HhOj0Vg4pdRtVsYl2+d7LuCgk5ZX4KNMlunUVBAy1UmnFgimiGLO6LNWY4zV0gtB0LxiGGxbrKxWr3+WSnBP+/9BZ5jQzUPFkjMBsMMw0JekjkFqjzU6Mf9Mfstu12cOHOkPifqmPQ3d99xK6BnVbiHwW20Vy0YgqiDzmP0Y8I4u+bwioKIlnUBfuRcN4eKGfCKIAZIiApZsiO/NcjiM9IK0lgRu4HtvW4RzTKi7evEssPEK25ylt1APu0azDGIkBeXR/cPNd3NjLL1krJjzWuv1mnrRgZXoX4ilO+/7A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(8676002)(4326008)(9686003)(110136005)(316002)(122000001)(186003)(76116006)(5660300002)(7696005)(66446008)(53546011)(66476007)(66556008)(38100700002)(2906002)(55016003)(38070700005)(8936002)(6636002)(83380400001)(26005)(66946007)(71200400001)(54906003)(52536014)(6506007)(508600001)(86362001)(33656002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6359
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0f099fd7-7a47-4db7-87af-08d9e0833134
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5a2aVHQlCLXYgi0CM47U8fPKW/61Xmgivjcw3qUvw5GWwiGd/p6qy+ktOAXJDh9N4+4DUY1kgO37pkVQfm0ulNA2pan1oP2B5qXJKXmDxYDhlmdnL4qLXlJD96r3QQLN8qwQziL6wO5DR4roUw+B06Fxh6Nm4z+bIZpyWWhKixcNmFSvbB/ZOyHdfjKaFbA2M1mdjrgfxpgkg/2FmGraG/u8W4PrAINsDleEfW1WPp2ki3mxWtkZIsOK7wtHYe666lQhWYT8Nv+D7PCesxy+ddyt9UbNTRP82viCXYpSzzNh8remZmHCq5a1kmUG85C/Dt0joDbAYlhcWvSC5znz/PbzFo/aJahrXRheghYHr83Y4HN0pvJT1VNX67k2RoSx2z1Mj7s8kBmHRuue2W06HRtKlM6cffT3xRnBNl4I0pA1SXmOfMt7V+Uq360fZSQ8PAq0BOiP7sVb4jeShh4I6QCu7OIBUcS6/YNdACecD5haGWYP9o1q8Gtr6ii6jxCQ4AmX4K63fMd43hdN53+MQm3s3EAxVjLTQMga3ges9rhBi67p0XLcZq2AokjxysgWi0x+hvee+0KVnXvlET3lQF7KGk5nnEofJuPk56IYOgwFtXmMSVZSCRWDpI9wD02g/MmbYDnTc/33C1J0d7KwBY3SNy5416PvORgWQgjPEDXCLTox7eD8VamAkxXXuErc
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(336012)(26005)(186003)(356005)(2906002)(70206006)(70586007)(8936002)(8676002)(52536014)(5660300002)(55016003)(33656002)(4326008)(9686003)(110136005)(82310400004)(86362001)(7696005)(6506007)(316002)(54906003)(81166007)(40460700003)(83380400001)(53546011)(508600001)(47076005)(6636002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:20:40.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bdc757-769d-427c-8552-08d9e083360b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Friday, January 7, 2022 6:43 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: will@kernel.org; Anshuman Khandual <Anshuman.Khandual@arm.com>;
> akpm@linux-foundation.org; david@redhat.com; quic_qiancai@quicinc.com;
> ardb@kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; gshan@redhat.com; Justin He
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> pud mapping
>=20
> On Fri, Jan 07, 2022 at 09:10:57AM +0000, Jianyong Wu wrote:
> > Hi Catalin,
> >
> > I roughly find the root cause.
> >  alloc_init_pud will be called at the very beginning of kernel boot in
> create_mapping_noalloc where no memory allocator is initialized. But
> lockdep check may need allocate memory. So, kernel take exception when
> acquire lock.(I have not found the exact code that cause this issue)
> that's say we may not be able to use a lock so early.
> >
> > I come up with 2 methods to address it.
> > 1) skip dead lock check at the very beginning of kernel boot in lockdep
> code.
> > 2) provided 2 two versions of __create_pgd_mapping, one with lock in
> > it and the other without. There may be no possible of race for memory
> > mapping at the very beginning time of kernel boot, thus we can use the
> > no lock version of __create_pgd_mapping safely.
> > In my test, this issue is gone if there is no lock held in
> > create_mapping_noalloc. I think create_mapping_noalloc is called early
> > enough to avoid the race conditions of memory mapping, however, I have
> > not proved it.
>=20
> I think method 2 would work better but rather than implementing new
> nolock functions I'd add a NO_LOCK flag and check it in
> alloc_init_pud() before mutex_lock/unlock. Also add a comment when
> passing the NO_LOCK flag on why it's needed and why there wouldn't be
> any races at that stage (early boot etc.)
>=20
The problematic code path is:
__primary_switched
	early_fdt_map->fixmap_remap_fdt
		create_mapping_noalloc->alloc_init_pud
			mutex_lock (with Jianyong's patch)

The problem seems to be that we will clear BSS segment twice if kaslr
is enabled. Hence, some of the static variables in lockdep init process wer=
e
messed up. That is to said, with kaslr enabled we might initialize lockdep
twice if we add mutex_lock/unlock in alloc_init_pud().

In other ways, if we invoke mutex_lock/unlock in such a early booting stage=
.
It might be unsafe because lockdep inserts lock_acquire/release as the comp=
lex
hooks.

In summary, would it better if Jianyong splits these early boot and late bo=
ot
case? e.g. introduce a nolock version for create_mapping_noalloc().

What do you think of it?

--
Cheers,
Justin (Jia He)


