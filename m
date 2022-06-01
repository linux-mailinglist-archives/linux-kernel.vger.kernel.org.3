Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E99539F87
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbiFAIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350808AbiFAI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:29:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93C64C78A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:29:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q21so2233718ejm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tE+HUVUrHikVji7UM5tJAdcQHFX328uHVV2QzrrXjtA=;
        b=VemYYxf0S7hescYJHrg9tYxr/KIPygy9wx/KpJESDjoPj0azEdQHUa3XBsjxIgPQKq
         vGmJ+o5wXyLmR//u1EQ/7r8lPD/2VIDbDx9z5/ktwbma6A10QiTZLmAbGILYvi+Ga6Gn
         Zyi3PugYSbuEB/PQx3lpmoEhOcDCafT1109npdiC45JmWypdOIxMV002oFgnrjiaTc4A
         Blt7ZsyIXgbKg6Z3y+C0TyCebSXtjmtFnN2iQXB1MhuLtSArjBTgx2u+H1GxnERoXEHl
         /ro1h+6X4gUWKTSM81elWl8trhePloOFmBHNFL/ZtU0f29tc70zcChRob3H2C2KaycId
         TQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tE+HUVUrHikVji7UM5tJAdcQHFX328uHVV2QzrrXjtA=;
        b=hlyRcoM6vGIu25Z3Aw3f77FE7CKt7j3lQMUPQD9sMf9iVoj1uihXhR1YST/3Tw+p67
         umY26OadLjG3AEU2alAiurELW+O9rb+2jnT6GoBy7C76UbvsUdwT4e9jLAusHnaDe2NP
         Ot+YUWkgulnjZa2dLErCCexn16niH+Omf0GXuekeOtk53Dss4KDfj9ef963hpE8PRPfS
         FJvAPXBA4QCIfTgG3ub1OTJxZWsUmo6CAL0FW5Pp0tnSTyheK/n8FV2QVI5lSlmRmz50
         WiaZeiecUkC1CK8dnDI4Z57SSiDBoFofx5Ry/w6RDW3R2W38hQGNR+osabXIoE0/afgm
         XgFA==
X-Gm-Message-State: AOAM532Sdd9i3OwcnfjFHy4ydJD3vPL9Q6d+73KtpsOCJ2JN/Xch1AzE
        bNvE5kIbQz2A/KWGJAuBCmLneg==
X-Google-Smtp-Source: ABdhPJyi4Z3RZzaBOS7ZnglUpKpLJgK5BnLa+QWibqgsr0wLo+mZsbF/byEfhXpXRBC1g3i7pXmhqg==
X-Received: by 2002:a17:906:7313:b0:6fe:ed0b:9964 with SMTP id di19-20020a170906731300b006feed0b9964mr40660647ejc.95.1654072194206;
        Wed, 01 Jun 2022 01:29:54 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b006febc86b8besm421340ejb.117.2022.06.01.01.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:29:53 -0700 (PDT)
Message-ID: <98e508e5-50cf-e8ae-e251-f2f1fc90fb92@linaro.org>
Date:   Wed, 1 Jun 2022 10:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220601080856.1548851-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601080856.1548851-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 10:08, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> ---
> 
> v6
> - Delete unneeded blank line at the end.
> 

Thanks. This is v6 however, not even v5 like mentioned in dt-bindings
patch, so please name entire patchset correctly.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
