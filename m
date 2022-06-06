Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6953E80A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbiFFPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbiFFPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:32:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C75393C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:32:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c2so4464110lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fN8sRgmISCR8EPXnnKKpVGqPS+/71A+Oz7QzCaYeTGA=;
        b=w8S3IgtvuUn9HPDdylfGpWAZkqCShXh3g2wLkkfBvi1R8UFi/o3UZ3K8XXJPjMcB27
         +rI6p2/56j/0hQgSg9p8RD6FeamsunizQWygk7Tv7UmUA8h7Ctu5dyLsH3ssg1lreH6T
         JlzEfcP3PuVUu1P7i26LKQi7uLmfsRZZbyQIDuu5cjzgPLk88/dkXXTrn3rKvOOyVKss
         dut3rf0bpL+4G2rRKDeVrXdINifUBxw9iiF4M8Sx6z6cY8/EQEtGhoLpghIcYlZPB8vE
         x1IeLuBRuHTdHwLlOdxLFW83y5le4h9Q3bE3zX7L5RFUvGoXhSHMGkB3q2ucr1izT3hd
         ScgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fN8sRgmISCR8EPXnnKKpVGqPS+/71A+Oz7QzCaYeTGA=;
        b=O+uR59rWvWdSOjT2fakZiyd88rOc2v1iMweRUZJJxdG0l8FOzJjQqC1cwEqVVdWox9
         gbZ3Mp19eYeZrp134R43rvqBftiNxEUOH7O98BKUAIDd5lkwChS23AYccz0Q/G9OYVSG
         3qwRB1kVgDaBGqj5V0eSD9D6gjU/V1moYuI2aqbveh+1FpemgPfPkwDBWYFXrbqnWDiV
         L3Wfhf9TbiM1CuXbvrrpEeEOxhxbSKmieebqvGaD3bPq8T2+ES5FchciAJUQ2hf/sNwQ
         cFT4ZSAVliGihH4YRPuixGQD5xnqbbywaM4NSiFf5sTSpAvKMzAA9DmpK92UnPPxSsyk
         7jIw==
X-Gm-Message-State: AOAM5318JjdXPT/aur2jsOX3/eTn6cb15TJHGggr23h3FELEKmFnge/B
        w3nmvW7dq4b1HFrCVWuaNgXGGA==
X-Google-Smtp-Source: ABdhPJzuO5Soq0HXtEC36yNiGAkwK+dJCFC5YZd9C7CvFxOUgpAd2ZM6vlfb1IMq/BN18vtafvAPTg==
X-Received: by 2002:ac2:44a2:0:b0:479:111a:b6fc with SMTP id c2-20020ac244a2000000b00479111ab6fcmr14228074lfm.412.1654529519059;
        Mon, 06 Jun 2022 08:31:59 -0700 (PDT)
Received: from [192.168.16.142] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id p19-20020a2ea413000000b00255a5a56201sm118386ljn.79.2022.06.06.08.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:31:58 -0700 (PDT)
Message-ID: <bbfaad00-4332-1236-081a-8b8c9e1edc58@kvaser.com>
Date:   Mon, 6 Jun 2022 17:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 11/12] can: kvaser_usb_leaf: Ignore stale bus-off after
 start
Content-Language: en-US
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-12-anssi.hannula@bitwise.fi>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220516134748.3724796-12-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> With 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 it was observed
> that if the device was bus-off when stopped, at next start (either via
> interface down/up or manual bus-off restart) the initial
> CMD_CHIP_STATE_EVENT received just after CMD_START_CHIP_REPLY will have
> the M16C_STATE_BUS_OFF bit still set, causing the interface to
> immediately go bus-off again.

I'm able to reproduce this and it definitely looks like a bug in
firmware. I've created a case for this in our backlog, but I don't know
which priority it will get.

