Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF55648E8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiGCSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:11:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3060F6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:11:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a11so8518342ljb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EA2HK1w3Mx9SWECBezKw/os0mvoFNvlKu8SCzQeFYZA=;
        b=AErGtm4DckMyY6HrGDk8x/qOpOCzcTPclkWo7BzqWtHYPQWvkAKeMSoWoZGzfokF6g
         EHfNtu6hGsDEiZcMIBDXH7iOU4tuMG3dVspL+YAtfaHBzs9TePyr7DoDipP+LyFzmd/0
         v2vF8tVpNzJAWX+UC2Du1olJzxPCnYAO5Na6o/aZtEiNE2i+6yzH7cu9IK/vbOQYHe4u
         OAsXylQFD1sfvGIi/+wP4/1tgieLac/0S/qmtUJJog2pmxS1R/X6SSLnRf7ubEQajO2L
         chf9U1eH6DkFlWM2tFlVaPMLmgt4XKC5bnY7xhmAbjt9QtavB4xfIxiAPf1aZwDNYGWD
         tuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EA2HK1w3Mx9SWECBezKw/os0mvoFNvlKu8SCzQeFYZA=;
        b=iXzsNtJTpFbj359vhJvmLyK8QQUIl35IOUHnonSZHG1OUbhVRkmSx3mo7bFcnCCd5Y
         fKVUsOwMyniTGGji0SMZMYjjrXAWZMLEtl3RlLzGCCC/wKNIxRb5FRm20agyA6Z8ZE7Y
         tCuKP8iJ5qGOwFQB8QWfiewwwYnzLUSR6VG1PrCkhLnvzCfDQMiXSFMoAR8f3jTjtfkS
         SKaeLym+OuibRKVZw9qbTSnQHFw/09srMzOjm23h/87rGxVq/VigH6I4DJbEv/Yibcqu
         HpL+jLCfv9BqVGvx40XcapYKMDyMwvy8XSJrRbaR1f48wcVzk+RogVIB5RAqS2uf9/ww
         4CsA==
X-Gm-Message-State: AJIora81ANgFyNKWsxDpfSSOrpToHOXEBzcV1hxFIH+GINo3JCmKgNPw
        Z6N/VUbE5sA6WwOttKbIV9uaqQ==
X-Google-Smtp-Source: AGRyM1tkKK+8SkFXgg4yB2FmoXvs0dFKzuwaGe5efFkEcCAcjGZEp5mVYgw8z+6ar4LH+dWt44D9XA==
X-Received: by 2002:a05:651c:1549:b0:25b:d2dc:2e8f with SMTP id y9-20020a05651c154900b0025bd2dc2e8fmr13780446ljp.334.1656871897227;
        Sun, 03 Jul 2022 11:11:37 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id n24-20020a05651203f800b004795311530asm4821761lfq.209.2022.07.03.11.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 11:11:36 -0700 (PDT)
Message-ID: <ebe6eaef-8bf8-3a35-4048-d0b079b52ff2@linaro.org>
Date:   Sun, 3 Jul 2022 20:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: soc: samsung: s5pv210-chipid: add S5PV210
 ChipID
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629123543.94515-1-krzysztof.kozlowski@linaro.org>
 <20220701173524.GA1185040-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220701173524.GA1185040-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 19:35, Rob Herring wrote:
> On Wed, Jun 29, 2022 at 02:35:43PM +0200, Krzysztof Kozlowski wrote:
>> Add bindings for the S5PV210 ChipID block.
> 
> Is this new or was undocumented?

Undocumented, I'll mention in the commit msg.

> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/soc/samsung/s5pv210-chipid.yaml  | 30 +++++++++++++++++++
> 
> samsung,s5pv210-chipid.yaml

Hm, even for files under "samsung" directory?

> 
> Surely there's other similar blocks. Can we start collecting in a 
> common directory?

It's a soc-specific driver, type of soc_device. If you think it's worth
a place of its own, I can put it somewhere dedicated.

Best regards,
Krzysztof
