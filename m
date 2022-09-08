Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024245B1F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiIHNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiIHNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:32:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF695FF0B9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:31:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c10so10417308ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=K8lsIXUFAXFlvET6IMdtGmpuoPDOZDFg3zMmcGfzIwI=;
        b=Z/99+K9k1Ibo1tPR+57rjDoV1qxZEgDqsG4vHdLURL6Ny+9TcaB2J1SYqWcU7A1zyk
         CyXUHCGgSKb5zWrMdM7QladzOgHyiasHGw4ND6um6GpoNPg7P71NVv3pIlhATtFkQb/4
         3+9TOmp/L40w+0ifimb7Qb/NsDhgPIfAa0GSyeJa6aTCsJG9NFaXHasCIV3YBuPi6fGL
         SNZUZwB4K+TRpdtZfBFUdis0gP3da46HfwiLA1uVLNUyIZaQy7CmwpVTyHWnpSXnMxnQ
         UZ/cAlHiYMjU++z2lZrEkqJqM1vkPXmR6c4x0MMZOX6+AvHtk/GNxOU+jxHwfpEhfudg
         mYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K8lsIXUFAXFlvET6IMdtGmpuoPDOZDFg3zMmcGfzIwI=;
        b=nwQQA39BUoT4xS8fnRffPj/cMyQklCaO8STcNH5zRq9qjuwn71jHyO9Uwx+geF1299
         6zgIFzqhfTnoBcNxezsxCio8JN3TQosXTIINtLhXlJLNs/VIivKkw2+4s52nQQWKAeci
         snBfbj06s2jdDLn4Bw27DBCgg3XhvHIcRnSlanOi+9Mad9hB1lch4hU+pyt9Jo0EliGt
         S+w1FVqEbHJY+mvO51MWWtTlor9yVXrXZYiUtiIuJhk6IkHdpM8Xmw+g3sk1Uy9Sk+Y7
         ACiQOy9TJEWP8WTsb9iHHod2Fs2FKVvEKv6+YPhx+9o+oqKIz1iMBuDOQmi9w1AL2PkC
         EH9Q==
X-Gm-Message-State: ACgBeo2TmcKHAdtI5AV4gb4VGl5jU7roCh+GHR3pVCawk6a6rXczEvgp
        i7upcC9QPqGR0yAtmG6DA+27fA==
X-Google-Smtp-Source: AA6agR7n+DhBD0AHyU4D5+n4AgxeApq7jxVuKSkPHwBfUpELv4I4hWyE5YDn2Gmno7sD/lWJlZy0Fw==
X-Received: by 2002:a05:651c:12cb:b0:25b:fa3f:c3f with SMTP id 11-20020a05651c12cb00b0025bfa3f0c3fmr2611062lje.364.1662643864620;
        Thu, 08 Sep 2022 06:31:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b002688844741bsm3195632lja.126.2022.09.08.06.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:31:04 -0700 (PDT)
Message-ID: <06748378-f5a3-5dec-eba0-58123084c51b@linaro.org>
Date:   Thu, 8 Sep 2022 15:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/4] ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead
 of EXPORT_SYMBOL
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220908063448.27102-1-srinivas.kandagatla@linaro.org>
 <20220908063448.27102-2-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908063448.27102-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 08:34, Srinivas Kandagatla wrote:
> qcom_snd_parse_of depends on ASoC EXPORT_SYMBOL_GPL functions,
> so make qcom_snd_parse_of and EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
