Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1D5B252F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiIHRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIHRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:52:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2114D99DE;
        Thu,  8 Sep 2022 10:52:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t14so20139283wrx.8;
        Thu, 08 Sep 2022 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kT+2AbTrH1Kh7uAi7sVUDrkL8YeDLjiGtQ85nst8gfU=;
        b=eUcl9Y0xLe5I1Pus5u74csvo/LKTlohSmCxPX+tbDeSL8iGEViZmBkXiZ3VWD0Upb0
         2mO2ePdJpdfgmdIkZJw2OWHce4Etar9/2uwx+eWAfsMk/xYvMG8kWDL9lFMTihWUF/fV
         bAXfVAJZsThVpObTsyA9GhaBhbAj+Zfl0M6dIXAQ7k355UQZurA+m/tnDm2RVa0AoNol
         Wat9+o0uEhzf4Q9TL65H97HxJUe/5OZwkpQI8m5RfZ4TRTxG20QARrA78afMW1s01a4I
         791yhCMweJ6cS5t/6LhoghDmmbnsGX5CKYjtnGo3zWWH4MtUSJHkpauzP2CtE9z8EUqY
         G4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kT+2AbTrH1Kh7uAi7sVUDrkL8YeDLjiGtQ85nst8gfU=;
        b=Jwg4W/8o2wtxaa1fPDtdz2Be0skmBldtZm6urrbsJ41akfLrcTTU4Gs9iDcsW8Vbw8
         SZ8vR3BPTvHGW7RA3//WHsdf1r2jiEiNoHkn5e0MUEGdL2vKXf7x0V3lkJJyORhiPxPa
         QGDDIv7e1vOhlygT43gM2vGsk5HYRxFPyI+i2hTc0WEXkPFLHoGmwNh9OKq5v0fwgbqL
         1ysi05TM4I8qUNmLDSwZGXaG4t9ODRA7uZWG14F/wwUCRSJl/XGBRenipgpQELoc8qJ+
         k+ItbhA2XUOyLnU6DCmzV/pnslFO50ojEmBMAalIChTAn59oE7CrtZQ2/ngJD93nfCQ4
         5PZw==
X-Gm-Message-State: ACgBeo1qP4VJOJeRTc5RpevmLBCEmIGk14qWOwjoWvD3BhnqjxEuQLv4
        /GiamulItUkFeH8UMEBPv1g=
X-Google-Smtp-Source: AA6agR6ac9wu3/ypYFwz28EfERWFSyeR30QK/KsEUG2H6NdnyQUu/tU98reF2mS37pHqFLnbL2ZBhw==
X-Received: by 2002:a5d:64cf:0:b0:220:6d8e:1db0 with SMTP id f15-20020a5d64cf000000b002206d8e1db0mr5580917wri.564.1662659529837;
        Thu, 08 Sep 2022 10:52:09 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id v11-20020adfe4cb000000b00228a17f92fesm14705767wrm.51.2022.09.08.10.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 10:52:09 -0700 (PDT)
Message-ID: <843b8280-5e71-c008-0ca2-4d289ca6e7da@gmail.com>
Date:   Thu, 8 Sep 2022 20:52:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-10-iskren.chernev@gmail.com>
 <e655cddd-677b-f277-667f-48107671db2a@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <e655cddd-677b-f277-667f-48107671db2a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/22 11:33, Krzysztof Kozlowski wrote:
> On 03/09/2022 19:41, Iskren Chernev wrote:
>> Remaining issues from make dtbs_check:
>> - rpm-requests: it doesn't like the pm6125-regulators subnode. Every other
>>   DTS I checked is written in this way.
>
> Yes, I sent patches for it, already merged, so please rebase on linux-next.
>
> https://lore.kernel.org/all/20220828084341.112146-1-krzysztof.kozlowski@linaro.org/
>
> Please rebase and test with
> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

It looks like this patch covers SPMI regulators. In most devices RPM/H (i.e
indirect) regulators are used, so this doesn't fix it for me.
