Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041FC4B671B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiBOJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:12:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiBOJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:11:56 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F22E1A398;
        Tue, 15 Feb 2022 01:11:46 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 358E092009C; Tue, 15 Feb 2022 10:11:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2E7E692009B;
        Tue, 15 Feb 2022 09:11:45 +0000 (GMT)
Date:   Tue, 15 Feb 2022 09:11:45 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <YgtQkjRe7fbXI/lS@infradead.org>
Message-ID: <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk> <YgtQkjRe7fbXI/lS@infradead.org>
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

On Mon, 14 Feb 2022, Christoph Hellwig wrote:

> > ===================================================================
> > --- linux-macro.orig/arch/arm64/include/asm/Kbuild
> > +++ linux-macro/arch/arm64/include/asm/Kbuild
> > @@ -3,6 +3,7 @@ generic-y += early_ioremap.h
> >  generic-y += mcs_spinlock.h
> >  generic-y += qrwlock.h
> >  generic-y += qspinlock.h
> > +generic-y += parport.h
> 
> Instead of adding generic-y just ad a mandatory-y in
> include/asm-generic/Kbuild.

 I'm inconvinced.  Not all archs want it, 5 don't.

  Maciej
