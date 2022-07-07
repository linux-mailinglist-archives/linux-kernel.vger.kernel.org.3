Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A3569CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiGGILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiGGIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105D3B1;
        Thu,  7 Jul 2022 01:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 211DE61F51;
        Thu,  7 Jul 2022 08:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037BBC341CF;
        Thu,  7 Jul 2022 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657181369;
        bh=vpVtewxY4/wedaaT/1GGlBycY026cAD5naxa3pWaPTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQhnK1KEzTmujTim2Q65duWMHpbCJ8Q+cLzs5MTsotRv47C2S75HDOMqlA5bbdgNf
         9LldUwMLIkTu+1uPVuGuJV09KvApakAEP6ZEqgu7wJvwfF0nBkcxm/ai2J4a4MzSbt
         HJ83dnFP6ZpSzzj8RExcazmKgov7BlI8E9PaLcW8=
Date:   Thu, 7 Jul 2022 10:09:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fully convert arm to use dma-direct v3
Message-ID: <YsaUtzVsobF1WNVI@kroah.com>
References: <20220614092047.572235-1-hch@lst.de>
 <20220629062837.GA17140@lst.de>
 <Yrv0HLSj3xAHa+av@kroah.com>
 <20220707045840.GA12672@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707045840.GA12672@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 06:58:40AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 29, 2022 at 08:41:32AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 29, 2022 at 08:28:37AM +0200, Christoph Hellwig wrote:
> > > Any comments or additional testing?  It would be really great to get
> > > this off the table.
> > 
> > For the USB bits:
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> So given that we're not making any progress on getting anyone interested
> on the series, I'm tempted to just pull it into the dma-mapping tree
> this weekend so that we'll finally have all architectures using the
> common code.
> 
> Anyone who has real concerns, please scream now.

Sounds like a good plan to me, pull it in and let's see if anyone even
notices.
