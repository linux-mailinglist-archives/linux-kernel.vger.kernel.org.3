Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB258536F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiE2DqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiE2DqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:46:01 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530A85AA66;
        Sat, 28 May 2022 20:45:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C9B773200754;
        Sat, 28 May 2022 23:45:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 28 May 2022 23:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653795957; x=1653882357; bh=WK6kA6QrCw
        wKMLUCmNwj3NNYnGVd5SuQZRtDlGxvgIM=; b=jA656v1jz2FAxKtCWhmQrhi7cI
        bAlr3xV+m4/yfpqH2MGwddW3OBcq73ObzFN1yfiGSZV3VzQ7vBOM3ZigPWoHo9Gm
        UUyqsd/tjBYL9ql7Ft3qgWwAhu95z5JSE9M0DHniUYRm+mqcZ2vxiDgDWqe5AY4+
        vHFJzEapzYMOifeE5mMuuvoy1SCebqWSSFbydpiFhD3IgsL8LVQp5lZXk+OF1w70
        kswguQHn92Qm1oGHErimniOH/gmF/AMDnXofN7K8FBPFKtTbt4feFdw7MsMaYbAD
        1XKn0/ezf+KVKRC7lCCiTEK23InyTkYK46GFtr35xD0ib+Az9x2ReSJX68DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653795957; x=
        1653882357; bh=WK6kA6QrCwwKMLUCmNwj3NNYnGVd5SuQZRtDlGxvgIM=; b=f
        G6PDdLVbb8/GJ/ni9Z2Z8luv6q+mzoh37dh3c4jdnB6OxqEqQSPlEoKiE9dp6qrG
        7XnGdColZLVXKCpjAY83AXoFdHy08lC59RoyVbdSeIffbb/ALOoXvWayT6ntHjs5
        PuZXN7oyyu9jclhrJaMaGhRDyQ2AkmHD0TeDKcTIlIVMvJxUD87Hnn8AxDrBj6ck
        ksH+EEqNjxz0AIlYMzTt+ntf5mzUPh/ZCPYbaMUx9lYPwgvcKpoAuVHvGFZhPxlg
        PpBQI8qrytH5y4+MwoJ7nGIdOl6bUiqFLpO61PgnkrM9YsvHtmeV7jUd6ItfItRO
        Zqq7tzGm+uIlHEWxHEzLQ==
X-ME-Sender: <xms:dOySYtl0mCRmdM0WmTyoNrt29PRajIQM_nFipWP75yeJp2SwNKQ8pA>
    <xme:dOySYo3S5rsbohOnNa9UVpcIhId01TEi_P8HHfRBZUEU-jrIVNxHpI9Vew2druOXP
    teCu9FKmQGgzsRtTw>
X-ME-Received: <xmr:dOySYjqszrlqte656snlhzkuGbjNNh8uJPH9l7iWxt05A-x9ZWt4gbz15y1PYOekf3qNMjFjJKQKYpqguW4szH7m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkedvgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpefgfeelleeuteefjefgkeeuhfehgedvleeiheegjeegveei
    jedtudeludfggfefjeenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthhomhdqfhhi
    thiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:deySYtncFiIbHVeQ6_rYsnxQ3Q8FQLhRMRaK-0_dnYiW_hnzjAdqbA>
    <xmx:deySYr3CdhAiP8E7_6AryfkhFhshgP5xdSDG7GjXvVgyW1Xx3qhc5Q>
    <xmx:deySYstUqaKB0cMXk943KAAuXp90_HdBJU-8bqyxxnGHljFg9UHGyQ>
    <xmx:deySYpN1GPpRSC7SiBBGLx6_eismD5RWA8h-tZhAH4CiXcIF9_VIDQ>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 May 2022 23:45:53 -0400 (EDT)
Message-ID: <b6500fe9-f7df-a7d1-09cb-9f772126128d@tom-fitzhenry.me.uk>
Date:   Sun, 29 May 2022 13:45:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <x@xff.cz>, Martijn Braam <martijn@brixit.nl>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
 <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pine64
 PinePhone Pro
In-Reply-To: <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent this DT for early feedback. I've commented below on the parts 
I'm unsure about, and would appreciate any feedback.

On 29/5/22 13:17, Tom Fitzhenry wrote:
> +	cluster1_opp_ppp: opp-table1b {

I don't know which OPP should be used.

Per 
https://gitlab.com/pine64-org/linux/-/merge_requests/36/diffs?commit_id=dcf78ea8ad6f0b1c6e3279d8d752ca68d6d05756, 
using the regular RK3399 OPP table exceeds operating conditions.

Perhaps this should depend on an OPP for RK3399-T (which would need to 
be added, as the linked merge request proposes).

> +	// Per "TYPE-C", page 23.
> +	fusb0: typec-portc@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fusb0_int>;
> +		vbus-supply = <&vcc5v0_typec>;

This is the node many PinePhone Pro users have been using for >1 month, 
but I don't understand the USB subsystem well enough yet to understand 
the node.
