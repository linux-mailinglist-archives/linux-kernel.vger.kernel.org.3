Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11A50C97E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiDWLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiDWLL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:11:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A5131353
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:09:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so20928014ejn.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8yzbhsc8AJFxz96n+CWuoDBEvQ4dJxwcwdc+XXBJK6U=;
        b=YC2Z9IHMaX9wNVn+Eus754bUxnhgHs6TEyZCMXVTPI288GQz13vBCae1GGqlpcHaTa
         Npdj50DtmuK95y67ao9yZ86J4y/zjlbjt8mrBIigDdAg0qEcngLb4Aw6a0iMHldq/AzR
         Bn5JnsTXeuVQs4bvntRXYDTZRnJM4kOHVLGTO2l9JlmmHsTiuvFOxhewH5EGgW66fVro
         xL/xRqPhrARsnae+/TIdAtVshh5nWgtq5J1ATHW9zUwpnayxZNF/ylmJsqrzB4u/g/tq
         wk6VddIMnRb2E4TiKhKb1PPg3Dhw6wtgIOqqr25JL7U0NDD2QgjB6GGQ2V1gY4oP8phj
         hIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8yzbhsc8AJFxz96n+CWuoDBEvQ4dJxwcwdc+XXBJK6U=;
        b=aF8/71mhnjCgQuwzqAgEIXzu70Ewfl0+vTeIcRo0PdBXZF+SSc2s7+IXo6+Ey9u/MH
         4977/BGFH4vbOYI0MLn9cbQFO1D2iKrXVehQjUtpDHtiPuv8ryV4ucTezGxVXYmhDvAs
         6NesWP2A7WGBmLMLzDcfpzGY6JfT7qaK3Risikb3aHernFmYT8O74SuP3hJa6aZx8cem
         ny3T4QTTHcPFoWIvfTcWyz3jLNp8Z732UKsQZVIFXyEtTOsmquQK5X77K5bJ//zTkaLO
         QJijjt0R9hDuj3/Pb4ZX4HRsHPGw/4g6drgVS38me2cXpDXhKkVPJp3Y3FMXSl8kLayB
         E+QQ==
X-Gm-Message-State: AOAM532mL0QRhmHU/DPImIh+qqEOqxdnRnuz38A8rkQk4LX/RM3M54F0
        cTG/za7bae4+AstReKgZYwbiaTTZecV9uQ==
X-Google-Smtp-Source: ABdhPJxKoVxcPD2r2DowCQ/+xzVG7wioKr7nqk5FM7VLI/eFbnGk2KIahI/AWfhxkvivkptyejRdfw==
X-Received: by 2002:a17:906:d7a2:b0:6e8:9a34:c954 with SMTP id pk2-20020a170906d7a200b006e89a34c954mr7716309ejb.697.1650712140720;
        Sat, 23 Apr 2022 04:09:00 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cn27-20020a0564020cbb00b00418b0c7fbbfsm2079709edb.32.2022.04.23.04.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:09:00 -0700 (PDT)
Message-ID: <ab3bc43f-68e8-9330-24d5-9ed30c4f2744@linaro.org>
Date:   Sat, 23 Apr 2022 13:08:59 +0200
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
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the HPE GXP Processor by modifing the

s/modifing/modifying/ ?

> multi_v7_defconfig instead. This adds basic HPE and GXP
> architecture as well as enables the watchdog which is part
> of this patch set.

The commit lands in the Git and there is no relation to "patchset", so just:

"Enable HPE GXP Architecture and its watchdog for basic support for HPE
GXP SoCs."

Your subject also does not look correct at all. Please use "git log
--oneline -- "  to get the idea for correct title.

Best regards,
Krzysztof
