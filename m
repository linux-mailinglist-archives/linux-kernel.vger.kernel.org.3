Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94335525F38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379037AbiEMJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379069AbiEMJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:26:21 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EAA5FB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:26:00 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 01CE13F4CB;
        Fri, 13 May 2022 11:25:52 +0200 (CEST)
Date:   Fri, 13 May 2022 11:25:51 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: qcom: Add PM6125 PMIC
Message-ID: <20220513092551.hvz5jvej57cgvavj@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
 <20220511220613.1015472-6-marijn.suijten@somainline.org>
 <7c7f7036-e3ad-c9db-2c31-749e2d01e83d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7f7036-e3ad-c9db-2c31-749e2d01e83d@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-13 10:24:04, Krzysztof Kozlowski wrote:
> On 12/05/2022 00:06, Marijn Suijten wrote:
> > This PMIC is commonly used on boards with an SM6125 SoC and looks very
> > similar in layout to the PM6150.
> > 
> > Downstream declares more nodes to be available, but these have been
> > omitted from this patch: the pwm/lpg block is unused on my reference
> > device making it impossible to test/validate, and the spmi-clkdiv does
> > not have a single device-tree binding using this driver yet, hence
> > inclusion is better postponed until ie. audio which uses these clocks is
> > brought up.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Two reviews on first patch... :)

Same story here, we review each-others patches in advance and it'd be
annoying to have them re-send their approval through the mailing list;
only for me/us to pick it up in a v2.

> > +
> > +	pmic@1 {
> > +		compatible = "qcom,pm6125", "qcom,spmi-pmic";
> > +		reg = <0x1 SPMI_USID>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> 
> No children, so this should not be needed, I think.

The size-cells or the entire node?  There's a PWM/LPG block here
according to downstream DT, but my device doesn't use it so I can't test
that it is valid.  I can add it anyway, presuming reviewers here have
the ability to validate it for me with a reference manual.

- Marijn
