Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1301550AADB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442160AbiDUVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442141AbiDUVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:41:03 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D3414BFE0;
        Thu, 21 Apr 2022 14:38:12 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1C5F992009C; Thu, 21 Apr 2022 23:38:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1626E92009B;
        Thu, 21 Apr 2022 22:38:11 +0100 (BST)
Date:   Thu, 21 Apr 2022 22:38:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 1/2] serial: 8250: Fold EndRun device support
 into OxSemi Tornado code
In-Reply-To: <YmAdTDkZzdiQNKab@kroah.com>
Message-ID: <alpine.DEB.2.21.2204212234350.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk> <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk> <Ylk3HNZqnBLMMQCm@kroah.com> <alpine.DEB.2.21.2204172339300.9383@angie.orcam.me.uk> <YmAdTDkZzdiQNKab@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022, Greg Kroah-Hartman wrote:

> > > As per the top of this file, this should not be needed here as you are
> > > only using it in one file.  Please leave it as-is.
> > 
> >  I find this requirement silly, but here it's not the place to discuss it, 
> 
> You have not had to deal with merge issues in this file before.  Think
> about every single PCI driver author updating this single file.  That
> just does not work at the scale we run at, sorry.  I put this rule into
> place 15+ years ago for that reason.

 Fair enough, I missed this practical aspect.  Thanks for straightening me 
out.

  Maciej
