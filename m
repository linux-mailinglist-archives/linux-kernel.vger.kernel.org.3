Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B165ADA6D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiIEUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiIEUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:53:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2054E633;
        Mon,  5 Sep 2022 13:53:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 380B65C00FC;
        Mon,  5 Sep 2022 16:53:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Sep 2022 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662411182; x=1662497582; bh=/E+mnHRRBW
        yX/W5H9Rh/7o3lZ0qxrudPegg0jcNTaaQ=; b=lekK+370pndbyQoVOuQNWcC7cM
        lz7iJJLPFEyOkxqodeUvaG+AMjbotls6QlZJ9XDnckpsf52aOUDrS5qQbxViJ6XL
        2LD17ts4571ZOcnJb44QXJotFIf/HwJsdNGe6l4QsBliDDvJnzWbSc6uItf9/A96
        ADZSzu0PN5OfBBxRpI8JhH74K6P/pvB2toNnIGevY2Yv2mmULs/1r467/e3AWqeA
        pilzVgBllKniVFljTToqzD8CoCWmR7TabfIrx6Lwy3klbxkdCw6UP5LuozUtxqeJ
        dPkE48e+tVZTevDt23wtA5fMFIjhbPhmCc6bI1FY2RzltTGb7/b8+6zL4MwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662411182; x=
        1662497582; bh=/E+mnHRRBWyX/W5H9Rh/7o3lZ0qxrudPegg0jcNTaaQ=; b=L
        c7Dp+hwgWOJJLffBHym2b8HyncaDXlQyd1H9Iybyyou7Eozc5J9k/8LvOdlAL1Mp
        su+XaOx8sTowjDBaXD7n2ZPpKvy/W9DiDghaC/LYI5/lIsGI/Ca1ZaS8aD9n7cbY
        kRcJLGIeGpVULG28IxdfMErJrFNBtBF5Uw3lRhiHp7yr7Oh0hLw92N30fOyCuuFk
        btEfChtYZN0JTVC6JkdeaFCo0PGFJsm6a6SlZao7PMHKkY28BOSn7X6G5QGAxmIo
        utMQ7pzOMck7P57ekKwkkJM9q/sJtIhq2BUKkL9ZO8Dum33b+oLcJomCgIHFnfok
        SFlXP9QC0GzZ9vXt42SWA==
X-ME-Sender: <xms:rGEWY6qmZAZFohihjKT2p9uBpVh13saLlHHn9ol4BrDfT4WsTR3RvQ>
    <xme:rGEWY4rORX8s_G7VtsEXImBo7TCmqrvwv72h35VvajgkgdjFkSmMVc9leD_s43dVr
    DsMrKa50XPHvzpnyA>
X-ME-Received: <xmr:rGEWY_NE4fI3-Ntko7eznigt-i-cMM_1PrRma_sF-8hl_DiWkm1CAmLZ-BiAyrevKRvh5081EyASF8OeAPsnwJ0N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepvfho
    mhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruh
    hkqeenucggtffrrghtthgvrhhnpeekueeijeefueffkeekteegleevjeeiteehiedvtdej
    iedvvdelvdffvddvtdeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:rGEWY54ZxFy6uKNnZ2tzcFZuOfc_IBmxa3VXA4wVXHF_vyJEOV3f5w>
    <xmx:rGEWY56gboyxkZkWoQfx__ePNsm_Kfo_9ujRo57Am8Vp5Ka7mB81Ig>
    <xmx:rGEWY5jz9sX-9MWwTVHemnk8HATmmyqA_EEEvuUBFjKeX545qScGug>
    <xmx:rmEWY4S0VP1l11CI8IY2nv1G_fgdZrvmOb4AMYYX5GVi8-baPKJTKw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 16:52:57 -0400 (EDT)
Message-ID: <00406e34-dee8-ba68-f2dd-c0c0634b42f6@tom-fitzhenry.me.uk>
Date:   Tue, 6 Sep 2022 06:52:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card controller probe on
 Pinephone Pro
To:     Ondrej Jirman <megi@xff.cz>, linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martijn Braam <martijn@brixit.nl>,
        Caleb Connolly <kc@postmarketos.org>,
        Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220904233652.3197885-1-megi@xff.cz>
Content-Language: en-US
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220904233652.3197885-1-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 09:36, Ondrej Jirman wrote:
> Voltage constraints on vccio_sd are invalid. They don't match the voltages
> that LDO9 can generate, and this causes rk808-regulator driver to fail
> to probe with -EINVAL when it tries to apply the constraints during boot.

On most boots, the SD card probe succeeds, and is able to be mounted.

On some boots, however, I observe this bug with error message:

vccio_sd: failed to apply 3150000-3150000uV constraint: -EINVAL

> 
> Fix the constraints to something that LDO9 can be actually configured for.
> 
> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Reviewed-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
