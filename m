Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F46529BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiEQIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbiEQICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:02:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F239646660
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:02:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c12so7554945eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xtfFxNQ4kXjnMowlOhtuczG/jVCPXMAxYap4G9Z9g4o=;
        b=HnPwwtmGhHal34IN62BohKnesTIAiJhZH/Mea1AjY9eivo9Z4ZXNv451zmhJn2bU6r
         G5PtXi9/vxmwNwW9cz/BanVwTkhxLUZ9j4NGk3TWyDI+atyps9zyk7SVj4CwbHlIV2UY
         KphPuli3AQw+8UE+yenQWPNpZGrAFvWsgcV5tMB5Wt0vk6WwRUoZQ/Ienfv3dQd12QAD
         pUzYH8gNLOwNtEO70chtu0cgEOMl7ZE417fud+dIciRDMGLg2anL0BKRhz2X67Me75cZ
         UNtZlLMwUbRhQhWp9UlWNcOkLtVZ2acOeyMHzKKQfkip7CcTf58qLYrt9qFUk63uItn2
         nElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xtfFxNQ4kXjnMowlOhtuczG/jVCPXMAxYap4G9Z9g4o=;
        b=RfYU9FEVQvol/3Yk169mxAFmCfBPZhDpfnRUtpar6GVbYgqslCjkzmr3l97M8mHOX6
         5EhBpTdltAPnMlW7yBLtG/sCMJpHJWpaJ4P8mG3HYsVKbP+gW/p7OxjZ3J3idMNZT0Hb
         3TuvJVm7M3Bw94SN9J2Ia+bQnKSKXoXVZ3A/9c7icQ8ld1KP3zGWX16Ak5+u1/qmkISI
         uq2pakS8j+vUZMbLNTpwGJP9WizDS8Wr2EncrzDMZSgixWN60aC84UwKFr4uDIbTPmGD
         bLwgMyJfFbBa7IAR4cU26oEdrtMdG3QcgribMteYJOwX3IlSl64ZBpa0hloUWCnjz78v
         IR4g==
X-Gm-Message-State: AOAM530ybadbspi87cxr4XtCPx3zGJO2sjbdLRj09F8ayvXpeYO1MLZm
        tFZmPVQtNlbU+r/NhgA6dK0zWg==
X-Google-Smtp-Source: ABdhPJy2xVmqaMW2+SK5q/96Y2Kc8dHmYLGF5OSaHiqk3OvCVkn1VCaUxDtmUCtWcrd9LTtbI/cLvQ==
X-Received: by 2002:a05:6402:84c:b0:428:4cc4:8212 with SMTP id b12-20020a056402084c00b004284cc48212mr17530588edz.171.1652774551112;
        Tue, 17 May 2022 01:02:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id md14-20020a170906ae8e00b006f3ef214dccsm737988ejb.50.2022.05.17.01.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:02:30 -0700 (PDT)
Message-ID: <20a7087d-dddd-134b-4cef-0ebcbc5115f3@linaro.org>
Date:   Tue, 17 May 2022 10:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 02/13] dt-bindings: Add headers for Host1x and VIC on
 Tegra234
Content-Language: en-US
To:     cyndis@kapsi.fi, thierry.reding@gmail.com, jonathanh@nvidia.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <20220516100213.1536571-3-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516100213.1536571-3-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 12:02, cyndis@kapsi.fi wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Add clock, memory controller, powergate and reset dt-binding headers
> for Host1x and VIC on Tegra234.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

All your patches are send from wrong email address and the SoB chain is
not correct. Please add respective SoB.

This applies to entire patchset.


Best regards,
Krzysztof
