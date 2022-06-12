Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEE547B2A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiFLRXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiFLRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 13:23:08 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9449B5E;
        Sun, 12 Jun 2022 10:23:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 117812016F;
        Sun, 12 Jun 2022 19:23:06 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I42IE8SSqenD; Sun, 12 Jun 2022 19:23:06 +0200 (CEST)
Received: from begin (anantes-655-1-33-15.w83-195.abo.wanadoo.fr [83.195.225.15])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 8A77220168;
        Sun, 12 Jun 2022 19:23:05 +0200 (CEST)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1o0RIn-000w9y-QO;
        Sun, 12 Jun 2022 19:23:05 +0200
Date:   Sun, 12 Jun 2022 19:23:05 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <20220612172305.ly6uxi4274wxftex@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220520194637.03824f7f@canb.auug.org.au>
 <YofnHcOa5AkhXnbX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofnHcOa5AkhXnbX@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le ven. 20 mai 2022 21:08:13 +0200, a ecrit:
> On Fri, May 20, 2022 at 07:46:37PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the soundwire tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > make[4]: *** Deleting file 'drivers/accessibility/speakup/mapdata.h'
> > can't open ./include/linux/input.h
> > make[4]: *** [/home/sfr/next/next/drivers/accessibility/speakup/Makefile:46: drivers/accessibility/speakup/mapdata.h] Error 1
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.build:542: drivers/accessibility/speakup] Error 2
> > 
> > Caused by commit
> > 
> >   6646b95aab5f ("speakup: Generate speakupmap.h automatically")
> > 
> > I have used the char-misc tree from next-20220519 for today.
> 
> Ugh, odd, this worked for me.

Ah, that's about out-of-tree builds.

> I'll go revert this.  Samuel, can you rework this again?

Yes, I have submitted a fixed patch.

Samuel