> The bit seems to internally clear quickly afterwards but we do not get
> another CMD_CHIP_STATE_EVENT.
> 
> Fix the issue by ignoring any initial bus-off state until we see at
> least one bus-on state. Also, poll the state periodically until that
> occurs.
> 
> It is possible we lose one actual immediately occurring bus-off event
> here in which case the HW will auto-recover and we see the recovery
> event. We will then catch the next bus-off event, if any.
> 
> This issue did not reproduce with 0bfd:0017 Kvaser Memorator
> Professional HS/HS FW 2.0.50.
> 
> Fixes: 71873a9b38d1 ("can: kvaser_usb: Add support for more Kvaser Leaf v2 devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> ---
>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 31 ++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 742626e69dd8..4125074c7066 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -401,6 +401,9 @@ struct kvaser_usb_net_leaf_priv {
>   	struct kvaser_cmd_busparams params_response;
>   
>   	struct delayed_work chip_state_req_work;
> +
> +	/* started but not reported as bus-on yet */
> +	bool joining_bus;
>   };
>   
>   static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
> @@ -800,6 +803,7 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
>   					const struct kvaser_usb_err_summary *es,
>   					struct can_frame *cf)
>   {
> +	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
>   	struct kvaser_usb *dev = priv->dev;
>   	struct net_device_stats *stats = &priv->netdev->stats;
>   	enum can_state cur_state, new_state, tx_state, rx_state;
> @@ -824,6 +828,22 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
>   		new_state = CAN_STATE_ERROR_ACTIVE;
>   	}
>   
> +	/* 0bfd:0124 FW 4.18.778 was observed to send the initial
> +	 * CMD_CHIP_STATE_EVENT after CMD_START_CHIP with M16C_STATE_BUS_OFF
> +	 * bit set if the channel was bus-off when it was last stopped (even
> +	 * across chip resets). This bit will clear shortly afterwards, without
> +	 * triggering a second unsolicited chip state event.
> +	 * Ignore this initial bus-off.
> +	 */
> +	if (leaf->joining_bus) {
> +		if (new_state == CAN_STATE_BUS_OFF) {
> +			netdev_dbg(priv->netdev, "ignoring bus-off during startup");
> +			new_state = cur_state;
> +		} else {
> +			leaf->joining_bus = false;
> +		}
> +	}
> +
>   	if (new_state != cur_state) {
>   		tx_state = (es->txerr >= es->rxerr) ? new_state : 0;
>   		rx_state = (es->txerr <= es->rxerr) ? new_state : 0;
> @@ -899,9 +919,12 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
>   
>   	/* If there are errors, request status updates periodically as we do
>   	 * not get automatic notifications of improved state.
> +	 * Also request updates if we saw a stale BUS_OFF during startup
> +	 * (joining_bus).
>   	 */
>   	if (new_state < CAN_STATE_BUS_OFF &&
> -	    (es->rxerr || es->txerr || new_state == CAN_STATE_ERROR_PASSIVE))
> +	    (es->rxerr || es->txerr || new_state == CAN_STATE_ERROR_PASSIVE ||
> +	     leaf->joining_bus))
>   		schedule_delayed_work(&leaf->chip_state_req_work,
>   				      msecs_to_jiffies(500));
>   
> @@ -1392,8 +1415,11 @@ static int kvaser_usb_leaf_set_opt_mode(const struct kvaser_usb_net_priv *priv)
>   
>   static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
>   {
> +	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
>   	int err;
>   
> +	leaf->joining_bus = true;
> +
>   	reinit_completion(&priv->start_comp);
>   
>   	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_START_CHIP,
> @@ -1566,6 +1592,7 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
>   				    enum can_mode mode)
>   {
>   	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
> +	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
>   	int err;
>   
>   	switch (mode) {
> @@ -1576,6 +1603,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
>   
>   		kvaser_usb_unlink_tx_urbs(priv);
>   
> +		leaf->joining_bus = true;
> +
>   		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
>   		if (err)
>   			return err;
