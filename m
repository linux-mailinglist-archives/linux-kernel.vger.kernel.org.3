Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3648AF19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiAKOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:04:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39494 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbiAKOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:04:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CEA4B81A8F;
        Tue, 11 Jan 2022 14:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCDBC36AEB;
        Tue, 11 Jan 2022 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641909841;
        bh=FrQdq7kDAd3poov/GMla0fYLMlQNl/bvSE4ucXW91a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4Czh3u2R0rZ8fmSyF/Xg9q8v0Qw+GuJiorDJzflXigGbZEZgZ+kSmK8ipEOjugJj
         9xFAaBuFfwsblCFMqDfgXyQPHFxQ+0gO8VXguUvIFwkurBOADt5JmB/Gvinw4pLsjT
         ANQamPP/H4ItT3X5Lcj+vtgxI0lO+Ysu+fvWXOOE=
Date:   Tue, 11 Jan 2022 15:03:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, singhanc@nvidia.com
Subject: Re: [PATCH v2 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Message-ID: <Yd2OTRrtP1XgxmHA@kroah.com>
References: <20220111133643.589346-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111133643.589346-1-waynec@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 09:36:43PM +0800, Wayne Chang wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> after driver sending the UCSI_START cmd, CCGx would
> clear Bit 0:Device Interrupt in the INTR_REG if CCGX
> reset successfully.
> 
> however, there might be a chance that other bits in
> INTR_REG are not cleared due to internal data queued
> in PPM and cause the driver thinks CCGx reset failed.
> 
> the commit checks bit 0 in INTR_REG and ignore other
> bits. ucsi driver would reset PPM later.
> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
