Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36508578335
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiGRNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiGRNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:09:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12112775
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:09:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z22so5572039lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BOiXRJ89xuD3QarsVl3RRpR7eGEZVIxWI2G1dcCUd2E=;
        b=a6pHOAo7dTkZI8LBo4pVDo9fnnDq9z0Hu87RvPLGN6RQBbXW8JHX8ipc612pGM5UeJ
         9ZS9Xjx2blc/9QoWcyWzKSB8fd537aKctk6dJHumx44WxPk7ncljqMYxrT4t5XYipuvl
         oBRjiEMxx+us9dO1qKpD5QxSLDTWLbQS/xIZI/sixyjaJZoMVzt46HOvnKlQpYBtvvHb
         +29om5kre7KopOB9FUbJ4oVp5JFExnjg8edzv9h3Rem8am/n+npC220koLFB7zwcQ1au
         vTAxedzz6J5SPqL2VVGfc3DMLWYp4dyTp4sw+S+LVtX5T4lc3sp665NHmiV3tXE27oVS
         5+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BOiXRJ89xuD3QarsVl3RRpR7eGEZVIxWI2G1dcCUd2E=;
        b=3ZjVXVe+ge5RmVJqx3u3H4kr7KZOLnPjCJy2tTeHeaUcfNN654WIGZOOX1SCNf8Uen
         FdGleKc2T4ep7l9mb2YcFHQBzM5rzzAN3XrGMLCe1nlMzl4aCkKZXj4jdn8yzBPiHA4S
         PRlxRhjiyiKiL8kIXDKwb7w6jr+t9AoKNBm4W1OV+NoPkYNZ2+ZuhFugolA4n+ixm1ta
         DVnG0bI7HoS4TZnXOg/YIl/Nt3Ebz9KaA+7Q+vjTJL9GYHtneGfU1UZnSSrXAgmbQBBs
         gLjHD3B4DdmR6JGtbAJPGzOb/2cG/BPayYN3FwkBfKNvEB287XX14iOEMq6BvKQ8CFAN
         FyvA==
X-Gm-Message-State: AJIora+2OKsepA2libgHERGsyMnXs0DTg2T1V7m+aGPfJhOBC3Vr28LO
        9QQr2J854z3MbFlk8yQY+GSHXA==
X-Google-Smtp-Source: AGRyM1tpw4Sy5WpV1Ji1GnRm8jRqr6MFhp+pAk2JslLmag6yX1UfOOwWyNNTnIFCQPWnBF6wuZzQFA==
X-Received: by 2002:a05:6512:3a8d:b0:489:da0d:df25 with SMTP id q13-20020a0565123a8d00b00489da0ddf25mr15865071lfu.453.1658149745920;
        Mon, 18 Jul 2022 06:09:05 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id be39-20020a05651c172700b0025c04962b5dsm2098864ljb.139.2022.07.18.06.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:09:05 -0700 (PDT)
Message-ID: <abf9d787-d7a8-d202-560e-6c424f6a63f7@linaro.org>
Date:   Mon, 18 Jul 2022 15:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 1/4] dt-bindings: qcom: Document bindings for new
 msm8916-samsung-e2015 devices
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220715102055.3844-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715102055.3844-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2022 12:21, Lin, Meng-Bo wrote:
> Document the new samsung,e5/e7/grandmax device tree bindings used in their
> device trees.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Sorry, it's confusing. There was a v1. I asked for changes Then there
was a v2.

...and now is resend of v1, so you decided not to implement changes.

Send v3, with all changes applied or keep discussion going.

Best regards,
Krzysztof
