Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DEB559F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiFXRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiFXRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:18:15 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C69CF1E3E1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:18:12 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8E11392009C; Fri, 24 Jun 2022 19:18:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 86F1F92009B;
        Fri, 24 Jun 2022 18:18:11 +0100 (BST)
Date:   Fri, 24 Jun 2022 18:18:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PING^2][PATCH] RISC-V: PCI: Avoid handing out address 0 to
 devices
In-Reply-To: <mhng-a0733eea-8220-4bf6-b1da-9de3139dbae3@palmer-ri-x1c9>
Message-ID: <alpine.DEB.2.21.2206231750490.57474@angie.orcam.me.uk>
References: <mhng-a0733eea-8220-4bf6-b1da-9de3139dbae3@palmer-ri-x1c9>
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

On Wed, 22 Jun 2022, Palmer Dabbelt wrote:

> > > Therefore avoid handing out address 0, by bumping the lowest address
> > > available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM up by 4 and 16
> > > respectively, which is the minimum allocation size for I/O and memory
> > > BARs.
> > 
> >  Ping for:
> > <https://lore.kernel.org/lkml/alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk/>
> 
> Sorry, I got this mixed up with the non-RISC-V patch.

 If you mean this:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>

then we just don't have consensus to move forward.  If we ever do for a 
generic change, then we can revert the RISC-V platform solution, as it's 
merely an internal implementation detail and not a part of the ABI or 
something.

>  David poked me about
> it, this is on for-next.  It's passing my tests, but they're just QEMU so
> probably not all that exciting here.

 Thanks!  I don't know offhand what QEMU supports as far as the RISC-V 
architecture is concerned; I guess you can't just enable a PCI port-I/O 
serial port in the simulator and see if it works with Linux or not.

 Anyway it's just number shuffling, so the change should be reasonably 
safe.

  Maciej
