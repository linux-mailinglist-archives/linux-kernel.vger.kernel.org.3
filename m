Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDEA527175
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiENN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiENN6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:58:11 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7A452601;
        Sat, 14 May 2022 06:58:09 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 51B3192009C; Sat, 14 May 2022 15:58:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 42D9392009B;
        Sat, 14 May 2022 14:58:08 +0100 (BST)
Date:   Sat, 14 May 2022 14:58:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: Wire Oxford Semiconductor PCIe
 (Tornado) 950
In-Reply-To: <c6f4a479-6689-1ce6-60fb-c24f2635ad28@gmail.com>
Message-ID: <alpine.DEB.2.21.2205141454350.10656@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk> <alpine.DEB.2.21.2205131727070.10656@angie.orcam.me.uk> <02a1d5a9-4a95-ce58-d401-962d8ea5a0a2@gmail.com> <c6f4a479-6689-1ce6-60fb-c24f2635ad28@gmail.com>
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

On Sat, 14 May 2022, Bagas Sanjaya wrote:

> > Shouldn't this patch be squashed into [1/2]?
> > 
> 
> Oops, I mean patch [1/3].

 Possibly, but I chose to keep one self-contained change per patch as per 
the cover letter and also concluded it makes no sense to wire the document 
while it's still broken.  I'm leaving it up to the maintainers to decide 
and I will repost an updated change if required.

  Maciej
