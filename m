Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7664CA303
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiCBLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiCBLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:14:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CAC606ED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:14:07 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E4DF3F5F3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646219646;
        bh=c/HrBEq7VXD/vzB2plWQqXVKzKIhpuLhlwaapBvCoq4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZZvYRDF/TkkrYLNl3TiNcu+DN92urcmu0P7BgYyvNvSRA/KAQuj0+hbSgwOakKROo
         O1F0AbDAy6rsHiBpJL2UPgxo2ILfehkBEzPZFZSlhSdKGbc72dV1+/gCl5frakWkpY
         uyZDAt86+K4VaKSZHLty4FtVShq5tmihkIWPsr0s4vKYbYtj/XgSdf8fU0VBFn7f6l
         4cP9lD4XKZPWakf1WJMr2ldMA1DtZ3QTaNbz5Ek3EtHBCkgacI1eYg8nK8i7RwORoB
         v5QnDLow7gVyZNbZSSGOetk6GdIpxLCrVnCiQZ4lq7EQJy2QIDmLgTawkmzznz1p6a
         RiCrgHLE4Rr/Q==
Received: by mail-ed1-f69.google.com with SMTP id f9-20020a0564021e8900b00412d0a6ef0dso806036edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c/HrBEq7VXD/vzB2plWQqXVKzKIhpuLhlwaapBvCoq4=;
        b=AjvZfLTzlucnzDZkS7tEPx+XllnuBEv8zaamY67w7dtKLX3tCKnszdKkdzC1fAoUiI
         sPaLzQ61nX451pX+l/x50yF6DdTunhpcZoHR8Hb9j5bJhXsy5YLvTBfQ7B+XGlY7TOO9
         4J/Ox++ZFF4fK5BMqQ0/Y1fF7p6J1ly6+t9IMJxvEGvZgqpfKaYy29e/5XbpCc4S2za8
         u9L6fl6zIM1l8Q1xJzATViXCGOZQOP3YoBCWFytawjejES/MWAneK6W3e2f0d+FQdqmr
         nevs0fMBAI/EfPrxbjyCvlLshw8sR31ECiMYW8NVaNeHlwFCRETkHSJY8GdQ0qOfSGZ5
         VrlA==
X-Gm-Message-State: AOAM533JLmcPpjDFGTD/1ki6LEZ4pb8KIFJjw4XghZxW+EBOqs7bHU30
        U4CqruC+BPGS8LpU83ZqydGrG4ZN9kELa4J9poHoEQQ5W0AR97tSI53Fve6VN8b1nTlFe6KB46j
        hNY9ZeLQczmP1BYyVfROBK5xo5fn7IbqFjgK2qW0MuA==
X-Received: by 2002:a17:907:a41f:b0:6d6:f925:1696 with SMTP id sg31-20020a170907a41f00b006d6f9251696mr4947753ejc.62.1646219645739;
        Wed, 02 Mar 2022 03:14:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4eItwRYHbFhHJecp/z62mEUFQa+5CGvwbfF4FEcKbfj5pKDOx0k/F7sIT5mVv7fPze2379A==
X-Received: by 2002:a17:907:a41f:b0:6d6:f925:1696 with SMTP id sg31-20020a170907a41f00b006d6f9251696mr4947744ejc.62.1646219645563;
        Wed, 02 Mar 2022 03:14:05 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id vl11-20020a17090730cb00b006d8121d0fc4sm857414ejb.138.2022.03.02.03.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 03:14:04 -0800 (PST)
Message-ID: <c13930a5-85ab-5a2c-54e5-15fc5bc87b17@canonical.com>
Date:   Wed, 2 Mar 2022 12:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] serial: samsung: Add samsung_early_read to support early
 kgdboc
Content-Language: en-US
To:     Woody Lin <woodylin@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, markcheng@google.com
References: <20220302101925.210810-1-woodylin@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220302101925.210810-1-woodylin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 11:19, Woody Lin wrote:
> The 'kgdboc_earlycon_init' looks for boot console that has both .read
> and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
> console to support kgdboc.
> 
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d002a4e48ed9..eeb30d016ff1 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
>  
>  struct samsung_early_console_data {
>  	u32 txfull_mask;
> +	u32 rxfifo_mask;
>  };
>  
>  static void samsung_early_busyuart(struct uart_port *port)
> @@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
>  	uart_console_write(&dev->port, s, n, samsung_early_putc);
>  }
>  
> +static int samsung_early_read(struct console *con, char *s, unsigned int n)
> +{
> +	struct earlycon_device *dev = con->data;
> +	struct samsung_early_console_data *data = dev->port.private_data;

This can be const.

Rest looks ok.


Best regards,
Krzysztof
