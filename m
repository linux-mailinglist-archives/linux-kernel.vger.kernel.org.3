Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E597E47B1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhLTQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLTQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:58:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A492C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:58:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A76F61253
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B408C36AE7;
        Mon, 20 Dec 2021 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640019509;
        bh=pfF9ORXeb90crdwy1VVWelsCrqD4leceDDbigsLj944=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIMCbIZlFGaOxquS5TY+bMOZkLYmRHcg3LEoDDGLtdjn/XJztHhDxn/T3blx8TwOi
         YgH+RjZM1P3rKggbvh9WpOZhEdhm7t0pGqFNxR7eU7sH8TkdRXZrNJy1S+R8Xi7ohk
         v9A/YbbTqxpYmtoyTyOjUafoKXJ5ihceTBQF7IRc=
Date:   Mon, 20 Dec 2021 17:58:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable CONFIG_RPMSG_TTY
Message-ID: <YcC2M/QseKewXDGw@kroah.com>
References: <20211220161155.32564-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220161155.32564-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:11:55PM +0100, Arnaud Pouliquen wrote:
> The RPMsg TTY implements an inter-processor communication with a standard
> TTY interface on top of the RPMsg framework.
> This driver is a generic RPMsg client that can run on different platforms.
> 
> By enabling the RPMSG_TTY driver as module in multi_v7_defconfig, it makes
> possible to automatically probe the rpmsg_tty driver by the RPMsg bus,
> when the support of the RPMsg service is dynamically requested by the
> co-processor firmware.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> delta vs V1:
> add
> ---

"add"?  What does that mean?

Do all v7 chips have this hardware?

thanks,

greg k-h
