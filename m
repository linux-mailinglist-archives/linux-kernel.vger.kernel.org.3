Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64558574B46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiGNKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiGNKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:54:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08F49B6B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:54:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so1726277ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CPKYqpuFvHRszzFqa95UUli/KqXiV5SOOqK4tNwAYvA=;
        b=OId8LCKXz+O5hCqtF5v+RRRr962G3A6iut6QY+JYHVXnSYAHS3skUAwLv446k/B9SK
         odLtrv9BI3HZ7xgQ0EJedfE39V+7m/pQDjkXZKkhK7BBaudswj7MC2ABuEvHkHp5WMhB
         s6pxQWBEDXniDqvErev0SQZ1ey+EQj/KxY6SNZRZAFkNvHwOJneWEJFX7mmkZNtWeuM0
         wG8bgh7Boe1C287SdA9SwC1lKp0KEbvevzPm44V/2NZCidAVBO4TAM7b+Lmn8NHSYqNA
         G972I0QzGfTcJ6IKjZO5mciDd44zcJp2YyTqxVWKmhA+kjvJ0GiLxepx/7z+SQ7tGyOT
         j/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CPKYqpuFvHRszzFqa95UUli/KqXiV5SOOqK4tNwAYvA=;
        b=tx4xNdBULk4Psdp7vBPSJiKyQ1B2ZLQU+YRw552qRaWaNFFJZN0DmFPgovDWFrNjy0
         4Cc/P4fplsOI+yBMzGXF+IDME92CUpPDYDVZg6bsE0B/7ZpKKWJzAdMbFA0VHSVQ3n+F
         1TGmpjQJF1o4aJOdNSLWyGTsDEuhl5cj1Xp4JWfMo2L10/g74UdSq0shIW+FpsODunZN
         vtaEc2ZUY9XVx6ko5R3tg8k80jSl4exy4386jaqgiHBL9Q0A40c69Ldk22MT+ZN506dX
         9XfhkymGuAC9xE2MIlQuByGuQtaoVAV0swdNPKzJUz3QTNaNMIkGyEJRbbvC1XLIUbAn
         FU1w==
X-Gm-Message-State: AJIora9/H7rpGtqimVWi4L/oHrpKejnJd85nCWKjx2yCC3gjRp2SiEHK
        9bhb3GKrAZ6tPzlYKiTrKKfAbQ==
X-Google-Smtp-Source: AGRyM1vAaFTljkVenFoiEylvoyDOn1bVo6ye+4NYa5NDhv+80tJTuhGHBi1jYJLx8gwDwVMrGyNRIw==
X-Received: by 2002:a2e:a58e:0:b0:25d:7113:7f30 with SMTP id m14-20020a2ea58e000000b0025d71137f30mr4220600ljp.74.1657796058965;
        Thu, 14 Jul 2022 03:54:18 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id q2-20020a056512210200b0047f6c7542f6sm294138lfr.279.2022.07.14.03.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:54:17 -0700 (PDT)
Message-ID: <7ff46f76-e465-27c6-29b2-1e8dcdf7545f@linaro.org>
Date:   Thu, 14 Jul 2022 12:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: reorder USB interrupts
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-8-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713131340.29401-8-johan+linaro@kernel.org>
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

On 13/07/2022 15:13, Johan Hovold wrote:
> Three SoCs did not follow the interrupt order specified by the USB
> controller binding.
> 
> While keeping the non-SuperSpeed interrupts together seems natural,
> reorder the interrupts to match the binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
