Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B744AB71A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiBGJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349805AbiBGJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:00:52 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E4CC043181;
        Mon,  7 Feb 2022 01:00:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 31E9E58018B;
        Mon,  7 Feb 2022 04:00:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 04:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=LlmYXeK2fC2UdJ
        0/MsJYEQrTJxKAOlqRD+axqJoLm3I=; b=fm5k1dGy1PeO02r1/TlAHJNiPhTGWE
        5Iz8JgwP01EUiauX3iYERT0YPoAlmiNhvh3zHn48pU5ZR7i50wdIqMi2TqDT6zwS
        hSIARHAQBic+WMq594pw+r1hdkJH4foiJ/v+za5CYtlxOHDk/rYnjJ62V9U2/ukk
        R3ewIPTVnznf+fpkdJ/DJZMLouLKFrfDOanqmzwMjhr8CK/tWD65z3sO/CnpyEKO
        fldsssTSz1jV+UAAVeaAblRuLVmN8hZUZ0VnWsFFq27v9+RX3ZCcaLoT52X32/KW
        UatXs76ZJTfxBlcK/Hc3RYGiYWUjHrc7YN7Ksm1/YyQZN9WQa13550lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=LlmYXeK2fC2UdJ0/MsJYEQrTJxKAOlqRD+axqJoLm
        3I=; b=adMfYwoaQ/+F0Adw54uNBbogBqWCNOpwNoQ9vM7kPwDVtliGcE/0sJW5T
        GSkPw8fKguIjcu3WS6SwiePhrbtPoapSJKd278hw9l2tAE/4SvgN9Kgdr6/zer0p
        A6PTNSUunpLYmjfPgmCuXdOvtVnzckBrHJs1f6PbP1WMrBR2ZJGyNx4VBsi4cBzm
        eWcn6BqdpcHjNov6rWoYYhZfXlzkoFhtDP7lZuQR/ySkBo6afBQJYlWgJOg6lPma
        VaQ5opIv7rqfHGUpqYb3c0/pWUsLWRQ8cZf27BEA9hvk78RevuqoSUyunTfG2SVC
        7fHlzXXpXiu1lF9InYRRu7WoiVb8A==
X-ME-Sender: <xms:wt8AYvpYzksObIQVOstgSzXW_j7vTFG4na98z1tyat7OAlBQVMWVAg>
    <xme:wt8AYpqaOsWE4i3N_9ZNkIZLPgSfeoklFLKzjhLbeUSB542-49RtnhvuFn84nDMCD
    K-d_uqCQ0a0HTq-2Mw>
X-ME-Received: <xmr:wt8AYsOHMqrHXEo3mqTx-DPOHWLrrIzBhHpR67W2xZSY-b0oBFO7OgzQ1heB2KGO1LjxAipzrsiiEftZuklxmByAIK4CMiZ884aFoCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wt8AYi5sJGTaHdSyOFBTpB5GBdyKWj7W4q2Qx6G4ow6j7a3Ngk9u8w>
    <xmx:wt8AYu4nXzcilGfFlbSU8FeohOslwB1MibQ6UJwKse6CAHxnRQI0MA>
    <xmx:wt8AYqhwssUi8JB6SACMjFKALBnoIooSAjNSWdHq-vI-PfVYgLIm0Q>
    <xmx:wt8AYtQUyHpHBiDSq0K7o6o4idoY_DwsL7FYrbumcamqnkqPLVPQxg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:00:49 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: (subset) [PATCH v3 5/6] clk: sunxi-ng: Add support for the sun6i RTC clocks
Date:   Mon,  7 Feb 2022 10:00:45 +0100
Message-Id: <164422443570.21572.13511859513410998733.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203021736.13434-6-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org> <20220203021736.13434-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 20:17:35 -0600, Samuel Holland wrote:
> The RTC power domain in sun6i and newer SoCs manages the 16 MHz RC
> oscillator (called "IOSC" or "osc16M") and the optional 32 kHz crystal
> oscillator (called "LOSC" or "osc32k"). Starting with the H6, this power
> domain also handles the 24 MHz DCXO (called variously "HOSC", "dcxo24M",
> or "osc24M") as well. The H6 also adds a calibration circuit for IOSC.
> 
> Later SoCs introduce further variations on the design:
>  - H616 adds an additional mux for the 32 kHz fanout source.
>  - R329 adds an additional mux for the RTC timekeeping clock, a clock
>    for the SPI bus between power domains inside the RTC, and removes the
>    IOSC calibration functionality.
> 
> [...]

Applied to local tree (sunxi/clk-for-5.18).

Thanks!
Maxime
