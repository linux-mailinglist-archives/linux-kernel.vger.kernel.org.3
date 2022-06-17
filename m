Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39305550083
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355685AbiFQXSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiFQXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:18:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C65A5BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:18:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f18so4366pfq.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=dnlvDERG8oowX1HgALJdegPeU3FrNxjdXcUUPk217Kc=;
        b=dYgOoOJ+N1WQxKWgcZXmEa3c1hdI0FiUiq4kjgxMtELC1+LGpzl7e3X18OpxsPSLM6
         Z/Md1Q8QQHTehEao5xTscQMo7T5Lz4/pzDY3ntkLraiKoKzWL7ROaL2cao0FuDoT9stK
         Y6P4ABr9fN3CpUeRy0JOTZbpI9REGz0+47sTJIsSUOPeGNaoMlC+f+NCcpS6t8dOO/i0
         k26TzfWBvaDMUogUbaw/ePh4I1gdsJWFEU4PXk4hYL0DfC4g6chOMd3nJE1h86wiO1et
         1I9ZkUSlHIQ81Yj27Bv60tr/T2MsJF/eku397IM1VZwlVgBppgapkFlTfY5NfCWNSsqt
         MDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dnlvDERG8oowX1HgALJdegPeU3FrNxjdXcUUPk217Kc=;
        b=y7hgBQDmLlBBjg7Fm6j4a6IA89ubBpSSa9dzNtV6Q8mFSS7InigqVoIGfuc8qRezQi
         ta3eud4XpBfPlDl7+2MXZ5g01+2JUGq31wmlsSEMDOOq+SNy4JutUbUbudgEkLUg5ZGY
         01FVNjPwGINlu/EmW/ZM0GNhewqQxwcpsDHbOjDpEQaqoiTB3+8cNcWmNb3IEt+AjCUl
         GHFV2fD/VCTZQi8xYG62kJuwCTOVFJqT1hh8Dpjtz1Jwg+JdlPLIwMBbovcflWI2d8r/
         7HUsbaTKA24/eXXD50hXsu/Wnju4XMmlg5JeuRlscINr4mCqDzLMUI0vYkIWNQ8SjXuF
         DUJA==
X-Gm-Message-State: AJIora/EkThPACskRlCsocU9OwWgxv5nRWk9NEjc/T5j4FDm7XHL9Cin
        uKDGZC0Fzj3Tv0US3Fe5hQl1cA==
X-Google-Smtp-Source: AGRyM1u/txoKu7R37NfERg5G/UkpHCJc9k3H5j4ALGDpTt/qdkZUdeh8lUa7533JzX4jdxzHyO1UDw==
X-Received: by 2002:a05:6a00:2410:b0:522:9837:581f with SMTP id z16-20020a056a00241000b005229837581fmr12316295pfh.11.1655507920906;
        Fri, 17 Jun 2022 16:18:40 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903120400b001620eb3a2d6sm4088846plh.203.2022.06.17.16.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 16:18:40 -0700 (PDT)
Message-ID: <542f4f86-7bf9-b5fb-16d2-849121b6ee6d@linaro.org>
Date:   Fri, 17 Jun 2022 16:18:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 17/40] arm64: dts: mediatek: mt7622-rfb1: correct
 gpio-keys properties
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, arm@kernel.org,
        soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-17-krzysztof.kozlowski@linaro.org>
 <fcc5f00b-0776-9511-845a-5eac5d4c7876@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fcc5f00b-0776-9511-845a-5eac5d4c7876@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 03:41, Matthias Brugger wrote:
> On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
>> gpio-keys children do not use unit addresses.
>>
> 
> Is it me or doesn't the commit message match the actual commit? Change looks 
> good, but message puzzles me.
> 

Indeed, wrong commit msg. Thanks for spotting it, I will send a v4 of
this patch alone.


Best regards,
Krzysztof
