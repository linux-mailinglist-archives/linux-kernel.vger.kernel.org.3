Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63041565A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiGDPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiGDPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:42:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1361146E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id i17so6750740ljj.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EcZ5rQhAoacfdlYLguMbSs24JZeR+2Vf2FW6PLncyKQ=;
        b=McfHBD7uZDzpFq0p7tCEt/hUOtzDLANUWL72At+to30fVSjPI8WYK+MOljH4tU6vce
         9YU2YeO1g//ykXVxvn7LDrAf38/KbiX9YnvCQehKw2HpFN47IRtCdrcZpV7oHBvXZ/A2
         1xJQfJpT3Zx9x25Jn+BtSM8h005wwNt5GTY1i8pXQAXPPsvIxZ2kXzJud3I7qxKCqXJr
         ku/A+uoczH2BIZIIrXPZrWD/Jpb+TddDriflmt19SVih1U4oisV21JHfLTVld9dgEnyG
         ngyXNg8ZJfaGLv5M44cGxljWijjyh456ZC/SJQ2gUgHNfthWvhz1F1XgufEZMj54J5Gx
         V+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EcZ5rQhAoacfdlYLguMbSs24JZeR+2Vf2FW6PLncyKQ=;
        b=eSTmBigBBB6lGhgBkt/Zoy05u0cAwGvKiLP1KTgAdbyV93EtwzeHRX8Rm7/rgaOMSH
         INbSXPy+/Hq+cwD+eeerXJQ8WLx2txSVsCPaYlXXIV89d/8J97Gx6R4+gp4vQltcctca
         Rbfb07ncBSrAcrRwbo/XSnLdHoNUpnWUu7YowG7QMR8wjY2GWyWi0kzk/T13Z8h42vQx
         SW7nn9A0nrj1J6LWvT/ShfWfwT7E4GhrUlWQV/ADrPzSkBVsVrLy53empkeMux/nX+c7
         27S6p9j3AlYVurOrTXcEJ8zDajz4dN0vBEeUIUCuMC3RZ9Mha2YVLuclVezvwK1RHdFM
         Spyw==
X-Gm-Message-State: AJIora+ln1Ur6J/qw0m2MiZ20MWukpZF9cCR6pQL/SDCgQBFfDRLYCBa
        VCeTBaN1DtFiSvTvefHXOREUtA==
X-Google-Smtp-Source: AGRyM1sOChkfy4qCYFd1OxMV2pqpXME8Dth7bbMT8uv5pyETHqKQKM1J+eK6u3Uot0Sh5fa5/Xo8ww==
X-Received: by 2002:a2e:844a:0:b0:255:46b9:5e86 with SMTP id u10-20020a2e844a000000b0025546b95e86mr16069055ljh.388.1656949368138;
        Mon, 04 Jul 2022 08:42:48 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id g2-20020a056512118200b0047f701f6d09sm5189380lfr.184.2022.07.04.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 08:42:47 -0700 (PDT)
Message-ID: <4ba83a27-08e3-dd43-1a37-9475ad60d202@linaro.org>
Date:   Mon, 4 Jul 2022 17:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ipq8074: add reset to SDHCI
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, bhupesh.sharma@linaro.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220704143554.1180927-1-robimarko@gmail.com>
 <20220704143554.1180927-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704143554.1180927-2-robimarko@gmail.com>
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

On 04/07/2022 16:35, Robert Marko wrote:
> Add reset to SDHCI controller so it can be reset to avoid timeout issues
> after software reset due to bootloader set configuration.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
