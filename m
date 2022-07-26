Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76222581870
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiGZRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:35:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BFBF75
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:35:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q7so1840366ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JHc7AYlRXZ6aiCtTe+oSlD5N4Ua+N3EzvkXaFf2RC4o=;
        b=N0deSDI+LiMOpces5+etS+NS14zNCm+md+u9gARDG0ixEpQGvSTtzErTuNz2esW0bT
         pXkajtBnlcabT+ZLAsxwBTnlCw0OlA5Cnt5/ohO0aXrKf0uwf5hwWi+MviSEd1CBBRjP
         GARs+6N9PoIAG51nVHvY68XB+6nN5SRbaAn23aBQTdq0DEDKIKgdLAY6y7p2XvQ/XosN
         Pd37hCg3n0SvCLNIHyOn3l0YWoYBZjVqlvxzuBK6aPAttokOg9VMKY/XelUJ/ZtuLpoj
         0gVLchzNRRmyDsHubxvRY9zv5ZG+0x3LJCGdwPqzLDj1wQMo8FO3NBAQE4g3UBz085Vd
         cq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JHc7AYlRXZ6aiCtTe+oSlD5N4Ua+N3EzvkXaFf2RC4o=;
        b=gtACw2pjfhebyeIJ8hJcyLmnWYWKcoSGnr7EK32/YqiAlml/9O/FxYGnIX4bORrC98
         LlZaJk5ECxuVSA3pEbyPyEqq510UUVZl51c2rTF5176Sv48O6PH1AEAMOiqC6RV2HCwE
         RLwDB9ayT2FqVjv8EyuGwafcHxbDjmzmv6kKzg8t09mW04/N2g8yJ+m5OktrZHfGtdZU
         0LJrsS3e+nBiybZ33Ddx02PZyq8E8dEFLvgLymUpTbxNBWQ5twBG3DgvrEftYq6hdmjP
         GyEWnuj0EqPLOsAb3FBQAoR+BYXJioisTSUGSV1ZO3Feb1s3u7L9wMsk59seyeyoTYjy
         chvA==
X-Gm-Message-State: AJIora9BTZvE7DwuNbAK/kx4oQRI3AKgRD7kgfo3eBhARFlsrFKpDZaM
        oAauhAiE5xHTK4iqJRmoOOpjTA==
X-Google-Smtp-Source: AGRyM1tmwXLiYKvaVFxKBF/ccqtJ5bZ4CGr5twneruJ80NjxbDQMnHuz7XCk6ts4YVIGB6Rk6qhsRA==
X-Received: by 2002:a2e:a16b:0:b0:25e:8fb:a1e1 with SMTP id u11-20020a2ea16b000000b0025e08fba1e1mr3784078ljl.270.1658856927106;
        Tue, 26 Jul 2022 10:35:27 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651234ce00b0048a7ce3ff84sm2246967lfr.285.2022.07.26.10.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:35:26 -0700 (PDT)
Message-ID: <246f132a-a23d-7c53-38a7-2bcec50d65e5@linaro.org>
Date:   Tue, 26 Jul 2022 19:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atul Khare <atulkhare@rivosinc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726170725.3245278-1-mail@conchuod.ie>
 <20220726170725.3245278-2-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726170725.3245278-2-mail@conchuod.ie>
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

On 26/07/2022 19:07, Conor Dooley wrote:
> From: Atul Khare <atulkhare@rivosinc.com>
> 
> Fixes Running device tree schema validation error messages like
> '... cache-sets:0:0: 1024 was expected'.
> 
> The existing bindings had a single enumerated value of 1024, which
> trips up the dt-schema checks. The ISA permits any arbitrary power
> of two for the cache-sets value, but we decided to add the single
> additional value of 2048 because we couldn't spot an obvious way
> to express the constraint in the schema.

There is no way to express "power of two" but enum for multiple values
would work. Is there a reason to limit only to 2048?

Best regards,
Krzysztof
