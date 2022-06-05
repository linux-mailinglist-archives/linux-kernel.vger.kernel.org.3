Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305CD53DE99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348346AbiFEW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348226AbiFEW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:26:11 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449974A3D2;
        Sun,  5 Jun 2022 15:26:06 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id w3so10750265plp.13;
        Sun, 05 Jun 2022 15:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A0xX55WDVN2TCBKlHQmNwVNo2vSS6BCodfPPsBHk1V8=;
        b=pOHSlMeoXObLSs14T8eS2ESAikuV1yRl6rcOcp7FZ3Tf9zECFwyFjrOLBq2yUFzuvO
         +3KWEDffqi1cE4BqHp08DPdMA5ASUOQlcjl5Xw4v7L89jYEk6BWJxfxBVnySkIzlCF0u
         +tFz7b+aBLjGYp3WmWuYErTK0CsqgxnOn5OgULJYBeMUwi/iBd/6xg9sl2S6+whxKVIj
         deYaahREVrqLB0z6X6BHhRh0S9qGGW4j4gQZ6JI9oKVcZU77Z0RTSbi6znOVuXhR7Ikb
         Fd/REpgf88cXDhCg4cApMaU6ELfK1UoajQj20RWh6fxvcEzxYdyUtW7TwsNV0St+ljsb
         pDZA==
X-Gm-Message-State: AOAM530AhXiHh5DGR7LL4hFU9M+SyqagoIreHKCn93IZokLIR68ytHXM
        MgHxGOM7FtvtNHxpAmjXWQ==
X-Google-Smtp-Source: ABdhPJw4V7dBUOt5lYHG6MqKgO39dhWg60CiTCaUsqPrNWOOr+u0cpP6Sp4aX1nJL4oUxR4SRX6E+g==
X-Received: by 2002:a17:90a:e642:b0:1e3:524e:4cb with SMTP id ep2-20020a17090ae64200b001e3524e04cbmr23034096pjb.114.1654467965532;
        Sun, 05 Jun 2022 15:26:05 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:27d2:a39a:a9b9:e8bc:8bee:41d7])
        by smtp.gmail.com with ESMTPSA id t19-20020a170902e1d300b00163d76696e1sm9050269pla.102.2022.06.05.15.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:26:05 -0700 (PDT)
Received: (nullmailer pid 3638748 invoked by uid 1000);
        Sun, 05 Jun 2022 22:26:03 -0000
Date:   Sun, 5 Jun 2022 17:26:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: power: supply: qcom,pm8941: document
 usb-charge-current-limit
Message-ID: <20220605222603.GA3638715-robh@kernel.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
 <20220601071911.6435-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601071911.6435-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2022 09:19:10 +0200, Krzysztof Kozlowski wrote:
> Document already used (in DTS and by driver) 'usb-charge-current-limit'
> property:
> 
>   arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb:
>     charger@1000: 'usb-charge-current-limit' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/supply/qcom,pm8941-charger.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
