Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEBC4CD075
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiCDItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiCDIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:49:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E5D2242;
        Fri,  4 Mar 2022 00:48:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C3F360B88;
        Fri,  4 Mar 2022 08:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB9CC340E9;
        Fri,  4 Mar 2022 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646383725;
        bh=mIe4ebVK/3MbGuk9kq/lop7PUdnW6RsBQlBvdB3IX0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7SvQQ1dChGu3LFkn6/J0nF+PFLf6gY3ndfrrIqC4inRI8gxP0WMS7VXpGutRiS9T
         H2Obh1fcGlLDQR+JJfRK04ZhKcQux0TT6Ruuj2XNdeBxpIrqFdnCZlf5hxDZcnq0IB
         yLi97DunPY05L6gr1CEnIkG450EpMgxDKlBI5aS4/juDgKB2R1WikP3D64IWmk+Buo
         ePF8ZvX7S+cWfIqz884XstNx77JEqnQEJtCvHDKb56LM53zgZz4rX4d2QLAn3kNp0B
         jh8M50ZeYV23tt7xhVuEtxpPfTNXSDKrotfQAlVZRfbc3HSnmzedb5txnmRidBstPl
         EgIsTqXXFeLqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nQ3cB-0000yP-99; Fri, 04 Mar 2022 09:48:44 +0100
Date:   Fri, 4 Mar 2022 09:48:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Joel Stanley <joel@jms.id.au>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YiHSa6bCmDTdS3dU@hovoldconsulting.com>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
 <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
 <YiCHPuNkMuO4uARu@hovoldconsulting.com>
 <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
 <YiCN+x2XPiawaweY@hovoldconsulting.com>
 <CACPK8Xc9MnM9_jr7NrNLtqBrN_t8D7G-scQvk51vbpOU6LWeuw@mail.gmail.com>
 <YiCU3KI9Dh2psRnK@hovoldconsulting.com>
 <b1ec9ab3-d621-fa66-0fae-f966242f3f7f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ec9ab3-d621-fa66-0fae-f966242f3f7f@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:48:37PM -0600, Eddie James wrote:
> On 3/3/22 04:13, Johan Hovold wrote:

> > I was going to apply to the patch, but I see now that you didn't provide
> > any details about the product apart from it being a UPS and that's not
> > reflected in the define name.
> >
> > Do you have a pointer to device (family) in question?

> It's a pretty generic pl2303 device and doesn't have to be used for UPS, 
> but that is our use-case. Here is a page with some detail about the 
> device: 
> https://www.ibm.com/docs/en/power9/9009-22A?topic=power-uninterruptible-supply

Ah, ok, I thought it may have been built into the UPS.

I've applied the patch now, thanks!

Johan
