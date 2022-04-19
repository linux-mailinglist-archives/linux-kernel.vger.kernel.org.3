Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCAF506665
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349675AbiDSH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiDSH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:58:42 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D913DC2;
        Tue, 19 Apr 2022 00:56:00 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id s25so19713638edi.13;
        Tue, 19 Apr 2022 00:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJ/lP8fDTD2M4Ye8YmxDUmYzoCedu92mR6gpKzyiQqU=;
        b=XoizcegNEhkxYOKBWzQHT68UcbjHJzvvbsRSx8iI4n+QlzvWZ3zgtK2mBgJZ8bD1iG
         y7wLRPpI+lXYdSHUaLPo/V1AYFE442Iva+a11NT2SXBzn69g0puBgjueWHW36nPoAjbs
         uczgIrfdUrRKM0EBTMOwk0FDwViLeFzJ3eiCjoZYEvvv9YGqus79ZltozZq0z00utSrY
         ZDGfxQ56m3DJLCQ49kKpSlIhWF7tmekmr2z/vN/mir0obsqCuQ+D/STY42NceeAJeg6y
         LLYqVPILQG7xBFGBVlF8IgpzgH71JAf73DwXtlF6GWzERc3tP12F8cOZwng2eSeRv3fq
         PUvQ==
X-Gm-Message-State: AOAM531WoEzV/8If0CVPHmr4raU/5QGOafqCjjgtArTr7kaaoVL5fyU6
        lpIhFrsw/nBq7YVAtzjK+U4=
X-Google-Smtp-Source: ABdhPJwvgKc8DptlJU037frUeAg97O7xPjl0BMERQxypZbGb/1cdaq5Yws045/wQDZAbEdnBW8Ye5g==
X-Received: by 2002:a05:6402:2714:b0:422:aeff:34ae with SMTP id y20-20020a056402271400b00422aeff34aemr16012414edd.92.1650354958806;
        Tue, 19 Apr 2022 00:55:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906768200b006e89514a449sm5344136ejm.96.2022.04.19.00.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:55:58 -0700 (PDT)
Message-ID: <0c6c2a70-2692-2f5e-edbb-8735a0a80637@kernel.org>
Date:   Tue, 19 Apr 2022 09:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: serial: fsl_lpuart: remove the count initialization
 as it is not needed
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20220418021844.29591-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220418021844.29591-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 04. 22, 4:18, Sherry Sun wrote:
> No need to initialize the count variable in lpuart_copy_rx_to_tty(),
> so let's remove it here.

Right,

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 87789872f400..452a015825ba 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1118,7 +1118,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   	struct dma_chan *chan = sport->dma_rx_chan;
>   	struct circ_buf *ring = &sport->rx_ring;
>   	unsigned long flags;
> -	int count = 0, copied;
> +	int count, copied;
>   
>   	if (lpuart_is_32(sport)) {
>   		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);


-- 
js
suse labs
