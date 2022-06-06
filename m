Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935F353EB9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiFFPhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbiFFPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:37:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD66120BE6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:37:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fu3so28220138ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TPOApYvb6Wxwe5KarWLI1DK2xlnELfMdmLjwPBhUFmY=;
        b=xrtvxq07G0Balt8gqFW0xfBnb/KqOGRnSXQmweTC1TqHRtRmMB5Bh3SvoaPCjDVZAl
         P/aPuE1HqZbPccP4zpOozDQ9Gq9/m5EvyK7WlkVZX4c1s9eK/NG2S3AjSAcEIOfVOjaQ
         736slRtSeLnDfPGFQLrS1Fqyv3hmnkGTRWxg+UIjmMUXXCP13AIhHnFlGyJBerj6kcUn
         05eA8tuaZvVdnTvXm0Q9jc20DHMXiNmttyvKF6udj6REH04kfJ/lUQAMRvhTIsumMwlM
         IH+2UF009KRW9/MJSIKfUEiw++VZFKtsS3FSjqjUZHETbMSyq8CkbvciVrO3ki2IhNZJ
         1reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TPOApYvb6Wxwe5KarWLI1DK2xlnELfMdmLjwPBhUFmY=;
        b=ClMRkQWma3RoppdAmXYCDd4pf7pJlTMa2XuR67tIIIpoHQCnFQK2Btzl8AcYmf5quB
         E66VLbN3x2cAcvNupxTeIxPV7/+nMiD/nGTUf+AfU+bBL3oR7aPpv8TiRKxtsT7+Z0Zr
         cbCdMs5cGzff4Au37TzfRt+6sXD5j67NiowiE+E2I+bvBELlwP1gci+Gcrq5wp74ys6d
         Twk960k0us7om+W2c3MBPEL89LholA3Su7F6VbKGSN2PR1BZtOKeLorxjg/kKBcOvk1Z
         ZERR7VB6d55OiCRrLlz7hO69bHo5Zi73reQIMQAe6ApDQq/ipvH4rDwXA7/ZqONmjwvq
         Rxsw==
X-Gm-Message-State: AOAM532rE1fT5e9fYbIXEPmKncg4CR4zPZOCQRtjOwkgJp29nuCMjYNz
        kBW1qRL8PLErjrvU0UqwhtvONw==
X-Google-Smtp-Source: ABdhPJyTldoWxgNbTyUfoG0DE5atMlvTxvy7y3jeS4TIndwvgOwStVK1T0DxwBIHX1tbTfm5woE5lw==
X-Received: by 2002:a17:907:724a:b0:6ff:2ed0:960 with SMTP id ds10-20020a170907724a00b006ff2ed00960mr22376130ejc.480.1654529859405;
        Mon, 06 Jun 2022 08:37:39 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e26-20020a1709062c1a00b00711d88ae162sm669769ejh.24.2022.06.06.08.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:37:38 -0700 (PDT)
Message-ID: <8bd4323e-9005-6a15-b94b-c49427fffa68@linaro.org>
Date:   Mon, 6 Jun 2022 17:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 19/23] MAINTAINERS: update maxim,max77693.yaml reference
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1654529011.git.mchehab@kernel.org>
 <6a87dfb278765465d82ad4641a42ae4de0ded392.1654529011.git.mchehab@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6a87dfb278765465d82ad4641a42ae4de0ded392.1654529011.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 17:25, Mauro Carvalho Chehab wrote:
> Changeset b38213c6118b ("dt-bindings: mfd: maxim,max77693: Convert to dtschema")
> renamed: Documentation/devicetree/bindings/mfd/max77693.txt
> to: Documentation/devicetree/bindings/mfd/maxim,max77693.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: b38213c6118b ("dt-bindings: mfd: maxim,max77693: Convert to dtschema")

I look at that commit and it performs proper update of Maintainers file.
It is not the commit which introduced the issue, so the fixes tag is wrong.

The commit which introduced the issue is I think within Lee's branches:

Fixes: afb67df31a8c ("Merge branches 'ib-mfd-hwmon-regulator-5.18',
'ib-mfd-iio-5.18', 'ib-mfd-led-power-regulator-5.18',
'ib-mfd-mediatek-mt6366-5.18', 'ib-mfd-rtc-watchdog-5.18' and
'ib-mfd-spi-dt-5.18' into ibs-for-mfd-merged")



> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a11aa7ebb6af..dc64a23d0bdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12118,7 +12118,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
>  F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
>  F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
>  F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
> -F:	Documentation/devicetree/bindings/mfd/max77693.txt
> +F:	Documentation/devicetree/bindings/mfd/maxim,max77693.yaml

This "+" is not correct. The entry is already properly covered.

Just remove the max77693.txt.


Best regards,
Krzysztof
