Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA659CF36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiHWDJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiHWDIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:08:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4413DC2;
        Mon, 22 Aug 2022 20:07:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E2C65C0130;
        Mon, 22 Aug 2022 23:07:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Aug 2022 23:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661224034; x=
        1661310434; bh=LGz61TGMJw4eB4K1edx3Y0jE6fpIOCMFMqzcbFbb+4s=; b=0
        3GRcXBcM6whAkg4wrC6xHUSAX5fzIWR4YLs6tDxiZ4NKmvHC8EeKxJd92UxYgzGm
        HBvDD5idFIcyyrSAc/Rh+i2YmheOpqmFWao26W4/7GsUrdoqANuN1xEUFOfsggBP
        uHBiZ/kS9W8qARau8tyJlEYqeD1m6hBMbAA7Dtc56sh/kwNTkFiFkQkaQnZLBjaJ
        Mi7oP5UTIUVcl+fbg6VxiPGCrOia9/utO3cJ26XU5+NnYLG7iiT768jwXEXplpop
        U84ceKp5mf43inu6lSYOhHusI1uWbd0i3AqL5NbRnufAEs+IIfV+J3GUdSXHX9t9
        emXmQ11SnJjucdAEd1tMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661224034; x=
        1661310434; bh=LGz61TGMJw4eB4K1edx3Y0jE6fpIOCMFMqzcbFbb+4s=; b=y
        NZGT1yP4oTwzsKphPMf8kLo3Nh5wWmYuA4BXo3p65RQuAEkkiXA5fuhyPdbuoTFE
        1l55jlMun1Rr7hBuCtT+xktw+uDfZrYvxCmG9qXFk5kwvJ6mVN84HipEh/S+UAw9
        w+WPTXircOp6k2M8Uc55cAcDiDywyTBOzgE3yO886KOGN9purztsqIUg+cUnBzha
        RajOFVRm/Cs0BrXY5syeon+Wa5DbfZoxOftBCy7bzpRhx3rn7TOeEjMuNC9YHfPq
        ORDLSzZBADgQq0D6tmFW4fg5kEx1ipeRoUjaGVVCNjo29hTRySC6Nz17wiEbU0dR
        dMZ+KGWp3grEaS3J38mCw==
X-ME-Sender: <xms:YUQEY86ajBIkBtX2kcxoyZ9J8ZNU2lBtvnNWAi5EMMOOPG9A3PCflw>
    <xme:YUQEY94Z0dr54yhZqEMUfz0zj_d10-xsYxQ4XqKROy6DvG0sluSW2fL-MEzI4M601
    Xko6GVwE-bV1ZBYgg>
X-ME-Received: <xmr:YUQEY7fPTVxuMj5mVfXhktBftqCZY5qXLpdm1uRlflgIjDNQjebkwoFCgoRPj4SaPhU4oR2jHEfkug5sutbKNK2wXXN_ZNEFWXcQVRK_-oK_kWY6cv5UZmeiQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeikedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:YUQEYxJHV6kWpE6Z9A-DqsMoaevhrVFsEwXjiI5AV4UPHcjEgSZ49Q>
    <xmx:YUQEYwIz3-BmWn_uibdL40Sa8dtCpDIBhu3H6aRSTW-ObOTcgRygRQ>
    <xmx:YUQEYywgm4lmPS8SWjGimxIs7A0ITKBqj4KW_utJA0OSsiqjsrg_Xw>
    <xmx:YkQEY5rXTBxSXpWS_WFJGmYR_NCzAynSp-eHOhNKlnj-WHCynfDzLw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Aug 2022 23:07:13 -0400 (EDT)
Subject: Re: [PATCH v2 4/4] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220821173051.155038-1-peron.clem@gmail.com>
 <20220821173051.155038-5-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org>
Date:   Mon, 22 Aug 2022 22:07:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220821173051.155038-5-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 12:30 PM, Clément Péron wrote:
> Enable GPU OPP table for Beelink GS1
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 6249e9e02928..20fc0584d1c6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -5,6 +5,7 @@
>  
>  #include "sun50i-h6.dtsi"
>  #include "sun50i-h6-cpu-opp.dtsi"
> +#include "sun50i-h6-gpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> @@ -261,6 +262,7 @@ reg_dcdca: dcdca {
>  			};
>  
>  			reg_dcdcc: dcdcc {
> +				regulator-always-on;

Why is this necessary? This file already has:

&gpu {
	mali-supply = <&reg_dcdcc>;
	status = "okay";
};

So there is a consumer for this regulator.

Regards,
Samuel

>  				regulator-enable-ramp-delay = <32000>;
>  				regulator-min-microvolt = <810000>;
>  				regulator-max-microvolt = <1080000>;
> 

