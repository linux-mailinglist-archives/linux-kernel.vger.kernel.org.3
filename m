Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E1532F84
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiEXRSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbiEXRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:18:31 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1456638BC6;
        Tue, 24 May 2022 10:18:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8FE1592009C; Tue, 24 May 2022 19:18:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 88D3A92009B;
        Tue, 24 May 2022 18:18:28 +0100 (BST)
Date:   Tue, 24 May 2022 18:18:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Rewrite `csum_tcpudp_nofold' in plain C
In-Reply-To: <7682977b-5929-890a-3a18-662fbfcede5c@gmail.com>
Message-ID: <alpine.DEB.2.21.2205241811180.52080@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk> <7682977b-5929-890a-3a18-662fbfcede5c@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022, Florian Fainelli wrote:

> >   I have visually inspected code produced and verified this change to boot
> > with TCP networking performing just fine, both with a 32-bit and a 64-bit
> > configuration.  Sadly with the little endianness only, because in the
> > course of this verification I have discovered the core card of my Malta
> > board bit the dust a few days ago, apparently in a permanent manner, and I
> > have no other big-endian MIPS system available here to try.
> 
> How about QEMU is not that a viable option for testing big/little endian
> configurations?

 Yeah, for this particular change, sure.  I don't have QEMU set up however 
at the moment and would have to take some time to sort it, and it won't do 
for peripherals it doesn't implement.  The failure is a fresh problem and 
I yet need to figure out what to do about it.  A bad coincidence I guess 
as I have MIPS hardware 10 years older that still goes strong.

  Maciej
