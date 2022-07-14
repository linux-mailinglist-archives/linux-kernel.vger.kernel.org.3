Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630A75748DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiGNJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiGNJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:28:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A964B0F7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:27:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q7so1436796lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5PPm9mfokY2Sd8yxvJ0i2p7X69Tuy9DnoDdMoGMHDzM=;
        b=shV2ztajRAlsLHi6MmtqBz85kKuJDzs5clN5R3pzpYV0ka4lvpOLzZgL4WjdLte2Yg
         emJpshiLiXBcocMVyzrU3wjzKboFXRee2hXU8fNPjYaLLXhq6DU6aaBFhaYI5eGYUem8
         JPWdaWsMCeR6P3AS2sIjwjYLSu96IAYMVR2sEAzGfaky9O2vtGLtX0UO+lYSmLvi2bX0
         2RBzVlrYy+bJ2ywjIW7HwldqjMw+UpRY4pzyf636JzRDZoQHeOtKF0LR/v0CvR7WSaRS
         AdujqgTqlSlqMmpRcIol2jR6yT0MaoikZkQz2hVqA7QFtsZL7cf9Omwdr9Elp9ekzSDn
         Z4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5PPm9mfokY2Sd8yxvJ0i2p7X69Tuy9DnoDdMoGMHDzM=;
        b=iOj4gApNAsKSyjBq9iuZofF4Xay2ofUysGVwxD28ck9uFOotXFS9ujuQbjqS42XmUa
         0IRcJxMP/pEn8Hn6M2Iyq2GdVBSc3wq3i11jYqWMwMqAB+iQoBDODfu9Bw+m+tYr8rvf
         TyhdVZSdEfD960kpzEyPD6fHmNS4Z9Kb1Ua8sc+0deyQTuDWUYwws8uawm2WZi2rrjH4
         CMjr4LBULv+PTLo5ejQzr6tfLUnJrH3jUUGx0CZKpt0bayN9ieK8OINt5Ol1JzlQGTOZ
         Z1vbLTOuPjz3zyGOR9+GBlLe2ifmt4+ua6oul5mJ4tWhSO9XnPnLy9+poMVGdEEXy0eC
         byMw==
X-Gm-Message-State: AJIora9l+KFmSbrbBtTLIj5iKdxiA6+54BmvtCDVLY+qV3epMwLK9ZDG
        vSRXFUmRo3OFt8fr1B2uI9V/rQ==
X-Google-Smtp-Source: AGRyM1snJzZ09XV9EaTXILi0szS/hA8la1MsQ0GDeBlqN6lUjYgRS7bgjt8lJJFveJUDdypMhYmsmQ==
X-Received: by 2002:a2e:a9a6:0:b0:25d:6062:91af with SMTP id x38-20020a2ea9a6000000b0025d606291afmr3925528ljq.144.1657790844982;
        Thu, 14 Jul 2022 02:27:24 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z29-20020a195e5d000000b0047fac1feb6fsm259206lfi.210.2022.07.14.02.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:27:23 -0700 (PDT)
Message-ID: <ade6d39c-7b99-1396-33c6-f55410353bbb@linaro.org>
Date:   Thu, 14 Jul 2022 11:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 23/30] dt-bindings: phy: qcom,qmp-usb3-dp: fix bogus
 clock-cells property
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
 <20220707134725.3512-24-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-24-johan+linaro@kernel.org>
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
> The QMP PHY wrapper node is not a clock provider so drop the bogus
> '#clock-cells' property that was added when converting to DT schema.
> 
> Fixes: 59351049ad15 ("dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml        | 5 -----


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
