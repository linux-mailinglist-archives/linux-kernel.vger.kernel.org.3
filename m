Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A751F47F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiEIGar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiEIGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:20:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A819140C50;
        Sun,  8 May 2022 23:17:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69D2268AFE; Mon,  9 May 2022 08:16:57 +0200 (CEST)
Date:   Mon, 9 May 2022 08:16:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: fully convert arm to use dma-direct
Message-ID: <20220509061657.GB17190@lst.de>
References: <20220421074204.1284072-1-hch@lst.de> <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com> <87pmkq7tmx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmkq7tmx.wl-maz@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 01:06:14PM +0100, Marc Zyngier wrote:
> > I think Marc Z has a Netwinder that he can test this on. Marc?
> > I have one too, just not much in my office because of parental leave.
> 
> Finally found some time to hook the machine up and throw a new kernel
> at it. Booted at its usual glacial speed, so FWIW:
> 
> Tested-by: Marc Zyngier <maz@kernel.org>

Thanks.  I've not heard anything from Russell and we're pretty late
in the merge window, so I'm tempted to wait until the next merge
window.  I'd like to pull in ASAP for that though as I have other
changes that are just waiting for it.
