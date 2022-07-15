Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FAC575FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiGOLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGOLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:00:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9B85F99
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:00:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d12so7200772lfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QCQCmBsf1DA1Wn9Db/rqbLuUpiiA+4ckSDT/a9GkcLg=;
        b=KLG+3UnmIBqTm11CZQOXA3v5XkFnjQ3NnsSIXk+Wbxp3IMj+ntYW/QzFmMexKmI7te
         gAgfNJ3enlvskxm9V/tqzEtAuVRUEmINkLeGnHOPQjTykdPoGNfqWjYOlHWsJKKaJKos
         ACweysGLbgiJr9pAYcdRSj+V6Cshr5G6oBLVBU1FXIiwRGWqmPyr5fLQ1NUihkjqON6M
         DZZbepq07ojP6/3sPvVU35YNZ5urb0g47ARuOONZB+FXDSRRJwgM0gQdiDAipXCz1x84
         un+8cOEheNXU8XUopXTBigTUSznJ5QIuiEqYSKFCD6eeMO9SwA0BBK8kCmJ8jafHEh5r
         2CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QCQCmBsf1DA1Wn9Db/rqbLuUpiiA+4ckSDT/a9GkcLg=;
        b=EBK+WVnLOAqeFqS0umVvXQNht9ruKG4ybd8wqyok17mLCnE3l/TVCHFh6fat6GwmQE
         RDkocy1Ps+/o/tXD4oeAb3LGX5hmlyHcAPlmhF1E4TN8LmIxoXfRAY1Hcv9fwxHxc5yW
         Fr1SM37SCBzLYxCLCeV+cnqzg/tnfgUhWR/JcJ1nfmLmbiEx0ThOwSMFKwQk30rDgygW
         8zO8wG+VxGNa/ems7D8RiAZ9uciyYGh9eNBXR7x4woY/loVijucDQ6UTBRbNuFifkTza
         Kz/+l4TndZlaKWl4UJwuoIZaFPCZzIUugC2x5hZTJrRhnNdrUjziziAXFNl6O5/r3rla
         8ibw==
X-Gm-Message-State: AJIora/gwq3GRMzKQ6vFIFn0+bAEqBx+38B8JuhdO1o7HXqn64kwelv4
        aqTHy/KsVUU5ySnRJ+pga2JyVQ==
X-Google-Smtp-Source: AGRyM1uud0vYpm9BdHaEw4F/cDP+GmNnJZYc1ROR+M3VRHmuHg9rOz6vgMJzDj5ccZj7a0ziUcFdBA==
X-Received: by 2002:ac2:44cf:0:b0:48a:1251:1cf5 with SMTP id d15-20020ac244cf000000b0048a12511cf5mr5145684lfm.680.1657882827338;
        Fri, 15 Jul 2022 04:00:27 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b0047f88d15ec0sm842600lfi.251.2022.07.15.04.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 04:00:26 -0700 (PDT)
Message-ID: <937479a6-8ad5-dc38-3c8a-f972993d23e2@linaro.org>
Date:   Fri, 15 Jul 2022 14:00:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 30/30] phy: qcom-qmp-usb: drop pipe clock lane suffix
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <20220714124333.27643-31-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220714124333.27643-31-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 14/07/2022 15:43, Johan Hovold wrote:
> The pipe clock is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the clock name.
> 
> Update driver to support the new binding where the pipe clock name has
> been deprecated by instead requesting the clock by index.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

-- 
With best wishes
Dmitry
