Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33AB5748CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbiGNJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiGNJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:26:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183F15717
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:25:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d12so1782252lfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NNwnWPeD5mRbFNqIkyD+pTqqMFhALyWUWBLa+q1m/vk=;
        b=w/U2Ib08cu6VWEhiJkRblQLMSvBTtDz7j4qlNQtZxMc+Mi3OrHuTc+Mskpl49Se6eY
         p9yzf8xWYTkF5SayKsMSxNjdC1SWIsyyby9Vp2g3+hvBp/GQFAoEaE0J3fB2BlJD2Zta
         A/f2gxZrhGA5QFhQqi7X+H0h6tSYAefV4CFxdVNSqf1eXD7UFuUGGeYaRkoAQtbBEZ1x
         1uWnWnBWnvuZSpzeTDS6tVbbvHMGqOLVKoQlE8SYdEyqWWQHvu6S8rzd2o4EDA82PvDM
         CS/UQznDA6APOivjdgs4xO+nW5gSpON9MthZc5U1ev+Me+yPtvAj980LUsDyGZ/bp4Hz
         2KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NNwnWPeD5mRbFNqIkyD+pTqqMFhALyWUWBLa+q1m/vk=;
        b=ECvhVZ8E2mEnotSn7SRWnV1hLemSaYNEPJ4ZtoscaKSual426LYF7HXdCquUh56ywu
         yzINR71Oo2u2wb+rH/uoN1NY9jGP8cVqal/QfP4GBTbNKxNVLKL761S/J4XejCZbZ2yM
         E8stcwRT4zqKdJVur8rlnpn+BrbCbKzXNvn9p3t4Knl5Xx4u5VI5dW+c7fS9DiexfEq3
         cF+4hQgK3pAjIGmH2ciBzt6wSIysjdYwBV+GD4TpfJtwUVwstAfuPvxvl2ncU84/Jueu
         t6cY/wVl/1cx+vepg2blU/cXJToEAhfO9ET4iscK0kE0ZMclgC6sgXVrxumCGpmS31R+
         tAfQ==
X-Gm-Message-State: AJIora+QpjRsUxMzK/r4GK+wCLQqi2QSW/DFY2vI3TmdLop0wJFNQkKa
        d85HPnnMdl/IoyhniFhO4eA7IQ==
X-Google-Smtp-Source: AGRyM1uWrgChUqWYOMuYeJaQIptSFkQDwvmHHhgzJG6FWsn+s+0B3XZyI9ve6trSThI6ZgQIVZmfAg==
X-Received: by 2002:a05:6512:224a:b0:489:db85:53c6 with SMTP id i10-20020a056512224a00b00489db8553c6mr4476143lfu.383.1657790702471;
        Thu, 14 Jul 2022 02:25:02 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id u14-20020a19790e000000b0047fab4c3651sm259673lfc.85.2022.07.14.02.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:25:01 -0700 (PDT)
Message-ID: <9f226d8b-f5b9-2978-991b-69a37907ab2f@linaro.org>
Date:   Thu, 14 Jul 2022 11:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 21/30] dt-bindings: phy: qcom,qmp-usb: deprecate PIPE
 clock name
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-22-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-22-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 15:47, Johan Hovold wrote:
> Deprecate the PHY node 'clock-names' property which specified that the
> PIPE clock name should have a bogus "lane" suffix.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml | 3 +--


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
