Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA3590F11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiHLKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbiHLKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:17:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319FAB43F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x19so728693lfq.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wrTNOhesfXnWUGmcgplYqSMMtykEUHclxdrOZJyijsY=;
        b=s/Wszsa9xWXXcb+E3yXMPOgdfqMtB8bVbq5jYzNgpIztkttS3wvUEHj7YKyC7FcWAq
         8c9I4Aozt6yFX7Rwinjm7binvK+YeLJO7NSvwIxBCcymdC1JNBWTySC7CRCYQb8JTPz8
         1JcyE13+9aG3xIb2SNW8TjEHjH5tydYCuloqoF9i1dWNz/PRQfsOgAnXhREpfFbKrKwH
         66FrqBKB5N7TsuDcxTSSPvQNlenDPPho3tOOZvtrqPpU+tPRylbCta2dcPFIpBHgJp40
         Uzit6PAnPVD/GL902ny1+z4PH8+II/suve7lk7Rw2OvdWyIfSGyKD8JwUjGUyjL7bZ3T
         ie2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wrTNOhesfXnWUGmcgplYqSMMtykEUHclxdrOZJyijsY=;
        b=zzdPnXa9c36sbtUaS9k68iJhE06iUNO8SvnIos8eC8lpMpGzBvPcdhYSmQ2iYCEDEZ
         ZOulwoHodZ8ttYYjxUEnvbTSOe3kyqhzyip3+0Zavv0yJGmcY6KSIXv7K11WyU9h1RgR
         4PVkYfqeTckD9PY1+/UcFZAQ77aJ2t6v9tvBQDWT44Gyk99Wz3tbPcosI2jOIz5crQNw
         htW3OT73yJZPV5x+CQsdP1/NBTJ61jmsizRiXx6xulwC6Zn9A6gzB7yCcUJP8XOHb9GC
         XDOGFjJicN/1rdWpL0pUV2yUJUtp+EHkIRwWMnPaWp4b2NlG2nr/+9kkUuRZmERkFjfa
         gS+Q==
X-Gm-Message-State: ACgBeo1p/COSBGEMEAOgeJ9qIlfumzhED+jQSN7g0/LCVqMCUsf44pfV
        LpHPOpQCy/KrPbI1bRm+J8KOZw==
X-Google-Smtp-Source: AA6agR5BNSl5cct0PJlpU5JzfIRjElsKmgAm7DP+dSxTjRkUa/3Mb3cy3BcfHdJQvAsCl+y9aP6Prg==
X-Received: by 2002:a05:6512:1291:b0:48a:fe0b:cd8 with SMTP id u17-20020a056512129100b0048afe0b0cd8mr1026853lfs.440.1660299458634;
        Fri, 12 Aug 2022 03:17:38 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0025e5a65afbbsm304844ljm.120.2022.08.12.03.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:17:37 -0700 (PDT)
Message-ID: <509a75ce-0451-215f-e3ce-acfaeefd26c4@linaro.org>
Date:   Fri, 12 Aug 2022 13:17:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sdm845: Reduce reg size for
 aoss_qmp
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812101240.1869605-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 13:12, Abel Vesa wrote:
> Like on the other platforms that provide RPMh stats, on SDM845, the
> aoss_qmp reg size needs to be reduced to its actual size of 0x400,
> otherwise it will overlap with the RPMh stats reg base, node that will
> be added later on.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
