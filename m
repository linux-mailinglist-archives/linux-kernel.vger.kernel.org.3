Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3D56CA95
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiGIQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGIQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:20:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE7E48CB0;
        Sat,  9 Jul 2022 09:20:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 262AE32009CE;
        Sat,  9 Jul 2022 12:20:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Jul 2022 12:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657383611; x=
        1657470011; bh=wMBAxB5wUdc9k4Kte+DeQUguPB861x4tBpSXnoRGxfk=; b=q
        P9CYkyaU+wPPBnMp3ScTzcNAg2ud5w9Q+E2SyD05y4WH0Th7Z0ZZtT46Kp3vbywc
        6/lZvUGtDvKPHZMD8my9Zx6nkbZwZCiaL4PPiImQEJPBA4yLaj97IoS0SnXsNo1z
        V1NsDC4pjdgqryhG8deRkoN3+OK/bni4Mwn3xLRSJyfKFlaUIRzKnhB4r/Mn7fDR
        3bfv2Ipl/TgLAzoZd3xum3E4T7v0TQcqcQS2LjSRaUwWBU5UoE1uqcORYi6Dn/Uv
        lmWtODyn4BqKzD2XYJ73my5+vc7NeWR+X3l8qvjoxxED41MAfaRB11LgzoIArhTY
        DlDq2n1ACzxbUVFxUataw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657383611; x=
        1657470011; bh=wMBAxB5wUdc9k4Kte+DeQUguPB861x4tBpSXnoRGxfk=; b=R
        a/xnL8w6NUkmznVSYp+IJOX6y50KNJPvFR8CfanMUNGgHCaPzqsuj6fyqi0kfLuH
        LWWPwgiFAjy7cxWUHaSnimHaWOcJTRGwwX7vDVGQQX94vvfhtTcjeBKyZiJfeG+f
        EFBO/X7fWtoV8YYGTpGocQHhHxSxV4ZTL2bpo0Q9hUd8OLGq4yUEIEpAZnsscayf
        Wf6rXyRBMxf9lAsV9JnQyLeNXQJfXSKiDv9Fs+1CXnqC4jmuAPTaZ+YSp9ywCZGH
        R/KGXd9MrvuHbP7iMMeaftXZOO1Hcz0utTjfVSjnfYwMKx8pxO5Mqcgy1AnXiKeL
        6MraGF3WyVKEobERlsV4A==
X-ME-Sender: <xms:u6rJYrDDdh89K-CqkqtbVTbaiK_KJoNKufvN907n-0ZeHscHkNW-aQ>
    <xme:u6rJYhiOl2cFyE030WCfV7ZMZLfV2Vx1164BJddTd39g2KSA6rRyjkL8P5ZdCtR5B
    o-aOL95wwFyM6h2RA>
X-ME-Received: <xmr:u6rJYmlosQpljkGS7P40Nx9PqOprw4iem2U3X1yOXbbvt6P7lQvs7faia4zIWgZBrXSUQyLwOS-_x1sGRmTdTDPq8LXQKB6SvJEqMkHFt1R5AHaWUHkTorpR9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:u6rJYtw2B4UcHOyKWPxaXMeU2RnVgOMybcupoqmXH2T2xJHNE55YiQ>
    <xmx:u6rJYgTIb7aRHizdt7hYy8hnyy46e6QwlHgnAy1hJoHYnHEPXwO-KA>
    <xmx:u6rJYgZe4nfYIqkwjhjoPzgKkAzDsZ98RAOw9YGoGU-1beX57dthgg>
    <xmx:u6rJYjE9HwFitE6Fw_p0S9Y6nvS4_zdj6HNKfp0nu9yVhqRdio3dLQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Jul 2022 12:20:10 -0400 (EDT)
Subject: Re: [PATCH v13 6/7] arm64: dts: allwinner: h616: Add OrangePi Zero 2
 board support
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220708105235.3983266-1-andre.przywara@arm.com>
 <20220708105235.3983266-7-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6665adb6-d90e-6bbb-f8a6-4ae7ab1fad10@sholland.org>
Date:   Sat, 9 Jul 2022 11:20:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220708105235.3983266-7-andre.przywara@arm.com>
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

On 7/8/22 5:52 AM, Andre Przywara wrote:
> The OrangePi Zero 2 is a development board with the new H616 SoC. It
> comes with the following features:
>   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
>   - 512MiB/1GiB DDR3 DRAM
>   - AXP305 PMIC
>   - Raspberry-Pi-1 compatible GPIO header
>   - extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
>   - 1 USB 2.0 host port
>   - 1 USB 2.0 type C port (power supply + OTG)
>   - MicroSD slot
>   - on-board 2MiB bootable SPI NOR flash
>   - 1Gbps Ethernet port (via RTL8211F PHY)
>   - micro-HDMI port
>   - (yet) unsupported Allwinner WiFi/BT chip
> 
> Add the devicetree file describing the currently supported features.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
