Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1A476606
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhLOWif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhLOWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:38:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F639C061574;
        Wed, 15 Dec 2021 14:38:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0914FB82025;
        Wed, 15 Dec 2021 22:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E58C36AE4;
        Wed, 15 Dec 2021 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639607911;
        bh=s++UjRbQmYwVbz9yvTJZtffpCxib298ldlhliLuLGsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frSwk1imcYinI8ck+zslQAjbJVbaIQjDujoeQ7sxCDHpRfyUX/tUhhljMdKuO/Tam
         vlhYg3SRkXJ9lOsvKfyREeFf0hKbVsTbR7zx4zF+MbJ1Htuu3FpTAbMEVLiXLQEk8l
         MvqY3uBR3/fc/bCEjrBbAGA1peE4z0k/deW0UYEo=
Date:   Wed, 15 Dec 2021 23:38:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Extend support for runtime power management
 for AMD's Yellow carp.
Message-ID: <YbpuZV5qcF04PHt8@kroah.com>
References: <20211215093216.1839065-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215093216.1839065-1-Nehal-Bakulchandra.shah@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:02:16PM +0530, Nehal Bakulchandra Shah wrote:
> AMD's Yellow Carp platform has few more XHCI controllers, 
> enable the runtime power management support for the same.
> 
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> ---
>  drivers/usb/host/xhci-pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Mathias, I can take this now, no need to add it to your queue.

thanks,

greg k-h
