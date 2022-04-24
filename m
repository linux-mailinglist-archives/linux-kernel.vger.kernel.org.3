Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E28150CE80
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiDXCj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiDXCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:39:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794B55209;
        Sat, 23 Apr 2022 19:36:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D7A075C00DE;
        Sat, 23 Apr 2022 22:36:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 23 Apr 2022 22:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650767816; x=
        1650854216; bh=zZVrArUX7/OaFFH/wPngT85tNgxOKdzgV6wTwRqKWk4=; b=m
        wEaNTBnpp9NKrBE4dST+9bkdRqYHAMfsQ0FVn9Kl1cZMXeZ5fotkfayou6yaByhH
        xT8eusS/A8+A4XheeJFRP54KzwkuXPyBRyMjSBbHGy0gj8tJU3vBYpV3fRwMf47l
        UnymMquQk562AHhGyOJYnXLVqlbyuayHKdzLKnhuqg7DSwxCpdyA2ozCKQRAx0vr
        3RO7/IgHq/XyWFvd5ZtFwxjeKwqn9RK4hGSqW19XBHuK9vg9gW2WsvDNiZ0oJSIj
        d8SXRXoxzPJOFrIZyH8AZUpdzSBIGATVCysYSzrz4cEMrLUpqc9cTXeVZZwpIgO5
        xDiv+Md9CF3rLxtdnrCUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650767816; x=1650854216; bh=zZVrArUX7/OaF
        FH/wPngT85tNgxOKdzgV6wTwRqKWk4=; b=Lamj/qzwZkXd6cq59iJfc4jl7ySkR
        coGNhuAw33P5BfD0Nxe4LqT8CfBawMGd/at3nyGsbt0YdX48VLUjNUpkhI3IBG5Q
        eoj1VrOUTYX6npIvQCmem2ydq8olh+RKbEG7lMsJGr65CQ1QuanEGN0d1XJni+9V
        rN4amNWdxvQOdmxDE2PsWjjxd2PBw1lF23r9gB7qOzRi5Z6rXuG4L2wsO8ahW1Wl
        kLkBbHCuR1cAJ5uupnGBPnmov7dUQwg4V3qNdIEPXPMyO2W3Gl12HER35hc7AAma
        fsTSYWnoadeRdKw5ilDmN2j0qIvHdwe1aesDE/4n4xA5OBBkBP6zb+3Tg==
X-ME-Sender: <xms:yLdkYpbCcdhONFRHWbpNC-rJ6_DMl8wOP0waQFSgSoxpsYQM9udUQw>
    <xme:yLdkYga6gBuzMsilUpBSMjHvRUIvV6-kjzsaBJSBACVaq9d73EyYHziBR6ZzdctVe
    w1vJB7aQ-nQ3kHdNQ>
X-ME-Received: <xmr:yLdkYr_w2AX8Nm3gwgSM-Jo1CI__sYM8_YZrVpSfDQWT4O1mBPfyeA8PwJb2emp4MNA1cx1dkNOc0xKUi7K-7As8J38sECJErkSHpjKpuPuE8P4uIyipC991Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:yLdkYnqHoTzXs1efdYQSauSxeT-PRfbK9NFepSNMsfyXvp1pCjsvkw>
    <xmx:yLdkYkoPOt3V_vN_JT4V1jy1JnPHRIJ1hdzTnYO8bLP6uWfvS3RtJA>
    <xmx:yLdkYtSakyAOWgB6Awy6ba6huH7_cTo2DxBxZPMsk4S6-excRi7V1g>
    <xmx:yLdkYhgIy93qsDugQWer7kPF1bt6Fow7Mu6XIPmrrRfjozW83lN30w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 22:36:56 -0400 (EDT)
Subject: Re: [PATCH 10/12] arm64: allwinner: dts: add DTSI file for R329 SoC
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
 <BYAPR20MB247209BA9B07425FADC82A84BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9351b4f6-dc60-4a57-2265-f17724f89e9e@sholland.org>
Date:   Sat, 23 Apr 2022 21:36:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB247209BA9B07425FADC82A84BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
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
> Allwinner R329 is a new SoC focused on smart audio devices.
> 
> Add a DTSI file for it.

Please make sure your devicetree passes `make dtbs_check`. There are some errors
regarding the watchdog, CCU, and pinctrl.

Regards,
Samuel
