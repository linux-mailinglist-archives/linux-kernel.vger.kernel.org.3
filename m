Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BE472E67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhLMOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhLMOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E8CC061574;
        Mon, 13 Dec 2021 06:01:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BF67B80EFA;
        Mon, 13 Dec 2021 14:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BC5C34602;
        Mon, 13 Dec 2021 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639404096;
        bh=BgybE5B6gOYKFZiJQhdNJnLs6C3rGroxuqy0tEJHivo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=terxZXDuaZnaS1+FxWAwB0vFkleccI6YMa2NQEYO+qztjPoL4Vi2tZ2YRFGTMISbB
         Q2SSG+ER5CLT1aLtt/1plvju4ZZ2jQ8YzAKNMelVSavJDlL7Lf+QPUiqihm6+2xnGj
         JfkMQkkpkvEBFx/e1ae7U3itaz4PC/zVlvcPljiU=
Date:   Mon, 13 Dec 2021 15:01:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, benh@kernel.crashing.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Message-ID: <YbdSPWX2pnp5pT9G@kroah.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <20211208100545.1441397-3-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208100545.1441397-3-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 06:05:43PM +0800, Neal Liu wrote:
> Signaling remote wakeup if an emulated USB device has any activity
> if the device is allowed by host.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 +++++
>  1 file changed, 5 insertions(+)

What commit does this fix?

Does it need to go to stable kernels?

Should it be independent of this patch series that adds new features?

thanks,

greg k-h
