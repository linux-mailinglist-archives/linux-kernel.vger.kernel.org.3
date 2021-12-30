Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF216481C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhL3M2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:28:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44020 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbhL3M2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:28:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714DF616C0;
        Thu, 30 Dec 2021 12:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BE6C36AEA;
        Thu, 30 Dec 2021 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640867283;
        bh=q08v2xMnzhH1M5Hlg4JEoffzO4GwcuQDHUieT0yNTrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9FzBOz8i87TrcUN8k5pMrfSe+nrNoS/4KYb1LB5lrRNyLXdRgGbIy5wZAn+NelGg
         WtUD0TviyU0Dl6Q73l1vWePMlkgYpodI5kJXPrXTSFXD4cHMqU77mAjqV4maC5eM6a
         gb3Asc84rE/f3Q4VHxj1W3dnGDKJOHI5zf0U7Vgs=
Date:   Thu, 30 Dec 2021 13:28:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 3/6] dt-bindings: serial: meson: Support S4 SoC uart.
 Also Drop compatible = amlogic,meson-gx-uart.
Message-ID: <Yc2l0Rp3lrfYr6PP@kroah.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-4-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230102110.3861-4-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:21:07PM +0800, Yu Tu wrote:
> Deprecated, don't use anymore because compatible = amlogic,meson-gx-uart
> don't differentiate between GXBB and GXL which have different
> revisions of the UART IP. So it's split into GXBB and GXL.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Again, your subject line is way too long.

thanks,

greg k-h
