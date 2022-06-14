Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C514554BE49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbiFNXZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345811AbiFNXZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:25:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C845AD9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:25:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t2so8991041pld.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BOx6XIBJpHQ9i6HRPFxH3V3DBHMtEKH7TS7SLJPIFF8=;
        b=e2BIuNosBhCTQzgHwsVXQpOhfDWh7H2tjOkxZs0d/Bv3R9s867Rnom0Zcu6j13/sv8
         D2dsYjQM7BLVY9fxsEWmKlLEoj9lTrCmy0FwSseGKQ3WZVA+UMVbt/WWOOrrVnUASsuv
         DHothm7XaIcXmGujnbWOBWnhXahBh5qhiY+0DqtPx+NK8w/pIJPJ4FfxefOb2Ws4QLW4
         zDKVZ5WuShQrJSWJfqJGOpbwh/6+Owfi6tf0MTC1Xrmu+rGQVUH9IWiAPV8ZigjpF9pl
         9wggdn+FtmMbh6WC6cn7sqvQRryyWlpckbNL/W3iI8iI8a3E1M3n7W1I/2SKlEbBQyf/
         kG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BOx6XIBJpHQ9i6HRPFxH3V3DBHMtEKH7TS7SLJPIFF8=;
        b=VM5/po+TGmVbTqJ6PibtRhwxEUYLYPO4xHV4AN92SOkKyxobBrHT2Pwiu9a+6gYt6l
         R6+ssyGlOJzC3+KbhSxltEKXT2kkxAKqxGAIk+E/t/ZmWTZq92Z5SxTMofUD9L7y1p+m
         O3IVywZAB0lZyh7AkJudxNsPc+czlCCfExOikCR1rwXwumb+R3kxeeXmZieF5ylcljIg
         KmbM0mcymucaGDbKp5k4xpr9Dq6H7Xwjtkj8setZvRhKZwHFO1xGjlocZgvOq4rkmtLX
         xZWaiPhC2X4cspF6p2CNum398o7JTZGnS8bYf/ID1DEUyIK65kCjPiUz3dAvtKRqjrFh
         XuLA==
X-Gm-Message-State: AJIora+jzWcKQjrF/hZa06wgyiBzvK3aBFtnoAWLIuTtRyXr/fYrYHp0
        IXUtIM25CZQm8bbEAnSxq9jGKw==
X-Google-Smtp-Source: AGRyM1u/eHZ/3w8O7kR+z3BPXyBQklQIPR5vVUZD+xH1Xbsix/hIhqvGlAlw9VmUVjXszkB7PGVixQ==
X-Received: by 2002:a17:90b:388d:b0:1e6:a0a4:c80f with SMTP id mu13-20020a17090b388d00b001e6a0a4c80fmr6981607pjb.39.1655249142703;
        Tue, 14 Jun 2022 16:25:42 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0051bc44f26d9sm8219195pfg.23.2022.06.14.16.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:25:42 -0700 (PDT)
Message-ID: <c7e2cbad-9e6d-a089-0507-8d1f69c5e6a5@linaro.org>
Date:   Tue, 14 Jun 2022 16:25:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] arm64: dts: Add support for Stratix 10 Software
 Virtual Platform
Content-Language: en-US
To:     wen.ping.teh@intel.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220609025500.400695-1-wen.ping.teh@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609025500.400695-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 19:55, wen.ping.teh@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add Stratix 10 Software Virtual Platform device tree
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> ---
> 
> changes in v2:
> -remove indentation before GPL
> -change root compatible to "altr,socfpga-stratix10"
> -remove bootargs
> -move clock-frequency to label
> -remove l2-cache
> -remove no longer exist authors from commit message
> 
> changes in v3:
> -change root compatible to "altr,socfpga-stratix10-swvp"


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
