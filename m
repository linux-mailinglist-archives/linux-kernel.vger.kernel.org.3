Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31288574DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiGNMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiGNMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:36:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270895C9CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:36:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p6so1994062ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BiNLu6xnGV9ZsmOkKtRu8GiJpJaUEre3r3pnPbEbxjM=;
        b=FHdgMunntPsutX4pz+6aGsb6vcE7Ixf2ZYUFoPTGHrEFejrLnyjAlfCD0ywMiGyRDk
         UfEhXQxQP0ZuNp/Z3UGCb5Q/138+hHJbn65GnZcA413gKMKOWlQsvHtuqC4VEAN+MXl4
         CBO9h4pCl2qqbpu2Jwulr+X0VkSinEp6hUW6PcfB4NIeAnab+OFrMAeOB+Fd63cvd2Ty
         y0a6XkU6jcb9YDWJ2EIDhVhhIlvrnWDCpUja06ZdC7BDBr5OJY3rhVES6GA/hk0r62Yc
         DZoNyyE3jzlCFZD3Dw8EIXi1hxmYPzzJicSNAP6YnxNW8AQ/l8Q8//SWZvLU8YKajMSl
         /ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BiNLu6xnGV9ZsmOkKtRu8GiJpJaUEre3r3pnPbEbxjM=;
        b=jMusv3TpirEtOzV0Rfb7RRyB8DntQ2hygZeZLfyRkcN8xnTIFSPDruO3DNJNj99+Kl
         9uOKqdAc7vzHO4sCt/uyUVyaJaJGJK8cestn9iN1fTnoP3TVUkxCjfriRkXfROqlnNM1
         4byM15XXFTNyHIAP8e7cboGJzVERiT0IEXYMKcHLziAUsWCNbLADX4uGeF/TOeiLX/Cm
         W6I6zpLv/OoPyCzEsX4Ac4W8cYIj9wCTbbEiaa4O+IfVrAKW9fepOmB+sJ/qM9t6LH+p
         dDDiJzo95NJiHhSGBhJsgSe/s+ugVSIBZKwKQcxcQQMOcDPq36q3nINm6LcoGDV/hFCG
         gT9w==
X-Gm-Message-State: AJIora897arJb3kp8fOcAd3GgfbNfwYEjuwqYXpNrkmjp/5tiUp0oSSM
        wM/Z0UbOAjvxzwgp1smKfeaDOg==
X-Google-Smtp-Source: AGRyM1ufjQDkB4prXpgXK1PHUIK0jMqKORD8LAVpBkL75jwLGc06XPfOU+ozWIva+N7ub5TXsI558g==
X-Received: by 2002:a2e:a3d2:0:b0:25d:4834:aa0a with SMTP id w18-20020a2ea3d2000000b0025d4834aa0amr4658241lje.272.1657802207546;
        Thu, 14 Jul 2022 05:36:47 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id j16-20020a05651231d000b00489c924497asm339568lfe.202.2022.07.14.05.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:36:46 -0700 (PDT)
Message-ID: <727e71b7-9f80-d715-7761-0c56af1cf1e1@linaro.org>
Date:   Thu, 14 Jul 2022 14:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: Document the SM8450
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
 <20220714123406.1919836-2-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714123406.1919836-2-konrad.dybcio@somainline.org>
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

On 14/07/2022 14:34, Konrad Dybcio wrote:
> Document the compatible for SDHCI on SM8450.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> * Add this forgotten snowflake
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
