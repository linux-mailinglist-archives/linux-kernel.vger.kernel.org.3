Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D54F2300
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiDEGXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiDEGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:23:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FF3121D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:21:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r13so24480048ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dFScsEWOIQMzMNWYs3fFmAJMFFVGjdTXWlfZ6OzACcM=;
        b=ThW/SFaboNZtHF1joXB0EOfD3+A0oYJ68xb8vJwAGJJiAGdr5v9cOdv2Dn66J/LFyu
         tDNav6AsyulSZuGIEw7SaLofwLqlZpeX62mUTRZP80YMIBFpCdQj2Z9FyiN3CqOSYQm2
         LalCB5F1uP33hNg9iwBf7oB6uMrnWQNDoPsglXr10xJOBqkYwAjCgqnqd3jj45MnEqDa
         Lg30iUzsG5H5ep1/kiOcndp8nAfuZgbCulVghu/RP2S+rGF53vYqBWYVeYqdV6ixfuza
         RiDXrjpU+PItsGYrqSpREsv+U6svzjtGW0w42psnSUBOu1BB8eBwq0W9Bp7xR8totzeV
         8KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dFScsEWOIQMzMNWYs3fFmAJMFFVGjdTXWlfZ6OzACcM=;
        b=iatB2ZtFwjuQFvVZuWz3I4V9HhhMTxOj+jni5ndmsD4uywtuojFwrjECcoMrxPNyiH
         Cq9iR9eBSAt9QPU5MwsxLOLTLzfDoJgW3Kpkuu1vNxZanoRZDK6WB5+4Ft8rpgMdFrz7
         iVsI/PbOGdljef33U/nF7ZmwdnGFOy1QTLr+YrxUBGAHa1wKjJlojOr1n854QZoXzZnD
         ST6FECnQaazsuCcKceG45AL8/K8G9FPD2GcFL6Qv+xQ9/k5gbFliQgAlFc1+U5H0IA9m
         h6oqQXPQdZDZONxWKSq21hamE9v5BwjQIYizfPgC6Dx3jly2a3cDODDh7poxAMvRPt2l
         gBrg==
X-Gm-Message-State: AOAM5317pQDWCzc/mJHb8hL0dngIRH22cVLVZ5i82AwAiXuLbrja5uz9
        EDH6Jqp46/crdy/SVfHPMl14BQ==
X-Google-Smtp-Source: ABdhPJyYwzqhusFM2acIFejF6DscmAD/F8UQ9YmVdk9ycgo6D64esQZRZXphTaTK1r5QecxoV/dc7Q==
X-Received: by 2002:a17:906:c145:b0:6da:aaaf:770c with SMTP id dp5-20020a170906c14500b006daaaaf770cmr1919863ejc.504.1649139674388;
        Mon, 04 Apr 2022 23:21:14 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f13-20020a50bf0d000000b0041cdd9c9147sm1051481edk.40.2022.04.04.23.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:21:13 -0700 (PDT)
Message-ID: <12b2cd08-f296-1c48-4ea4-0d119597854e@linaro.org>
Date:   Tue, 5 Apr 2022 08:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: white-space cleanups
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>
References: <20220402192819.154691-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqKuFAY4QENRb3dKETKcaJm-fcguoCFOgUnzf0Pwmf1Ezg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqKuFAY4QENRb3dKETKcaJm-fcguoCFOgUnzf0Pwmf1Ezg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 23:18, Rob Herring wrote:
> On Sat, Apr 2, 2022 at 2:28 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Remove trailing white-spaces and trailing blank lines (yamllint when run
>> manually does not like them).
> 
> I assume you mean run without our configuration file. I probably
> disabled the check because I didn't want to go fix everywhere. If we
> are going to fix, then we should enable the check to not get more.

Yes, just "yamllint *yaml".


Best regards,
Krzysztof
