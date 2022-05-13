Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED03526D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379789AbiEMWrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349751AbiEMWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:47:21 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69DCD4839E;
        Fri, 13 May 2022 15:47:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C79E892009C; Sat, 14 May 2022 00:47:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C0C0492009B;
        Fri, 13 May 2022 23:47:18 +0100 (BST)
Date:   Fri, 13 May 2022 23:47:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg KH <greg@kroah.com>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tty tree
In-Reply-To: <YntKUn8AZKpLbBTp@kroah.com>
Message-ID: <alpine.DEB.2.21.2205132343080.10656@angie.orcam.me.uk>
References: <20220511075804.79c5b697@canb.auug.org.au> <alpine.DEB.2.21.2205102341030.52331@angie.orcam.me.uk> <YntKUn8AZKpLbBTp@kroah.com>
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

On Wed, 11 May 2022, Greg KH wrote:

> >  I'll see how to fix the file up and will make the necessary corrections, 
> > but how shall I post the update?  A replacement patch or an incremental 
> > change?
> 
> Incremental change as I can't rebase my tree.

 Thanks for the guidance!  Patches now posted, as a small series as the 
issue turned out more complex than one might have expected, see: 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk/>.

  Maciej
