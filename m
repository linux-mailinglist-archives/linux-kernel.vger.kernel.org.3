Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636456CA93
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGIQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGIQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:20:01 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73118474E0;
        Sat,  9 Jul 2022 09:19:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1D89F32009C4;
        Sat,  9 Jul 2022 12:19:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Jul 2022 12:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657383597; x=
        1657469997; bh=ckAQH/TS15UUvt0fzPakXv/P6BCKlKnB5ngi4InfzRM=; b=H
        sf/6+mFlfo3Nv3bFTg/p4fIjH+zMWw7QNyvZgiJkxPE6ZQ05m3I02pnjSopQIJre
        Cu3Vwb6hNdoLouPEClGyaKhbml1nitFqM7G7Pdy0x7XMiae8cVGtjmJfauVezmNS
        iM/S/CCpUvPmHqSXKCSARgSwjugtQw/vn8d1+sX/tGzbhcI+cxfioYrMUV4cb9WC
        rlF0wcU2QvZiFj9iVAk1UUA40XG6/wtxxb1cAFmj/f8jOyE6DqkBoYjVMhycTJtp
        cZGh/knaQ/PWYPsl/flDYdjbHiQVstb6QJh1nnScTal4Rqi8E8Wi4y/j1ORjxblJ
        2dvAHRj9c8fG4okUGnU5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657383597; x=
        1657469997; bh=ckAQH/TS15UUvt0fzPakXv/P6BCKlKnB5ngi4InfzRM=; b=Y
        ZNvoxRtlKUEpV+I+M34vK9lC8JZk7SNPuHgNnx8+LE+IXAUICZFTEy5zOoBK7Sbr
        ZvFWu4T3przVgh92klNeIjC8JsguUiAWXfsyQQBxndk3+PEm+jKfplV0Hh1LnJE7
        4qBrOWjNG9IA5rYX7T5tPsCvwUvIpK3vPzo02LjF4NJo17iUwEjf5b3vR/qJezOF
        aIPzWZ46iLOpnPPI6SFh3rWNyVrn1iLLleBgq2LgP1hB2pjnbs61Vm3GuDiGqQtC
        UXotPh/pP8WKRBv+POwZzkjuFUEMUs+JWWHyprre0fw3d3r5TkfAUBpI0BgPyYWI
        iHVcvvJdpl27598VyLZaQ==
X-ME-Sender: <xms:rarJYoNqDxQ0WyToQLQo08NnKclQLnyP0VI5FLKZf4nV4skyl_ktGg>
    <xme:rarJYu8n_HaLIPbBNYOr1wDGjbSMLD-E1iww1s7_Ji_X_tMFGKp8_y9-vZqMPpNU3
    b3jRiWdghSz5MrhLA>
X-ME-Received: <xmr:rarJYvQS8j78cZo7ZEG6MaHC4W2h482P_4YEtD_eBla9_Cm-l2djBJTAMtLMQTOXFQAT9baXuvgV4ktPZeo48FSapoKysff_CFE0f28kEi5J3384m9K3W_Ou3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:rarJYgu27J_fDR8PtK5XHPl3PnniJZktT_bVPmHgNrLw2eCFiTmnWQ>
    <xmx:rarJYgcpv1skc1Wr-UiwxcZbxmKUr31RxDbFvAScf2UQA0_NdMvuoA>
    <xmx:rarJYk1emzR2ebmt8DQcbD-thL0W5PYFbQxGIxCDrqkp6qtIwzg-KQ>
    <xmx:rarJYnyg2y1r0_4WFLsr82V9xaD4qwL4OcVXzuGcmLKlj2KUf-HEvQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Jul 2022 12:19:57 -0400 (EDT)
Subject: Re: [PATCH v13 3/7] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220708105235.3983266-1-andre.przywara@arm.com>
 <20220708105235.3983266-4-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b82dbd31-3b73-41e3-7017-dedd65273857@sholland.org>
Date:   Sat, 9 Jul 2022 11:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220708105235.3983266-4-andre.przywara@arm.com>
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
> This (relatively) new SoC is similar to the H6, but drops the (broken)
> PCIe support and the USB 3.0 controller. It also gets the management
> controller removed, which in turn removes *some*, but not all of the
> devices formerly dedicated to the ARISC (CPUS).
> And while there is still the extra sunxi interrupt controller, the
> package lacks the corresponding NMI pin, so no interrupts for the PMIC.
> 
> The reserved memory node is actually handled by Trusted Firmware now,
> but U-Boot fails to propagate this to a separately loaded DTB, so we
> keep it in here for now, until U-Boot learns to do this properly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Thanks Andre for persisting with this series!

Other than the EMAC0 compatible string, which will need to change along with the
binding:

Reviewed-by: Samuel Holland <samuel@sholland.org>
