Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B464E2231
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbiCUIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbiCUIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:30:36 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A80B1C13E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:29:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D6865C01CC;
        Mon, 21 Mar 2022 04:29:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Mar 2022 04:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mJOoRUMYX3YmX13po
        9qoHQ56zhl3uYpuOoJWbXxYEFY=; b=MekULqoFVnQl1+cCRF8WdVEiPR4UQiA1v
        iwe8N8NXBsUHo/NGxe6+PrtWL9xPyZ9aelp3k3FZSWmL0VFQeDf2CIB9R8XLYmcK
        LAVakqRxrBTYXuuCFwpr/zGJ3RVq6zWhqwDJXpsEKjrdcJPn6mbBbHUcb/UiwVCZ
        TZv+6LRrDsuuhwC0sSPhyzboVBAR0z640It0iZuLlK50KWXblBxDaKUNLbOIgmVZ
        yqfgNg2zpEtW6seIq4i4CWknX/4daBGPFmLLGDCfmaTMhCnDTxqJ47UzJi9JBEsx
        Sz+Mq9AXxdzFfbkRifU2xs0SUe1njJNOGKQuJXJJN8b/E3DJ4OpGw==
X-ME-Sender: <xms:Ujc4Ys58J6p33yC3OE4CC8fIbr3phjWBN6TVNgfAeI5NeLhVPJ6jog>
    <xme:Ujc4Yt5Tz-bxaG5sSBmBIxduzMI1Xmg3wNLj35xlzw3bPwLTQnf6vlO4nx_Mcvhia
    5F_nruF7y_D1ASfyKg>
X-ME-Received: <xmr:Ujc4YreBqFeQ6y8vzQjVRMYl-Gc2K7kA6uNYf-ZWEV6Oi5sX-zwgd9CU6RZjozZ4N7Slugep2z8HbvrYlF1RFPsZZ8Sk0BW0y1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffh
    gfehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:Ujc4YhIR4UJ85EMUEC8wyjlG4oCseuRfJMWZAni0cppdgXdNc6n9xw>
    <xmx:Ujc4YgI1BkS9zlHsEGdY4mpsWCBjsWj8ouUQnlCSbsxHHJLloK05LA>
    <xmx:Ujc4Yiz6AqWNYh51xGjJ6yYhSbCNngQcBG5Y6JarjE7UiQ46W2LUow>
    <xmx:Uzc4Yk35x4Apxk0Gh7N1bj5Qe5iy07pVLl1LyWD7KpfUlY1NFaJ-9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 04:29:05 -0400 (EDT)
Date:   Mon, 21 Mar 2022 19:29:11 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT
 is disabled
In-Reply-To: <5291a177-9a67-b23a-515f-7faa3cc887e8@csgroup.eu>
Message-ID: <e8398356-8ba3-e9de-8da0-3591907340b5@linux-m68k.org>
References: <d987663bbed18d7dbf106db6066a759040b4e57a.1647837028.git.fthain@linux-m68k.org> <5291a177-9a67-b23a-515f-7faa3cc887e8@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-1060938498-1647851351=:12278"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1060938498-1647851351=:12278
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Mar 2022, Christophe Leroy wrote:

>=20
>=20
> Le 21/03/2022 =C3=A0 05:30, Finn Thain a =C3=A9crit=C2=A0:
> > drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
> > via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
> > via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
> > via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
> > via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
> > drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
> > via-pmu-event.c:(.init.text+0x20): undefined reference to `input_alloca=
te_device'
> > via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_regist=
er_device'
> > via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_d=
evice'
> > make[1]: *** [Makefile:1155: vmlinux] Error 1
> > make: *** [Makefile:350: __build_one_by_one] Error 2
> >=20
> > Don't call into the input subsystem unless CONFIG_INPUT is built-in.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> > This is equivalent to the patch I sent a couple of days ago. This one
> > is slightly longer and adds a new symbol so that Kconfig logic can been
> > used instead of Makefile logic in case reviewers prefer that.
> > ---
> >   drivers/macintosh/Kconfig   | 5 +++++
> >   drivers/macintosh/Makefile  | 3 ++-
> >   drivers/macintosh/via-pmu.c | 2 ++
> >   3 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> > index 5cdc361da37c..b9102f051bbb 100644
> > --- a/drivers/macintosh/Kconfig
> > +++ b/drivers/macintosh/Kconfig
> > @@ -67,6 +67,11 @@ config ADB_PMU
> >   =09  this device; you should do so if your machine is one of those
> >   =09  mentioned above.
> >  =20
> > +config ADB_PMU_EVENT
> > +=09bool
> > +=09depends on ADB_PMU && INPUT=3Dy
> > +=09default y
>=20
> Could be reduced to
>=20
> config ADB_PMU_EVENT
> =09def_bool y if ADB_PMU && INPUT=3Dy
>=20

That's great but my question remains unanswered: why the aversion to=20
conditionals in Makefiles, when that would be simpler (no new symbol)?
---1463811774-1060938498-1647851351=:12278--
