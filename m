Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED46536B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbiE1HhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351088AbiE1He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:34:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4B27B16
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:34:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a28so5281568lfm.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=0VcqXBlpP0I7elewIqn6aQ54FjWGSH2ypaKSX8Uqy1M=;
        b=RPxkGevkMe8lgaCNKeFyQ6eWEruuX1TTgds7VxTzBwA8GNQW4Km9s2+cag2lrbNRwV
         1em3juaiJ7KSwG1wHiBUvbFM3GzaV1rdZBWgB9KvKjjpkmgA0Aj0N5xBjVOJxf2UHnl2
         3lW4ZTLb5oIzW3Gl6JO4EHG5HeBzmBLTtkiOtVuLT86Ae9AmgtPJ1vm3nXFsqLLvFoPk
         1EiLyFmrQljRQ2mN35dW6rHe5sgykxkZ83D2tb/IIXlf9MsEfb9A/KjC9xD3ORxkZHuf
         JxBOnIMkPlljOzFap2KYLPceiYf7tY7XeFl9x3p3Wp9uMwItyCuG5QyW6lf1oXwQNN4W
         Ssbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=0VcqXBlpP0I7elewIqn6aQ54FjWGSH2ypaKSX8Uqy1M=;
        b=dwo/39XPHC/VOgv+KpQMLPYcoM7NzBZBfaKdGbBMMQcAwlltlPZ20u9wGqeGQwEyKJ
         IysFegfIOqa0h3yIpiZbcSHVAIBYjEKBmzp26TaOV4iPEQiRwey6Hryrv8YqLkAIqSUJ
         dggs3KDv7C1a6NHaJk2VgeMEvO2OEh5EBqbOCW6FQYMiDhNYy3gKSAfvAJE0cTychnO/
         20Q7nP3nggMcQP4XIHChv/wW51xmFNs6UA3nFeXlY3TZSuLIAQ2owQSJuDbVCw48d9lp
         sCs2cx9sLVZaFiem7VpeOYqjt5nU+wXsTf9ohGFf8XfQ9U3/LwiQ+2ERPSjSFSVUJX0i
         BxGA==
X-Gm-Message-State: AOAM533GpK7JQu+Dpn3cJ7JbysiQE19atbzK+6I1QpPvYc+lgCnNVgE9
        lUo+SeZkU5iMGrfoWmrgNUGM4TSsDixHtQ==
X-Google-Smtp-Source: ABdhPJyvRdBJ8smYCYD+s2XXssa4v+dzt6uvzwKpwaiKPK3GZg5I2m0ccEZe3W4n+LssYz5RWnJSYQ==
X-Received: by 2002:a05:6512:a88:b0:473:e080:40e8 with SMTP id m8-20020a0565120a8800b00473e08040e8mr32658225lfu.359.1653723292052;
        Sat, 28 May 2022 00:34:52 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id d8-20020a19f248000000b00477cc3fa475sm1204393lfk.204.2022.05.28.00.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:34:51 -0700 (PDT)
Message-ID: <139cfa7f-c2a8-4a4a-7e3f-43afdb331753@kvaser.com>
Date:   Sat, 28 May 2022 09:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 10/12] can: kvaser_usb_leaf: Fix wrong CAN state after
 stopping
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-11-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-11-anssi.hannula@bitwise.fi>
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
> 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 sends a
> CMD_CHIP_STATE_EVENT indicating bus-off after stopping the device,
> causing a stopped device to appear as CAN_STATE_BUS_OFF instead of
> CAN_STATE_STOPPED.
> 
> Fix that by not handling error events on stopped devices.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 7ed2ced8ba08..742626e69dd8 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -879,6 +879,10 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
>   	leaf = priv->sub_priv;
>   	stats = &priv->netdev->stats;
>   
> +	/* Ignore e.g. state change to bus-off reported just after stopping */
> +	if (!netif_running(priv->netdev))
> +		return;
> +
>   	/* Update all of the CAN interface's state and error counters before
>   	 * trying any memory allocation that can actually fail with -ENOMEM.
>   	 *
