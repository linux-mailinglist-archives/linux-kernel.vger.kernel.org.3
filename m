Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33655D7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiF0IRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF0IR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:17:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611FF6273
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:17:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r18so3948935edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bJe+EHscmpBI3l8sdzkx98qjGwntmBZw5/UI+r8ZqSI=;
        b=NSiQD4pcQ7h4Nb3yuNNthTQZjzy0AC9aizCXSr6X6WSSMjfNAo0JvxUzc2re/98uy8
         CTpKXFnQr3x+l8kFC0WQM0Wpt5lX/fDZn4W5Z7+9251QBlWCWX+AEmocG/wIaZOSB4I6
         uXntkNfAwjg9P+eZSPPJkPR3kz4lLNAqQZuE3csp8HLrs249gzEZD8dsUS2asvfyj76f
         wX5kcCOPj91+iJVd9nlidDg6nwaeakpIbqc6l/jC4pMoCrVvRPEElFjiy0ef6QwRysif
         YNZi1+Ne+F+Z4WyxWJaiKzFrausU+XK68VxsqW2bE1qQO0YJsGCcFCqV/4YL9WXIUo3C
         Qu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bJe+EHscmpBI3l8sdzkx98qjGwntmBZw5/UI+r8ZqSI=;
        b=Uu7nRZ+KoCiUnjbtOnx2/Jscaap5LIYGzrJoPcy1XDQeKyK7uKslbSaB66f4aye4zo
         T5NP9E6s597F75d1J+d03nuHm/dvSfxIbl6t8STAM8hiE1A3pFLgSosIZoqGb7T8q/Mg
         VOhpedAFyJ8YQS44WeMb4Y73cDbZ5vXJDsdVJcxMowetEETvlVTSN7OACUvPzP430+f4
         dM+7Mkjf8IuoSp8lVHGzfVHaWJxnIr9mvrlh2C8r0MpMmGOtloPqEvKshh8QpT3ck28r
         n/ElhKQS7MR3xg06mBdtl+HMp1p+WvsGUC1nVZWU+2TNbx6dJlGXlWlos/L7eRRwFQ0w
         BYLQ==
X-Gm-Message-State: AJIora9L/JjOxiS0Usjm2XfxGIOVwi3GTRdPJKJC5T1ujrzADt5SLz97
        rEyVsdlAzNJxpqOO3O4/HlWCKg==
X-Google-Smtp-Source: AGRyM1uY/I+C8DSEIO+4P/vX0mBvSB1E3AuWL8dm46TteoTz/uhg5BxVd1obDTUaJQ8kUbO4cfZm8g==
X-Received: by 2002:a05:6402:1e93:b0:435:7f3f:407f with SMTP id f19-20020a0564021e9300b004357f3f407fmr15073343edf.173.1656317844990;
        Mon, 27 Jun 2022 01:17:24 -0700 (PDT)
Received: from [192.168.0.246] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906604600b006f3ef214de7sm4800441ejj.77.2022.06.27.01.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:17:24 -0700 (PDT)
Message-ID: <cab6fd96-4b8e-42a3-4dce-db63656df92c@linaro.org>
Date:   Mon, 27 Jun 2022 10:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 01/40] dt-bindings: input: gpio-keys: enforce node
 names to match all properties
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, arm@kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616005333.18491-1-krzysztof.kozlowski@linaro.org>
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

On 16/06/2022 02:52, Krzysztof Kozlowski wrote:
> The gpio-keys DT schema matches all properties with a wide pattern and
> applies specific schema to children.  This has drawback - all regular
> properties are also matched and are silently ignored, even if they are
> not described in schema.  Basically this allows any non-object property
> to be present.
> 
> Enforce specific naming pattern for children (keys) to narrow the
> pattern thus do not match other properties.  This will require all
> children to be properly prefixed or suffixed (button, event, switch or
> key).
> 
> Removal of "if:" within patternProperties causes drop of one indentation
> level, but there are no other changes in the affected block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 157 +++++++++---------
>  1 file changed, 77 insertions(+), 80 deletions(-)
> 

Dmitry,

Any comments from your side? Are you planning to pick up the dt-bindings
here (patch 1-3)?

Best regards,
Krzysztof
