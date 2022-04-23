Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B787350CDD5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiDWVtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiDWVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:49:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABFB48320;
        Sat, 23 Apr 2022 14:46:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A19F55C0120;
        Sat, 23 Apr 2022 17:46:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 23 Apr 2022 17:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650750377; x=
        1650836777; bh=dHEjTHUFDvHxSW67Dq0IGibu2U4W+lozpqOMR2nEllw=; b=P
        JDLxMHO+ymIlLGjLjQphL5ypU1Akas9WHQQgLUn9iceCDIG5Q6W35nVtXSLjmScg
        OkNfPaStv0s7aYtcOWQgfXLjp6Ff/sB6cxte0hhe+Cpw4OCjcdp4Fc2DcX5hy4x6
        1wZ8QOXzlhq7bhppj8PYQIuS9INHyGyTdNtY0ZnUl1W3W0SgIohOBo5D18cgX7GK
        QSSLdmpVp1IpP99cSBG/m3D7L6IUoxcRRHJkYePR/OtTZlW3STw02UHULfiG+t3K
        YXKibzAY9IjyS01bstZ8vvrl2/r7JeNUNgVfs23RxvWd49AChFI8Q8d3noMA+tPJ
        N+KkkPcWAMDBTEiMIfWug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650750377; x=1650836777; bh=dHEjTHUFDvHxS
        W67Dq0IGibu2U4W+lozpqOMR2nEllw=; b=AquY4sIAEzHAe6DJdP6E6wZPUms7m
        GQ/zGhlyc9EMF0vH7mzEtJIi63jqNuIirU1P4eLsCtu0TghIFtEnmmqP+tTamoXU
        R6b5DjdbNjQGD2muny8iqpQ50xklFATSurAx/00wmSG5qxe1yTsZiiFZsA4P3myU
        SyGUhhBxYiqHMmOSIfBkDcehlz0fRNPCiaULnmfbMBN9ZNrCfxPSQhnlIKiPbnpD
        9AnO7qlJgrMJ2SBUhBaRJgZAbzR2sa3y8O/AogM8oe/33GO8auJWU6G2Ffxa66W+
        e/3fQfu6qjoOMlyX0lZzERW1xVCeIG0r95Sr+lUgTJ4B5wEGrWJntRS4w==
X-ME-Sender: <xms:qXNkYi-WQIbPeEmBojfz7uusuUgYBMLHEko7Vrp2ijjyPrVwQpiubQ>
    <xme:qXNkYitIuK3EHfUDP9ob5soedu9qsIf3VQfBpQlxtEFEVDXUAQ0-gChtL1l9KYpmU
    64QbQq0aWD7cvkb3g>
X-ME-Received: <xmr:qXNkYoC0UVGYtKogzxxTWuoBK4yMgx5oYqlopgV0ErBd01xmBE9frq7J-KVlrq9Cb2RFxc1ffY2UfwHKyHEHuica_WTqnpi5SbEpibAHXaUy4HI6TM-xxjPRlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:qXNkYqdG2LIe-b6h9i48nTfYURtSp8tYxFozgiyq_mkETfI05isIeA>
    <xmx:qXNkYnPjx6Wl4hfte4IMKmhxg0-uq8-odcQPMBFkAVsrqpPMEqAnbw>
    <xmx:qXNkYknGXxVitPENq7U0dij-96voGe9zxst0V_3t-4rc3l5g9ACz9Q>
    <xmx:qXNkYrnxjPGNeAxeLGMvMBR6M5xF3a54yZ43g1Do5tLL6ler0l2zqQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 17:46:16 -0400 (EDT)
Subject: Re: [PATCH 04/12] rtc: sun6i: add support for R329 RTC
To:     Icenowy Zheng <icenowy@aosc.io>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472C608678F3FAEDA7B7541BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8ae69c13-a619-62a2-1bf6-90a6c5d9dcf7@sholland.org>
Date:   Sat, 23 Apr 2022 16:46:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472C608678F3FAEDA7B7541BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
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

+RTC maintainers

On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 has a RTC with a similar time storage with H616 but a
> slightly different clock part.
> 
> As we have already handled the R329 RTC clocks in the CCU driver, add a
> compatible string to RTC driver to allow probing of the RTC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Samuel Holland <samuel@sholland.org>

> ---
>  drivers/rtc/rtc-sun6i.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 5b3e4da63406..522e28fb05c9 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -816,6 +816,8 @@ static const struct of_device_id sun6i_rtc_dt_ids[] = {
>  	{ .compatible = "allwinner,sun50i-h6-rtc" },
>  	{ .compatible = "allwinner,sun50i-h616-rtc",
>  		.data = (void *)RTC_LINEAR_DAY },
> +	{ .compatible = "allwinner,sun50i-r329-rtc",
> +		.data = (void *)RTC_LINEAR_DAY },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
> 

