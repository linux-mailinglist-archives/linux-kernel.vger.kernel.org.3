Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3216587ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiHBKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiHBKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:41:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D308F2228F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:41:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f20so14110434lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3qLvNhAx0ZshshWMGsLhQiJFEgbstO0kVWIVueJ7P4M=;
        b=RGPG5b8+QlKFSiIaY0/Z+ZIBzeL5qF17ni0r7YZO0MMIluEyizGqfVQFvswt1kqTdX
         Xxj30W3vztSKDgLKdjKTWuqzTsLhf65OYmrl8ytl3txizOiRh7Ps8KeLcr/QjtzruAo6
         HrYb/A3S5Qrl1/82Iy5VKDgF+W46DmSSAWT29RRmg/0+W5tGMdFWWoJxTE623X128Yn6
         /XBrmds+sjgHTa2tIjNn2w/XyrsjupPJI7vlTnjBpKEhiCgXKpmV8XFgY+uBojCaZYCj
         CZE+51NESU9yri/IpvnYsrcNgh81OX6nOvyC0ePIL51sTiJ2HbzcpyQELBoCQ+NACQQD
         mbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3qLvNhAx0ZshshWMGsLhQiJFEgbstO0kVWIVueJ7P4M=;
        b=xYh3lTN0j+6fgt/nAOqL2EuYd9pMwmstY+dQRdmsiExLSq5zoBj0UIU2V6dcTPaDyw
         sS1O7hzD3W0Volbv+jVjJlvftyX2fucxKJ3MhdKSVRbfBua7rqji/MuX25QthajLHqKw
         XsFKsshYnpBdkg2KvMizfQ8xm7fMlsedf7Peoyq/9FLhBmRWXdaSRSlMVfCtsCnKrE3O
         3yJwgoMW6vWXvCw52EA5MuVHgSEL4Iff2I5RgspGvT9n2bNT3qzfs2uVq84Duw0RCWlR
         IDOdThlPMkZaFAd8zs7zuwBlVU2jIDlgnyUSRj9ASNgKdoLAP7eKclDDMFakXAYwtHF1
         omOQ==
X-Gm-Message-State: AJIora/GVtGPvAzz0MRBQ5wLZH6NFOFAZ3QfpRaNFghkUwOBplpqscQj
        pbWFCPYx9x1ULiJk//rnAdPsYg==
X-Google-Smtp-Source: AGRyM1ulk9FftA473yTrqLrLl5XAtNdoG6EZxNyqMRzN6I7Y4dw+FR2rMi+idU56zCI8IAVlQjzMyQ==
X-Received: by 2002:ac2:4e13:0:b0:489:d699:5046 with SMTP id e19-20020ac24e13000000b00489d6995046mr7602347lfr.134.1659436884254;
        Tue, 02 Aug 2022 03:41:24 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id i3-20020a2ea223000000b0025e4ed638dcsm688267ljm.59.2022.08.02.03.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:41:23 -0700 (PDT)
Message-ID: <c140e7da-bc89-afc5-12b2-f3d53bc4020a@linaro.org>
Date:   Tue, 2 Aug 2022 12:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 01/13] dt-bindings: regulator: qcom_spmi: Improve
 formatting of if-then blocks
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
 <20220731223736.1036286-2-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220731223736.1036286-2-iskren.chernev@gmail.com>
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

On 01/08/2022 00:37, Iskren Chernev wrote:
> Add a newline between if-then blocks for different compatible PMICs.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.yaml      | 12 ++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
