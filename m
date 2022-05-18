Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C452BD5D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiERMnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiERMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:42:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABD1ACF9C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:37:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so3453023lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bjcBd0dxyOLx4l/iVB7YLxv3pDEKJIveecABs/FmMKM=;
        b=dEr8oxgz+QsG8iMxbxZ21rateVZFoCcOtAjB6P8Lk/o3e91YIV/tyvFUlciQrzvkQi
         ak2X7qWrrgXRkMIrBCfW/YQfkNL5NasaId+ZgBQ4EywCI5xIJroeyYGojdu5ECzD/vhf
         Rbkd50rh9mvFJaReOjdXaekKBLX8H/HG0SOuV039UcxdlOibl6WgtvsFJcWZLziEKAL5
         n72UBACaLSQQoSeSEKqCX9zdB5zjrUJU7ePMGxz1YNbJQIko+enDSr9JB5ciDW5OelDm
         2Gsj1tXn5+kpo778SO40n39xuRWHsWRk4lrybwenApCRXhlCJ1nJfVm0QijYhBgr2bJL
         59TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bjcBd0dxyOLx4l/iVB7YLxv3pDEKJIveecABs/FmMKM=;
        b=wt7bW0/elSusru5maJ08q6TGqbKTnK3UJSZCITFS1nnMkz+dUXevY5wKHwfOFnjoWY
         zJyo9+KHOw41C4slP0h8/cMk8ygcPeTNFuGn5YDi538cHAjryiGLAZn+jnJ19qHHpYm9
         GIVCTMx51MIXk6JiigqvFrrDMfU/QqnmzhIl51zROuZVQ+Z5IFDCjnfu/8HJW0Jq4lsL
         ftjQXFhRJimZrbb8SIHzFJUXOp5YQ5RlrQcaWt+HntgqVpPY8QsK0ACutitr+J2Q/lvC
         xiL0svbGMMFhFKjE/T8j0r+a8szwO8M3psFFUPVFg/VF5lc37njVWdWh2F4ZHyHrXJCF
         VnDw==
X-Gm-Message-State: AOAM532pQKAF6VCV7nEkiwsdjoDqvwFOQAVT9dmHnrrIT+mKnmjCKl7a
        oGrO1rQ99hVzDnCIxPgWJdgFQihKDTyXj/5k
X-Google-Smtp-Source: ABdhPJwHMKd/jdGmVLU/ZeYiatYQeLrhAI3N0HVLhUBn7kOKFKlKZpFS1pwdOKyqn6Tt/LpUcqFjuQ==
X-Received: by 2002:ac2:46f5:0:b0:477:bc14:f03a with SMTP id q21-20020ac246f5000000b00477bc14f03amr1376980lfo.608.1652877428730;
        Wed, 18 May 2022 05:37:08 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a13-20020ac25e6d000000b0047255d21123sm201360lfr.82.2022.05.18.05.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:37:08 -0700 (PDT)
Message-ID: <4c9b7f31-4473-fca9-0e72-2f32e0983479@linaro.org>
Date:   Wed, 18 May 2022 14:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] dt-bindings: microchip-otpc: document Microchip
 OTPC
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220518115129.908787-1-claudiu.beznea@microchip.com>
 <20220518115129.908787-2-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220518115129.908787-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 13:51, Claudiu Beznea wrote:
> Document Microchip OTP controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
