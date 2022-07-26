Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B1581825
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiGZRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGZRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:11:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3F13E1D;
        Tue, 26 Jul 2022 10:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACE9DB81893;
        Tue, 26 Jul 2022 17:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78AFC433D6;
        Tue, 26 Jul 2022 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658855502;
        bh=oB/9YXDllqHNaPx+0+OoJRyg6nWhXunKlacQATTrCVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2G3pA4DjMcfYujd4B3AX7B602Rdd3zhyaC9iQ7GgaXEr5kW+nJhEvGMVyt6hZaNhZ
         +7D8OoWYNOSDLjZyv3aa2UyaqrhLFcPatxkXXvxKtYO9vxb9YLjXJnH//UoYakXv8L
         6bjHVWagMvR8rRx11oaI1d6QhGzYWu6f7+95xkyk=
Date:   Tue, 26 Jul 2022 19:11:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     balbi@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, cristian.birsan@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: at91_udc: stop using legacy pm ops
Message-ID: <YuAgSxsJufJoIfCP@kroah.com>
References: <20220726095948.1809038-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726095948.1809038-1-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:59:47PM +0300, Claudiu Beznea wrote:
> Stop using legacy PM ops and switch using dev_pm_ops.

That says what you did, but not why you are doing this.

Please read the kernel documentation for how to write a good kernel
changelog and resubmit.

thanks,

greg k-h
