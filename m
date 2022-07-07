Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0F569A87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiGGGal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiGGGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:30:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708C10559;
        Wed,  6 Jul 2022 23:30:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 590775C00EA;
        Thu,  7 Jul 2022 02:30:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Jul 2022 02:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657175434; x=
        1657261834; bh=TJIn1V9ic4c6ApTfvv5dVrRd3t/GgxV3Sqp0Eq+6r2g=; b=c
        MS6GOy0bVkuopuTWs3E68kSB8PBsKg8ibPv3O84u5Sh0VeXirV2OjpPl55joEPVI
        WE53kOXPflazVfEgd8BbKerHq4/KseZZOPO+VJfL+A3ob1MbA0I5w5MSqEXFeYrl
        ydmcsZ2V7Scisq+aH2ZZ5f4mN2UiI0Ap5xnJxIud1qlN2gN4zan+fWkmLhPYctAE
        32TJBqvLB6Ejx+L2DY27g9L85fPdoMa4v4MsNB2ojr+k6SBzvdZi3Qh0gU0WwasT
        9FQcReC5HItTaEY9HczcXJI3AM1lfUM3n2EYaEwQFUyQAQC2z3LjsVzBjO8BQMQU
        emOBVIIz5UiGcw1FIvspQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657175434; x=
        1657261834; bh=TJIn1V9ic4c6ApTfvv5dVrRd3t/GgxV3Sqp0Eq+6r2g=; b=H
        jz8B7KLzbG2MiX/JJiPW0Ecv8YH9Fx+7bBEcpdtIFAJeOtRMStgSwhNJrJjeO7qA
        4ZNu2CGNf150HlgJ0fEAd0vVV+4azEPquXHaokXrbttlRvKwxVvW4hIptjREGrFe
        9kC+BdJ2bR4nfVI8mo4rQMlQk+ga4LGYGOxx9q0lb3XHdOXcjCXZqDCDjD47HKhL
        6ZZDoTpvoJ9+MrP1wRoHIQD8TuUOG4WefSVt0M+Z4GmEJngBAIjuGyDKTCSg1xVA
        DHE2q4h4zcGJXVCCAkCOEUSsquragbcZMm7pXCgrEQjmuYwBMbciYZhRXrTXOKWS
        Gw/iDGGEdnEMjJcJYWluQ==
X-ME-Sender: <xms:iX3GYtUbQ8sSCWKMsyk1ZiyCOdH1oc2iU4gzaybbpkZzD3j24n9QfA>
    <xme:iX3GYtlT5nx4ARJxb2hJwi0SI5vB0jPfmRbWiWCXf_MOUfOWrnjX_c-9G0GYBI5au
    RjPsb4OCEMYjgDEIQ>
X-ME-Received: <xmr:iX3GYpYB044yJcwFqElkFhRn_E92_-h3lZntpCMcUOD4Prci6mcf1Z6Bt_p2favjuf5svEuQLlyf1QEU6dVY3xeKYbIOTMak7MnvYg4gmwNApGyzXqZImPx-4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:iX3GYgXdbzLv5yFKKcNEbjuVMdxFf6HwoPgTbeokPRJV44xgHKq7ww>
    <xmx:iX3GYnldE02U6d-KTR5G7LE5l8ADzjA0YNOgZKirRFT3A6FuOAbpMQ>
    <xmx:iX3GYtcerNFQGAyI0Adpuo10lgp1O8s4iVjw-FnElFoLi_Ffn_NZFg>
    <xmx:in3GYp57PRmOH0nBgDQTexj1gKo512VSuiQiX8DXDGGn4tqse8dA8A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Jul 2022 02:30:33 -0400 (EDT)
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
To:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220428230933.15262-1-andre.przywara@arm.com>
 <22699277.6Emhk5qWAg@kista> <20220704225534.3e1a901a@slackpad.lan>
 <5278570.Sb9uPGUboI@kista>
 <20220706141655.15d2dd0e@donnerap.cambridge.arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <39537f95-2ed4-f526-5912-364c1c1ed512@sholland.org>
Date:   Thu, 7 Jul 2022 01:30:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220706141655.15d2dd0e@donnerap.cambridge.arm.com>
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

Hi Andre, Jernej,

On 7/6/22 8:16 AM, Andre Przywara wrote:
> so after seemingly having finished writing this email, I realised that
> this won't really help, as I think this diverts the discussion. And the
> problem has been around for a while, and won't probably be solved easily
> or quickly. I think we agree to disagree here, or we should admit that
> there are different approaches ("bundled firmware" vs. "UEFI"), so in the
> interest of not blocking the H616 series:
> 
> Shall I just keep the firmware node? This would work both ways, whereas
> dropping the node would impede the "bundled firmware" approach?

Let me try to sum up the relevant portion of my thoughts (and save the rest for
elsewhere):

The only reason to add the reserved-memory node is to support externally-loaded
DTBs. By adding the node, we are committing to support externally-loaded DTBs on
this SoC.

Upgrading the kernel is not allowed to break boot. If we support
externally-loaded DTBs, that rule extends to DTBs shipped with the kernel.

If we remove the reserved-memory node, the combination of old U-Boot + new
externally-loaded DTB will stop booting (the kernel version is irrelevant).
Therefore, if we add the node, we can never remove it, full stop.

I will (begrudgingly) accept that, as long as the node matches what TF-A
actually generates today. That means, please:
 - Drop the label and update the node name
 - Reduce the size to 256 KiB, matching (BL31_LIMIT - BL31_BASE)

Regards,
Samuel
