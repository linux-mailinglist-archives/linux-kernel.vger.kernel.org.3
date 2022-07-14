Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64696575091
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiGNOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiGNOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:15:52 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723E643D8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:15:50 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9FEB23F72A;
        Thu, 14 Jul 2022 16:15:47 +0200 (CEST)
Date:   Thu, 14 Jul 2022 16:15:45 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: Add device tree for Sony Xperia
 1 IV
Message-ID: <20220714141545.2z65355wgjuqeuwl@SoMainline.org>
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
 <20220714123406.1919836-5-konrad.dybcio@somainline.org>
 <ef935a6f-77a2-5c9a-2cbc-0b0192aee56b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef935a6f-77a2-5c9a-2cbc-0b0192aee56b@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-14 14:51:36, AngeloGioacchino Del Regno wrote:
[..]
> > +&i2c14 {
> > +	clock-frequency = <1000000>;
> > +	status = "okay";
> > +
> > +	cs35l41_l: speaker-amp@40 {
> 
> What about an even more generic audio-amplifier@40 ?

If I understood Krzystof's comment correctly the "generic name" request
is to describe in human terms what kind of device this is and perhaps
what it is used for.  Since it is specifically driving a physical
speaker on this phone, carrying the word "speaker" in the name is better
than "audio", IMO.

I'm indifferent as to whether amp is written out as amplifier.

- Marijn

> > +		compatible = "cirrus,cs35l41";
> > +		reg = <0x40>;
> > +		interrupt-parent = <&tlmm>;
> > +		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
> > +		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
> > +		cirrus,boost-peak-milliamp = <4000>;
> > +		cirrus,boost-ind-nanohenry = <1000>;
> > +		cirrus,boost-cap-microfarad = <15>;
> > +		cirrus,gpio2-src-select = <2>;
> > +		cirrus,gpio2-output-enable;
> > +		cirrus,asp-sdout-hiz = <3>;
> > +		#sound-dai-cells = <1>;
> > +	};
> > +
> > +	cs35l41_r: speaker-amp@41 {
> > +		compatible = "cirrus,cs35l41";
> > +		reg = <0x41>;
> > +		interrupt-parent = <&tlmm>;
> > +		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
> > +		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
> > +		cirrus,boost-peak-milliamp = <4000>;
> > +		cirrus,boost-ind-nanohenry = <1000>;
> > +		cirrus,boost-cap-microfarad = <15>;
> > +		cirrus,gpio2-src-select = <2>;
> > +		cirrus,gpio2-output-enable;
> > +		cirrus,asp-sdout-hiz = <3>;
> > +		#sound-dai-cells = <1>;
> > +	};
> > +};
> > +
