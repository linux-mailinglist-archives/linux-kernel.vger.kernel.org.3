Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E393558D752
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiHIKUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHIKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:20:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88431F2ED
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660040401; x=1691576401;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CNPNRhN/yqd4/045TH5SYwETgTnWptTwG4mforGwsew=;
  b=b6jq3ht2LaTZgATgRvcEwHsI4taY5mEYfCGguJlJayRjAMNeZl0gEhDt
   7fM1Og/2AtlCuzXllnRRMD6pTa5RTijFbrXfHhJ8XsXCQyomkOuyEdViF
   SZzzDOAvYFuYP+FB9EkoOrpk79Og5vQiW6tbzqU4ofEhM3c/EtTYZkHGG
   VDu0TFNNXU7Bfa8i9LoqkJtPklGWliQwR2hoG4if58H+0pVkhFWvQ2hYB
   PH+KUkJkrixXAFeK14bkpNlNlhlIkb/xXu464Mpor33Oltu2cZIrwfTry
   UaubUDUrdHT6fFSXMx8YL+94UBM4aL1XQ5M3XvRJP6RLKRJIdV08UO9eH
   w==;
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="175502482"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 03:20:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Aug 2022 03:19:59 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 03:19:58 -0700
Message-ID: <ba44019b3c4ae9052ca6ddfa6673b7f1c71d8891.camel@microchip.com>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Michael Walle <michael@walle.cc>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Date:   Tue, 9 Aug 2022 12:19:57 +0200
In-Reply-To: <38311987be9d29959bb303be9e3121ae@walle.cc>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
         <73dc6fcedebcae098751bd093fe2d028@walle.cc>
         <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
         <595347d292ee31a9f0de031d6349f44e@walle.cc>
         <4a12868d0bffbaef9912fbc54e5998e0c50bccf6.camel@pengutronix.de>
         <38311987be9d29959bb303be9e3121ae@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Sorry, but most people have been OOO (including me), so this has delayed th=
e response.

The protection bit protects the VCore Shared Bus (SBA) blocks shown on Figu=
re 5-1.=E2=80=80VCore System
Block Diagram in the Datasheet.  So in this case also the watchdog (which i=
s the WDT block).

I hope this clarifies the usage.

Best Regards
Steen

On Thu, 2022-08-04 at 09:53 +0200, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Am 2022-07-13 14:08, schrieb Philipp Zabel:
> > Hi,
> >=20
> > On Mi, 2022-07-13 at 11:52 +0200, Michael Walle wrote:
> > > [+ Horatiu, I missed you earlier, sorry]
> > >=20
> > > Hi Steen,
> > >=20
> > > Am 2022-07-13 11:40, schrieb Steen Hegelund:
> > > > I am afraid that the exact list of affected modules is not availabl=
e,
> > > > so using the
> > > > RESET_PROT_STAT.SYS_RST_PROT_VCORE bit is the best known way of
> > > > resetting as much as possible, and
> > > > still continue execution.
> > >=20
> > > Mh, you are designing that chip (at least the LAN966x) no? Shouldn't
> > > that information be available anywhere at Microchip? ;)
> > >=20
> > > Anyway, it looks like almost the whole chip is reset
> > > except some minor things. So the driver has actually a
> > > wrong name. Until recently only the switch driver was the
> > > sole user of it (at least on the lan966x). So, my question
> > > remains, is this correct? I mean the switch driver says,
> > > "reset the switch core", but what actually happens is that
> > > the the entire SoC except the CPU and maybe the io mux is reset.
> > > What about the watchdog for example? Will that be reset, too?
> >=20
> > If [1-3] are to be trusted, RESET_PROT_STAT[VCORE_RST_PROT_WDT], which
> > protects the watchdog from soft reset, is not set by default. So yes?
> >=20
> > There are also AMBA, PCIe, PDBG protection bits against Vcore soft
> > reset in this register, depending on the platform.
> >=20
> > [1]
> > https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?se=
lect=3Dcpu,cpu_regs,reset_prot_stat
> > [2]
> > https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?se=
lect=3Dcpu,cpu_regs,reset_prot_stat
> > [3]
> > https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html?se=
lect=3Dcpu,cpu_regs,reset_prot_stat
>=20
> Ping. any news here?
>=20
> -michael

