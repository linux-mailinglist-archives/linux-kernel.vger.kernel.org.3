Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773544872E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiAGFty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:49:54 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58747 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbiAGFtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:49:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 673A158046E;
        Fri,  7 Jan 2022 00:49:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 07 Jan 2022 00:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=m
        0eUzpbRurQerx+LcCzqwPejVGqLzsonypVAH0SBKsk=; b=orm0I+Q2e8duuVpoE
        yedsGF383+vsCTEgDciuvU1YKyJHTdNzZB0icF4uaaRqvV5XIvLTQSl3V6RcRqZG
        7mPhi4ZmqUMaeltxm/WnBqOPrjRuSG3MtZAEt6JmGyA/rgQO2stbzlUHhFCJ1z/d
        By0/QVnNkIJECbMvnwus5FX+NP+LE9PciWG8f9ftvrzT+6F8WBkW5G+Y3APBqq+R
        m9a0oOyDzkGqfucdxKwG8yscYsm/PsIeOqgfDhnD9q8znrXxfh2ylrg2V7qImmWW
        DrrAE/hBgYJ57Ao/GMt65k1ME7kMsVpT8q9SEVD00XPMfLi58/Cbk54dYek+A7bA
        pTSNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=m0eUzpbRurQerx+LcCzqwPejVGqLzsonypVAH0SBK
        sk=; b=jAiqqDpQWwi2oCc6RgaOof9fPPLzMQYaJ9S0v+mK4pNrpv6hRM9D8t/Wm
        we+E/jQ/n36VF5JJ/u9nPRmHLs/tlG2y2vn8GCphfisIj2lbX0XmAAu5MFQj3lV9
        zufDniZD01Sn85rJGqYDqdq8uIUQYwhCoZcrV1Gy/IIiaJ1Fzn1+3QKM5Qa4WV2J
        JTLobWoVFiW+Z1UKDDWQPLwccVSANhTlcO7JrpzlwkC73uzfeW3nnNwc9vwP7oeZ
        v89BRPejYHiqtVRgjNX7vknRs9SfKR4IsTlZc1HsARwzk/95E8fnIHwrWWNWbhDp
        y985xqadfKj/YWxXJPEEE87iftIWg==
X-ME-Sender: <xms:f9TXYVBnpS1DHxXdrkA6j6hO4fQi-yZz1SSI7SxbQuUofwbyu7rxbg>
    <xme:f9TXYTj59O8QucmwlD-XSls60RkFls8-ocSzhYHoBWNMqfA9LmQNEo5ujKbK3tpls
    wy2JJBrvsmQvTW-Bw>
X-ME-Received: <xmr:f9TXYQnFNorqTRTDMzpkhKcbFqIsKVxx-oj_m69jd8zim_bYuJxwgML--zQSqldUtQhzpGI9hDhMn3Q101qHm8MplcI7mHjb2zkiJKftkXSZKI0TexAyUfA72w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgedthefghfevvdehfeevtddvueffieejjeegvdevtdeugfelvddv
    hfdtteefveefnecuffhomhgrihhnpehgihhthhhusgdrtghomhdplhifnhdrnhgvthenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:f9TXYfxmh8Uqo3V2CKtc9PemWKHcuU_nEU1c6kQ1JQ2HmQ7RwGHJig>
    <xmx:f9TXYaQFwXWQ7jLprSOOgqP8QwOF1aiFtw3n_ZsneBUdvLb73Y9hjQ>
    <xmx:f9TXYSZbV3ruKzS-wE-4XxbJF5jvuqHrkM7fD3nTbhsK782AUqSjwQ>
    <xmx:gNTXYfJIxAYMVE64KBOfjvfWzS3bvQP_hdE_P3mo2bhIYANQA4VYUg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 00:49:51 -0500 (EST)
