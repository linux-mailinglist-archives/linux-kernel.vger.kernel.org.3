Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689852A4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348956AbiEQObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348934AbiEQObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:31:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AFB19280
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:31:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so31668110lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D4tC4CnESKBgOF+WHUt7nUFhsjNxOiCDiAL5/0+dEm0=;
        b=rUMZqKgaNmZMwXks9Jy/UbcRcIgVdnZbN/zHltL6ebIaQRXsWq5UkTyh0hR4Zzz9fK
         Xl6eE2KTXcqmrXbu/LQGy32ZkLitSI0Ym1d9yFnFtnN7GCQA5XegcoWnN+R+BpV+KCdy
         KKWF6zAqQvHtfWg+URqhrihJ0h50x9ddqm6tO3MbQ7nSc5oOQ1+aJ2vjW8V/IZZiRzKb
         JUfcZoJv0YBZ6yT3Lkmp4kzMaCSNhq5izazjXp4mqYQ5fkPTPR99EkvU9Ou9meAkYIUF
         CBBEyyyuHwoD2o5up4i4Qnq0Grav+d3JVtCvUQs4AdjqWIzB28dxjKt3B4FnbRiMkbWG
         7O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4tC4CnESKBgOF+WHUt7nUFhsjNxOiCDiAL5/0+dEm0=;
        b=l6J0aDZNPRZVmUU4Z9cZDJOi4XuQcGqa2gs38a+llVi30gJCcle7vo4VF8DgZ5vhog
         71VwWP8AI68hx7w/ma9LKgUubBdxSpf2eU4D90LV8SpX0meQA53qJSgtMk/B3sKtHGej
         T3KQ+86ntFUhWAkkKgh+Uy1kvVvsQ2y521528T3sYgWuzTB5b3fkPUFUlf4YFtv90fOY
         58qFvxynk91NSHgpUM0G5noNO9e8JoyT+1BXbNZ4vC6S/IHajB/wTVIbipRdiR3hJRbM
         /pAlD2jiLF8fDholnDUmii8YsFhJcHaMvmNd5KMlWkO7p3Z99V0kSz4lz2V81JsBhZId
         7gng==
X-Gm-Message-State: AOAM5315wrJPqRcAzZac9IFyM9KueP4901hIW2mODCJvzcKxiPdwIju6
        qgVJ6TJ16VWc8Tb4aySfc28nIQ==
X-Google-Smtp-Source: ABdhPJwXMt1lAtTIKCHzfXbl4frwEhcaGUM+J8+xGzgnu5RUnPINhXiaY+LuOMG6qu0c84K5UgTVKw==
X-Received: by 2002:ac2:593b:0:b0:477:a3d8:4042 with SMTP id v27-20020ac2593b000000b00477a3d84042mr2580626lfi.640.1652797866635;
        Tue, 17 May 2022 07:31:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b2-20020ac25e82000000b0047255d211dasm1598860lfq.265.2022.05.17.07.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:31:06 -0700 (PDT)
Message-ID: <cfb32aee-91f8-ce2e-3915-6a444e189c07@linaro.org>
Date:   Tue, 17 May 2022 16:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/6] dt-bindings: arm: mt8195-clock: Remove unnecessary
 'items' and fix formatting
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <20220517101514.21639-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517101514.21639-4-angelogioacchino.delregno@collabora.com>
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

On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
> There's no need for 'items' when there's only one item; while at it,
> also fix formatting by adding a blank line before specifying 'reg'.
> 
> Fixes: 34d3ed3b9a00 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock")

Squash it with first patch and remove the Fixes tag, please.


Best regards,
Krzysztof
