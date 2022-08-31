Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD65A7E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiHaNVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiHaNU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:20:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A93AB27
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:20:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k18so8203139lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gXyPGs1xzbqWLyCKCXFzzY2n7w6S19U4Yvty6n2m3xI=;
        b=BS+iR4ydREy9MZ7gRYr2l+ma3DWnH9f+1BrJTWu2kpJujnIGn4ylhL9yE3RjvSFbs3
         qJeKzs1i7Lq8Tz2IzKqcT+joLyZ9cnHgdOu+UMz8Lfp3JZqVTg6oc2ha464C7c1nmMld
         fIrKQy0orkywCqiBh34WVfTq/TsyyiIgzoJhGZOap2Kp6iEtSjbQSSj4S8szXBp4G1gX
         sfyQBFgzd3aUxXyPuscbnqzTqTLjdBq7uhoPqmJd1Qx76soaiyNL7yaRkM3iBf42g69D
         HrMoVFeSA1yyEk512f/rdp5TL5v2k35zviPsyAd3ecqgHJyfiwbwE/qE8gNUFYObckMM
         MV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gXyPGs1xzbqWLyCKCXFzzY2n7w6S19U4Yvty6n2m3xI=;
        b=mvQEaIYN9GEJOq6BV7m9ezb74CPnICIykODedqbK962SNhuN2UVw+7PiT/mLxAvrXM
         oZMuuy/rWNI+eHYQhJvGZoxTJOgqCdfOM2Lzw41M/L5OHpvohCtNFb6UECCQE/OUysYm
         WbmcRGlHrF0J0mldml6qXa59MdHsCrtJ0ymFyMr4sJEbogDL6gUEj0kc99ES8pMp3kFK
         DRN47EawtQN4/EhnswW2+yRu1w2tXdKRxdCH9kib0kYjqKTj/x6E2yc8Cbr7E5RcBKTT
         0untdwXdIMoJHfcEJhUSrNa4Ogq5NUTgFhABxCXXWTQXG4Ecbefs5Vi9zeWGRdHnhSDu
         PufQ==
X-Gm-Message-State: ACgBeo1PrRz1kYCujNjQl/3Bz+MlHIWfNDE9xSsv4BxGLa3UjffNFIIK
        0XwYsAVPyH7yZlQzDtVz5qG+vwGYVnLHV0dD
X-Google-Smtp-Source: AA6agR68vhI8/CXEZ3hYaem0vpetajctNycqN1PQYVoVf9YCRz4ASjoY0Ha1A8CPSwcomrieT8YKWw==
X-Received: by 2002:a05:651c:1942:b0:268:9b0d:e15c with SMTP id bs2-20020a05651c194200b002689b0de15cmr582532ljb.479.1661952055897;
        Wed, 31 Aug 2022 06:20:55 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u26-20020ac258da000000b00493050d6bcesm1987686lfo.122.2022.08.31.06.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:20:55 -0700 (PDT)
Message-ID: <330d1f46-0e3c-f58e-b916-9e8644e7b4a1@linaro.org>
Date:   Wed, 31 Aug 2022 16:20:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/4] Introduce MediaTek frequency hopping driver
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831124850.7748-1-johnson.wang@mediatek.com>
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

On 31/08/2022 15:48, Johnson Wang wrote:
> Introduce MediaTek frequency hopping and spread spectrum clocking control
> for MT8186.

With one line introduction, you do not help us to understand this. :(

Best regards,
Krzysztof
