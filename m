Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4559572A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiHPJy4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Aug 2022 05:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiHPJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:53:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37312AD9;
        Tue, 16 Aug 2022 02:12:17 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oNscI-0002ox-1h; Tue, 16 Aug 2022 11:12:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
Date:   Tue, 16 Aug 2022 11:12:05 +0200
Message-ID: <3881930.ZaRXLXkqSa@diego>
In-Reply-To: <5593349.DvuYhMxLoT@jernej-laptop>
References: <20220815050815.22340-1-samuel@sholland.org> <149eee7b-a9e9-94ad-1ab2-13812b541a8c@linaro.org> <5593349.DvuYhMxLoT@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. August 2022, 09:49:58 CEST schrieb Jernej Škrabec:
> Dne torek, 16. avgust 2022 ob 09:41:45 CEST je Krzysztof Kozlowski napisal(a):
> > On 15/08/2022 08:08, Samuel Holland wrote:
> > > +
> > > +	de: display-engine {
> > > +		compatible = "allwinner,sun20i-d1-display-engine";
> > > +		allwinner,pipelines = <&mixer0>, <&mixer1>;
> > > +		status = "disabled";
> > > +	};
> > > +
> > > +	osc24M: osc24M-clk {
> > 
> > lowercase
> > 
> > > +		compatible = "fixed-clock";
> > > +		clock-frequency = <24000000>;
> > 
> > This is a property of the board, not SoC.
> 
> SoC needs 24 MHz oscillator for correct operation, so each and every board has 
> it. Having it here simplifies board DT files.

I guess the oscillator is a separate component on each board, right?
And DT obvious is meant to describe the hardware - independently from
implementation-specific choices.

Starting to discuss which exceptions to allow then might lead to even more
exceptions.

Also having to look for a board-component in the soc dtsi also is surprising
if one gets to the party later on :-) .


