Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513F4579460
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiGSHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiGSHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:37:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A03B16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:37:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o7so23325933lfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r4cv516uQxlxsZfiE7caLvXTXMPp49cDpkLbpUXYAvg=;
        b=d37WdnjG2bJqk/154vqH7Hj/KVN91/sW4IQVDtbEMXUtkCwwBmxlT8M4JELbLVd0Br
         DL4Pk8d0tqLCawW+CxhLb6sel7IG+JACPPrett83J68FQSA0pDYVYRvI6Bhr27+ZIpwn
         nhnuUc5Lg/ViwxIyJQ0ECGITO1mB8Dy82ce2ypN1SjEcd373ETw/njuSNsnVDEYGo0Eg
         2MV/9lhoZy3BcJVXB2GcSwwdcfsT6eLPIvSNDLbKKr7PQ77wTR0T4kapbm5nJtbomTWD
         0TRrsZGLVHTCoUaEp+jMgbTIEVK5Ul7htWbBREd1LE8Y7MZC0ZCtyPLUjgowzHh4sbu1
         1tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r4cv516uQxlxsZfiE7caLvXTXMPp49cDpkLbpUXYAvg=;
        b=N8kNsM21ScvBK0eHrHQi0x0NMMaEhgbnKqe3/chxCd6UEwvaO/aR4nY4Qt2RtW5iKg
         5MvQYh0VQF46ZKrpoYHIS3XAk4MILIL64YPp1hxoXP51HTK7osJBWEKhhm4eSfvYrtzr
         uomAPMFaSExk+Mo9Ce+bry6z9e+lvebkwvuN7zvlJsvZohr/C6Yfdb4PEMb4RiONJ3ez
         QOTwvsWkJIV197gVGdKhGRw/NOnVsCqys5in7HZXfsZ+WdS8CdrwR9piG2/0x/3zjmwx
         +fF+onLr6mT5blCB2JJPfnk2HmjK14pZJifhAKy0/KrQFkTx/D3YWDBaVTOQXYy5sQE1
         r3rg==
X-Gm-Message-State: AJIora+2qhLGnv2P+gisH9Ol+bF6gyBs2sagdI/lDswfnwtAFNEr0xpe
        BLEpKniD922ta6nkeHejxU5IUg==
X-Google-Smtp-Source: AGRyM1vtiHrB/m3pGEUMRE5R6kEWFeE1Wvdbly5/LeJQWMKXICn8/HeFObMsSvtEuiCLQaftpGplyQ==
X-Received: by 2002:a05:6512:39c2:b0:489:dca6:a23b with SMTP id k2-20020a05651239c200b00489dca6a23bmr18227413lfu.633.1658216266173;
        Tue, 19 Jul 2022 00:37:46 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id y10-20020a0565123f0a00b0047f7464f1bbsm3049382lfa.116.2022.07.19.00.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:37:45 -0700 (PDT)
Message-ID: <6379d663-fbfb-67bc-e8ec-3976b3593036@linaro.org>
Date:   Tue, 19 Jul 2022 09:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: leds: fix indentation in examples
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kyle Swenson <kyle.swenson@est.tech>,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        linux-kernel@vger.kernel.org
References: <20220607075247.58048-1-krzysztof.kozlowski@linaro.org>
 <20220607075247.58048-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607075247.58048-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 09:52, Krzysztof Kozlowski wrote:
> The examples were mixing 4-space with 2- and 3-space indentations, so
> correct them to use 4-space one.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Any comments for this patch as well?


Best regards,
Krzysztof
