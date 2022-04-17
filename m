Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D485048D5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiDQSRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiDQSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:17:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB40BE22
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:14:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s18so23665096ejr.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o7HCLjJ0glORsu4WJthw5jv3bE9Tt0o5UvzBb0xp5Iw=;
        b=y6bseGpnDkz/F1SCphszEzDJJQpjVU56HhyjgCrRoYvpBDC1Yw3GwHBJ5K6lYh7LOP
         nIwpOKa/zk3TsHyo8oz0sYi/lLZoHaw90zhYOqEZAcdba6PrzqyqCx6wnCCHHA1G1Bgv
         PNLUEu+tErN6JhPpV89TzwvpncC29YrYDazCglUIYoa/FoztqcjRK8uI3cD1vyv2sI3h
         +prC4T+mFa3eUx+jZ89dTwcYZFQCgLPyKWMOJ0FaFUYdII2FEc7J5oElnERbDbLtxaP2
         y2i15Y5LGUnpFKxnZ/Z2GDiZwzgO69tvLmREtNQSk0S2FU7Ar8rTDm6r/o4fcL9KeqG9
         aDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o7HCLjJ0glORsu4WJthw5jv3bE9Tt0o5UvzBb0xp5Iw=;
        b=MSJnmcIcibEm5SbsvGIX0a/+p1XLJJW9Ggnld0jjesKdKLlCnfFllEsNKC1CSTSwiB
         kA8OpolRCYtPkAiKA8NzQyWujBk1UqGESTMZoOJ8O0lpLWhfsjkzCjAo7z+XOcFtzWo6
         u1zR4Vf8LinoFoNjamcV10gq5JsvXTipQgQK86tJWuVQWHlGHWtHazWWx2W+eAJf/jI5
         i8yQhHIH8SprhRLHj9iTYq+X6Pvlcrm+3KiP+ZgSo8WIXjPGCl93QDtRYOgwThOhQHiN
         rIIqVDnQdep557eN92yREdoeKHIZNE5q1YnyAMEswXOgPRFNGzmbXvzzkalnbee+m380
         zEmA==
X-Gm-Message-State: AOAM532vyP8viDtD3SXZAYVE2G+BNv8DTPB84JM74NeuH+UJWsCdRfUf
        P5WfvN2GTS3Us7C4ipElGDWRkJFhM62lCg==
X-Google-Smtp-Source: ABdhPJxymFMtTBVp4k8Uhn608gxOUAtj6acupk0lrQr3TTmnT2JhxDtr8HNT++fUNjJJi8upoG7pGw==
X-Received: by 2002:a17:907:9708:b0:6e8:d95e:273b with SMTP id jg8-20020a170907970800b006e8d95e273bmr6312472ejc.421.1650219264357;
        Sun, 17 Apr 2022 11:14:24 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090617d300b006cea86ca384sm3779097eje.40.2022.04.17.11.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:14:23 -0700 (PDT)
Message-ID: <daf1043e-be50-729a-e2b7-a095f6c2c026@linaro.org>
Date:   Sun, 17 Apr 2022 20:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: add bcmbca device tree binding
 document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220413192645.7067-1-william.zhang@broadcom.com>
 <20220413192645.7067-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413192645.7067-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 21:26, William Zhang wrote:
> Add arch bcmbca device tree binding document for Broadcom ARM based
> broadband SoC chipsets. In this change, only BCM47622 is added. Other
> chipsets will be added in the future.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
