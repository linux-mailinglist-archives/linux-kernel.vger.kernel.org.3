Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9239F5AC0FE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiICS7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiICS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:59:17 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD257253
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 11:59:15 -0700 (PDT)
Date:   Sat, 03 Sep 2022 18:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1662231554; x=1662490754;
        bh=9L+ya5D+HHVzJ5A4w7jqzlee5Frl26BuJPqFAGtXACA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=NImseukOYaGDkkChPfsbZ4Kqoa97NI/NWK49vmHM9uAxS5X1KB2OPK6TbxUz3TgYX
         fjvn8+Q5jrpGuACFMEwmBkfKUqVYdV9RjbMrJ/IW7twkJF3yGSmR+hs1DikYvRMWvT
         le3aZvPNKaEi7IjfqBdhAZIT6KflURlnT+P7W4Ec=
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v2 4/9] dt-bindings: pinctrl: qcom: sm6115: Add reserved ranges
Message-ID: <c54bf940-a9f2-44a3-b327-b9e4d779a910@connolly.tech>
In-Reply-To: <20220903174150.3566935-5-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com> <20220903174150.3566935-5-iskren.chernev@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2022 18:41, Iskren Chernev wrote:
> Ideally this and similar common properties will be inherited so you
> won't need to paste them in every pinctrl binding.
>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml        | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> index a7a2bb8bff46..d8443811767d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> @@ -49,6 +49,8 @@ properties:
>     gpio-ranges:
>       maxItems: 1
>
> +  gpio-reserved-ranges: true
> +
>     wakeup-parent: true
>
>   #PIN CONFIGURATION NODES
> --
> 2.37.2
>

--
Kind Regards,
Caleb

