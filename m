Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA147BB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhLUHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:32:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48962 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhLUHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:32:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C5F861466;
        Tue, 21 Dec 2021 07:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F25C36AE7;
        Tue, 21 Dec 2021 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640071924;
        bh=siOKuI9TLZ2SagEvBuHZINAGCpcztazaYp56jX0A6YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cszWef5TdMj2NWbcOPxb6AA7YxTfIKDZ0f5HXy7SiH4dSnXIGJqCEwdyeqbvQlok0
         vS8ekrt/teFFkefOYbeaUS97CNQ1cjUOJ5qcM6r996zEwcEVK0ynO+Kznx6kNv+iT3
         /5aQNDXpZ46ltorzMW2Wteh84rHV+2l2n3bbnROY=
Date:   Tue, 21 Dec 2021 08:32:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 2/3] tty: serial: meson: meson_uart_shutdown omit clear
 AML_UART_TX_EN bit
Message-ID: <YcGC8hlOEbzH8rc8@kroah.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-3-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221071634.25980-3-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:16:33PM +0800, Yu Tu wrote:
> The meson_uart_shutdown function should have the opposite operation to
> the meson_uart_startup function, so the shutdown of AML_UART_TX_EN is
> logically missing.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

What commit does this fix?  Should it go to stable kernels?  Please put
that in here if needed.

thanks,

greg k-h
