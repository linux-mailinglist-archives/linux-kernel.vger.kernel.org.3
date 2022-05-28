Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88C536B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiE1HhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355911AbiE1Hfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:35:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C627B02
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:35:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so9852216lfg.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=cS89s9w6cdCaXdnwTN3yhnuBLS/GgN8VqMUDgWjJSaM=;
        b=jr/C2torrlk/rjv18Zc0FYNGHvoGqhUdns6S7F6Sd5kcQNLmTQgm2n5N5SzJHrru5B
         7/tO17YYh2+yhsG0AfzUEtwzr5LXcxwFwW8cHtlbx3vxUsrrL+ObFzb2OJLHPFoxi+df
         e1qURAIqYoSrua51xeVVpPYgUBVJo8ex+r7XYkNIYpsisyIly5SdpY60uHyvim+PQXZ3
         IGBnLnm9m22rCxWxmZP256z9ydPmhQRtlRcJZAbxvSWnLMPbNewEwLDqwn2KX2xq4qO8
         LpDojxpLeXEd0ML0XVHZnUhNZLQP/FEdRw/YekV1zVJhBECbBOAMHEg4QomDk2VZFvym
         wUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=cS89s9w6cdCaXdnwTN3yhnuBLS/GgN8VqMUDgWjJSaM=;
        b=MLFWSa6tRMnAN66PRddKMiDdRvLfaWdnuiKrdPMMr8mwb4zpnFSDE5M88BNrueLdM9
         mDE1xMm5Yn2KJUJ2tUdvEZK0YmXi3AAv4X19hpURB20bAoL8FrQsEP2ibAmvhexeyz0D
         0oo/BoQFmXtLvJ/KiQczrZzDEr1Sy98dtJeyGHRp5Me4KBmXLEhDCCjDsVai7ZS+Cj15
         bBPITeHEcm1Vm/ejdQ0qI8nB9ZVj3BoM7WBR3s+39aOs7lVtzkp8Eljr7GakIDNZlFdi
         VbJz/p3o0nHwD11syGmGtadO/NvOLDerZtzCXtJAq1NhcfOP4y7zLSYzNxqcNxSo2KOj
         NtRQ==
X-Gm-Message-State: AOAM5331KRsi6vu05+Kc2JG5s23FVm+J81PlbCTJSJ5O1quqXYHIDIqx
        4eL6d4NCmzQEeylTG5qyKNjs3A==
X-Google-Smtp-Source: ABdhPJxlo5ZvgC446ksafbxviizFbqVNfVhKc5HT2JkyNbGbrXrmtTSlKa+RN9PjRuG5HidZWPTkGA==
X-Received: by 2002:a05:6512:3502:b0:474:21a5:8d41 with SMTP id h2-20020a056512350200b0047421a58d41mr33008226lfs.570.1653723333969;
        Sat, 28 May 2022 00:35:33 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b13-20020ac25e8d000000b0047255d211d4sm1205574lfq.259.2022.05.28.00.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:35:33 -0700 (PDT)
Message-ID: <66ffaf57-8667-ecff-1793-51af7304b0e6@kvaser.com>
Date:   Sat, 28 May 2022 09:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 06/12] can: kvaser_usb_leaf: Fix TX queue out of sync
 after restart
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-7-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-7-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> The TX queue seems to be implicitly flushed by the hardware during
> bus-off or bus-off recovery, but the driver does not reset the TX
> bookkeeping.
> 
> Despite not resetting TX bookkeeping the driver still re-enables TX
> queue unconditionally, leading to "cannot find free context" /
> NETDEV_TX_BUSY errors if the TX queue was full at bus-off time.
> 
> Fix that by resetting TX bookkeeping on CAN restart.
> 
> Also, add an explicit queue flush in case some hardware versions do not
> do that implicitly.

See comment below regarding this.

> Tested with 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb.h      | 2 ++
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 ++++++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> index 3a49257f9fa6..f1bea13a3829 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> @@ -175,6 +175,8 @@ struct kvaser_usb_dev_cfg {
>   extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
>   extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
>   
> +void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
> +
>   int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
>   			int *actual_len);
>   
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index 7388fdca9079..a8d72fb8291a 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -440,7 +440,7 @@ static void kvaser_usb_reset_tx_urb_contexts(struct kvaser_usb_net_priv *priv)
>   /* This method might sleep. Do not call it in the atomic context
>    * of URB completions.
>    */
> -static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
> +void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
>   {
>   	usb_kill_anchored_urbs(&priv->tx_submitted);
>   	kvaser_usb_reset_tx_urb_contexts(priv);
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index d7f2d64a8083..2d30a662edb5 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -1402,6 +1402,12 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
>   
>   	switch (mode) {
>   	case CAN_MODE_START:
> +		err = kvaser_usb_leaf_flush_queue(priv);

All affected devices, leaf and usbcanII, will flush the Tx queue when
receiving CMD_START_CHIP.
So this is superfluous, and can be removed.

> +		if (err)
> +			return err;
> +
> +		kvaser_usb_unlink_tx_urbs(priv);
> +
>   		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
>   		if (err)
>   			return err;
