Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D356A506D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbiDSNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbiDSNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:10:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B741BE9F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:08:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so21232121edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T31Djo2/z2XaPcxzxAz1rn0flMW2eyaZTYqk7BIRLNs=;
        b=nrbMzj4HymlsJuI9VMrzMaCG33vkqNUh3YM2ByAM6/Dyh8+B9XdNSoOQ+EeH0UYvpQ
         LY4ajt8UjQFEVo0YXTbOj5ZA98FuzEolIgKzBgXklzQik/cTtLWWmDwUw9zbBWl/Dlp1
         NMiO642N0NVr4riqzgfoVM41endDuoGSHCHBDV4SonKaU3dQKQtYy/wmfd7nl3zwX6VZ
         wjnje9U2EQouzMrIZ0cm0Nwk3cYjDxwyEUIk/BZi8e8U2Xm7QIvLA3UtfSS0gINPlmYx
         UaW7fg/dtYpDup1+nlMKbx4pSNxCaTTkq2354pxXVLZZzyf29D/0lqZRHUlmQ+paDrIq
         K/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T31Djo2/z2XaPcxzxAz1rn0flMW2eyaZTYqk7BIRLNs=;
        b=ZQQaol02EIAY+7P/tSJn8yKQMXr/qzSjYs174+4qIabeeHJRw4wj2PNr6fbjz/VYAc
         rpB8ZrTx9kagfxzlBnQibuvJHh/v83HVlKBA03YJ4wB53IK+vEfg1AqShgxQqoMhgP39
         PcqgG407r8ArMZPlHaVoqZAmrl+5/SlOXtKcF/7p89FFv6+CgQY9rGA0drW3q8Ni+KuQ
         eWw1UcwF+2PyZ109MgtsfaPU+vAsSrbbeIEVqwcBv1oU5G+1mN29tiphOEFFzeakJ/ex
         dNjOdBX4wZj0cTDeMjpF47hcZ0EaKuWy8dpHMM3k4HNiFnF6jEresQtMbTdIOtvDAPfY
         V9pA==
X-Gm-Message-State: AOAM532seb6JpJXg0h07iBpexALg21WNGiLgn65YIpTHt+ffPsIt0PwZ
        KiRfYEttbjbwhgCWRjF8VKwh4w==
X-Google-Smtp-Source: ABdhPJxqqzQGY/UFRocnFzCdJdCNz46/xZt5lTMKwdsd4sNGMZR5pASwEH/T6g7fl4AvM4FggGygHQ==
X-Received: by 2002:a50:c3c6:0:b0:416:293f:1f42 with SMTP id i6-20020a50c3c6000000b00416293f1f42mr17351035edf.187.1650373688767;
        Tue, 19 Apr 2022 06:08:08 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8456456edb.23.2022.04.19.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 06:08:08 -0700 (PDT)
Message-ID: <9dcd088f-e351-4bef-acfc-24dbda95fda6@linaro.org>
Date:   Tue, 19 Apr 2022 15:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] extcon: ptn5150: Add usb role class support
Content-Language: en-US
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
References: <1650372249-10787-1-git-send-email-jun.li@nxp.com>
 <1650372249-10787-2-git-send-email-jun.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1650372249-10787-2-git-send-email-jun.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 14:44, Li Jun wrote:
> Some usb controller drivers may not support extcon but use
> usb role class as it's the preferred approach, so to support
> usb dual role switch with usb role class, add usb role class
> consumer support.
> 
> Signed-off-by: Li Jun <jun.li@nxp.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
