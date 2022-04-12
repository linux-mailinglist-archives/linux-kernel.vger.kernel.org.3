Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF94FE0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354061AbiDLMmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355417AbiDLMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:39:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C54E03F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:00:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so31408569ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4XT57RJ2zR0pUw59EDpBr/xnn0uf45XYMH4qW2Nnhag=;
        b=PjTkhyxG9YnT/WRgCigk6dnjQLEqvWLBnqJI2oxk5GEFzh065/3zJ6/VA5+CQBLpKU
         ljnXnp3/rV4PlaXn22l0r6QtObTkHsit4HWew6uxkt95zQF27zPcfeMrGu1zLQxT067i
         Vnb36PyoD+EwmuEiS0iLt+ph45Vo5xXTIjcLOg4tzTp2rpSSH9dOf/ofFNfk6B6Siigc
         /BSb05fegwqITJVh7KcYQaq4ovOkCP93LqIZR+8XpYs87wTg2nwjn1wsEOoy9EVhzdf5
         MCoUdVSyTzcG0bX89zamHIuTF1qRxE7G+9cKyrOte0dGyY2UgpMeINiTXpG9D9Ce5usj
         zdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4XT57RJ2zR0pUw59EDpBr/xnn0uf45XYMH4qW2Nnhag=;
        b=g72Jcmcj792IKnNDqmrJhsnqiMz106HaJvkNsVEIXJpgN8mQobECCE+CqB82nVsJsZ
         SE5CsH+gdwxlhFFO0u4v/BWe5S2lvh4xyBU7HUJ0Yt9hadxEl7sybdA58lu+/FVGbEhu
         w6VQ4Rqycvb67TZ8BA7yqCFhchIHMvD/Hf0F21ciWvifLJU4NqUtYbffP3PkndJVUK51
         k4dr9gVb4fQUZdgVlUCoUg9Fh/8nN5O0mQZLmEPDSHivpWm9rnTVA1yMhUHYMnc1Jpq9
         uZ+v0ylDS6YpYOcI1V+UZob7mZ34bQRJkO5Vo7XPr0mdz+j9c3WSfoLDK0fdOGdkPU50
         h1tQ==
X-Gm-Message-State: AOAM532lM7Ayv9BzmgYae+DRPylH+qwevWDCue0v1zcKSe2kiYmOk9GN
        qJRmQAw5tOXxtbX+tv8cjCeIgQ==
X-Google-Smtp-Source: ABdhPJz5Rcv2dy4vHSQGWUoNuyDX38ldlJdyBOsnSd7fJARXObJEOMnlXSoDY/87s+k5IVcc4n2vbQ==
X-Received: by 2002:a17:906:3082:b0:6e0:111f:8986 with SMTP id 2-20020a170906308200b006e0111f8986mr33086544ejv.677.1649764845598;
        Tue, 12 Apr 2022 05:00:45 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906644e00b006e4dae79576sm12802578ejn.14.2022.04.12.05.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:00:45 -0700 (PDT)
Message-ID: <54abc3c6-959f-58df-337b-dc847e9d7b1d@linaro.org>
Date:   Tue, 12 Apr 2022 14:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: ASoC: fix invalid yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220411194409.3390002-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411194409.3390002-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 21:44, Corentin Labbe wrote:
> The word "or" is useless and breaks yaml validation.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/sound/tas27xx.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Subject should be reversed for this subsystem, so:
"ASoC; dt-bindings: tas27xx:"

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