Subject: Re: [PATCH v4 0/4] Add support for the Cypress cyttsp5
To:     Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     dmitry.torokhov@gmail.com, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        andreas@kemnade.info
References: <20211222124603.326920-1-alistair@alistair23.me>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <37291fe7-7028-cd9e-7fde-01d13f85f0d9@sholland.org>
Date:   Thu, 6 Jan 2022 23:49:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211222124603.326920-1-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/22/21 6:45 AM, Alistair Francis wrote:
> This patch series builds on top of [1] and adds support for the cyttsp5
> touchscreen controller for the reMarkable 2.
> 
> I first tried to add an I2C HID device. Although the cyttsp5 has some HID
> looking aspects it is not HID compatible. Just in trying to probe the device
> I found:
>  - The HID descriptor has extra padding
>  - The HID descriptor sets the high bytes of the descriptor length
>  - The HID descriptor has extra unrecognised tags
>  - The HID reset command doesn't appear to work
> 
> I don't think there is a way to use the I2C HID framework with the cyttsp5.
> For anyone interested you can see the work here [2]. In that branch though I
> can only obtain a HID descriptor, nothing else works without more core
> changes.
> 
> So instead I rebased the series from [1]. Converted to the new yaml DTS
> documentation, added regulator support and fixed a x/y miscalculation bug.

I am working on the PineNote, which also uses a cyttsp5 touchscreen. I attempted
to use the driver from this series, but I could not get it to work. I found that
the cyttsp5_sensing_conf_data was filled with all zeroes, so every touch failed
the max_tch check. I noticed that cmd_done was being completed by empty
responses (which explains why the response buffer was zeroes), but I got stuck
after that.

So I looked back at the thread you linked below, and tried to implement the
workarounds described there, and those above, plus some others, and I was able
to get the touchscreen working with i2c_hid. Here are the changes I made to i2c_hid:
https://github.com/smaeul/linux/commit/a1e07425a6c4

In summary:
 - Perform a 2-byte dummy read before reading the HID descriptor.
   This is required to clear the two-byte empty message.
 - Split command/response into multiple I2C transactions.
   This is probably some sort of timing issue.
   Without these first two, HID descriptor reads return "02 00".
 - Chop 2 bytes out of the HID descriptor, as per the thread below.
 - Similarly, chop 3 bytes out of the report descriptor.
 - Skip the reset command, as above. Otherwise, the touchscreen
   sends a different, short, unusable (partial?) report descriptor.

I reused the the existing i2c_hid_of_goodix driver to handle toggling the reset
line, which is required. That existing binding is almost identical to the one in
this series. Here's the glue I added:
https://github.com/smaeul/linux/commit/65d9250d3899

And here is the result, from dmesg and debugfs:
https://gist.github.com/smaeul/60b4b0f784bfff8bb8ce3ee3b4483be9

So far, the quirks only appear to affect probing the device. The touchscreen
works normally after that.

What do you think of this approach? It certainly seems cleaner than parsing the
HID reports/responses by hand. But I don't know if all of the quirks are
acceptable for i2c_hid.

One additional quirk that I haven't handled yet is the missing min/max for ABS_*
axes in the report descriptor. This prevents libinput from working, but other
evdev users appear to work fine. The driver in this series appears to get that
information from some vendor-specific command, and I am not sure where to hook
that up.

Regards,
Samuel

> 1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@bootlin.com/
> 2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid
> 
> Alistair Francis (2):
>   ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
>   ARM: dts: imx7d-remarkable2: Enable the cyttsp5
> 
> Mylène Josserand (2):
>   Input: Add driver for Cypress Generation 5 touchscreen
>   dt-bindings: input: Add Cypress TT2100 touchscreen controller
> 
>  .../input/touchscreen/cypress,tt21000.yaml    |  92 ++
>  arch/arm/boot/dts/imx7d-remarkable2.dts       |  89 ++
>  arch/arm/configs/imx_v6_v7_defconfig          |   1 +
>  drivers/input/touchscreen/Kconfig             |  14 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/cyttsp5.c           | 922 ++++++++++++++++++
>  6 files changed, 1119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
>  create mode 100644 drivers/input/touchscreen/cyttsp5.c
> 

