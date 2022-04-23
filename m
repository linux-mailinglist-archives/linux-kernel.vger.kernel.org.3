Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11650C97D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiDWLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiDWLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:09:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA984AE35
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:06:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a21so1079926edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GF/Ydzf1WvYfy3QDQgtio+cc6YY6ogoQZWdGNtS5VO8=;
        b=pWMTRari6BUndIUw2/zGTCMeMSlcqmAQwneKe0ldqD4af5eVzHswLH23wtOQZwzEVx
         uB/8i7LTjEjL9utOnneujjDx8DSOyiJFdr2p6CFYFSjcNUuHCapF6jkHwMNG3npmxPW+
         MqTIv43L+vVJJ4ZilNj4j9lq9CXzMtXHCDJ8HhY98y1uYUzLQlwQq6GQbwrB9LUPHJYX
         QMpahHUfxZapeTze3BGQGWus4oaVFRKWtiCJ62KG09m60qgLCKiPV8n115Mm0C4baZvb
         hevGRUWfh10pLmDxj26w/IZAmSUtzs7qOtRY18JIC/KKzEE+EPFiUsGs1uA2Twpkq2TN
         kPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GF/Ydzf1WvYfy3QDQgtio+cc6YY6ogoQZWdGNtS5VO8=;
        b=2fnjOgC3nP5+Y6JmXd72ZCouiLLXL5vo2wYBZuRX4NbsD9PYYbshsGHJ3lehzLwxv6
         ji6zJ410kXlY8hmg2r7MLomb5GR3Bys5MkJ1kZDM8dUlC2INfRUb++ygUY/xY0Ug+1hI
         qvzRqIpulAKQAwp1M+HeLhEOmRFSdbiYnfgkEyXJJf35WasI+o0Ppf6UNUILycih9hiY
         vCLLdXTKcLnIGFKBLYcQfhHVurQIJgAb0iOromSCKZRbR9GKKr3ej/Pq9RrqwlA7FVFG
         MMjBpfS2h2R8izzBW61MTpkh0fv11OAF39lIb8U5haCljZ0DnvPEk4FtITHubHsar4SZ
         t/xA==
X-Gm-Message-State: AOAM530Ic0ELNYketIViMGRIZD05wCi/IfX6/Zn+xnT6WPN6RkGOaU5V
        YtCEpIS/Wju4lBMfSGh5aPDLjg==
X-Google-Smtp-Source: ABdhPJwMDTI8DmWaBO7evEmGYhUnWwmbi/xdet01iamstVOCGfjydSR5GC0olQqE4p0jQP3cQayK+A==
X-Received: by 2002:a05:6402:268c:b0:423:ec54:6fec with SMTP id w12-20020a056402268c00b00423ec546fecmr9746401edd.151.1650711975022;
        Sat, 23 Apr 2022 04:06:15 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kj23-20020a170907765700b006e8973a14d8sm1590159ejc.30.2022.04.23.04.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:06:14 -0700 (PDT)
Message-ID: <b5a549c0-c3f8-3c39-c4ca-a960fb748814@linaro.org>
Date:   Sat, 23 Apr 2022 13:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 02/11] arch: arm: configs: multi_v7_defconfig
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421192132.109954-3-nick.hawkins@hpe.com>
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
> @@ -1228,3 +1230,4 @@ CONFIG_CMA_SIZE_MBYTES=64
>  CONFIG_PRINTK_TIME=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_FS=y
> +CONFIG_GXP_WATCHDOG=y

This does not look like in correct place. You need to add entries how
the savedefconfig would do it.


Best regards,
Krzysztof
