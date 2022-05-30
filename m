Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A449537579
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiE3Hf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiE3HfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:35:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8692719C7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:35:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso5921657wmp.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j9oWpoYF6cP0rasfQg0lgU3K+paVeBGM3B58Xnx0N70=;
        b=J+Nmc5vIraLihuVuNTQS3pr8e/7nM1ph14p0AXnhWFqAnwjoMKWbxFIZD2zkjxIEBl
         gHZUqLzIRqPoLrXbukGzWJM3zfc1ofhuP/ULOzLkZzSgl1hDRyPf7dOo8MfGwy7deYM5
         vNT2ilEX48SKQX11OPqHQSV3vrRdsQv9LoNVOc81tFGoYO0GGwe4ZueCj+WejHDYxf+h
         F51DzT9qt/THYLBug11JDqhkQ73pJe2yCCVbI9As873b/Ck83LmW2qKspryFs1iDtJuh
         HkPYN7VWXoNFGrodnuLTH8uH1Mqx7cse7GHr328H7YXe4Oeq4e5l0q/uv3n8tCezSnvb
         Ur7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j9oWpoYF6cP0rasfQg0lgU3K+paVeBGM3B58Xnx0N70=;
        b=AxpEAk5O2gnOejrug9BTz7bsLq0aNmLkkpnxhHIYKBiSFW2GGnxBQ9vK0yKct6GeMz
         2uOEH/0l4w1xxTmQPjnl8hXTnuRRpJd5IAAL1J57OtB0+TTS3+n319+cWz5CzIV0dXOv
         0OJpdEYeEKnjZksaflNFz6ldYfx8d4rPnlnLQc1GlH6hXqUUyv5GmXMKl5k3/y1i/eO9
         qdkQ6s9yczJdYlWuw5H5N/MB3667lPwUgx28zw3ReRaVoh9qmM1Htr3MeblSCVGI63XQ
         f39SeJ+sUeCCm/L4gwmlImjH6bEjANZezKVMlyXxTRpVB/Rp66VDF6dr857d8i4ujThc
         INHw==
X-Gm-Message-State: AOAM530hTkXoA+lZljXRX0iJcAxqGDnbfRxAiv6MSyL2ICwGTsYW5xK1
        D6GTsvGWZybWSSdgnbbtReNIPg==
X-Google-Smtp-Source: ABdhPJxJ7o9DPjs3Sap3nZ8dMyV7GNUSisQEhRGh8ngGsb8rZCZsFbu3TWaWmTIrENCsWJ30MyyU4w==
X-Received: by 2002:a05:600c:acb:b0:397:bdb:ffea with SMTP id c11-20020a05600c0acb00b003970bdbffeamr17906469wmr.56.1653896120344;
        Mon, 30 May 2022 00:35:20 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b002102af52a2csm5860109wrp.9.2022.05.30.00.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:35:19 -0700 (PDT)
Message-ID: <11b5c026-26ef-6b79-fbd9-f994a21e6755@linaro.org>
Date:   Mon, 30 May 2022 09:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/2] Add support for Xiaomi Mi 5s Plus
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Alec Su <ae40515@yahoo.com.tw>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com
References: <20220520120449.12996-1-ae40515.ref@yahoo.com.tw>
 <20220520120449.12996-1-ae40515@yahoo.com.tw> <20220530070738.GI1363@bug>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530070738.GI1363@bug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 09:07, Pavel Machek wrote:
> Hi!
> 
>> This series adds the device tree for Xiaomi Mi 5s Plus (xiaomi-natrium)
>> smartphone which is based on Snapdragon 821 SoC.
> 
> Please cc phone-devel@ mailing list with phone-related patches.

I think you need to come up with some smart content-pattern for
get_maintainers, because there is little chance I will remember to
manually Cc some different mailing lists depending on type of some
device or some other factor. I remember just to cc soc folks on certain
patches and that's it. Nothing else fits my memory. :) To avoid the
problem of poor human memory, we have a tool - scripts/get_maintainer.pl
- and contributors are encouraged to use that one. If you want to be
cc-ed, please either work on proper maintainers entry or set up some
custom lei filters.

Best regards,
Krzysztof
