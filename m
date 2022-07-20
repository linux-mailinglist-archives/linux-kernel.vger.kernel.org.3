Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AAB57B119
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbiGTG2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiGTG23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:28:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310449B78
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:28:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w2so19960503ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iGIlqhxSlWfDFHRJ6mC4b3eFYcIQYybstvvJnU9esOQ=;
        b=UhRYFA7/LdF7XYBnvxrhbtAKNgFbmStp01s9LorBnZT9P/gNWlUpzMtDsJ7V13Hj94
         2KBIksodqZwwgXfk90DaKlYpfP/fkforCFjRfcCGg1PzzBuHUbe4UC8KjHDw7pc7Fdvq
         AHaRWe4HyuvuPcviYulWebVolSWtE73diELmsBeyJ/dM0Kz2uKD4ETpcA4/tcPaaIKJV
         VVrhWEbLg5rhyZ1yL2KXRNcwL1TtB9XOnWKktJMRsMcOxJs6leb8iSwnfDGFiuTuqMii
         Q8ejJfNCFQtwUyMlokGb7Q+4yH18Dx/RpNeRrhS6lMOBU+rBxDf6r7FNeZhRAWqoI4RG
         oTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iGIlqhxSlWfDFHRJ6mC4b3eFYcIQYybstvvJnU9esOQ=;
        b=FdZR+dPW9NZz4egyrUgcDq59KpOjeri0u4tzqbh/FpRVkw3CXRvYzTU9TL+sDbLemH
         VKKo7Lu5w80NUr9QDtMWPKiyRf8bm1Dc6/3wWzgosLsVWDYHEEnybzoTJHLXranHpIab
         H9WjQnMTyex0zNIvnMPyiXVdHOFBr/blhpJay9AHeXmf68HIu5zu2U0dtSijQZ8BPjn4
         tzDSF0tluDsJ6EiYsSwlvo0s4waJiTMvTZxbxbMaQQ4O8r3QqZPKAcPedU9w7zySVv5L
         TkWcdV5t73AIfmogstCgzm51jBkAY9wP7GAot2KmxS2U+xWr39CDgSEwkFsuT15ve0zC
         BiCQ==
X-Gm-Message-State: AJIora9Jegym/3eCnGVhouFoGqRJm/yfzsrZrjvn72dnK/5CsEublzX/
        eJt8/eUZpg9ubUkPYCQbp0Oxqw==
X-Google-Smtp-Source: AGRyM1siG1a6lGXNfYqKnVxqm2uEHALLXWVQNvG6wDpmJgK0FropWIFYWjsRsqncZiQDfr78WgDjoQ==
X-Received: by 2002:a05:651c:4c9:b0:25d:8599:5637 with SMTP id e9-20020a05651c04c900b0025d85995637mr16842827lji.163.1658298506308;
        Tue, 19 Jul 2022 23:28:26 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id j28-20020ac2551c000000b0048329aa6c92sm3607514lfk.139.2022.07.19.23.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 23:28:25 -0700 (PDT)
Message-ID: <2a19c8ec-ee4e-5a6d-b2ac-a25ef080cd09@linaro.org>
Date:   Wed, 20 Jul 2022 08:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: media: mediatek-jpeg-decoder: Add MT8188
 compatible string
Content-Language: en-US
To:     Jianhua Lin <jianhua.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220719100214.2096-1-jianhua.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220719100214.2096-1-jianhua.lin@mediatek.com>
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

On 19/07/2022 12:02, Jianhua Lin wrote:
> Add compatible for MT8188 jpeg decoder.
> 
> Signed-off-by: Jianhua Lin <jianhua.lin@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek-jpeg-decoder.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
