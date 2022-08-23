Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE78F59E4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiHWOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiHWN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:59:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9D237160
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:06:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l8so1642345lfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=upMrhZzNt5L4wt+Z6rQpjqaSfbMFmcSW/S35w6kildQ=;
        b=lUuOxQYURyFztcD8JB1k1/VOOWZsCmGTQ+yF4zeLSfv3Bl+u/6fhI2ZJtH13awkTmw
         z0SdAS43JPtjndvCJ7drXhMDbhvXkWvgDyUKj1AqJAd4C6YvIFupEJes+bEdB7YsyL6N
         AEV0uuAQihFB8R1Cs3VVYRjoMBZtmNKfDeAr8KrrqU7o7nC5dLIiWL5HxMb3mtgCtBmC
         9VUZjQ+c9DYK9IS3ofubScpMHfz1EBFwnIMYBuOsQ1o6M2B5UlMjihumKecDPa5iPqRv
         KV49raJI8eHlcG23ogtThAPwTImUTYfbfWnJdKELO6a6ewC5Lql2SjSDBh4ulDZWlvpF
         XaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=upMrhZzNt5L4wt+Z6rQpjqaSfbMFmcSW/S35w6kildQ=;
        b=XFMkVjyTZO1aMNFspGIPArzNYVUb/XNiyCFpitZHURNvf7dOF3BfQviKxCN8TAAZ/Y
         CRLTnIj3W6J+10ZzxE/xyN33++yEt3ddSMViYZJi4PLKAZEeSbL15tb2cHvkaav1gcdO
         abdhtNtRpB3lQA8AQ6+QVYqmdTi0rexklVgGvbOZqlyy8CaVEG6lDI36YpAeqNdVtmEB
         L1cMlSMltk+8fPYWyYOZnZ625xSsz1+1EzwF56f/rjl8QSUlprW/b07UVxx3o91tD9Fz
         tFJRu9JQ11W276iGhIBz3vdSNZPOjNnSFxU9rr+Kx5Gmv/4Kfhk2JdfQIqWWdhCqjYnC
         3OAQ==
X-Gm-Message-State: ACgBeo0DoX9AD1ZDl5/Q2B0dJFoDAtuMjuvh9ggE8zqGgSsBdEw+onMr
        CPRlPRXJFUiwoaJQxklEd3S/vw==
X-Google-Smtp-Source: AA6agR6VDkkW1YVbogAhJeIpNaNVuRjVSp+tFRcF7y4uJIoy3Tksj2HeP+xWqTXyiKRv0Qkrx1RBVQ==
X-Received: by 2002:a05:6512:3195:b0:492:db16:ab67 with SMTP id i21-20020a056512319500b00492db16ab67mr4959077lfe.436.1661252726672;
        Tue, 23 Aug 2022 04:05:26 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id e5-20020a05651c038500b00261b9df2ca2sm2139082ljp.51.2022.08.23.04.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:05:25 -0700 (PDT)
Message-ID: <7d314905-676d-0c5a-59f3-034e1965a8ea@linaro.org>
Date:   Tue, 23 Aug 2022 14:05:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: fsl: Rename compatibles for
 Kontron i.MX8MM SoM/board
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>
References: <20220822080103.24016-1-frieder@fris.de>
 <20220822080103.24016-2-frieder@fris.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822080103.24016-2-frieder@fris.de>
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

On 22/08/2022 11:00, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This updates the bindings in order to use names for the boards that
> follow the latest convention used by Kontron marketing.
> 
> By updating we make sure, that we can maintain this more easily in
> future and make sure that the proper devicetree can be selected for
> the hardware.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
