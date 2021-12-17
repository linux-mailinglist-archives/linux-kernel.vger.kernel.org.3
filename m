Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B247886B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhLQKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:09:34 -0500
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:13025
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234704AbhLQKJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfMoN7Zb2gDZ/9J0wGI6PiiUmDAq+SsfrNb8vY8z/78=;
 b=9fnzNF43I8LR1sKh6rksjpXL5hX/K9kpHklspShJQ6HtvRdQA02NB8hPOfP9N/aFEkgPTirdrOrhLyCJb79Z0s1vlIru+vGfFU1V2z8rv/xU0B1kOT5tqoOyHQt0DsmRZcOL+1ssInABOmgEsBdiQ9S9iMuV8pI0c9V2Dky6eg4=
Received: from DB3PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:8::44) by
 AM8PR08MB6420.eurprd08.prod.outlook.com (2603:10a6:20b:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 10:09:16 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::59) by DB3PR08CA0031.outlook.office365.com
 (2603:10a6:8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 10:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 10:09:16 +0000
Received: ("Tessian outbound de6049708a0a:v110"); Fri, 17 Dec 2021 10:09:16 +0000
X-CR-MTA-TID: 64aa7808
Received: from d182e4b12e52.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 04FFA0D8-EFF0-4CDB-997D-8AC8F06C5086.1;
        Fri, 17 Dec 2021 10:09:06 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d182e4b12e52.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 17 Dec 2021 10:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtdyZMeu1aGF7Z8PgKz1srvHI/D8nSeA6mcutFHaMY2aBBgrDgGimmQ+cC6Vr4Qf96IBTvoow4yhuaNMN1/vK/e6PdG6ARkgPFlHX+1LoFjgRi+c+OSNQDSOwb3yAADcXecWT+40yu8snoZ6lZ4VBNuZLIEUQSGuz7NCqVPPcDvdhMRPAzVAuqZ2nHo01SW0nWI4k3qca7LEgCbgBzaIv9rnR/4Ce2G9Fvf8PScg46q/wk6jyLa7GxVNm/YQhrb8foM4X2GnmY+bbUilu3X8SP5Moy+b3tv0URftFPUcLAvKZw4Cf7UZ5oZ+FhA3tZneeiZPkgpbJ+6DBo32d44dEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfMoN7Zb2gDZ/9J0wGI6PiiUmDAq+SsfrNb8vY8z/78=;
 b=JVkW8RX2F1vfUhCZUhPvYeKmuuZNXnXYW2BJR/hJQwux7b/Ll3kItzW1p6da+n/sEjR0oH/yNbSG5J6IMe6yK2W6A7+2lyinv34eay+DyG5n8Uh7X+cMhQc9mQqKhKB+v/jjVVrktjyrDPPhuqkPWFqsxz8MvsO1eNq7IZNyRIKKHICI7u+wnPBnsUR+o1XKdULggQ4KeoYHIP5Vee6Er2GFn4v2lrf5CWwu3GCVHgJuyEfRnbRj7sHIrghk027HzP+Llc0YwZdfd9s73J2RrJf+Im7+AWRbsExsdoQH/tHJYaa1mkQjori0qVLvM+fz4sGrnrPsJEzmBMXc2U6fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfMoN7Zb2gDZ/9J0wGI6PiiUmDAq+SsfrNb8vY8z/78=;
 b=9fnzNF43I8LR1sKh6rksjpXL5hX/K9kpHklspShJQ6HtvRdQA02NB8hPOfP9N/aFEkgPTirdrOrhLyCJb79Z0s1vlIru+vGfFU1V2z8rv/xU0B1kOT5tqoOyHQt0DsmRZcOL+1ssInABOmgEsBdiQ9S9iMuV8pI0c9V2Dky6eg4=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AS4PR08MB7432.eurprd08.prod.outlook.com (2603:10a6:20b:4e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Fri, 17 Dec
 2021 10:09:05 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14%3]) with mapi id 15.20.4755.028; Fri, 17 Dec 2021
 10:09:05 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Mark Rutland <Mark.Rutland@arm.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6w2bMsAgAAEIAA=
