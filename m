Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51A580570
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiGYUWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGYUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:22:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6996F2180F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:22:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bf9so19664503lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6olDaq/uvfvlpPsjXbwiD0KGbFCbw/GgwCU0Otoyu9o=;
        b=cf14DlLTiGj5aFxICV0ITuDWZLKAzORtJfL76XQFibFta09hkTS/VA7G2ru2FHZ7XY
         0kqakW/bTZpWyTvpU4Go2JkGrHVA7hfUprfxJv4XhVaiTYBXYZgDwReNqsm0Q4mJrdG2
         4sxqgFTaKJaIPaI7XkYl7gGEfhxdIEjE8sjVuPeQAAVJh0BHmnAKGwEpl3SWhhmDFyF+
         wmNkoxVFGhOOJ94Ui+OUxGPg75+rB9sd29OxeteYKad6L6a7OjcbPYoi6+IjDXuZbag5
         ozPvVXrMsRp1I4aEQz9ipWK7+KMvhX11RaKBnEGChwTVdHSnttZy8gycLkUk4/ESuXzd
         avGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6olDaq/uvfvlpPsjXbwiD0KGbFCbw/GgwCU0Otoyu9o=;
        b=a78BngoVVTMx+0jBwkL0/W2s5W80kOn/nS4hJzvHhkC6sniocTgd8glV+jZUNk8DkW
         Lp6V9gCzcKpOy4XNVlKIapJJfgBZeFphoeAD67C697RdSsfg0bI0KKB3HnoT3vuLpEDO
         QrpUpEi2uKHpj+ZCQlG/aya74Qf6Z45fYFhyH6aRtvHiCWY+pW2WwzsFhumDoLtHnE0p
         1tzzosUkcdIp5i2QQRxj3GRYGWfuIlC2v47eB8YjAqiQn61QfQe2t/tUFRHrBdoK2U33
         EqzMorw2QrMI3bbRbj9Jz0GLTNo/Ir8S9f+AkTXh8zrUc7yrW5XHTszOSbkFObFxfSuk
         kWjw==
X-Gm-Message-State: AJIora8oKfHB4pt1B/wFLLz0JZ7bG4TvmfwW815MpZUHpjEqXHUNK1Bt
        mQcGqJtdnpdoLRKH/57grd6K9FhbrM+mOEJM
X-Google-Smtp-Source: AGRyM1tiIV7vdS2ost7/f/zFELVJA8SPxee2aUrt7GUtNNgBp0VRvmv5veQZvMzPDKzi96SxqWMlnQ==
X-Received: by 2002:ac2:465d:0:b0:48a:8122:45f3 with SMTP id s29-20020ac2465d000000b0048a812245f3mr4217480lfo.573.1658780527708;
        Mon, 25 Jul 2022 13:22:07 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e9b04000000b0025de8d95352sm2714473lji.1.2022.07.25.13.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:22:07 -0700 (PDT)
Message-ID: <3faffe39-061f-0e94-a59f-ab25a25820b5@linaro.org>
Date:   Mon, 25 Jul 2022 22:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: smd: reference SMD edge
 schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
 <20220725191742.GA2535526-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725191742.GA2535526-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 21:17, Rob Herring wrote:
> On Sat, 23 Jul 2022 10:23:57 +0200, Krzysztof Kozlowski wrote:
>> The child node of smd is an SMD edge representing remote subsystem.
>> Bring back missing reference from previously sent patch (disappeared
>> when applying).
>>
>> Link: https://lore.kernel.org/r/20220517070113.18023-9-krzysztof.kozlowski@linaro.org
>> Fixes: 385fad1303af ("dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for smd-edge")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>


Bjorn,

Can you take it for v5.20 via remote-proc?

Best regards,
Krzysztof
