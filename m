Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF94CBB13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiCCKOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiCCKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:14:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902A11768C0;
        Thu,  3 Mar 2022 02:13:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 428C0B8228E;
        Thu,  3 Mar 2022 10:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3EFC340EF;
        Thu,  3 Mar 2022 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646302431;
        bh=CJxhrnC/0v+orCoyqK9g//SkJ3vQ/iZ/7d/x+OeTdoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it07Iur1ptUBK6/jfLQiteERWzp4SLULJGfinqkR2F5dQGdfbSeLFOq1O8h/2PJDd
         CeL5chQ51/nBJQvuiaiGBzo39v6A0/KKQA/KPDExwEaoczYXMU++IYQnRigOuD8moZ
         jq1malKjCnphxcHvx/rSejLxSpQ533ADe5Dxx7RQjiMTSpVWwKfv2dlGtDRZq1Xsfa
         k/ikNf0kUpGwNXv3UeeS40ouTgUTCkKefffTobE/7QMyAjIgLUuIW9AAEwBqxdK1Pc
         E42f5UKd40Po6CPkzGUF6sLbQbFWRn4olIQ9g+wANS6nSXKEBsNpbZGL7tmjgL2NZR
         9/KSG9btgb25Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPiSy-0002uL-14; Thu, 03 Mar 2022 11:13:48 +0100
Date:   Thu, 3 Mar 2022 11:13:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YiCU3KI9Dh2psRnK@hovoldconsulting.com>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
 <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
 <YiCHPuNkMuO4uARu@hovoldconsulting.com>
 <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
 <YiCN+x2XPiawaweY@hovoldconsulting.com>
 <CACPK8Xc9MnM9_jr7NrNLtqBrN_t8D7G-scQvk51vbpOU6LWeuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xc9MnM9_jr7NrNLtqBrN_t8D7G-scQvk51vbpOU6LWeuw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:46:05AM +0000, Joel Stanley wrote:
> On Thu, 3 Mar 2022 at 09:44, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Mar 03, 2022 at 09:24:51AM +0000, Joel Stanley wrote:
> > > On Thu, 3 Mar 2022 at 09:15, Johan Hovold <johan@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 03, 2022 at 08:52:29AM +0000, Joel Stanley wrote:
> > > > > On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> > > > > > > IBM manufactures a PL2303 device for UPS communications. Add the vendor
> > > > > > > and product IDs so that the PL2303 driver binds to the device.
> > > > > > >
> > > > > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > > > > ---
> > > > > > > Changes since v1:
> > > > > > >  - Fix commit message Signed-off-by ordering.
> > > > > >
> > > > > > Almost there. You're still missing a Co-developed-by tag, a From line,
> > > > > > or both.
> > > > >
> > > > > It's neither. This patch was applied to a tree by myself, and I asked
> > > > > Eddie to send it to mainline for merging.
> > > >
> > > > Then you are missing a From line. As the patch looks like know, Eddie is
> > > > considered the author and not you.
> > >
> > > You are incorrect. Eddie is the author.
> >
> > Then what is your SoB doing there in the first place? If Eddie is the
> > sole author as well as the submitter, and you didn't touch the patch in
> > between, then your SoB does not belong in the chain.
> >
> > If you applied Eddie's patch to your shared tree and Eddie generated a
> > patch from there, then the chain should be:
> >
> >         SoB: E
> >         SoB: J
> >         SoB: E
> >
> > but this is starting to look a bit ridiculous.
> 
> I agree. I would appreciate it if you applied the patch, with or
> without my sob in whatever order you deem fit.

Ok, I'll assume what you intended was E-J-E but that perhaps
git-format-patch swallowed the last SoB. Thanks for clarifying.

I was going to apply to the patch, but I see now that you didn't provide
any details about the product apart from it being a UPS and that's not
reflected in the define name.

Do you have a pointer to device (family) in question?

Johan
