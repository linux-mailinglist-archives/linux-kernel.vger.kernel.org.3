Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46150CDC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiDWVer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiDWVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:34:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF98B42DD;
        Sat, 23 Apr 2022 14:31:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 807475C00C3;
        Sat, 23 Apr 2022 17:31:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 23 Apr 2022 17:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650749506; x=
        1650835906; bh=Dl4Gnii1lgQ3CuqDwJm6Ada66ZIg7WGp0sT4NijET4g=; b=a
        /iCwS1IcycZQFMyCZJPXqJBoDi8knnuTpxOkS0QNqrVgcZazrMU6me+qzJsNLN0g
        6ymzf63HBnh7sRHkkTMA88xBNlbJp2eINv+C1qdAzTJmyAIdjEp1vAKnmchLPkil
        7st52ELLVULgHo5NZu0PHf1D2m5D9pbJ7e/OBbri412iMIjDydqzPDhnCeBy3Fye
        kCvbHQFW69gIuWFYSw66bdUHIBG4o6aYlWQFY1U2H15/8J7uwBVLU1m1T8NCuJKi
        G9Dynumf2p4uBH151PT1+I377f5IJWocFXWCaCQakir9hZF8wd9p5addhVzPeokj
        gGoXKrbgPzq1+X+ZCdTJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650749506; x=1650835906; bh=Dl4Gnii1lgQ3C
        uqDwJm6Ada66ZIg7WGp0sT4NijET4g=; b=ZuZ36IQxtV8ZTl/R4Zxd9maMIyvZ7
        EXZAaoMxtOVMr9V5aHrxcgRuwmlJQbcCcwx3K4a1sr2EkeR+W1XZ9GpdfP/iXJDq
        e8CuChhJWYNmZs/1NJ74bk/gixMYVqePKDZJmTXKqhhLdLpN5YNGPklgAs7CFgx3
        jecvL+ZdgsOSgYcSClc+z8q87fCGYEuDXL7vrPVdQ2X1TJ+/+cppa66LiWketeJi
        k3oCUKbNyLr/KL82ie+ADOJA0phfY8ubidGMllxE4V2+ocruJN7Pij+fIX7ShnPR
        zYroca46yzjTtzkEhaaEsvEOLTDU68LmIcO+fKJqNpgHCISQSrcE8ws+g==
X-ME-Sender: <xms:QnBkYoicMMF3JgAgfrdn_RWGLmH7gR1nKZRGdGDeycKhfLTvZjtiwA>
    <xme:QnBkYhDyqnPzxNlHo11Xx2JA3aLf5e0iyTycF0-em6GlpRm8MHKYOr_lkMq7Ly5Q-
    HMCBoRwf3MTLegI4Q>
X-ME-Received: <xmr:QnBkYgHJY9NjHB6VYlM_I7nJ0O2SKqlUYMRooXl7oOFfgLDL_DeFGTBhIst_aFnZtOPLTJhnIu-B9Vd9tUetI_jS1OHyJ2XvDCPryJqyX0xhfNl_rSCU-fvKIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeelteejffdvgeehkedtkeevueeuteffteffhedufeeujedvudef
    udetieeijeevleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:QnBkYpTn4hefkply-JJGXOGQ47ounA_l8RhQ2Ti16tsud_3Lj_9_RA>
    <xmx:QnBkYlxWXxhTnheZtbYTuljqn7ym4FAAmMzXMKlFNf5Mi8zKexIk6g>
    <xmx:QnBkYn4J5e2rIiMkDK4zCY_c3ewmqKyBCWTXVFkkce3MW6QvM6tMPg>
    <xmx:QnBkYqo3-CBV_-lIBsd-zKdGypplFiTuy9tbwss2TlXeXstM_NKMNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 17:31:45 -0400 (EDT)
Subject: Re: [PATCH 03/12] pinctrl: sunxi: add support for R329 R-PIO pin
 controller
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB247251E54E05FE4EB315B4C7BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <5365b3af-a8c2-6f20-3ac1-6a4483ae2a52@sholland.org>
Date:   Sat, 23 Apr 2022 16:31:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB247251E54E05FE4EB315B4C7BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R320 SoC has a pin controller in the CPUS power domain.

This should be "R329". Also see my comments on the previous version, which still
apply:

https://lore.kernel.org/linux-sunxi/e9937a23-8a8a-ebec-0a44-0d15a06b7e89@sholland.org/

Regards,
Samuel
