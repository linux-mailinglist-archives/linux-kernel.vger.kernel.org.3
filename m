Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF157E683
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiGVS1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:27:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00B6E88E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:27:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t22so2518451lfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I1vUGpwMpvsFijcK7rMVb17fRKbm3rXcOPS4jhYHo+s=;
        b=mfO9qhrEMeDSmoRTcZLxZYa7i+qL705xCNjz0AxbE+xl4krndTWTvD+DNwwqe8gCjo
         G158X6kjFckVPHj+JnJoQRjMHr5shekolrNQRyzGP0neK2bdQ5/hhs1WGwAGNPcqmN64
         46fWG/datwAYc0KLUSDxYt3Bw2StnfXl6gWgvZxBFSspFy2iTgiYwqCPqijK9lRMC33k
         97/IO6Jw3yQ9ha9/fmnNOFxwNXuJWhyigtB/mPwctGu5zzi04DwYKbh8Qd0XT2+DuyWr
         zmhtq428dE5g+fcKb/VJETBIBy7u3rFhdWh++s53ONHWZDWRzSwI1d+uL3gzB7pcSn+1
         JvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I1vUGpwMpvsFijcK7rMVb17fRKbm3rXcOPS4jhYHo+s=;
        b=7z315QAxXHZe4pC6ZZsvYq6kzn1XCTqS/vG9PCG+Qyo6spA/8quqb2jAoTGbELa4aS
         H7cwuCeNd2B9L2feCZf6A+9IkviAcYN2/XC6g2YxMn1nVcs7Tb1cRkspZ+7qj9dxFS5z
         Qn3zZQZhQgVDcVA6+k670jexplun91hlJJ9B0umTp1i5vFrpTMT/iTCz7oGiDr4akzDr
         1QH/WuSf7a8/xXEQ5l78uKbBArXsnanErmB0QveYnSeFWHcr8bgzOCTzW/X6McdJAE2c
         GgN8v73HrHLwSUFJNnblAyULt2e4PNMh7aGTEmguDBJZqJwNW8jKdmhNvt8dGSIsfRM2
         4irQ==
X-Gm-Message-State: AJIora/5otSIpu79FXFTb0INMV4hOuj1RnTjuPJY7aehYjymXminecLV
        m9EgxN0JFtuIl5i5Vs9Dn8hYVg==
X-Google-Smtp-Source: AGRyM1u5s9vPRllug8ZcmUKJwD6rKM+iYjo9EoPGp5f+2bxpIwcItZExHlxKP0O+ZhB0AaukTIb/IA==
X-Received: by 2002:a05:6512:ac5:b0:48a:74c4:3d90 with SMTP id n5-20020a0565120ac500b0048a74c43d90mr443420lfu.653.1658514462023;
        Fri, 22 Jul 2022 11:27:42 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id b27-20020ac2563b000000b00478ea0e4f66sm1181083lff.169.2022.07.22.11.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:27:41 -0700 (PDT)
Message-ID: <de7fc091-ed12-c585-d39d-2bcf2bda37fe@linaro.org>
Date:   Fri, 22 Jul 2022 20:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Document additional
 sa8540p device
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220722142515.18592-1-quic_ppareek@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722142515.18592-1-quic_ppareek@quicinc.com>
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

On 22/07/2022 16:25, Parikshit Pareek wrote:
> Add the ADP ride device to the valid device compatibles found on the
> sa8540p platform.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Additionally - please thread your patchset. Git send-email does it by
default. If you use other tools - be sure the effect is threaded.
Otherwise it is not possible to find the patches from you.


Best regards,
Krzysztof
