Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A058307E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiG0Rix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242522AbiG0RiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:38:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D78721E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:50:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b16so15435444lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rb1FB8S7K+YoHZwnK5lpzdbH9mR1fCmHK8/JCTc6i40=;
        b=zvVoFZ0OHaSCxvfqQ/tBxedkQ+6xY52vCay7aQqTCmOV57kXJGCmpGecBeN5Cyva3q
         tQsjhBeaY+bDnUC0QjNu8mvDMw34FiI3J6rmXWHFZ+9YeIWjqBQAi/t0PSKRNJSQp89R
         psFjSgL/4dGZsyiO8jYkxZrem01Y1RT1Fza5GNXHvbf0KPURmWdXFs1iv1nntSkP5AaX
         C6cW2c2weWcjtKWdEakGmZk+fG+JT/k/94abqQ+5qGgtwowtxOhvLvvmmybv5NcKUM8+
         +CTNiX/YFtQDEGtBYl+zGZEfpfoycLa3YsTef0gxzg03pKlalTnjrf9b9MzRCmviTZet
         /0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rb1FB8S7K+YoHZwnK5lpzdbH9mR1fCmHK8/JCTc6i40=;
        b=SxYXeuEirY6Q3bmqlAXdabLiANn4MCPWs4L2MqqdfX8Z/iD8QhyY4RoqCySrKh0L9+
         ADv7fgPFw0rq12ef+kU2sevGoWxzglJGgeRejPk8RC/Q2TM8WTR6kh9fGFHIrDa77mix
         zcp7KRhZ6wPCryK0I82dmKxvFPZLGX2V+3MXEU99WDZ1iit1Wu9IrcNKDFms1EUEWpEw
         I5v9Hj1ZjwzaYs/fuGKe9UtQ24jEwj9R1NljVSbe+t7uxbnS7wf8u2z7V28xgKvRjb6+
         ElxNODi/EFlJXxdUdyFqZcEN5NNS/msaF4/1E4EWyrgTPOTLjgxuMoiY5lDwFqb3a9L+
         7ekQ==
X-Gm-Message-State: AJIora/9zLE2m0EFv9FTxDN5LCPBXAqc+gj8jPKdMRf6gT2wAXGGaUMu
        iIZRuCUsqw2xKnDMZjqBvRAQhQ==
X-Google-Smtp-Source: AGRyM1uKN/6CsJ7dRw2kJ7G6Z+87qHHOAOs+37FNzhsjBRnj3nETk9Dnt1PcbTtv0zfAhhvq2Yc3fw==
X-Received: by 2002:a05:6512:16a8:b0:48a:9ba0:606a with SMTP id bu40-20020a05651216a800b0048a9ba0606amr4383326lfb.476.1658940635704;
        Wed, 27 Jul 2022 09:50:35 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id e28-20020ac25cbc000000b00489c5db8bb6sm3856186lfq.176.2022.07.27.09.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:50:35 -0700 (PDT)
Message-ID: <0c3a95fb-a3ee-ba48-1f69-ae9db84cc856@linaro.org>
Date:   Wed, 27 Jul 2022 18:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220727164736.48619-1-nick.hawkins@hpe.com>
 <20220727164736.48619-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164736.48619-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 18:47, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 

No blank lines between tags.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---



Best regards,
Krzysztof
