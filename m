Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65C47BB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhLUHbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:31:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55824 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbhLUHbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:31:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89FC0B8106C;
        Tue, 21 Dec 2021 07:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF9DC36AE7;
        Tue, 21 Dec 2021 07:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640071862;
        bh=CNeQD1UgCcyk9OiMA9cYBMpngp02cKvoagD3hTeIwiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Azhs+JHNZ37JDosMNQkxDfvhzLkRxssGF6G494z3+bQk3e3ZkFFUbq3vex4IT/Rac
         O4Yn0Hda1++RQksqcMyuEAZMOr67wYFboaz0ucD3Q4XvCGlph1FvJAxWEnhZGLtYjk
         VdNLOOUhlgf1I3WCMbR5ieQOVdpOfdn7ZNn4jZeM=
Date:   Tue, 21 Dec 2021 08:30:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/3] the UART driver compatible with the Amlogic Meson S4
 SoC
Message-ID: <YcGCs1LYqXNnQwsF@kroah.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221071634.25980-1-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:16:31PM +0800, Yu Tu wrote:
> The UART driver compatible with the Amlogic Meson S4 SoC on-chip, change the
> UART interrupt interface function while adding IRQF_SHARED flag. And add clear
> AML_UART_TX_EN bit in meson_uart_shutdown funtion.
> 
> Yu Tu (3):
>   tty: serial: meson: modify request_irq and free_irq
>   tty: serial: meson: meson_uart_shutdown omit clear AML_UART_TX_EN bit
>   tty: serial: meson: add UART driver compatible with S4 SoC on-chip
> 
> Link:https://patchwork.kernel.org/project/linux-amlogic/patch/20211206100200.31914-1-xianwei.zhao@amlogic.com/

What is this link for?

And why patchwork?

Please just use lore.kernel.org links for mailing list threads.

thanks,

greg k-h
