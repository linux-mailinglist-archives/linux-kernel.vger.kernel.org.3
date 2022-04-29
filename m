Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519FD51565B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359731AbiD2VFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378579AbiD2VFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:05:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2CD3D9B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:01:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d6so10373929ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+hPInKpIDooHrKupF5RNs/2guHgbPlSDYet1zTo77CM=;
        b=wPzuxVUyq4buxSFTI12310NVqICUJ/+JXnauyORm9IhtDwlBC4TKSS92rTZz6IA0Ze
         gAS8gVzLn+NAo1j/nyet4r/GM76503xZ9FqFlHnZ2runqv7n6clIoPWxv1v3AAR/jmGP
         n+Rcubc4fckTLI+f7+LLY3m+eiYdvGK9nxuFBXPp9cWmKPYniazuSyTwGgdzekaUjP/N
         XfC3JZhWEhlmU89UAGAadAp2ug5ruorPWZljOrM4brVnI4vNixQVHZAj4xHb79MtSo99
         XkUvaF/P8IJmzMEJ8Yu5E4Aqj+bOROp2URTh62M5mCQYNVJXsKbO21KrYKEOxbvK0DTp
         Og+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+hPInKpIDooHrKupF5RNs/2guHgbPlSDYet1zTo77CM=;
        b=1eWW52xayPV46wCAyNiOEbXXtKlALfRsWDDT99lorB2k1+OQWXexo1EvX/1k8fq7t2
         IGXTiXgC9kl3QT7EPCPx/9lQr4jOnQeaSwmwaxqvEX3niFBXOK5hIgydi3IS0Wn7im+P
         eOBA2fnAFt+TD8mrmZ8tsL+YJYouKa6/3GI+KcOLaxPee2GMzD9yPNrDDFvx2kscK1kP
         ZjPgF2tl9iU0EoefiDCnmS8iHLucCBpPEIbOPqqbKThEJq94zwbBF42GUtsVCMzh+g5q
         ipQZvoFZSJQ5YO2dzHvZmQz4asWlscjByiQ+cmL0HP2TbIjV3WAG2DxGcbBwTc+aQN/n
         CfDQ==
X-Gm-Message-State: AOAM532TWCQiK+w0oNbM+LjHFYXmqtUt5zhfhMyTLHqQ8KSjAucyZk8a
        k1Tw+3a6BIXhdNGk2iljS+dwrw==
X-Google-Smtp-Source: ABdhPJydYUfzRWWlb7jnujGl+WeNXPkeDfWil6Fvx7LhbEmTqT3D2ffUa0UXb/8GKmomagoc6J4XoA==
X-Received: by 2002:a05:6402:26d1:b0:426:3bc9:67d0 with SMTP id x17-20020a05640226d100b004263bc967d0mr1160939edd.400.1651266102271;
        Fri, 29 Apr 2022 14:01:42 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7d1c7000000b0042617ba63b1sm3379674edp.59.2022.04.29.14.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:01:41 -0700 (PDT)
Message-ID: <fff7c77f-452f-2fe4-b405-a6f65e483d3e@linaro.org>
Date:   Fri, 29 Apr 2022 23:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/2] dt-bindings: remoteproc: imx_rproc: support i.MX93
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
 <20220429005346.2108279-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429005346.2108279-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 02:53, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 remote processor(Cortex-M33) compatible string, and
> reorder the strings in alphabetical order
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
