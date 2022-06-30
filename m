Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A7561432
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiF3IID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiF3IHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:07:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E57F4161C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:07:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so17598374edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SX35NYBl18cFyXPhs0piBZ6V9yukiQBwYl3DBSAgvYo=;
        b=zf/eWGICuhybaZpy1CYnjb96uihegSq1Tm0FONQB4g6jCYFYZ4evOOd9zFLURUeg4D
         KF0vMmPJF8UfVJOZogLmaTd8EpPM/izgNr5TYWsjDyAMvNWfyl0ZIjn72zYHr3gxuB+o
         Sx64LlvAuzXC8uFkkPNIJMEoNGvuXXmaKLzn9/rE9XQH7HDi1yo35v1Wzf2ywcYQF3gu
         pL11d7T5o/I5yjSzlOq5DWSILePGOXbMhWtD5vqY6phtmXogvaCePXiuF23rBqeT6PWO
         t4OoL52dphH5uZ19j42T/sJVOca+nCyrqFWMvP4H1W4SCi51pYN/mUemOOaburGdOGUM
         +Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SX35NYBl18cFyXPhs0piBZ6V9yukiQBwYl3DBSAgvYo=;
        b=H9v4/URxwjAfdcpTTU4IneCvXaRbZmN+MXP55QzKosvSiwnKKdOC3lCOs2YF0LSHzk
         z9eu0+FOaRAyGgQ8BZZnnk0/4k20cohLhMoUyUuu0MuJIJ/tR7VNHDaiawAI1gspX5CV
         YKszH2I4v6yYTIjxUM0x9FUSGPFRioAn5OY/6mW7kKBFpkvSR4rVvgy+0CpDyq7bDn74
         yEBrgB4Jj+qtha3gfhwQJdhh2u0tvPK27vCcAsXbZKzz9a6mN90BJ7QNMWp5JdQdeSgF
         PiYbpe6VDzHoHBSO3jAtgXg/9eUqCEXx67SZvFdJW1J9Lln+FO3FTQydhNtXBim5cDR+
         gLGg==
X-Gm-Message-State: AJIora83DYnBV8GeteOuaE1FrQoiaen392J6wSpH/z2DYEyFUBu7tnOW
        /HUWUiK94nzGGIx3aqW1XTBlDQ==
X-Google-Smtp-Source: AGRyM1vZqX5lmlghOj96ey25H6ZkmHIbZtFnwEa5ZWItru/2ZEgAy7KZZwC7Ej81Ewk34r6HMc6fhQ==
X-Received: by 2002:a05:6402:847:b0:437:62bd:bbc0 with SMTP id b7-20020a056402084700b0043762bdbbc0mr9706897edz.285.1656576440937;
        Thu, 30 Jun 2022 01:07:20 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n4-20020aa7c784000000b00437e08d319csm1529439eds.61.2022.06.30.01.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:07:20 -0700 (PDT)
Message-ID: <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
Date:   Thu, 30 Jun 2022 10:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
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

On 30/06/2022 09:45, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the OV5693
> CMOS image sensor from Omnivision
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>

How Sakari's tag appeared here? There was no email from him.

Best regards,
Krzysztof
