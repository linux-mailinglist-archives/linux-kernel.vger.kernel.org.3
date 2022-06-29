Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFA55FD92
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiF2Km0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiF2KmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:42:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9E3E0F7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:42:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fw3so4053833ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZxfcwaP0xQFeronCkW5JXgW5rTqOk9T4HcBolfywAVc=;
        b=NTZQkESm/vkFdNS4coY6Hq2idjat0LRV8D2PcHcuxdiQch7wETWnn1Uoib/C04+loA
         xO81hYSuA9CBS3/RIFJT1xPoiQ4z10vtdhxkKoE3aC3cQjVbe20kDof/IsMhHkGNs36j
         jtSxmoCg9HetOVIv3hRmFTCl5CH/f6gv768UDT7kp6vfrnlUNCL+U7u3zzXyLHGjrTBk
         O+y9Y82x4DZq+fwgXpfD/oHhzTGvpRu6MLAbnXN4rvRuKJicWPHdFvzBeDeEh3refarg
         uu/GEFTSD8tRZYTuuGkEK78+goxjdNGesQfedpkFFJxmPYFZge0sKb23cMhL0qaqJ0H0
         o2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZxfcwaP0xQFeronCkW5JXgW5rTqOk9T4HcBolfywAVc=;
        b=AmgGiLLxm6QwmlHddv/sUhqEBE1bRMAYZma0lAR05BpXGI8Hr986UrDb6HD36ljp9D
         IoOEp6bYdZY9GFkwYBX6IL8k/Y0/rNKJsm71wjnUqcPJ9BMAYW3FxnZ6L17iZGsQ/iE5
         IZkkQQ47jinnTLDpQinv1iIn1EonVY+V7BIxznFfCIfW7uGBiqYg1IsMhXYSGrubQGKk
         ZIlTUB5CBAT9sLnVD7OYwVUOXrLgNIv2ctdnTlAnEJ8juCvlIFpLIBOK89KuqY5GLllJ
         34r7Pe/f84tvpgW4Rc7ltUiuATc8EIVppammuydNJPvnuiAcoPf+1u7t/E+DqwASD71E
         yMnQ==
X-Gm-Message-State: AJIora+3nkbzqX3A1ubbC+7eh96YGbwPF8EX9w1dxTwPohC6ZQ2gTDdT
        3xtZEWnkcby0J7QsMt0VTjOEDg==
X-Google-Smtp-Source: AGRyM1vkXyDgAocbBCGlE0rB9oybrd7dgbaAZywVUZK/udpU1RFSE6ehz5oQ0RfZcnAZcHp74R4Xig==
X-Received: by 2002:a17:906:3899:b0:715:9fb4:bd28 with SMTP id q25-20020a170906389900b007159fb4bd28mr2566237ejd.97.1656499331722;
        Wed, 29 Jun 2022 03:42:11 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r12-20020a170906c28c00b006ff52dfccf3sm7605626ejz.211.2022.06.29.03.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:42:11 -0700 (PDT)
Message-ID: <abee0a14-23ba-b784-33a0-ffe878a76a3a@linaro.org>
Date:   Wed, 29 Jun 2022 12:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 7/7] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-8-tommaso.merciai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627150453.220292-8-tommaso.merciai@amarulasolutions.com>
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

On 27/06/2022 17:04, Tommaso Merciai wrote:
> This patch adds documentation of device tree in YAML schema for the
> OV5693 CMOS image sensor from Omnivision

You could remove "This patch", but it's a nit-pick
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
