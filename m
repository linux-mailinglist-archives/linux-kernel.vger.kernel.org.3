Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656FE536B62
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiE1Hez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiE1Hen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:34:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C3C27B02
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:34:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a28so5281568lfm.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=MSxcb1fW8qjZ9uc8pRmLY43rFckana9PwYKKu14a0vc=;
        b=dJBGxYil2YeTQi8ydgLsLA+aEk0Ijzo5rUJhHfI8r1/nCGDNTwhArlxt520sWXU5s4
         5w8MDYx3c6RkDgQ+actjblfwngiTCSpdI1eYhgNEdR2SY7T4ZiiFYM3w785OCDH/Spx/
         EL2PtiR+u8rZZcCGivv+Z9bhfXV5drF34IvJ4JrAOJraJDtVVvAGSI7F7Ovl/i04+eRN
         j+ztCI/U2+gO8YqckI4oG6kIjiBca5FEYqd3oPdhwKSz1yDG+ydHRydUltYV2Fy+RefN
         cRRwEGCZqVYmKhcFfIvF3ytUa+rw6Pzq3Jc3E3O0qx5YLlQjq/fDZNUO5NbSLmeLKbj/
         xGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=MSxcb1fW8qjZ9uc8pRmLY43rFckana9PwYKKu14a0vc=;
        b=Zt+lt1zIHtgkJa192liKVWvv/3CS/yIIfcPijMt93CK6M9RvY1zAjJsnpLFEhnkKEk
         UQHYh09W8NNggLqgSrzDqZhuPlhK8WK53qPJEUkpLWBjVMpdmdGYGVm5P9yZZpz5Ozwe
         Som3+hC4oH6Q/yd2P4gXsVRUIIgZ42drrEnVgB0C4DOf4f79c0+HB7Kb4oOY9izqKU2O
         OFNBzH5OVUbgLBUe7UofU5coMmXzQOMcH7PUzoHj3kFaaN2HT2BwNFPYDws/bKc/xOeX
         5N76/KIACJsoEjdyvPS/8QQDXjlTnynzknxQf+itnL/b30Z9HOD3U7LLG1lZLmb6TBs+
         LN0w==
X-Gm-Message-State: AOAM532ql7g4NiKCktky4N8y9BLjEpbXzUkZ8rTrnIyZFDn9uyqh+CQK
        Qy7i1iX9eLsEUpFNiCxZHqeAJHPFN6/dnA==
X-Google-Smtp-Source: ABdhPJzWuyL7aNarDTnlI8BGxu0FRkBXF6rYzhzx2UQRhW26lo+JAZZbx3PRuVR0B0ZBKfTlliH2YQ==
X-Received: by 2002:a19:5043:0:b0:477:cc18:840a with SMTP id z3-20020a195043000000b00477cc18840amr31094758lfj.437.1653723281378;
        Sat, 28 May 2022 00:34:41 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24c50000000b0047255d2119bsm1206762lfk.202.2022.05.28.00.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:34:40 -0700 (PDT)
Message-ID: <e2f0ef9a-642c-0f1d-e557-39ddbe8659d9@kvaser.com>
Date:   Sat, 28 May 2022 09:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 03/12] can: kvaser_usb: Fix possible completions during
 init_completion
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-4-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-4-anssi.hannula@bitwise.fi>
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
> kvaser_usb uses completions to signal when a response event is received
> for outgoing commands.
> 
> However, it uses init_completion() to reinitialize the start_comp and
> stop_comp completions before sending the start/stop commands.
> 
> In case the device sends the corresponding response just before the
> actual command is sent, complete() may be called concurrently with
> init_completion() which is not safe.
> 
> This might be triggerable even with a properly functioning device by
> stopping the interface (CMD_STOP_CHIP) just after it goes bus-off (which
> also causes the driver to send CMD_STOP_CHIP when restart-ms is off),
> but that was not tested.
> 
> Fix the issue by using reinit_completion() instead.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 4 ++--
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index 4e90a4b7f95a..b0094f162964 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -1869,7 +1869,7 @@ static int kvaser_usb_hydra_start_chip(struct kvaser_usb_net_priv *priv)
>   {
>   	int err;
>   
> -	init_completion(&priv->start_comp);
> +	reinit_completion(&priv->start_comp);
>   
>   	err = kvaser_usb_hydra_send_simple_cmd(priv->dev, CMD_START_CHIP_REQ,
>   					       priv->channel);
> @@ -1887,7 +1887,7 @@ static int kvaser_usb_hydra_stop_chip(struct kvaser_usb_net_priv *priv)
>   {
>   	int err;
>   
> -	init_completion(&priv->stop_comp);
> +	reinit_completion(&priv->stop_comp);
>   
>   	/* Make sure we do not report invalid BUS_OFF from CMD_CHIP_STATE_EVENT
>   	 * see comment in kvaser_usb_hydra_update_state()
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index d9f40b9702a5..09ade66256b2 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -1300,7 +1300,7 @@ static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
>   {
>   	int err;
>   
> -	init_completion(&priv->start_comp);
> +	reinit_completion(&priv->start_comp);
>   
>   	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_START_CHIP,
>   					      priv->channel);
> @@ -1318,7 +1318,7 @@ static int kvaser_usb_leaf_stop_chip(struct kvaser_usb_net_priv *priv)
>   {
>   	int err;
>   
> -	init_completion(&priv->stop_comp);
> +	reinit_completion(&priv->stop_comp);
>   
>   	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_STOP_CHIP,
>   					      priv->channel);
