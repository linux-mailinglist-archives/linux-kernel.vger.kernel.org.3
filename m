Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DE59CF38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiHWDNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiHWDNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:13:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34357E012;
        Mon, 22 Aug 2022 20:13:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EE885C0088;
        Mon, 22 Aug 2022 23:13:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Aug 2022 23:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661224424; x=
        1661310824; bh=GC4pKpm2AJfeKp8/quk8AaX41Q1qRM9JRH1j8mfqckk=; b=C
        UZj3iQzTZBJ9Z7nv/v6MalPY39Bj9LygcjA1X89qKB0pux8PEp9snloJbPTAQ+aQ
        b7HG6imcyHvqfOSwssbTdhtydLnuDvGPhXRCb1MH7HELKi3A3NUjQHwmmAuAY8e0
        R6m2w+8BZr/gsl5mTw7SghtlhrtwYTrbbnq1RKInd+lsR9BjIG91VD/TtHiCn2UN
        k5+iXlqNCE95kM7WvByGrH6qt9YmFr3yUMhdsntfAsgS7RGjM0EzzImy1JlvR1+2
        Ttv6I35L0KAcpeFy0bq7I875DEqnGk9oHLQ8gOlFXRokX6lzArENv14G1nLeuz5c
        AGh0G4w7LKFahMeJgtiiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661224424; x=
        1661310824; bh=GC4pKpm2AJfeKp8/quk8AaX41Q1qRM9JRH1j8mfqckk=; b=P
        Wbr1oHzUh5GcmhsSli0MVJpz7Bp//g/4DJWKDvqdKpF4OxG2rrL4pPNwS/64rZW2
        TMk0ZTfZzKEO1fVMf/IC1L9En+HEAEvK2Qj0POzdZyCQq4avOmuQTpIAhYR8tDZA
        OxarMuHLxKXFy1LeQ7BjD0t77XN97yHXwRJYihJvZozGz2ucuReCiTuIP2pIuTD4
        b6CDK7IvHLpWIdlv2qkdy4KuI93vc0MT3nhn6mvypyixb0FW5DSdWZoEolnCYQfR
        lq4K2XkgiBSDTQ1aGuDKE+RSyMngDWPK7fPulYljgVRK80ZHBm+sd2w6SIHhRKfL
        AP5/GQIFO24fw77wVsiEw==
X-ME-Sender: <xms:6EUEY4cIYLALYhmblcQnaE-QX4Vp61vStd5Ev-kS_6rsxL1FlhsYYw>
    <xme:6EUEY6MH95YLUfQz59ha4qLHiO09-am4khNukR8_0aFBWTSNOXMB5j7YkO7wIKNWv
    Eh4j9FAx-wsADGa4A>
X-ME-Received: <xmr:6EUEY5gKr5PrI2bYNEIN3jqA00dq1YHQg3ufJ4Kiz0DxHrMPQxeh6D5yGzOx6ieYnOeUcwb_eA3xWIPmLCpgMEJW5rmtXUclgwbdV4vrLtN-NnNepgVTLyuqnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeikedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6EUEY99-D_6poQMBvmT4KzCxyikDz2L2Okxab0_IJZVAAJjAH3kl0Q>
    <xmx:6EUEY0sjbayWoBdCKt9juof8ld3jhgLPYBvS2A1HaeCaFnSdxOakjA>
    <xmx:6EUEY0EFOIy5LWtSg2NYdQrEWE0cYPyBvYwkaRdmrpytcHq98WtHcA>
    <xmx:6EUEY5_ADcsp8LN37J8mPWyN7OHy9j5N1EG-wV0UXkkG3uAtb4VZ4A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Aug 2022 23:13:43 -0400 (EDT)
Subject: Re: [PATCH v2 3/4] arm64: dts: allwinner: h6: Add GPU OPP table
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220821173051.155038-1-peron.clem@gmail.com>
 <20220821173051.155038-4-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <873b8e79-9f68-027a-5c46-153c6a9e62b1@sholland.org>
Date:   Mon, 22 Aug 2022 22:13:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220821173051.155038-4-peron.clem@gmail.com>
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
> Add an Operating Performance Points table for the GPU to
> enable Dynamic Voltage & Frequency Scaling on the H6.
> 
> The voltage range is set with minival voltage set to the target
> and the maximal voltage set to 1.2V. This allow DVFS framework to
> work properly on board with fixed regulator.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> new file mode 100644
> index 000000000000..a66204243515
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2022 Clément Péron <peron.clem@gmail.com>
> +
> +/ {
> +	gpu_opp_table: gpu-opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp@216000000 {

Please fix the `make dtbs_check` warnings:

arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dtb: gpu-opp-table:
$nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
        From schema: Documentation/devicetree/bindings/opp/opp-v2.yaml
arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dtb: gpu-opp-table:
Unevaluated properties are not allowed ('opp@216000000', 'opp@264000000',
'opp@312000000', 'opp@336000000', 'opp@360000000', 'opp@384000000',
'opp@408000000', 'opp@420000000', 'opp@432000000', 'opp@456000000',
'opp@504000000', 'opp@540000000', 'opp@576000000', 'opp@624000000',
'opp@756000000' were unexpected)
        From schema: Documentation/devicetree/bindings/opp/opp-v2.yaml

Regards,
Samuel
