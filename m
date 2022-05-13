Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC4525E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378531AbiEMIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbiEMIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:44:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2CA29839F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:44:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i5so10420078wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=JTmmZZrjjt1hpC3GYbK+OrumndLLbB/5XKH0Ceu//Qw=;
        b=GrrA4zNNH11zqhiaQhj5njhGLa61T3Rdg5e0EaXPKYVkKuE1my05Kv/NAYJ7uyllFW
         o6sBqbJrkfxM6N/fkJ4uM6MHgWyUbEsps/HjhqiLZylZSFPykGe+wpTXPfpymN2oXB9B
         pWEl+hYVV+BmgMofS3LlG6q6UU8u62bP7EKlYKe3U+FttSQ8qfHFZ5GkWO9TyuyTWvLg
         u1ONSkp6y8ozzfos+MCZuNNhn2pt0Fyd3Yv2txxi597fhd140r9x/QgpywK0rkVWnvO5
         b4fqjDWx19BR8k9AEhkBi6ls5mMCnwPaAOfhPCEzzVoOX6AEkTPW326DBT9+ppPemF1V
         2/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JTmmZZrjjt1hpC3GYbK+OrumndLLbB/5XKH0Ceu//Qw=;
        b=BuxbOoEkxfYMpH9OO7dLOe2YoicyisBToLoC8Am2VtGt13r/aDN5sOBVUKuqSBOfKx
         lOixSEUaPOlsbm5A4vr2Ub7s8S4UjSWkJqntxpqoZwQ+6I0DHlLu0XouXsObZm8eKNkM
         HRLuBUhvcveHoEUvqV4IzJwKoIdCq9Fre5J+aZzE4VkGo7ALEMQtXvHAt7jaC/fns2pz
         32YMAYFmz8YwyQ302HUyAGi8AjOPyEpqrNTGRMWYQyLdOCLEZIs9LApffoa1rSr6poa5
         HkewdTa5YxbDUDrmbKU02jtnmo6wqrJzNCNg0zGI6306qD1wsI0H14Ib72ySKetSyOZq
         x/Jw==
X-Gm-Message-State: AOAM530zR9YS04Qa7S+xe3HYhkXrUov+mdVxmmVtXM6b409Y6xcO53mA
        zZQnhIa7Ksr4UTpVfKqbvKuEuA==
X-Google-Smtp-Source: ABdhPJyHhlPLOukfjjtC8elUtEr+RQ3i1s8e4uPbZzwLxk8P9533jLrEp5Wk6pubVLTuIRP1s215Og==
X-Received: by 2002:a5d:6d88:0:b0:20c:594d:6ac7 with SMTP id l8-20020a5d6d88000000b0020c594d6ac7mr2993077wrs.622.1652431442042;
        Fri, 13 May 2022 01:44:02 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b0039444973258sm6332569wmq.0.2022.05.13.01.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:44:01 -0700 (PDT)
Message-ID: <5e5520d0-dbb9-8ba8-cf5f-40d322c1f880@linaro.org>
Date:   Fri, 13 May 2022 10:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 07/11] arm64: dts: marvell: uDPU: remove LED node
 pinctrl-names
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-7-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-7-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:49, Robert Marko wrote:
> Using pinctrl-names requires the appropriate pinctrl-0 property, otherwise
> it is not utilized at all.
> 
> Since its not required, just remove it.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
