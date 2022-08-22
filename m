Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4659C59C5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiHVSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiHVSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:16:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F432B80
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:16:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v10so11379348ljh.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wRS+T3KmeWtDMHibn7SUSx56KdkCFBSVRzTzNOlIYvE=;
        b=TKv+sar4EH50ev5KJbn799H0JoeL61TWAgFK+UhEWVjp//WwMhLBnj3fD3/SPnHbra
         vq0XXWB0PpPXfLxaL7nJ6doFmB60qwPJS23DDQ/J+gxoarN9Aed8sAzeJ9bzb2HHQLKJ
         MQgxonNOu1R4qSbj3aRlP9LW6pDERqVWeDXm+LElstzsoXeincMHaIbMuAyBFOteNamF
         f4UvVZq7TUJhB7upUzPfAvj5kGmcKw7IPvrnc9Fs1T9EzQHFd4bHLO7PcSplJYwIA+g3
         Q0KFIEm3cnRaxKnq0R+fiCM/HpW3Q6trQG1Dic6JebXA7eEXp2Maxye4/8w4UcbZG/4I
         E2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wRS+T3KmeWtDMHibn7SUSx56KdkCFBSVRzTzNOlIYvE=;
        b=JOQqXeA9vQahHamvoi6BpIASMs1z2+GGH94UMuuDL7smQ513bb1O7BHQYR9L/CTB8J
         48uM2gzvVFDt8dvkLh9LpmXyIam+QuvKUnCEPmWValJy8Ji89NKS3P+S/mAblDvzmqsY
         RbTnypVh02QHzXE/rMb1X90o7DbYo76byMpFgl8PKGJSwYbU2lehKe2I3eQDnccVtM+I
         i0OnXcrvgQSF4i3wAWGpzujP6/phkqsjtw3FXU/WyCvSiCGiWKkYlr/K7ikMRnoFPjOZ
         Fqm3Z2J8+GmOvAikXltgpvdIHntlGgdWAn6NaJUowzpJInaQKT4p3DMAhDxKyn7BXYpP
         7ybw==
X-Gm-Message-State: ACgBeo1L/70c6D5+2qdBV0WKc2d1REvAabiDAEVRJqP4MT1r5lyg1nnZ
        CEmdqxxT1feuDP3Kizk0EnsQRw==
X-Google-Smtp-Source: AA6agR48ehK8nASmJ0ZqCbE+OJgnmQy0c10s7hR825BciR0gnqGL5AUtzzcz1b1wHGck1h8ZjvY4mQ==
X-Received: by 2002:a05:651c:17a7:b0:261:c0b1:574b with SMTP id bn39-20020a05651c17a700b00261c0b1574bmr4434271ljb.40.1661192160505;
        Mon, 22 Aug 2022 11:16:00 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id d11-20020a19384b000000b0048b0975ac7asm2028703lfj.151.2022.08.22.11.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:15:59 -0700 (PDT)
Message-ID: <9501750a-e382-e4ab-cf96-d1fc6ba1c6e5@linaro.org>
Date:   Mon, 22 Aug 2022 21:15:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 01/17] dt-bindings: arm: add AMD Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-2-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820195750.70861-2-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2022 22:57, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document the compatible for AMD Pensando Elba SoC boards.

Didn't you get here tags?

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof
