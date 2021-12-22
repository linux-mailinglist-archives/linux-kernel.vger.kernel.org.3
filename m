Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA747CFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbhLVJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:58:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54932 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbhLVJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:58:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1E26197B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C5C36AE8;
        Wed, 22 Dec 2021 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640167126;
        bh=4Jbtx0sxV9eUary/KdEpdFh2LPUEDT9+q6duvRyEM3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IldX2r97TCE1WX4R71Z6NObvVMPrG5wnqtdEYIZ3ukMQAQW2gpG8U5J8ikHJVEu/D
         /tB02O/QmMhYdfGSaZylcxZicU2OqDzkozPpFT+OxK2O83UCwro3anDPCdoTH+j5sW
         jY5mjqU6YFwpZ1U0MIzvqyG4oDM63KcExIcFsHqI=
Date:   Wed, 22 Dec 2021 10:58:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: Addition of config USB_HSIC_USB3613 soon?
Message-ID: <YcL20/7ddWTsdIuQ@kroah.com>
References: <CAKXUXMym0M1UNuNGUVpFr2yUwOwjkZ_sQpCD0jC8YB+hs=j-bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMym0M1UNuNGUVpFr2yUwOwjkZ_sQpCD0jC8YB+hs=j-bA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:54:41AM +0100, Lukas Bulwahn wrote:
> Dear Vaibhav, dear Johan, dear Alex, dear Greg,
> 
> I have seen that the greybus arche driver has been under heavy
> development in 2016 and 2017 with some further clean-up in 2019.
> 
> However, so far, the config GREYBUS_ARCHE for this driver still
> depends on the out-of-tree config USB_HSIC_USB3613, with a proper
> exception made for compile testing (with COMPILE_TEST).
> 
> Will this USB_HSIC_USB3613 config and driver still be added in the
> mainline kernel in the near future, so that the config dependencies
> are consistent in mainline?

Do you have this hardware?  If so, we can add the driver, but given that
I did not think the chip ever actually shipped, it didn't make much
sense.

> Or, are the further out-of-tree additions still maintained for the
> current kernel and will stay out of tree? Is this arche driver not
> needed anymore and can be dropped?

Do you want to drop it as it is causing problems for you?  It's a good
example driver for those wanting to create a greybus host controller
driver so it's nice to have in the tree, unless you have a different one
that should be merged instead?

thanks,

greg k-h
