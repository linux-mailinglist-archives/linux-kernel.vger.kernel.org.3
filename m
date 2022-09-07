Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D15B0F33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiIGVdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIGVdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:33:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D283C1219
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:33:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so11160644otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date;
        bh=QscqM0nV84svG7WCGc8n2xoost3b0ICJjoMuYYPkgIg=;
        b=l97wHQLTtkoC2yyIythJfrgytAdirbzW+UXcePOcQqT8dD1nyb2Orof9p/7oMQ9ElD
         tGJZ8qoD+j4jh3drrCMeXTNRJZggeV2RWHeaZ0hG0dFTTMuK9JY6Tk3/+LD16B+21Pye
         TxaXPNmWr68NJFbOPfTIhJATk5usDAC2SYpEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QscqM0nV84svG7WCGc8n2xoost3b0ICJjoMuYYPkgIg=;
        b=tBrLngEUAaYuxkaXGvx0jrX+9Fwqvn4q3LXwsOeppbg3AftCY3u8hpxtWlk+BJcSyh
         mfVAjcutKjhvoTEXaQvwTFzhS2WaoVjbxgEi6kGeO4M5TogS6cahrhKwSiS6oBwSi9Bv
         CEZDZMJD5iEzlLEme61fkA6jnCWEuEv0QuU/viXOMKN17KkvHSXSErNJakO3LrD0zWLr
         lMzdhY0pT/YNwabB/Um/m/iJPSiRX2k6ye8UBwA4AZwV8A4vzwcAyz5SvcFoS0qv8YCv
         ROyYKT+ia/yHChscSK+38Xw7Q2DahxstvY9jmQFmoxIze09Rt7q81nwEEmV0WHEMcr0r
         u3kQ==
X-Gm-Message-State: ACgBeo2hVfJfVPr5cPEcSiLko5eUqVCtapkUtC2o2z+S1iFhx/s5r0WY
        5E6uwQQAurKrpSTUPpjv9TY9OXkQG4CTMDwMfue3ow==
X-Google-Smtp-Source: AA6agR6xMl6s69LJEe9/ANEpj86tS5Mf5dVXH93JXMx7uTBSPGstJb9qa0FXVFjAjOE1JVl+mNneubqBOO5h7W4c6Lw=
X-Received: by 2002:a9d:53cb:0:b0:637:1ddc:615c with SMTP id
 i11-20020a9d53cb000000b006371ddc615cmr2302282oth.3.1662586417672; Wed, 07 Sep
 2022 14:33:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Sep 2022 16:33:36 -0500
MIME-Version: 1.0
In-Reply-To: <20220902043511.17130-5-quic_rjendra@quicinc.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com> <20220902043511.17130-5-quic_rjendra@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 7 Sep 2022 16:33:36 -0500
Message-ID: <CAE-0n50x=h_rBaWAcTk_BBCMLpD=XQ6=BKLGp5+m8i4Lvn4fyg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2022-09-01 21:35:11)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 13d7f267b289..a839ba968d13 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3275,6 +3275,82 @@
>                         };
>                 };
>
> +               pmu@9091000 {
> +                       compatible = "qcom,sc7280-llcc-bwmon";
> +                       reg = <0 0x9091000 0 0x1000>;
> +
[...]
> +                       };
> +               };
> +
> +               pmu@90b6000 {

This unit address

> +                       compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
> +                       reg = <0 0x090b6400 0 0x600>;

doesn't match this one. Please fix.
