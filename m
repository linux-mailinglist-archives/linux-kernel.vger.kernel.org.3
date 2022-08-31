Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916075A7862
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiHaIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiHaICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:02:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4EB9F8F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:02:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id k18so7378142lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mcjkN3A9DFqOnzyDMP/4vsY+bIAutKbcUU811DHEXug=;
        b=siwYfse66ZSBcXSIbs3T0fKz2ScX0U0xgDT1LfCiwVAFFNk19D25MDC3Pr4wERESVh
         hHsm0yz0mbBTXmERMfxO9BtHFeXotDeQdQGfmtCTYGKY8n/lyCPiBTSk9/kWAjWrwxpR
         nxXqQJb2t+hd6a/EthSjjbtWU5s3jFvtDvZSGTKX8z/Pc3l0QFL3U+MfhPi6m588xP85
         5PCCQzf09qWI85ul0dNeAJOLbUycDOv7xzQzoE7J4suzXQKmy+fezy6U0tBzWJnFjSx8
         iceefV8psf8nrSTMuZcf/i/8xZX3+Pu23YtK0EDj11rI7DR5I1yyi7dpnLsEE88PvGzK
         d6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mcjkN3A9DFqOnzyDMP/4vsY+bIAutKbcUU811DHEXug=;
        b=gOULCbczFoiC9t4O+bcQKEJltiSB6YaN22K4xNR4GZ7E1JTG5EipelPZ77u/QgCL3c
         FLkrvgGYtIW6zSJ8boOZ8E8k4tk2NlUkPNjPQ7btRcs1qKyhf/Qvcgybb9NNLcMUNbpB
         E3u866oSS+tzURsTJu6/v9hHrQYPw+i3zqbDlX8Q4F5veAeSzhSXI45RQcNod9NUNS4Y
         KZrpR7566aJL6Vel0+5N1HBUjET8RBaqAe7q947km7S3CDd7apiWgNvUr7bcXxTuRWNi
         Y+NAzGgpRVZSaKp2Z52Nby/814oVCx/ZUlzBRXBMfd8FB/Ln1Sdvj7JZUgiEaEWNEu5E
         boVA==
X-Gm-Message-State: ACgBeo3i42olt0zKYXiGxJKwHFMmKuWHo/ooBbbeuLiCSDavNLsz9BZ9
        VXdocUU4sBucWHxtXeCcEHezFg==
X-Google-Smtp-Source: AA6agR5ZFwRrNTK4X0TdLuhjQd5HialV0pcKzZjv37QULxCTS2sXvR8+wol8Rqmm8U9+PMM0GTK7lA==
X-Received: by 2002:a2e:9f50:0:b0:267:7e8e:5396 with SMTP id v16-20020a2e9f50000000b002677e8e5396mr1854742ljk.222.1661932965694;
        Wed, 31 Aug 2022 01:02:45 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id o19-20020ac25e33000000b0048b064707ebsm1906643lfg.103.2022.08.31.01.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:02:45 -0700 (PDT)
Message-ID: <c842f6c8-fe7b-1e74-d873-4b674556ec40@linaro.org>
Date:   Wed, 31 Aug 2022 11:02:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v2 3/5] dt-bindings: firmware: qcom-scm: Add
 optional interrupt
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-4-git-send-email-quic_gurus@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661898311-30126-4-git-send-email-quic_gurus@quicinc.com>
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

On 31/08/2022 01:25, Guru Das Srinagesh wrote:
> Add an interrupt specification to the bindings to support the wait-queue
> feature.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>

Also not CC-ed to proper people and lists.

> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index e279fd2..4d6c89f 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -75,6 +75,11 @@ properties:
>        Specify this flag to remove SCM call serialization. Need to ensure that
>        the firmware being used supports this feature first.
>  
> +  interrupts:
> +    description:
> +      The wait-queue interrupt that firmware raises as part of handshake
> +      protocol to handle sleeping SCM calls.

Missing constraints.

Which firmwares support it?

> +
>    qcom,dload-mode:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:


Best regards,
Krzysztof
