Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0853A36C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352394AbiFALCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiFALCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:02:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3C606D0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:02:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v25so1650570eda.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kuuAPeBvMXlT4Qr0rIDPPzJHYIF2J7uJ4dEFJVwS+Og=;
        b=rAKE7c//X9VsmcrCrzt+3SQVda0R+zL8SvZR364FeIewxrwimw1sg39tE/ObobVrNc
         rumQ7rLrHhpst92XhEZnhMhC4TnGx25oMcCqH5g9EIE/qBCiYgq2uAM5wpFKf3A7mhE0
         3USbLttY8DnbqwEQRVOLageRTzwVMHQHauzQ1rgf2QsigDySC0M7s/bOMV3bteel7SG7
         hmr61RnWvHJdzCN4ebTSdaghWXPhS4x4XrXnY1tzL74Gwp5VknzjBadeT8aiONHMQgSR
         6hgqFEEOKIBm1cFWJRHPa5YOA1aWhUM9jDqHspc5Ytf7l6/Cfm+8P/5G/gjsF2GDjCD1
         A/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kuuAPeBvMXlT4Qr0rIDPPzJHYIF2J7uJ4dEFJVwS+Og=;
        b=oLlnEYrwZcIXUsXcuOOm/v0nvleR/g0Mqy77EON664ecgYBiNCGpaQQczYcx+Lv+sG
         8L7uUsHaPkJGlCo6Hudpt1LlGkohPYcq1RV0ykjdoyygaEZm5zutliAbr3tjGncKhcDI
         lER33ahMuGd7nw/COzIX/ljfZHWqzfJOx5B3lfSbe8DrAu9R1I0rHStKSdHBE/e6sN+P
         ZzhKvsuEiel4y3yzTsXVY/KBTitGc+1vNbo1HzzztJdIAxlcYChcrTcqc9ZHddP7nU2j
         /qzCmVEhBr3Xc6MOCGcy8Mw5F+i7/vC+vxWn3eut0tpuQbJ3NFQWp+yhu1dM0HlOebnm
         beIQ==
X-Gm-Message-State: AOAM5300j4OZ+nmUjCIYwjr8hurMGwLzq61txX59IdPGM0VbfPcTBTGC
        p31eJfYI7t+GrLjl1xpOuxGxag==
X-Google-Smtp-Source: ABdhPJwuP9ToPsswAN7zlS2t+50aXR+R2g9mygUn7Sy65W3wXMMxiMFudHonBXq+lmVpifEuUMxjiA==
X-Received: by 2002:a50:fc10:0:b0:42d:cbd2:4477 with SMTP id i16-20020a50fc10000000b0042dcbd24477mr18945136edr.363.1654081366009;
        Wed, 01 Jun 2022 04:02:46 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402020400b0042ab1735552sm766512edv.66.2022.06.01.04.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:02:45 -0700 (PDT)
Message-ID: <59c140cb-5cab-b006-ec6e-eaf0ed0d414b@linaro.org>
Date:   Wed, 1 Jun 2022 13:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/11] dt-bindings: watchdog: Add binding for Qcom SDX65
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
 <1654080312-5408-10-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654080312-5408-10-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 12:45, Rohit Agarwal wrote:
> Add devicetree binding for watchdog present in Qcom SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
