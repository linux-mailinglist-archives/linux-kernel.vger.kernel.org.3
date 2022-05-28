Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE49536B69
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355935AbiE1HfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343570AbiE1Het (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:34:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A529CB4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:34:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q1so6987470ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=aQdX2DZ1UDtnbWl/MXB/65OWqubghKRnM3Pz0ddYuSw=;
        b=N2/0oHWWxw8AYodZEPOOT9ySkPwT/+0d3um88y4/4WyT4s7jDZd2irvEF5ZlUEJGve
         /9JYm/+CSW77WtNRiQLmzvR84jH2Cn+SyCz54tUYFqF9k7fD8p4t4K/D/nBM71pJNHsp
         WL4bIgJUC/mGOkvkt2K+FHtOgo/exlACcYJLo11mszpEzvCPIcEOBD4/4tTsdo1DQj4P
         wBkQIvjpTwBOYoAgT0Rs+PgkUiNLGosjzgf8f6n82eNKE8MT2NYIl5VpOOJLZMvrkr6g
         YiXJ5lc/sa8sLJSlFvYIwtaLjjSi1sY3Wo20+DLt1r+yV9AAjKrcF0AOwa5wDXr96yZf
         Zldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=aQdX2DZ1UDtnbWl/MXB/65OWqubghKRnM3Pz0ddYuSw=;
        b=CqUZB/jVjLrIbqy9i+1qKtTd4pjH4oyzBkhUVjQ44Vk+/etmGRvj1k+69DroqkJRqP
         J7WNNSnK25fslxwWvSmqhDlnVKewGJwSJ9DJ1BFItqPbzNgTZDZcFJXpRATGnW0YANL/
         SewW1MTiZ3OqJIhhxRvX+aDJcT15e7IJRFpR7cir/sZ7sKn15t4pnUpHjg/aIAH9KFaI
         LlnQlwNNG2PcN9BitOupLI7ZD5vMdrYbXO/R4Fpy4h4CXFTa9PeWLoHhIZ4ZMZlLME9p
         2JlDkop4Ya7GjxDAUH8J7CrCNYXBAKNoqCQHJSqHb4fvT1BxqmZuIMBV+6tSa8ZvtPf5
         thpA==
X-Gm-Message-State: AOAM531W6zcGBmgb+f4gNKEKMXZ2/UAPvpLH8U9dV3zvJRGO+z/4fYOX
        8eWfD8TYuV8r2M1EcNrXuz46WgNuv/PKvw==
X-Google-Smtp-Source: ABdhPJyKe13amFauEAEdR5pfUpyULGHZumZAciZ5YwIpPFYw+3Lm26bGRR/k1eEtXc7MQXhWzJ2G2g==
X-Received: by 2002:a2e:9b42:0:b0:253:d85a:731f with SMTP id o2-20020a2e9b42000000b00253d85a731fmr25643859ljj.262.1653723286158;
        Sat, 28 May 2022 00:34:46 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id e13-20020a19500d000000b00478c1ac6d98sm732108lfb.248.2022.05.28.00.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:34:45 -0700 (PDT)
Message-ID: <78aba0b0-4669-c94b-13bb-3f4f1ac6ed50@kvaser.com>
Date:   Sat, 28 May 2022 09:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 05/12] can: kvaser_usb_leaf: Set Warning state even
 without bus errors
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-6-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-6-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> kvaser_usb_leaf_rx_error_update_can_state() sets error state according
> to error counters when the hardware does not indicate a specific state
> directly.
> 
> However, this is currently gated behind a check for
> M16C_STATE_BUS_ERROR which does not always seem to be set when error
> counters are increasing, and may not be set when error counters are
> decreasing.
> 
> This causes the CAN_STATE_ERROR_WARNING state to not be set in some
> cases even when appropriate.
> 
> Change the code to set error state from counters even without
> M16C_STATE_BUS_ERROR.
> 
> The Error-Passive case seems superfluous as it is already set via
> M16C_STATE_BUS_PASSIVE flag above, but it is kept for now.
> 
> Tested with 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> ---
>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 20 ++++++++-----------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 09ade66256b2..d7f2d64a8083 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -775,20 +775,16 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
>   		new_state = CAN_STATE_BUS_OFF;
>   	} else if (es->status & M16C_STATE_BUS_PASSIVE) {
>   		new_state = CAN_STATE_ERROR_PASSIVE;
> -	} else if (es->status & M16C_STATE_BUS_ERROR) {
> +	} else if ((es->status & M16C_STATE_BUS_ERROR) &&
> +		   cur_state >= CAN_STATE_BUS_OFF) {
>   		/* Guard against spurious error events after a busoff */
> -		if (cur_state < CAN_STATE_BUS_OFF) {
> -			if (es->txerr >= 128 || es->rxerr >= 128)
> -				new_state = CAN_STATE_ERROR_PASSIVE;
> -			else if (es->txerr >= 96 || es->rxerr >= 96)
> -				new_state = CAN_STATE_ERROR_WARNING;
> -			else if (cur_state > CAN_STATE_ERROR_ACTIVE)
> -				new_state = CAN_STATE_ERROR_ACTIVE;
> -		}
> -	}
> -
> -	if (!es->status)
> +	} else if (es->txerr >= 128 || es->rxerr >= 128) {
> +		new_state = CAN_STATE_ERROR_PASSIVE;
> +	} else if (es->txerr >= 96 || es->rxerr >= 96) {
> +		new_state = CAN_STATE_ERROR_WARNING;
> +	} else {
>   		new_state = CAN_STATE_ERROR_ACTIVE;
> +	}
>   
>   	if (new_state != cur_state) {
>   		tx_state = (es->txerr >= es->rxerr) ? new_state : 0;
