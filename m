Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E175AC0F3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiICS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiICS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:56:49 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7ED52DE1;
        Sat,  3 Sep 2022 11:56:46 -0700 (PDT)
Date:   Sat, 03 Sep 2022 18:56:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1662231404; x=1662490604;
        bh=aPBCTEbI6iwgcVUZvF06LjZy+eN7W1HsRypeG7AB8bM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ST7bnIf7OLpnhGiuvib3kdbTrPiCD/j+JT93OyuT6Hx4ZoS05S+c6ys9Gx9Yy+Sv/
         FxhgXmTSXWx2qwLha1UkdtkwkAAR95LEg6qiZMHNeUKp4AspBQ3eqT46vVNba8RwSS
         FFNQ++oo1WcAnMVriENySbRLiuejmZAasP4JjBb8=
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v2 2/9] dt-bindings: firmware: document Qualcomm SM6115 SCM
Message-ID: <34a64393-1231-325d-5fcf-b326949c6458@connolly.tech>
In-Reply-To: <20220903174150.3566935-3-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com> <20220903174150.3566935-3-iskren.chernev@gmail.com>
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
> Document the compatible for Qualcomm  SM6115 SCM.
>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/D=
ocumentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 9fdeee07702f..c5b76c9f7ad0 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -44,6 +44,7 @@ properties:
>             - qcom,scm-sdm845
>             - qcom,scm-sdx55
>             - qcom,scm-sdx65
> +          - qcom,scm-sm6115
>             - qcom,scm-sm6125
>             - qcom,scm-sm6350
>             - qcom,scm-sm8150
> --
> 2.37.2
>

--
Kind Regards,
Caleb

