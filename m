Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339CE527DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiEPHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiEPHBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:01:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F6E9FE7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:01:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so24216260lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NbvfOiX/jtGbPtYjjUDXC+IzrP1LLgnY1EgAFKsMWp0=;
        b=tgw+AdEnx9eQx5k3kbD6Pq7cq5NnJeNxQilDPd9IaKz3349mKE4c87X+GbStT4GBvs
         dwiqjLc9JEKbJMrHYcMneCBO2xaG5/bW7wnFdsckzgQCxUlmUpZBEFB87HA9hVF5+/ny
         T2xT5ZoN3fGW3fxkoDpS+gmAynETh3VUNb1tcwFanze5v5iFTPYtaBl0uK6f7rqzSpCq
         HPpvtAUckdP9cV6tLPq1KcmRDFHqWqvCIvaZNAQVRIOKqo4SDt6UBwgXMBCXt9m4jntr
         lormf40CO0lfsyZoqQT6RtgfsVX/nH0v46h+X2WU7FEBFVhjihvSjoFhVur8HagSS2b5
         KBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NbvfOiX/jtGbPtYjjUDXC+IzrP1LLgnY1EgAFKsMWp0=;
        b=bvEFHW8aX1eqZ022vN1VjBSv0R2l2IPpAdbwZPo59EBa5ySfrSwELbF1cgMWDFOxE+
         xohxx4a2ecju91q0cTWghPjcOKkx4/KmJJ/e9aPc2xzp8s5Q8JtYpklUIg44stutJBIf
         f+H7Mx1mPxkI5LeaaCYT2YTgNKAcAL2jZZ8FUxLd+i1upbmhmkWNWVA+BeLv86afcws8
         Aw2fmRWnbf7/aeF4kvT7n5PD/MEQetGrFEyheOoLUnjVDXg5CEJG/JXkqWe3mWE+xdXR
         cy9/m/QZlo4eZ/S4la+gije7ZPEDuzJmN/MPCpwbioRm755Em7yhnsprKyNa/7nQZBy/
         LEoA==
X-Gm-Message-State: AOAM5322WABvmC+h9XjuqzPDOuxXzdyEWeXYC6WcIoXIah3uVU7/zMbG
        H2k1svez4dTzNo0qchYkDdjCaA==
X-Google-Smtp-Source: ABdhPJwmLBBWEwrRgPz4mXsYykl61uynZi06W+txJ8t2mcxBNaa9FQ7HgmbVci/MRO0Eex3gE5NO2w==
X-Received: by 2002:a05:6512:3091:b0:473:bfb1:8da0 with SMTP id z17-20020a056512309100b00473bfb18da0mr12227874lfd.154.1652684468914;
        Mon, 16 May 2022 00:01:08 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v26-20020a05651203ba00b0047255d2116fsm1219146lfp.158.2022.05.16.00.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:01:08 -0700 (PDT)
Message-ID: <d4e031d0-8a43-e458-6535-1044d43a2b63@linaro.org>
Date:   Mon, 16 May 2022 09:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: qcom: Add sc7180 Chromebook
 board bindings
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.2.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513095722.v2.2.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 18:59, Douglas Anderson wrote:
> This copy-pastes compatibles from sc7180-based boards from the device
> trees to the yaml file so that `make dtbs_check` will be happy.
> 
> NOTES:
> - I make no attempt to try to share an "item" for all sc7180 based
>   Chromebooks. Because of the revision matching scheme used by the
>   Chromebook bootloader, at times we need a different number of
>   revisions listed.
> - Some of the odd entries in here (like google,homestar-rev23 or the
>   fact that "Google Lazor Limozeen without Touchscreen" changed from
>   sku5 to sku6) are not typos but simply reflect reality.
> - Many revisions of boards here never actually went to consumers, but
>   they are still in use within various companies that were involved in
>   Chromebook development. Since Chromebooks are developed with an
>   "upstream first" methodology, having these revisions supported with
>   upstream Linux is important. Making it easy for Chromebooks to be
>   developed with an "upstream first" methodology is valuable to the
>   upstream community because it improves the quality of upstream and
>   gets Chromebooks supported with vanilla upstream faster.
> 
> This patch also adds a link to the Chromebook boot flow documentation
> to explain that Chromebooks don't use the scheme described for the
> Qualcomm bootloader.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> The link added here will (obviously) not function until the
> documentation patch makes it to mainline. Presumably folks who want to
> read it in the meantime can find it pretty easily. If there's a better
> way to link this then please let me know.
> 
> Changes in v2:
> - Add link to doc about how Chromebook devicetrees work.
> - Use a "description" instead of a comment for each item.
> - Use the marketing name instead of the code name where possible.
> 
>  .../devicetree/bindings/arm/qcom.yaml         | 187 +++++++++++++++++-
>  1 file changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 5c06d1bfc046..8ec0805f4996 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -90,6 +90,11 @@ description: |
>    A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
>    foundry 2.
>  
> +  There are many devices in the list below that run the standard ChromeOS
> +  bootloader setup and use the open source depthcharge bootloader to boot the
> +  OS. These devices do not use the scheme described above. For details, see:
> +  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/chromebook-boot-flow.rst

Absolute path within Linux repo, please, so
"Documentation/devicetree/chromebook-boot-flow.rst" (assuming that will
be the final location). There are tools which check them for validity.

Actually this change should be rather part of that other commit...

Best regards,
Krzysztof
