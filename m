Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A004D73FD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiCMJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiCMJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:31:42 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F03524BE6;
        Sun, 13 Mar 2022 01:30:35 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id d10so27928580eje.10;
        Sun, 13 Mar 2022 01:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fmkH3wByQJwzfCIF5YG1OcruHQz6/XV1xWswn1DFZ3g=;
        b=5FbH6AMnLwMK4YG5VZUBk2iEVFSio9ytwc7jQwwbdJjtI3gn4Ww9+gsh8Rd4/L+eN5
         7DcB/Y+vktEe5TPW1WKlzXosCLLX4cBbJ6fOxzMrP+wsslUA9HOVLAbLhBBYbcEnMAQU
         i9AUtrMuNalevQqchwBzhT7WVyIMlMtvYqhoipZNLm8fYoTuriTlBLVy7Ug9URokaon2
         rX/k8zzZTowxp7ryyDrcRfMZB/TFQ4rCHx5MQTpCzXdPKLHHuXp0ewO5UV99FwYHmTsg
         lX1s8iGAW+W5cxSiQIkbcvbrtHSXiCvEVtd6jWMRt4WXha96ZajbjwkG5JTzkZSoQbU3
         fMNA==
X-Gm-Message-State: AOAM531VWX+dnyRmiFfgFvTn8z7Bjgkmv8RitPv16xLFGY3zCnt05lPa
        Ye9CxTfSxr+YaX3+dkvLIrQ=
X-Google-Smtp-Source: ABdhPJyTuDlCwrQNfpJelfW2ucJb6Q2xSf4dC2IsarbEL7/GKMZuBkZrZ+pPf9/eCB3XZHFmKMfVAg==
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id r11-20020a170906280b00b006cef3c7688fmr15156811ejc.468.1647163833526;
        Sun, 13 Mar 2022 01:30:33 -0800 (PST)
Received: from [192.168.0.150] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm5402951ejz.57.2022.03.13.01.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 01:30:32 -0800 (PST)
Message-ID: <9387e3f7-f7f0-41cf-f66c-728734bca653@kernel.org>
Date:   Sun, 13 Mar 2022 10:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: mfd: syscon: add
 microchip,lan966x-cpu-syscon compatible
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220313003122.19155-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220313003122.19155-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2022 01:31, Michael Walle wrote:
> Add the Microchip LAN966x CPU system registers compatible.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
