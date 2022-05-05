Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AEA51BB84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351806AbiEEJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351713AbiEEJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:14:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380D6165
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:10:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dk23so7490411ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c8YCaE+5K/dsPc+9iPR/du6PTroxvuxyU+b5yayfxT0=;
        b=BR9/PiFUmueB+D/dPuLP5gschdU/Btt/V6TifIiCR9DF9iMhXyAll6y6HgiXExHK5f
         LCVDrMZOR/Kn+bqkWVXn1PHgfgjAbOlqka3Iu1awF0njedHmUvHbvwbnMVW/mnuaJcTN
         zSe0NjynuCAT9rJckKeozN4VOfdarIDSP2C4abZ3zH6fK8QCWzDJH3bFgx23pC0e10yX
         a8nPQqMNzz4Ftzl9gTIDqvSo8tyjX09k6MqEhCJ71sPOqnY3ZuW59KgBVzv6f2V4Vdwp
         VBbQ6bvT6rn4vslTrJSz8so4skmLZe5YuaKHws5ojTgR5418yqOhNzZUMdzZY3Xp84Ir
         LPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c8YCaE+5K/dsPc+9iPR/du6PTroxvuxyU+b5yayfxT0=;
        b=iEJeNFLpF6AL5gWoWk22a5eZA3fWeegGYVKugPPW5d+u3q0cpS/ctG2pbkEvpdnG06
         EDAOrSBS/PEppIMGsHAL4lA2LAB3HysuHBaDagoWNOL2HssaAlJbeP4QgiRulvFelQ3P
         /bnMfF3oibrnGSoNLmdWVx2Y8esPn4o9zwaUThsviBHdaUglc9HJGbBilVTPs4ZPq5uc
         5SEifxe9jb7sfc+cV8F9oVXCB27S227UZ4vRZLjqYp4+VYY2UT7GTfBrbBnfKC8S7r6S
         w3Mw86ROfvqe8GNDypAiu6SJNGnj02vvZga/+dBzk62YsC3t9Ly6k7u0U6agDkku2o/f
         KV2Q==
X-Gm-Message-State: AOAM530PnYXLow8Iwvy8oog6eOPqQdMkwmDg3nQc8vjDMqTDjA3420qW
        2ga+JW3+1n3esqpMhPY9NouD8A==
X-Google-Smtp-Source: ABdhPJz7tsXlNRMPlAktkJhnba7TvMyZHIV5xs8SGanC49KbwY/dkQKKC6fYnLD9+ao8S0FbRuugvg==
X-Received: by 2002:a17:907:1c24:b0:6f4:ff62:a393 with SMTP id nc36-20020a1709071c2400b006f4ff62a393mr643548ejc.154.1651741820790;
        Thu, 05 May 2022 02:10:20 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id el22-20020a170907285600b006f3ef214e1dsm511229ejc.131.2022.05.05.02.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 02:10:20 -0700 (PDT)
Message-ID: <e0af5143-7fe1-fa68-25c0-eb81d695844a@linaro.org>
Date:   Thu, 5 May 2022 11:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: remoteproc: Fix phandle-array parameters
 description
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504094143.1272200-1-arnaud.pouliquen@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504094143.1272200-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 11:41, Arnaud Pouliquen wrote:
> Replace the FIXME by appropriate description.
> 
> Fixes: 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml      | 16 ++++++++--------

Please add "st,stm32-rproc" as last prefix in the subject. With that:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