Date:   Fri, 17 Dec 2021 10:09:04 +0000
Message-ID: <AM9PR08MB727694AAAB8247FDF9AD73DAF4789@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YbxYuETndF9LmJz4@FVFF77S0Q05N>
In-Reply-To: <YbxYuETndF9LmJz4@FVFF77S0Q05N>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: CAE04E6A150DBF42B43E8E07A4447643.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 73b585cb-15c2-441f-4ee9-08d9c14548b1
x-ms-traffictypediagnostic: AS4PR08MB7432:|DB5EUR03FT019:EE_|AM8PR08MB6420:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB642036A7FB470ECA30DFFE77F4789@AM8PR08MB6420.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PVF3n1ycDNW+P/Jh2MVa5rg/8Vg+KOv0/GdHXNEmiRq2/T9yXRfVgUu8I1I5NKXm0h+01p6vSoTeEk0+keWsQJv79SXUbs3U/wMehHTb5bI0kzUSKWe7wcWi4stojk713CGBBGzq5D+KJuBHVZxcTI3lMPBblXBilZ+UTn8euj/3xVf29QG1d4Wm57c+xtViz/113bRuLq0lX7VqG+NIjy27oAm3a6oZM4dQksxbHRG5by8rOwkW/Vng8RJR08xG5gfYC3UrAltCxFWS6sMRQkbSh8GJjbXymEZAGQoT+O/CzA1uYqwq1PQ+P9fU135AnDYaBvsa+EqMhb0RJXhaPIcw9IGijps7rFxVImcMmRTwGGOQVNyHf4cCgBgr7Zf9r3XzFPIs/P9HC4skZi65uk0zPp7sGxWegiooAmXbG0gMnW1CyDsCdDh4SBFZ2daYZcHnQEt/zVKVMYmj1kOmUFDx/mH0/GZWkQkIdGAONipYhy6ZKuMsiz1VQvUUGU+TQgUQJlR8RthDZOJkN0ftqMJNbj7DPg2w/4/+uEv7POTo7jOnOqOjDNgCDftrx+fuBa3JbUAIaySxRV4pLipIY0qDzAq0QNouaX2dHgO21i3cSUzCwoQ29/VnRTrpMcRhg1laHrz3+vV97xa33/o7pwnLSVFuAN5vMIW+fjYWf9cQP27VJz5aCg2mQ/Mutcohk3s4DOEiBnv/GGTXYkk3og==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(66556008)(26005)(53546011)(508600001)(66446008)(64756008)(2906002)(5660300002)(33656002)(86362001)(55016003)(66946007)(122000001)(4326008)(76116006)(6506007)(38100700002)(54906003)(6862004)(38070700005)(8676002)(71200400001)(9686003)(66476007)(52536014)(83380400001)(316002)(8936002)(6636002)(186003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7432
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c5181dd-3a1d-4870-e9b6-08d9c14541c8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iQbeZx9bIWwQSZ8Ffp1x2DevgdOcdBiqhsZpIb7CuYsdef6+afH+Ed0P4BSFQld4RxtVutbArItP8cm+kxZnCtygzP7zUJQ858NZsJoHvyo5E5yyVcGB4M2AoIWR4TLrRZaJT1cW5wie1XC/qiQA32qpQN8yAEMeU0cri4Jsi6Fq4XF1Lx8xzbzGFWqvWMjlZU5XsCKQdsIK4fB1xXLHBs5rpGksrCPXv12QrfaQEiMuhND+U+Q+jHCzOHhijnmYBcmxwlM4Ui3G0exUtBdZGElEmgnGtqskjdCBuDPvlt485Dik4Q8h9/hKW7GaIINpMHB7HMRYeBjd8PTITqWbSU0rKD68mnMKia9N3dCOgU3PD5Dh+ogYbywXo7bLGcqUK2v5hoCYbgDMQjSQC8C7TsXgyI6PJ+quwA++IOUiZNN2yJSJcm5fCIaGbXiqWi3KxdfmLMYRMqwaWqsG0h+wFINnH6JZEbV2q2G3cOeVxm4F0gvnYE/TV31UnB6xJMj7FqQaigFYYlNyhduNrFUz6yFQm09gnGDEuM9wMdtC/uQNij+5kILyjP+ZH5oaH8YeYb2a1sGZkTBVnVuGDEyT3VQsDBk2YWssw98k06jDEHwmPqAIRzVwloTjGeEuQdkkbzM1smGjTUkdwmlfh2yKVBuWeeiJP2qtuTTLOZl0hf9SMhBzgGcGH0TCLeEDny6uf54ycitCRfVMLnetLCMCJ8MDrWUKwO/C+Bazcq7Sq/w3f6WU35eINFe+k1bT7GCJTq9KVS+VpvJcQ+jWADL8A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(9686003)(8936002)(52536014)(316002)(55016003)(82310400004)(36860700001)(336012)(508600001)(86362001)(33656002)(6636002)(54906003)(47076005)(5660300002)(6862004)(7696005)(2906002)(70586007)(26005)(4326008)(70206006)(6506007)(53546011)(8676002)(40460700001)(356005)(81166007)(83380400001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 10:09:16.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b585cb-15c2-441f-4ee9-08d9c14548b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Friday, December 17, 2021 5:31 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>; will@kernel.org; Anshuman
> Khandual <Anshuman.Khandual@arm.com>; akpm@linux-foundation.org;
> david@redhat.com; quic_qiancai@quicinc.com; ardb@kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gshan@redhat.com; Justin He <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> pud mapping
>=20
> On Thu, Dec 16, 2021 at 04:28:12PM +0800, Jianyong Wu wrote:
> > The 'fixmap' is a global resource and is used recursively by create
> > pud mapping(), leading to a potential race condition in the presence
> > of a concurrent call to alloc_init_pud():
> >
> > kernel_init thread                          virtio-mem workqueue thread
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                 =
         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >   alloc_init_pud(...)                       alloc_init_pud(...)
> >   pudp =3D pud_set_fixmap_offset(...)         pudp =3D pud_set_fixmap_o=
ffset(...)
> >   READ_ONCE(*pudp)
> >   pud_clear_fixmap(...)
> >                                             READ_ONCE(*pudp) // CRASH!
> >
> > As kernel may sleep during creating pud mapping, introduce a mutex
> > lock to serialise use of the fixmap entries by alloc_init_pud().
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>=20
> Since there were deadlock issues with the last version, it would be very =
nice
> if we could check this with at least:
>=20
> * CONFIG_DEBUG_ATOMIC_SLEEP
> * CONFIG_PROVE_LOCKING
>=20
> ... so that we can be reasonably certain that we're not introducing some
> livelock/deadlock scenario.
>=20

I enable these 2 configs and test for the current patch. No warning related=
 with this change found.=20

> Are you able to reproduce the problem for testing, or was this found by
> inspection? Do you have any instructions for reproducing the problem? e.g=
.
> can this easily be tested with QEMU?
>=20

I test it using Cloud Hypervisor not QEMU. I find the bug when I tested the=
 incoming feature of virtio-mem using Cloud Hypervisor.
I think we can reproduce this bug using QEMU, but as there is no virtio-mem=
 support for the current QEMU, we can only test the ACPI-based memory hotpl=
ug. However, I think it's not easy to do and I have not tried that.

In my test: firstly, start a VM and hotplug a large size of memory using vi=
rtio-mem and reboot or kexec a new kernel. When the kernel booting, memory =
hotplugged by virtio-mem will be added within kernel_init. As both of kerne=
l init and memory add thread will update page table, "alloc_pud_init" may b=
e executed concurrently.=20

I think it's not easy to reproduce the bug using ACPI based memory hotplug,=
 as we must hotplug memory at the same time of kernel_init to crash with it=
.=20

> If you're able to reproduce the issue, it would be nice to have an exampl=
e
> backtrace of when this goes wrong.
>=20
Yes, this bug occurs when kernel init, the function execute flow is:
-------------------------
kernel_init
  kernel_init_freeable
    ...
      do_initcall
        ...
          module_init [A]

  ...
  mark_readonly
    mark_rodata_ro [B]
-------------------------
[A] can contains memory hotplug init therefore both [A] and [B] can
update page table at the same time and may lead to crash.

Thanks
Jianyong Wu

> Thanks,
> Mark.
>=20
> > ---
> >
> > Change log:
> >
> > from v2 to v3:
> >      change spin lock to mutex lock as kernel may sleep when create
> > pud map.
> >
> >  arch/arm64/mm/mmu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
> > acfae9b41cc8..e680a6a8ca40 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD]
> __page_aligned_bss
> > __maybe_unused;  static pud_t bm_pud[PTRS_PER_PUD]
> __page_aligned_bss
> > __maybe_unused;
> >
> >  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> > +static DEFINE_MUTEX(fixmap_lock);
> >
> >  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)  { @@ -329,6 +330,11 @@
> > static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned lo=
ng
> end,
> >  	}
> >  	BUG_ON(p4d_bad(p4d));
> >
> > +	/*
> > +	 * We only have one fixmap entry per page-table level, so take
> > +	 * the fixmap lock until we're done.
> > +	 */
> > +	mutex_lock(&fixmap_lock);
> >  	pudp =3D pud_set_fixmap_offset(p4dp, addr);
> >  	do {
> >  		pud_t old_pud =3D READ_ONCE(*pudp);
> > @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned
> long addr, unsigned long end,
> >  	} while (pudp++, addr =3D next, addr !=3D end);
> >
> >  	pud_clear_fixmap();
> > +	mutex_unlock(&fixmap_lock);
> >  }
> >
> >  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> > --
> > 2.17.1
> >
