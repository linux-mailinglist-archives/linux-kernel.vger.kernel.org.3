Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F3497A94
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiAXIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:46:49 -0500
Received: from mout01.posteo.de ([185.67.36.141]:50567 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbiAXIqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:46:48 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A5831240028
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:46:46 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Jj3W85sYcz6tmB;
        Mon, 24 Jan 2022 09:46:44 +0100 (CET)
Message-ID: <f01d8a90-973f-9492-a89a-a6a82435b731@posteo.net>
Date:   Mon, 24 Jan 2022 08:46:44 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 02/11] serial: atmel_serial: include circ_buf.h
Content-Language: fr-FR
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20220124071430.14907-1-jslaby@suse.cz>
 <20220124071430.14907-3-jslaby@suse.cz>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220124071430.14907-3-jslaby@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/01/2022 à 08:14, Jiri Slaby a écrit :
> atmel_uart_port::rx_ring is defined as struct circ_buf, but circ_buf.h
> is not included explicitly in atmel_serial.c. It is included only
> implicitly via serial_core.h. Fix this as serial_core.h might not
> include that header in the future.
> 
> Signed-off-by:Jiri Slaby <jslaby@suse.cz>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c370eddc651b..2d09a89974a2 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -8,6 +8,7 @@
>    *
>    *  DMA support added by Chip Coldwell.
>    */
> +#include <linux/circ_buf.h>
>   #include <linux/tty.h>
>   #include <linux/ioport.h>
>   #include <linux/slab.h>
Thanks !
