Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB949C944
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiAZMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiAZMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:06:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31740C06161C;
        Wed, 26 Jan 2022 04:06:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C77AE619AC;
        Wed, 26 Jan 2022 12:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE72C340E8;
        Wed, 26 Jan 2022 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643198771;
        bh=wBuUv2urNmkd6B7YiVdXQn3atD/cdJFkM+tiso+uQ4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3FrCtAYS5xIhjHWzlg3RBJ7tWHuB9zz3QQI0i2vIkIlT+j1/dZkgkT/UhaRWjChG
         nYCT0cTZh/16lpfuxFbjMRiikUStCKIPtk7XZHn4Dk6BZntyOoqyAIGcbac9zbOURR
         uoeNVWkNKSbgGFXVe8hFlyvb5j2d1Je38zAExUi8=
Date:   Wed, 26 Jan 2022 13:06:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset
 provider
Message-ID: <YfE5MOkQRoHQV7Wf@kroah.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> Hi all,
> 
> This patch series add minimal change to provide mt7621 resets properly
> defining them in the 'mediatek,mt7621-sysc' node which is the system
> controller of the SoC and is already providing clocks to the rest of
> the world.
> 
> There is shared architecture code for all ralink platforms in 'reset.c'
> file located in 'arch/mips/ralink' but the correct thing to do to align
> hardware with software seems to define and add related reset code to the
> already mainlined clock driver.
> 
> After this changes, we can get rid of the useless reset controller node
> in the device tree and use system controller node instead where the property
> '#reset-cells' has been added. Binding documentation for this nodeq has
> been updated with the new property accordly.
> 
> This series also provide a bindings include header where all related
> reset bits for the MT7621 SoC are defined.
> 
> Also, please take a look to this review [0] to understand better motivation
> for this series.
> 
> Regarding the way of merging this:
>  - I'd like patches 1 and 4 which are related going through staging tree.

Patches 1 and 4 now in the staging tree, thanks.

greg k-h
