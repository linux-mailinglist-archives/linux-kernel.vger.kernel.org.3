Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752D468F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhLFCS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:18:58 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:3972
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233840AbhLFCPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh+KnkA2xLDSd+BBXpfsrDA0cXcCXBicF3pN28jyQOc=;
 b=ChG+/R5HAlD62qrnh/HMf+u7F+lOzPdZP4p3ba9afQ3pxA52uHPxikWszWKdYclrj2YQJLxTaumkOpIRM7Ypy63w2GjhQSeNS5FqU1liTS5TsGs7lJ+56eNOwLvhUoFzrHoUn7wIAzVemdDh61seOgzObBv/nKkTcoi6EQ8Xy9g=
Received: from DB8PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:100::36)
 by AS8PR08MB6838.eurprd08.prod.outlook.com (2603:10a6:20b:353::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 02:11:30 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::f4) by DB8PR06CA0023.outlook.office365.com
 (2603:10a6:10:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Mon, 6 Dec 2021 02:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 02:11:30 +0000
Received: ("Tessian outbound de6049708a0a:v110"); Mon, 06 Dec 2021 02:11:29 +0000
X-CR-MTA-TID: 64aa7808
Received: from c5863d54cb98.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 11A5480B-0C99-4DAF-BF8F-D74CEE622A0E.1;
        Mon, 06 Dec 2021 02:11:19 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c5863d54cb98.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Dec 2021 02:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zw7pRdz6kWm4MvmHWO4s3PQKB7QtimNLZk5iHAkPwCGnIcphUrOiz7hufpHxELVsvvAd7QHbH4Gpj3U0pIbK0ykMRJtzuBxropZVwqxyYi+6I0hyr6HRDsYF2ErtziRnH9UFONZr63vHUp5rmIA+FsMZZzj1GYM8BDAE1bj9wywAtvEvsqsWI4NDDaquyKxHpoqlx07nSlmlfWcOH6nr7ZXM8wEZS7rDbtgPQuOcmO+z8LgTQV+k2706/gi+wj8jOvwNFzXR2Mut4vuVdGPwhysS5REM31we34m+1j3dol/ttKcPDZpCsq7IWE0fVAxsOf29Gh2/UmYPCEpgTJ/QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh+KnkA2xLDSd+BBXpfsrDA0cXcCXBicF3pN28jyQOc=;
 b=blXsSJ0oTzfSiMdgftijP677vnO//fXHQJIwXSMWE9wlS2eIIE/dx11qxMYPi/Rp3V7/X3GEvz5I7KFq14TvfRhY9C0i6KP1bN2upOg8krkM6J6njgZYgzRqQBTn3QFeg6WtFj+gVJst2PyvUbI2OuFkFfeQGV/3SO1+d5Eq1sZBalwhfmlLDTfLZ6idYVMAlP/v0yKeBbe11QMS1fsCGoKrAJEiNTnLMqdtePHRlHvrTzqvNRW42Xx6i92xNcu40jRoV5z/LCkyUbEx6TVzqZIQnfhB13VHjLUKRwmBc5l2flYkZ4dBfDYSEhfxfv3Ma6QJTbkeGM5RWhxFh1Dmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh+KnkA2xLDSd+BBXpfsrDA0cXcCXBicF3pN28jyQOc=;
 b=ChG+/R5HAlD62qrnh/HMf+u7F+lOzPdZP4p3ba9afQ3pxA52uHPxikWszWKdYclrj2YQJLxTaumkOpIRM7Ypy63w2GjhQSeNS5FqU1liTS5TsGs7lJ+56eNOwLvhUoFzrHoUn7wIAzVemdDh61seOgzObBv/nKkTcoi6EQ8Xy9g=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB7085.eurprd08.prod.outlook.com (2603:10a6:20b:417::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 02:11:15 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14%3]) with mapi id 15.20.4734.028; Mon, 6 Dec 2021
 02:11:15 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v1] arm64/mm: avoid race condition of update page table
 when kernel init
Thread-Topic: [PATCH v1] arm64/mm: avoid race condition of update page table
 when kernel init
