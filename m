Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A70567616
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiGER7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGER7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:59:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754618366
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:59:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u14so15518088ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+M8MzTYuEbXJSLPnO61JVVRmQg6x6SQdlrGpVMU3ZpI=;
        b=xea0ysUKeFTAO4aQdtUGtIF5HsmBkiebSA3tnIjwmngevEyDas+VoKZ+JDspL6iXJP
         iGi4dTnJFM3nxa28vQx0BFulGqHeNSIPmsNEQQZGclzZ7oT8brcv7YHXQhK9M7yIv0zG
         ZP2oWeGfnInf4YN//jf0Ua1u3IgXC7prR41iOUvK6XchDEUSEJfhP2kK1dt8NqQCbODQ
         FRbZ52fiEt3Rqokz3bBrP4Ad2Yl+42FGRrW0LpGz0E6Nr8VW4dxGSIgX8da2mppz5Zwv
         19pcGVsk2QPlsfYrQUcJ47aS9CQxxCArN+prM9/fjxu5kUZtRzFljBh1W0kl4/5uUFDZ
         0nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+M8MzTYuEbXJSLPnO61JVVRmQg6x6SQdlrGpVMU3ZpI=;
        b=TwJUP5NuS90XhVLmeJ4g6tnuei9hqHUm3aG6YJBFhmJDXjdtM0uOoyxuHdgynDEhAx
         dTUOjrdMwCo8HqfTT0ND2T1ccNSZqCiz5OkZ87N5+8wNYZB586Qjq1inbzC5UfR8SbTM
         Fki7KAxDUzI2B9CIrb6mV7CDwb+fzMxkgV6k9DYQ2If81mP45VstUloYBeS8yyn+L+2w
         35cA4fRgfLhvYC7nkxwcIOE5fR/s+s8i/rIIR64FHapvukn5D4ArM61Unh3NPDXCIE63
         VkoDHf0GaZbUgw2v3eCDnEDjyMm4DTUpIazR/mUYWn1AfX5hnc5KbHdKGwdZlF7Mp0zi
         4ULQ==
X-Gm-Message-State: AJIora9Sc2RAF38VcQIeSCjCAMNcS1rxbKbKSpN8Z4/Odx7CgjIs7zdu
        Gigzj7jdBvDTlo8DXONN9Mvqyg==
X-Google-Smtp-Source: AGRyM1uNwlJwg5ebt+9H4yH6oyLkpWmdvMe1h48WJGcGaCAAGs08QOzCrbC8D46cftYzuzpePHl+9A==
X-Received: by 2002:a2e:b94e:0:b0:25b:b99f:4f58 with SMTP id 14-20020a2eb94e000000b0025bb99f4f58mr19818877ljs.263.1657043956619;
        Tue, 05 Jul 2022 10:59:16 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id m10-20020a19710a000000b0047f68b11329sm5785881lfc.266.2022.07.05.10.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 10:59:16 -0700 (PDT)
Message-ID: <9792c554-79b9-dab3-5574-765541dd7a26@linaro.org>
Date:   Tue, 5 Jul 2022 19:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] [v3 1/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
Content-Language: en-US
To:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <SG2PR03MB5006CBD49DB3052D57A6ABF0CC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR03MB5006CBD49DB3052D57A6ABF0CC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
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

On 05/07/2022 04:57, Jimmy Chen wrote:
> This adds a LTE skus for Chromebook Villager to the yaml.
> 
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
> 
> The format of the added items is based on the below document.
> Documentation/arm/google/chromebook-boot-flow.rst
> 
> Changes in v2:
> - Update the patch title and the commit message
> Changes in v3:
> - Update patch title

It's still wrong. Not mentioning incorrect patch formatting.

You ignored my comment from previous version. Please respond to it. If
you prefer to ignore it, then it is a NAK.

Best regards,
Krzysztof
