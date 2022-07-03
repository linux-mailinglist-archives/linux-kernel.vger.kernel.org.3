Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F1956454A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 07:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiGCF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiGCF3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:29:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E465FC7;
        Sat,  2 Jul 2022 22:29:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 468455C0067;
        Sun,  3 Jul 2022 01:29:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 03 Jul 2022 01:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656826155; x=
        1656912555; bh=eu1mlB/r2fiKhhAfSH6KHcE1lAy+mJphMNtNjrgFVtU=; b=a
        o8RGWI+PyXkL4BILUTs14PKFnfEpRDYO5DTL4SpuGcVCcBBZpRjSZ3F9XE+R26vb
        Y+H/fMBX2gtRgJYt1XunSR1lkaoDhibsom7dlHC4oFlA82jVw7h6uGHNMQqHEOin
        NnUUyKOVx8E8+TYeeSpEOb7PyVGKw2cGH+mIkVcLZzH08vqUJVeGjMTNpF9rC4oa
        uNKfkUAH3q2haYrmb0INjrAEuooCWzdHDK3zxGvUGP737lldFf/fDp0Bntl+oKkN
        hNWXEj5m89tgIzcMH/Tqc6ez7RyOxgNezJoYo8GvL34Lxc2BUKvE1aP6UpSBX1Xy
        T9luJC87TLAM6djhXuNuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656826155; x=
        1656912555; bh=eu1mlB/r2fiKhhAfSH6KHcE1lAy+mJphMNtNjrgFVtU=; b=f
        LLL0xh3VoUln30Dh1PyZCwmzaoRSzyQTGpMR56qcDbnTylNk16feJX4omqdaKOdv
        CmI5ff0PE4HeYUGY1GNZbXGuvwoQtHPXqOJuYf7MLqx+qMzBnEN36YKH3/M5nfv+
        wGtNubLzmcWt0q30WzVt8oa3mQJbJ94LtpNFWiwAZns7sZXvorS+6KKFoqQj/QcY
        MuJgs3sn190RGXoZwSlifZpuVsSm0oV6sHI/NQ8VV72r6+NJNfV4B9vyl5d9vpn0
        JbK6vJRKL5Z8Ta524EcleNzhzIk0wv5U5ckgKZgQzppEv10HZFBKQnyZSHhKZrWu
        CiTmF66enqO+24C77tWtg==
X-ME-Sender: <xms:KinBYtYZHbOs_fH8q4AIHX7QTKVAXsUCV-IRS5bUw_gVQQbyq-KeBQ>
    <xme:KinBYkZg2BVYqyi3cDJwG4qou9p54gK9PX27C-GmP9tdKljZCjL5RV8Tl7QeyFFk_
    zjjxCJKDW-yqpCE8g>
X-ME-Received: <xmr:KinBYv85iB_Wh2eoQZaO_155irCIKLl6rfQtyuzJyYJTyQlU5OnENbkCBSkCkbINPghF5bwvqamdmt54K-AY_ijIVeM9x9xI1LSxi0lCj1OkW7HMIfyjlWmZCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KinBYro3E6-LYJtcIN5O7AV610dJn_CngShWa0mZitS1jnLwUdFUHA>
    <xmx:KinBYoqa-7bw_Pj0PTwtfd_DDBgfQWYU08W-v_Pet9chFKJJB1uZ7A>
    <xmx:KinBYhRlF5pHVOZQLUv4sHZJD24vhZkwehwjPCiaP7uLyqEMn98kQw>
    <xmx:KynBYl4DP0iyyd1V5nZjGUL2YmqqR6TK4j1sOf7jRktmOZgDbEQi5Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 01:29:13 -0400 (EDT)
Subject: Re: [PATCH v2 2/5] dt-bindings: input: Centralize 'linux,code'
 definition
To:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-3-robh@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <89b57bfc-578c-0a19-fea8-3b61bdbd4358@sholland.org>
Date:   Sun, 3 Jul 2022 00:29:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220608211207.2058487-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 4:12 PM, Rob Herring wrote:
> Multiple bindings use 'linux,code', but there is not a central
> definition and type. Add 'linux,code' to input.yaml and update all the
> users to use it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/input/adc-joystick.yaml   |  2 +-
>  .../input/allwinner,sun4i-a10-lradc-keys.yaml     |  5 ++---

For allwinner,sun4i-a10-lradc-keys.yaml:

Acked-by: Samuel Holland <samuel@sholland.org>

>  .../devicetree/bindings/input/azoteq,iqs7222.yaml |  7 ++-----
>  .../devicetree/bindings/input/gpio-keys.yaml      |  1 -
>  .../devicetree/bindings/input/input.yaml          |  8 ++++++++
>  .../devicetree/bindings/input/iqs269a.yaml        | 15 ++++++---------
>  .../devicetree/bindings/input/iqs626a.yaml        |  5 ++---
>  .../devicetree/bindings/input/iqs62x-keys.yaml    |  5 ++---
>  .../devicetree/bindings/input/max77650-onkey.yaml |  8 ++++----
>  9 files changed, 27 insertions(+), 29 deletions(-)
