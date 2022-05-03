Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC8518D6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiECTuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiECTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:50:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35AC37A19;
        Tue,  3 May 2022 12:46:46 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E422292009C; Tue,  3 May 2022 21:46:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E0FA592009B;
        Tue,  3 May 2022 20:46:45 +0100 (BST)
Date:   Tue, 3 May 2022 20:46:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Rob Landley <rob@landley.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
In-Reply-To: <CAMuHMdUZ-fTKPk1kXodjg1yi5vm3RZJ=wO9o5afA81yNvt0KYA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2205032045220.14935@angie.orcam.me.uk>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru> <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de> <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net> <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
 <2a3f8b4c-2c0d-28bc-8dcd-c56c7b8a2bb4@landley.net> <CAMuHMdUZ-fTKPk1kXodjg1yi5vm3RZJ=wO9o5afA81yNvt0KYA@mail.gmail.com>
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

On Tue, 3 May 2022, Geert Uytterhoeven wrote:

> > Sounds like it's now outside of the IRQ range allocation, but I can't find where
> > that's requested when registering the controller? (What is a "swizzle" anyway?)
> 
> PCI slots have 4 interrupts (#A, #B, #C, #D). In machines with
> multiple slots, the interrupts lines are "swizzled", to avoid that all cards
> using a single interrupt are mapped to the same host interrupt.

 Especially as single-function devices are required to use INTA.

  Maciej
