Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964547662A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhLOWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLOWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:48:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB05C061574;
        Wed, 15 Dec 2021 14:48:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA56BB8221E;
        Wed, 15 Dec 2021 22:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C265C36AE2;
        Wed, 15 Dec 2021 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639608478;
        bh=GgPsE6TbS7V5v4Amc3+um4dg/OZkdFC4aT5pVXd/aQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QM+DAYgneA0mf2OUOgEUscPaxesLtKahh8GWAa8xcxmLS/VxeusunC3EI4SJ3HMAU
         q7IfqHJtvilFgOI7Vhe0VrDvgMpd2QXuglqh8s+6b7Czp+UDZHLzmBBK4hlE9mbBuG
         eXNhmN6Gn97eqtJb9/b4Od3uIGdm8+w0w1pj540k=
Date:   Wed, 15 Dec 2021 23:47:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     balbi@kernel.org, maze@google.com, deng.changcheng@zte.com.cn,
        lorenzo@google.com, kuba@kernel.org, manish.narani@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] usb: gadget: remove duplicate include
Message-ID: <YbpwnHJWpwurP0pl@kroah.com>
References: <20211215014754.441065-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215014754.441065-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 01:47:54AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> ./drivers/usb/gadget/function/u_ether.c: linux/etherdevice.h is included
> more than once.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/usb/gadget/function/u_ether.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 6f5d45ef2e39..3b674f99320b 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -17,7 +17,6 @@
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
>  #include <linux/if_vlan.h>
> -#include <linux/etherdevice.h>
>  
>  #include "u_ether.h"
>  
> -- 
> 2.25.1
> 

This does not apply to my tree at all.  What did you make it against?
