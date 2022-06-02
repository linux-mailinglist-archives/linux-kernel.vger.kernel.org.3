Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375753B840
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiFBLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiFBLyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:54:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B02AE9F3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:54:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id er5so5917560edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vOIeliejt7alaBs5Z2oxObUDKABevjusYjU4Erw/4mY=;
        b=YJooYZLbvzfCiXH7hmynBv0WclB0Bx7zYb20f1woOP2Wbun+rEuxhH9Ig8lve3Hgm9
         K/QnIXlrqF+Tj5pXPqLx4hh12p7d9M5ndQiRURcK7WeneFJ4imwpDP1vI9C/HT83Q3l1
         jwhWGEz0/cNv+G15/LB1ixT43AjIFUhtXzlHwiaSd08LmwYJevLxQUwNkvrAjZREk7rp
         TOxUjMlyvwLoqZJJTMeYj3HhktJHO/v3sdT3Nl8jEpJKShLRhnmIMqKHZUwwBWA4xuaM
         nCgIGHiER49uTZUYWdXMs6VyoKsdibux6BftfDRP8sQFiKvIPvPUTfg3yiJVdcrKP64f
         osXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vOIeliejt7alaBs5Z2oxObUDKABevjusYjU4Erw/4mY=;
        b=7IB6eQJEsoJGFAI53odZTu9S78ANi8B9ESWCXzQUwNjWZOW1ac/dpR1QBeH0I+uh4M
         Ux+WLOTnEJrBbrzS7jYnPxLlZiZmeIrgVVVSj+X+DcYpNvEqlMxol6Yed/JbE7UH5lqy
         m06UF6mSrtj0+AkmG0eq4+Sx14Un453obSUlITGsPBQKyml36WqPCxfM/ccmv/4ShVKD
         K9uDeOM9FOAxJ+dzRjeJjaK9QKmTIj/HBkpSniz7gaHuW0tbKFDk4tv/aD4J1PE3Ww3w
         bmykLwkcRxKk0DF0QtqjdIsQt0bUSaCRLy8IO4HJpO/VhOU3KyOalh3JTO/507Oxu9ej
         94jA==
X-Gm-Message-State: AOAM533L0Uy1hVN9a9VnKNLEsKBrByvDzZFI+LyP4D4CYIVF5N+nY05z
        xjxLBBRQs5lafXZTOCwZeNNd9Q==
X-Google-Smtp-Source: ABdhPJyuBYnlDCZglcVn7BgN77+s0u8EB/IKbZCpv2My0ik0lsKFRnylU7pqq1ac5iP/OBi+qH9hVg==
X-Received: by 2002:a05:6402:d0e:b0:413:3d99:f2d6 with SMTP id eb14-20020a0564020d0e00b004133d99f2d6mr5053935edb.189.1654170884419;
        Thu, 02 Jun 2022 04:54:44 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906694400b00703e09dd2easm1684636ejs.147.2022.06.02.04.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:54:43 -0700 (PDT)
Message-ID: <c60850d0-7369-fe24-e6bb-97a437166c08@linaro.org>
Date:   Thu, 2 Jun 2022 13:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add bindings for Exynos7885
 CMU_FSYS
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601233743.56317-1-virag.david003@gmail.com>
 <20220601233743.56317-2-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601233743.56317-2-virag.david003@gmail.com>
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

On 02/06/2022 01:37, David Virag wrote:
> CMU_FSYS clock domain provides clocks for MMC (MMC_CARD, MMC_EMBD,
> MMC_SDIO), and USB30DRD.
> 
> Add clock indices and bindings documentation for CMU_FSYS domain.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
