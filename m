Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6757491C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiGNJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbiGNJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:32:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D22B256
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:32:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o7so1825554lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qLoqEanmHmcOVGRPRRT+aRCQvQ8+n03ZqH5LbbY6VbQ=;
        b=qqv8VRNxws6KBp3n3JqlUE94PaWsQnNPeJTcW/Zk7KymYZX7T7kzAGVhLc59C3qlh/
         qulRUDcoyjV10n2ah8TyFSr2vEXvjiN3x8/RyNmP8z0G3blX//ngjPZQ7Yj5JeVcp5FN
         Ldlqh03s7WTVuguG2fVxH4JFARBX6Y5B16CsCvgLK1vGMM3URMXAC1rZ/1+aApfS49cM
         hbPwKuQz++OeyJcZhaRdnycCqWgBjERj9nfqySGAix7X1oxJuZL17naBCWNdL4vYNniD
         iu6dvXxReYpHt22xT+z5OUvg3zlOtLBx6TlDZK1vq9OKaf4fITbpDzIUM+r0W8Zrm3St
         IwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLoqEanmHmcOVGRPRRT+aRCQvQ8+n03ZqH5LbbY6VbQ=;
        b=CtfkIwQmQXfrWqghpbrWxVnAh1yO8A3IzCgUAa6Ick4vX3GDF3GqQ02W7Jhxk2/S7I
         Zz0h6FVBVxeJPYmGlneMYRjrFbuJ4SOKEXUAbY0Gi3axuQmd5eqder7ibJ9plNnp0lOe
         Gzt6Vek9rA7qaIj2z2Tqe2uvNN/dDhm2z3v2he/QZicL5bF+Nbi7cJyyl/7uvHq8Qdxw
         cYuqI/n+nTG0U39wWfO/vMphfjEyESuYm4DSOxgBJVwZtPdGdmDU3HdzlmslcN/obu+U
         Qg9lgl2BWRNvB8YdjV+Qjo2/6bT1bNZnN7uLlfgShrOkftBaaenhQEvtdnXUrNY0vV6C
         KSQQ==
X-Gm-Message-State: AJIora+49QwMyNffL3+TBqRJzELqpVsGYihsjJ2EVVhoQjj4PSUM77fX
        cPTxkvWg1GEqQyRlqKO0lVJQjQ==
X-Google-Smtp-Source: AGRyM1tQqgmtfH0+ObvZ9P9WicC7fls3gdqpTXkF74E4fFHf2mZS8SoD7oxLCgJUT0sZDQDXxkXz7Q==
X-Received: by 2002:a05:6512:238a:b0:489:e6f6:c13f with SMTP id c10-20020a056512238a00b00489e6f6c13fmr4982398lfv.673.1657791122376;
        Thu, 14 Jul 2022 02:32:02 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id f5-20020a05651c03c500b0025a724f2935sm184502ljp.137.2022.07.14.02.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:32:01 -0700 (PDT)
Message-ID: <2a7c5cb3-f7a6-8953-e16b-5675e62562e1@linaro.org>
Date:   Thu, 14 Jul 2022 11:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 30/30] phy: qcom-qmp-usb: drop pipe clock lane suffix
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
 <20220707134725.3512-31-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-31-johan+linaro@kernel.org>
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
> The pipe clock is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the clock name.
> 
> Update driver to support the new binding where the pipe clock name has
> been deprecated by instead requesting the clock by index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
