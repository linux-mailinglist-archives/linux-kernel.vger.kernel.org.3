Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB445AC0FA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiICS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiICS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:58:31 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83C57234
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 11:58:29 -0700 (PDT)
Date:   Sat, 03 Sep 2022 18:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1662231508; x=1662490708;
        bh=oC3eNokSVQM0L9hwWw0OMbDDF2IWxQAIitsSbaCemuI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=fZAWTroNgNBWHdInKCyNi+VIh4Cqj0CCJDMwXgAujB990cH0hAI6nfG/ReRQsaM26
         ViYox8+mY5fkOWRPZZbOYTgyxBc3ShD/JQ1IH6A2/FjAtp87MKbPvzRlEZi7Tu3z5J
         /sUFXrR6IQ1xBdIkijONNDpjWAjeM933lzdhVq7c=
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
Message-ID: <14c7bd55-f462-5599-8280-e9b6495c00cd@connolly.tech>
In-Reply-To: <20220903174150.3566935-3-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com> <20220903174150.3566935-3-iskren.chernev@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2022 19:56, Caleb Connolly wrote:
>
>
> On 03/09/2022 18:41, Iskren Chernev wrote:
>> Document the compatible for Qualcomm=C2=A0 SM6115 SCM.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Nope, wrong email, please disregard and use

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
>> ---
>> =C2=A0 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index 9fdeee07702f..c5b76c9f7ad0 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -44,6 +44,7 @@ properties:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qco=
m,scm-sdm845
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qco=
m,scm-sdx55
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qco=
m,scm-sdx65
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qcom,scm-sm611=
5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qco=
m,scm-sm6125
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qco=
m,scm-sm6350
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qco=
m,scm-sm8150
>> --
>> 2.37.2
>>
>

--
Kind Regards,
Caleb

