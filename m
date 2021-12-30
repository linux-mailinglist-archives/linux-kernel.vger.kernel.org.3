Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AFD481C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhL3NUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhL3NUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:20:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4940C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613EC616CB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC4C36AE9;
        Thu, 30 Dec 2021 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640870420;
        bh=SbI2di2MmV67kh3BRNtE7ODhZEBFFYkmQQdOEC4qXCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQNoJxwBXB0rFpgg4Zm9qK/ohuawWuBwWASAa3I1FIezQUgumKf2UybpZFqlwCqZh
         fjlP5kv6BcFVCEARwZcoX4NK/+ztrr3xmwiGU7jfZTPMO8a7vqN0OgCBbm/ZwMlY3U
         mUz1oDusJfT4xGx1iFhKGmudYEtLvlRc5WVrP+40=
Date:   Thu, 30 Dec 2021 14:20:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] staging: vc04_services: avoid the use of typedef
 for function pointers
Message-ID: <Yc2yDsMg2D6GZe+T@kroah.com>
References: <cover.1640776340.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1640776340.git.gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 08:31:23AM -0300, Gaston Gonzalez wrote:
> This patch set removes some typedefs for function pointers in vc04_services.
> 
> v1 -> v2:
> 
> - Following Greg suggestion, functions pointers were not renamed making patches
>   1 and 2 much smaller.
> - Function pointers in vchiq-mmal were not touched as the result is less
>   readable than the original.
> - In the description of changes in the TODO file, it was specified that there
>   are no current 'struct typedefs' left inside vc04_servivces. 
> - The name of the particular subsystem of vc04_services was included in the
>   title of each commit.

Much nicer, thanks for redoing this.  Now queued up.

greg k-h