Thread-Index: AQHXyxfjckbZs45/jUaWUxeL4pEnmavn60UAgAAWg/CAOULKgIADsRjw
Date:   Mon, 6 Dec 2021 02:11:15 +0000
Message-ID: <AM9PR08MB7276033998B39D9B6CC83EE3F46D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211027094828.7629-1-jianyong.wu@arm.com>
 <1cd8e875-24b1-2904-4e9f-2a4eb13674dc@arm.com>
 <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YapXa8JWPNhkePwO@arm.com>
In-Reply-To: <YapXa8JWPNhkePwO@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: CD4D7523F80BB14C9D87A31D4D81EADA.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e4036103-1b26-4b8b-ce1b-08d9b85db7d0
x-ms-traffictypediagnostic: AM9PR08MB7085:|AS8PR08MB6838:
X-Microsoft-Antispam-PRVS: <AS8PR08MB68389A6386828F40595F7AD7F46D9@AS8PR08MB6838.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZQ4K6KpoHUsKDKqcmOU038Ax3Ile7hWbBl+j28y5QG8pnsk1xRqX5dVFKmr748fwR51ZJaQdhOxYvf1jb7XsX8eOTip0JNNGib4T6V/4pTwgGh1Ud7/odMSEaWLGx5+MrryqXGPME26bf7p+5deBHcrCk2nnb7WMtGxhEF3THtzZ5rg6irQJYLNF2TK0v0zzmLqAlAV0+XiAmIVdBVNkr+s7BYtUnXpkyyUckdhhZva5Z0WfgrWFt4D5nNwyq2TD2e/G+/YCxML/OjWACEsg5xpM/cnnnOtJn60HpOGtRO5Kd54FYY4z7FterJ1VW6Aa/gI4bosY4shXsk7z2lauY4KL4HDjt/PpKGqEP3Uv2sjUu8nshnXD/l3kBtQdXtmBZRD7UThHyzV65j2eqD9qNq8UFPQDGuCXsFBEXxKrpWhC6Thpk9fXiNga3I+liqdCmIjCCalD1PibHEewBv91QcdiOSqevBR/wnSKirJySf5tNpN5Uw58hICHoiKa1QQ+j0q5ELX57NUUnNE5tfmSD/U/tbuDduoSlfmWvFyMxGHa+EQGSFk5esXVAKPRQh7ZsuBz16rWiQ3AthuoABGadQBT9V4xMiQ5vNaHjmz4FgLKCnNvGfeo9ViARFJ+EK8MwuYi2on4AF4dJk72V3JQCcVMYfm3msqt6HjFD11YAhtI7M0fVEub8NZb7DcYkGDG58WYMb2X5ymAqixikJCX3g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(316002)(508600001)(38100700002)(122000001)(33656002)(2906002)(71200400001)(66946007)(26005)(66556008)(66446008)(9686003)(64756008)(54906003)(76116006)(7696005)(38070700005)(8676002)(15650500001)(6506007)(86362001)(8936002)(186003)(6636002)(53546011)(52536014)(5660300002)(6862004)(83380400001)(55016003)(4326008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7085
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6bab00e-721f-47cc-0282-08d9b85daeeb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXUgGJDWKgPWA+qY/6rwTlLfmfgVCR6CZ8FGmcc2AyGRh9FqKLICjvv5YpImF3JnvRBiaEpeiG32Ful991qQLjjJOYnOnmOF6feZ4Ahv9c6CxpC9GHD9lDrkvuTrb6xr+Y/TtoXcSDzj9vMdhDxZGF22Nty5674yE/5QwsVdydLdDda7vyYNuRrvETz/kP6QRoiO/3CWJObeAtqO4Z3SAVgi4sJVlllyZI7jIvg7ygz9ENzKAtdhqMOrGD0u836KppbBWyVQ8ZdVCWxv9/+/pSTWItavUKWexoIGkLG+WpEQiSCkQEdUbXRYVry3yZJpbHBKFnGbJbzqNOONyH6vsanam3yYqbQYkxUiIhlOzSqvgrI3NjYGaeQXM+MnJZZpmDxQi3JjPOxPOzPTq7sRJBrjXHOknbG6FSp1BNTd2ZXvnjmkIHo43C8MtOcdvfLPbleky2u5NH5JnLe38eQfQRgXiKqXNjgFNNdHkRUZYPR/OCfOFjH25k85htuIqy7TihsA8koWPlrSHEUnF1zKRerXSC2LnxIAHoG5HAaAssNb9AfXeEELplPVouPzeoIT++ZEhdG1bDCnbElcko7IJwIasDPq6P9q4dtkx4yUNgCWh2FyGNhnlycAo17A1dfgb5BVd9/9MFVIzid6n1YjMaqAFPs/LNqtTqErpueVu+Nul1e+LIHTyz24INkZIl1i8IqpAiD+pTpIFd4U+4wHXA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(86362001)(5660300002)(186003)(83380400001)(70586007)(26005)(7696005)(6636002)(6506007)(53546011)(81166007)(336012)(356005)(70206006)(316002)(52536014)(82310400004)(9686003)(8936002)(6862004)(33656002)(4326008)(15650500001)(508600001)(36860700001)(55016003)(8676002)(47076005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 02:11:30.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4036103-1b26-4b8b-ce1b-08d9b85db7d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Catalin,

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Saturday, December 4, 2021 1:44 AM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>; will@kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> maz@kernel.org; ardb@kernel.org; david@redhat.com; gshan@redhat.com;
> Justin He <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v1] arm64/mm: avoid race condition of update page
> table when kernel init
>=20
> On Thu, Oct 28, 2021 at 08:36:07AM +0100, Jianyong Wu wrote:
> > From Anshuman Khandual <anshuman.khandual@arm.com>:
> > > On 10/27/21 3:18 PM, Jianyong Wu wrote:
> > > > Race condition of page table update can happen in kernel boot
> > > > period as both of memory hotplug action when kernel init and the
> > > > mark_rodata_ro can update page table. For virtio-mem, the function
> excute flow chart is:
> > > >
> > > > -------------------------
> > > > kernel_init
> > > >   kernel_init_freeable
> > > >     ...
> > > >       do_initcall
> > > >         ...
> > > >           module_init [A]
> > > >
> > > >   ...
> > > >   mark_readonly
> > > >     mark_rodata_ro [B]
> > > > -------------------------
> [...]
> > > > We can see that the error derived from the l3 translation as the
> > > > pte value is *0*. That is because the fixmap has been clear when ac=
cess.
> > > >
> > > > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > ---
> > > >  arch/arm64/mm/mmu.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
> > > > cfd9deb347c3..567dfba8f08a 100644
> > > > --- a/arch/arm64/mm/mmu.c
> > > > +++ b/arch/arm64/mm/mmu.c
> > > > @@ -564,8 +564,10 @@ void mark_rodata_ro(void)
> > > >      * to cover NOTES and EXCEPTION_TABLE.
> > > >      */
> > > >     section_size =3D (unsigned long)__init_begin - (unsigned
> > > > long)__start_rodata;
> > > > +   get_online_mems();
> > > >     update_mapping_prot(__pa_symbol(__start_rodata), (unsigned
> long)__start_rodata,
> > > >                         section_size, PAGE_KERNEL_RO);
> > > > +   put_online_mems();
> > > >
> > > >     debug_checkwx();
> > > >  }
> > >
> > > While this should solve the current problem i.e race between
> > > concurrent memory hotplug operation and mark_rodata_ro(), but I am
> > > still wondering whether this is the fix at the right place and
> > > granularity. Basically a hotplug operation queued in an work queue
> > > at [A] can execute during [B] is the root cause of this problem.
> >
> > Not exactly, this issue doesn't only happen at the the *pure* kernel
> > boot. For example, hotplug memory through VM monitor when VM boot.
> We
> > can't foresee when that happen. Thus, this issue can affect all kinds
> > of memory hotplug mechanism, including ACPI based memory hotplug and
> > virtio-mem. I'm not sure that fix it here is the best way. If the race
> > only happens between kernel init and memory hotplug, I think it's fine
> > to fix it here. IMO, this issue results from the race for "fixmap"
> > resource. I wonder why this global resource is not protected by a
> > lock. Maybe we can add one and fix it there.
>=20
> IIUC the race is caused by multiple attempts to use the fixmap at the sam=
e
> time. We can add a fixmap_lock and hold it during __create_pgd_mapping().
>=20
Yes, fixmap race leads to the bug. I will send this change later.=20

Thanks
Jianyong

> --
> Catalin
