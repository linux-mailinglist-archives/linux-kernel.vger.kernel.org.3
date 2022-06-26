Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66A55B2DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiFZQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFZQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:37:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98DDFDF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:37:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fi2so14332995ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xWOQLnwbf/lq1WQhPZ0CbipYMTu3W3sjE9a7UDOix/Q=;
        b=uuglFL+Ib/INm/VwaCcQYQ3zXMFmDLVOrqDPunKJbUPbu34x0PWJT9dzR4a2qxMxah
         FpGxLi0TbJi1mrlEc81v91xnLUtNpYCsPnXXIO/KpJOAZqbdtQvOOjE2kBFHE8R975As
         gNh4NFjQXKGPe3KTr6BF/VknT0ve7aTe0sWOsA5RJGPrQ0OLkABdbAPrrACgO0IEBdgY
         JqWLwWMAnxzUca28KxnAQ+fWtn24CiB7N+lZ+u1rMyYs4SaPBHeQ8+GcwzXH10eP3QHW
         AMoM0cXFJKcC3bKprTtmgql/s+gyQ2oUJLxdGFIDb37tkeZPrAeaHyhcvYgaVs4n6HHg
         /BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xWOQLnwbf/lq1WQhPZ0CbipYMTu3W3sjE9a7UDOix/Q=;
        b=rGGuEENeZtIf/hja3m2Fip/EgQc4J0/boMU8Nj06rUqkHTpcl5g9zVsvfHt1mVFdqi
         rD+yzo3R3vxJFr2fhqYtYMSXRqj6m3sSyQV02rxMg0QhtBaluh4E8+YARO3qna41ln3D
         WvP01ekHSDmt7nruACzaYerSm5wIZX1dvYZMyMbftlurYP/sNNDGSEm5C+5/Vs9OeEZ8
         D22TV9/R6FoQoEbmsY7IrBBqwJwny/WyblbX/FpEPAyhOBayMl3cHbsrWkP03hftql4A
         wYT9sy8vsfdO7h+AZecxczT33BRPqmidNff2WhDXSkA9ldGTvQpNFNdqjfTRd7nler3R
         FEDQ==
X-Gm-Message-State: AJIora/s3ms79xrBITG7GYkNXwP+zYIQ9mJ2+FNuUhBN6cQC73p3k3VC
        rEBnzo942q+Mx4057fnxJol45w==
X-Google-Smtp-Source: AGRyM1uPh08CFh7YRjePwS9b4Vg8r8aJLIPGKAMUPGQRnJMdTcJmxjAD5h8S3WCNCFnHIQMR+/rGbA==
X-Received: by 2002:a17:907:1693:b0:726:4322:c330 with SMTP id hc19-20020a170907169300b007264322c330mr7976987ejc.9.1656261436383;
        Sun, 26 Jun 2022 09:37:16 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906138300b006fe9209a9edsm3913494ejc.128.2022.06.26.09.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:37:15 -0700 (PDT)
Message-ID: <ea68ca02-e485-5a15-1fe3-acf0edc79349@linaro.org>
Date:   Sun, 26 Jun 2022 18:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: add device tree for LG G7 and LG
 V35
Content-Language: en-US
To:     Stefan Hansson <newbie13xd@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Anton Bambura <jenneron@protonmail.com>,
        Gregari Ivanov <llamashere@posteo.de>
References: <20220626151213.10159-1-newbie13xd@gmail.com>
 <20220626151213.10159-2-newbie13xd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220626151213.10159-2-newbie13xd@gmail.com>
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

On 26/06/2022 17:12, Stefan Hansson wrote:
> From: Anton Bambura <jenneron@protonmail.com>
> 
> Adds initial support for the LG G7 (judyln) and
> LG V35 (judyp) phones.
> 
> Currently supported features:
> 
>  - Display via simplefb (panel driver is WIP)
>  - Keys
>  - Micro SD card
>  - Modem (not tested much, but initialises)
>  - UFS (crashes during intensive workloads, may need quirks)
>  - USB in peripheral mode
> 
> Notable missing features:
> 
>  - Enabling WiFi causes a remoteproc crash, so it's disabled here.
>    Needs to be debugged - ideas welcome!
> 
> Changes since v1:

Changelog goes after ---

Rest looks good.

> 
>  - Enabled GPU
>  - Changed some node names
>  - Moved framebuffer node from common dtsi
> 
> Changes since v2:
> 
>  - Made pm8998-smps4 regulator name generic
> 
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
> Tested-by: Gregari Ivanov <llamashere@posteo.de>
> ---



Best regards,
Krzysztof
