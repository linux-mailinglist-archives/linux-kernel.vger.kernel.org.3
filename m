Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A35640F3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiGBPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGBPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:16:49 -0400
X-Greylist: delayed 295 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 08:16:45 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED7135;
        Sat,  2 Jul 2022 08:16:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F0D8580988;
        Sat,  2 Jul 2022 11:16:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 02 Jul 2022 11:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656775004; x=
        1656782204; bh=uUPnY6f7r7pqDwXYoVA2oXIi1TTapVd9m1IxYXZs5xo=; b=U
        r6E1SUuRrfloJFqWNIXYdMIoyFAJfqHHF28aPNMQT9mPShr+j7fFgg5oYYlr2Y9j
        xIyvBlShnq0zRdZabRSHys7MsUGbVwdG3OupiYswcWEyy2/VYj8QnYcom0bctwzl
        Djbgx0viIg8LWPesmOBH77EO87q1pDNpw0l35Wzz62Xlt/E3BlYapsN0lIw2Rlb4
        jJAH87Dz+StotXKTULaBmqJGxmiFnCCRaaSVOlOSk/k9vfrN5dETWP9EUTc5LQ87
        Ho69OmSOdn3+VvlVHB6P6zeXfq8SBYx3T43DtFU5e29J+Nd2/r+dwt4BpMyGPzKC
        UehCLLFiDuEWkd3M5+jhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656775004; x=
        1656782204; bh=uUPnY6f7r7pqDwXYoVA2oXIi1TTapVd9m1IxYXZs5xo=; b=N
        1vXJEfDwm9J0P8y5LfNurTp/bawlihaCWJZzW0fXs8o8wBum5A9NZWnsJlqbUJrO
        JM9pMn0sVMWOSioppc3yYUpeWxw5tgQQXwRE3YeGOYvSf1bTnrLKaZzV8Ja+7r8r
        DrfilsxUirt1SECtFu9C+HYlmXCbOIQeRoIiPkL+vLZh9YWxSzG7oxSJgK/OXNwT
        mVmvzqN6URIuUxDvXxDD3ITXic8r1eQIuzVxcwSoEix/X9byCGzNh9I7UThb9l5j
        xyaV3XtroNnWhWDpq2cEyJXY+NBdYxqvoOnqDxx354PmrZ5GPdmELjn/JSiQtt18
        4wz5Q6pMlDNf1xP45n2Yg==
X-ME-Sender: <xms:W2HAYphSuLC6K5QLQr7n25UPFNwrbhyTvFP-k6azfrPHeGY-lpZ1dw>
    <xme:W2HAYuDWxRQUfBcP--iIovbwp58tZGQggrYttqLxmzJmiT0-7f_-im0K-J10iAobm
    NpgdoeUIsmj8NnuwA>
X-ME-Received: <xmr:W2HAYpEVKuWjFBb97ixNJ4QJ2iz6xbkAudgbyNjH6zqDVjcYUEUs5Ug4pNn3ZAWbSMQuJvCATemToOzGp3lg_KHYTIMoIuxGYHfQlylWVvxqT1dcxTtUo1uhFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfevfhfhkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepffdtveekvdegkeeuue
    etgfetffeileevudekuefhheelvdfhiedtheduhfduhefhnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrgh
X-ME-Proxy: <xmx:W2HAYuTg2kbEsdCw0Q-Bs0_Xy4x8Nx4Ridb33pIQZ9U399mN2MQMGA>
    <xmx:W2HAYmxdsheA9qm1KdOCwmwvXHedUaIbVn8kd1IDGSjuGH9iZ6RgWA>
    <xmx:W2HAYk5rV59p4s4LA4GNBRqhiLfrj6aqZLKynsNylWFvF5EcMDEsiA>
    <xmx:XGHAYjyZmPm_5xXGhVJfBUwt9GxAj-VBvmJBsyrVw23uHECcg6H7sA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 11:16:41 -0400 (EDT)
Subject: Re: [PATCH v4 04/15] dt-bindings: gpio: Add AXP192 GPIO bindings
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, wens@csie.org
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-5-aidanmacdonald.0x0@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d024858b-a461-2cbc-48fa-a13cf3be0cb4@sholland.org>
Date:   Sat, 2 Jul 2022 10:16:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220629143046.213584-5-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 9:30 AM, Aidan MacDonald wrote:
> The AXP192 PMIC is different enough from the PMICs supported by
> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> driver also supports interrupts and pinconf settings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> new file mode 100644
> index 000000000000..ceb94aa2bc97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> [...]
> +
> +required:
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - gpio-ranges

By requiring the gpio-ranges property, you will not be able to convert the
existing driver, as existing devicetrees do not have it.

If you instead call pinctrl_add_gpio_range() from the driver, you can maintain
compatibility with the existing binding.

Regards,
Samuel
