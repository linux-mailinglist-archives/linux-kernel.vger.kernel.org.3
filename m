Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA45748C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiGNJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbiGNJ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:26:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361104C608
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:24:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d12so1781706lfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yubhiqrPQElezyYpGNTpbSnd7pGxHNBvmiiE7QcQT+M=;
        b=eDf9NKMnm4+mrPZuV51N+ftUZw5oNP8KCjsDn/YGI0Amg+W3ifMA61sLrJodQdJNs4
         rHlCkw3SzEkZisVFzU84gep+Ugc8ur1JLbT3/ZLqmJ0XnF92HK8197PpmdjDc+MA2xn+
         A8xb+KuLAAOhutsU4NuV4sqmJ2n7+wm8NY+7xiAGX+NDdNK5jkJmZsEtiYSt2F1GPqBP
         QSj1YUTj4nFPA7piRi7PK0yaeMqzvTfklZfQysan7sVc/4CaT53cTjeRZMPukRQytDKb
         jCB5Rep/9vERo98pau0nTsZa3nP010wCgPIGij7RNGGM7qihVxVfrFOW1extB1wBRUTo
         XMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yubhiqrPQElezyYpGNTpbSnd7pGxHNBvmiiE7QcQT+M=;
        b=whM1A0jxxpP+3z56jRCiO6j4OQ2s1oeWm3DC+zaLThhchcIUNhK9YWEDepk/lmO8oX
         whqT8BPNXxSYksTWDM+2LE1XgWcpoaC9vJFT2qBoGQ3mguQ+JVo+p/Sy6hQp7YheDx15
         bgjQQ4dwB+GgShak4VzQxFKrHOtmgyK6CXI2MZ4g+pFrP7HB9H9TmT/lNjz31BqaGufx
         yXjPUEBsNITaxiXJ1HVn/56/j2COwLBpS8TpnHRAuiou/eAcFRxk7Hqcrimw2GHGDh4D
         ZgOI8S/gPzBGejNDcfjeHnqVD3J2P2ilemf2LWmOOBJvyuawut9FQnpgpFNXXqftBCO6
         ncMA==
X-Gm-Message-State: AJIora9TlJVcjrl2kCtuRKOu9kOFloKDL7G29wUBTX7W27Xdn6jIA5SZ
        P5ohmfCcK+OaWWbP+LAg/ZWeAQ==
X-Google-Smtp-Source: AGRyM1sFb52gQlDNDFiz0Q5stdfKzyZ/u012oRIIGRHTAOOSPEWkYgd1hbvaQ7xWAKh1si5XxdgrBA==
X-Received: by 2002:a05:6512:c02:b0:48a:80f:b92d with SMTP id z2-20020a0565120c0200b0048a080fb92dmr4724868lfu.675.1657790692582;
        Thu, 14 Jul 2022 02:24:52 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id a5-20020a05651c030500b00253c8dfc4e4sm175589ljp.101.2022.07.14.02.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:24:51 -0700 (PDT)
Message-ID: <3c454669-9317-28fd-ac57-dfab6fd75598@linaro.org>
Date:   Thu, 14 Jul 2022 11:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 20/30] dt-bindings: phy: qcom,qmp-usb: add missing
 child node schema
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
 <20220707134725.3512-21-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-21-johan+linaro@kernel.org>
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

On 07/07/2022 15:47, Johan Hovold wrote:
> Add the missing the description of the PHY-provider child node which was
> ignored when converting to DT schema.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
