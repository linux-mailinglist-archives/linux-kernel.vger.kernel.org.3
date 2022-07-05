Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFB566776
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiGEKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGEKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:10:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082113F9C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:10:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q8so1442068ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MW//Y+wR/vSY0K3bV7bnkLXMyA5kq1WLa4rsDsrZzYM=;
        b=LXGG6cVx9PTAR+eVRqh4QX/8xcZ0yH8Zqyf46z9wtK/bNWSZHtYWyBUga41j5N+399
         fOITRMf4Yg4P2krytBwY7D7JCRXtuOzvhUrhL8bh8MrcwztzThAecyHpNQiv2xh17L9i
         d08HqxxH0m34frisD8IrNwo6gr4BcQuLxsre3oALeYQ9Yw/7+yg4TNGdbvTyjLjluiEu
         cSHJPG9u8MfqC83GoIw2GftOJJDc4uCrMlubpn/tVByeCKTCmPXm0ZEF6uK9JaAwpXd5
         C8+o5VwXPrbPOO2dcPsp/xLlslf5mF+E2yce02RyoENwJKK9DtPatgMD4B8OnjOZ6A0P
         YVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MW//Y+wR/vSY0K3bV7bnkLXMyA5kq1WLa4rsDsrZzYM=;
        b=FbEn2SmKcis2q7oVz2kLm/ujjT8T8T3/xpKD9tQz9Kw3uGQnkGHXTe7T3lGspO4bYi
         GRqE4IrHQVjZXKYEi4U2XF73WN3uQi+5XTRSz4ucqUT9cXolA3KMXTyFvWALXhFYJOup
         +Szp7LfGTwzOcw1v9k5VGxUK1SMZjDtuirkWKOVZZo/LGi5SKgN+vF3ghRgQEq9HUeij
         DVQAzf9F0dxHwJphZuUY1CfUZrKpa/tsQUDSLBBbPXRAx8rnSYgxVoT7WDEatrFy/s07
         GCd9ttyhsEE0X9xcaCCmomCYkS2fxBjMG5cNo5Oagv8ktQn37d2Bi6dt+hW3HaOr1bhg
         bvFg==
X-Gm-Message-State: AJIora94r91qiLhZi74eXgT6SVQ+AQKqR9rujjqJUMlO+ktuH6xV8hqF
        o5+CyE4ZKd+H33+6c1prDS6UlA==
X-Google-Smtp-Source: AGRyM1su7snhFPRmmJMJWWGbBcIcFnm05JIMB0vnAYIPVE/AHQPavbtIl+GOGWg63aBZXWDf7ILiPg==
X-Received: by 2002:a2e:818a:0:b0:25d:2bc4:491f with SMTP id e10-20020a2e818a000000b0025d2bc4491fmr3240288ljg.133.1657015831938;
        Tue, 05 Jul 2022 03:10:31 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id y18-20020a05651c107200b0025a8963946csm5452184ljm.135.2022.07.05.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:10:31 -0700 (PDT)
Message-ID: <8271f4d5-e12e-ddf0-46ab-86a39577755a@linaro.org>
Date:   Tue, 5 Jul 2022 12:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: add
 example node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-10-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-10-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> Add an example node based on a cleaned up version of msm8996.dtsi.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Squash it, please.

Best regards,
Krzysztof
