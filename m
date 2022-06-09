Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88CE54466B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbiFIIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbiFIIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD10E149A9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:48:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id s12so38873828ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0FrUfxGjJdLOSXTrxUdjkVL6nrlzjO3+JUo/vnRLcSA=;
        b=KMK4oI5Fxe0qAHQkJ9CRo4IKa3GThd6bcTMU9rPxWbxZqBQFMskPd+ihFJHP4JcnZ3
         XmY244lJqm4jhVPAye8YmfOGsXd/Bvvxjp0Fv9phkeVEFmoa81HLkTohIxs6I62s2ehf
         GHtq8jUZKG3ijDVptmfLjIlJWIMxE0PgMbMlQLjQJjgwSfsxXoIKXDNU2nSLpAHJx89S
         0o7tM13z5DXSV/8hRHefRz56S5a2PyGLBn7q/ETGU40Ym5n0UH7P1vHnbfcvJtT4++6o
         5C8rLdB+EO/p9c2aw6/9lyHwuY7Bu/V4QDKR92OXSqeOnii9+OajsSWAZbWuo0mdkoMQ
         U/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0FrUfxGjJdLOSXTrxUdjkVL6nrlzjO3+JUo/vnRLcSA=;
        b=ztSqF8+QMzfKM/+IhuKQuiLtHUteFJLt7BFRORMEM+mR2qYrEDIH3KSfhsJ6hMH6Wk
         j8Ojd9+2wnITUh7aI6tlr3SakP0HYTC4o0RgAMLkLSSTqS1nfkY7/WCJ0Z0fgk1LL/43
         qoJ94IhfssCIFGAJqnSrTGFIiEh3MOXJeUGJ7CNK031uIcaQeIYk5CpYv/GE+ceueTX0
         ScGSsgNAzNuTx+8GUtu+GXHT4OUTTP35j6G0IoZ1Co5lIyInHGDaWytP6Ex1mex+99EK
         dgdQl6gvZxqyLSAV/o37dvhBE7mOSU92YXl8iyiCl/l1RVCg1TaeYrh3PI+IWoO24l/K
         hXdA==
X-Gm-Message-State: AOAM5325k4G3iA6hVDEwTa+OnfdWPffr42fuGNSP8ixiIVB/+0o1NH0i
        yfQBMGhuDWT+sajjHaqYgsqnkCZ/ncib5w==
X-Google-Smtp-Source: ABdhPJy8eOac2SjmBWPxOPqIBIeeBstXz50bOn/9Q8cluK6jx974GoDpH/JlagK8BogFTdJyDpkODw==
X-Received: by 2002:a17:907:94c8:b0:711:d864:fd84 with SMTP id dn8-20020a17090794c800b00711d864fd84mr15226830ejc.18.1654764526284;
        Thu, 09 Jun 2022 01:48:46 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b006feed200464sm10407049ejb.131.2022.06.09.01.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:48:45 -0700 (PDT)
Message-ID: <dbf1416d-03ab-dfb2-434c-3cab879afd59@linaro.org>
Date:   Thu, 9 Jun 2022 10:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next v2] spi: Return true/false (not 1/0) from bool
 function
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     andi@etezian.org, broonie@kernel.org, alim.akhtar@samsung.com,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220609071250.59509-1-yang.lee@linux.alibaba.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609071250.59509-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 09:12, Yang Li wrote:
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> function.
> 
> As reported by coccicheck:
> ./drivers/spi/spi-s3c64xx.c:385:9-10: WARNING: return of 0/1 in function
> 's3c64xx_spi_can_dma' with return type bool
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof
