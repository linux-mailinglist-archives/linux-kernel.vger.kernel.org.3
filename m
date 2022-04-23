Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705AD50C97C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiDWLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiDWLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:07:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F4108F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:05:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so20879864ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3O2ntaAkoSHXfUww07FUSB7z8bWdLfdZZHGEZgXUfsQ=;
        b=QHsDOfLOu8j+vpevWQa5YfvCh98BNqLRrraqzxrCiUD7/pZg7oTv7UutRdZyx7o5Bj
         aZIfEiglUFSzb0JVfeejuYopl2cmjRFoG9idQIa9h+FToZaoeUADZgsPXMGrnT9TC9JE
         PxWb7APZvgvL/DTJqjI8Gg8FNAm8ko65qzlIHqsqU/xAkZ08Xg556K2OZkeKYNYfPM/t
         aQ/+uuDycoI2McGHvxX1O6S+lNxNt805oseAJmcm5aqDDmS8K5Aly2E/Ta7D9Xtl6s0H
         U6fsAxMCdLTm1fLddamsm3pwOipX4sS7zMhibpdZy2cHsd36vt3xT6Jhla0D05P6470E
         1zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3O2ntaAkoSHXfUww07FUSB7z8bWdLfdZZHGEZgXUfsQ=;
        b=iJNxuUkcj1doCUbHl4hO5GmGy2GnNucgP/e4rPSLP1LZe5vC37Y6osYMoEJANPn7YH
         g5NXdQdi5qNyeOqStHNYGVW5NXmEgV8Hdcbe2hXY4aUcpkV8lBjpJea69oBUSYFSPDpJ
         FWW69VcaTDecVyqRP9q620GSerF5rwQCyruIy6ltLzgYIGlBsQiVFLxDPWTsDtx/a4yQ
         yd9M3QwovlI/UFKFcomAhUOoyhoNq7f/mohLXjrP4k1wKl0P1vmfZfUKmr/Cb5r34Mis
         DM7emDe/FjBwmkrQ3K5y0pZy446wrN7C6D1Hf/yC70fJ3qg+9fHw9LYC9/kDMCfiKhPn
         rCdQ==
X-Gm-Message-State: AOAM5314qhEuKwyLs32E/x4fyezb+1+q8jyNB8wetSkwjRezq5KHT90C
        o7crUjTA9t5tJxEU4WGZeeCmhg==
X-Google-Smtp-Source: ABdhPJw8Xhx9Bq+qsTttBgADCQUnkyjJPmm0NdQB0+CITdvx9YRJx9w8WTA6Hs8vGpu9gHHC+mUbBQ==
X-Received: by 2002:a17:907:9482:b0:6da:8ad6:c8b5 with SMTP id dm2-20020a170907948200b006da8ad6c8b5mr7862473ejc.372.1650711898901;
        Sat, 23 Apr 2022 04:04:58 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id me17-20020a170906aed100b006f37a09f7e0sm255778ejb.123.2022.04.23.04.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:04:58 -0700 (PDT)
Message-ID: <12902220-5f5e-4dea-1a64-da2c76d79e0c@linaro.org>
Date:   Sat, 23 Apr 2022 13:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP
 architecture
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 21:21, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP is the HPE BMC SoC that is used in the majority
> of HPE Generation 10 servers. Traditionally the asic will
> last multiple generations of server before being replaced.
> In gxp.c we reset the EHCI controller early to boot the asic.
> 
> Info about SoC:

Half of your patches did not make it to the lists. For example
linux-arm-kernel has only 1, 2 and 10.

Where is the rest? All your patches must be sent to linux-arm-kernel and
linux-kernel. Unless the list of people To/Cc is too big (~ 10 people),
entire patchset should be send to same addresses.


Best regards,
Krzysztof
