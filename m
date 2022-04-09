Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD64FA70B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiDILOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiDILOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:14:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42B2B1A6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:11:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso9215493wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NocFHobML3Kvh5HOcMiUsxLrqgkYwa3jJ1l2qWZxl+w=;
        b=qQQ3tKkqupKa5NQHgS2hjs3OTENlvIJ6iqth4AnY/qIB9RJv52mixVOudFeLtTGERm
         lKqZkkoOV90nTTsyik8B/bnE2mVECBACPDOly60SiqqrvDX3wp/owHBlE1O94J1kkhup
         aYjtl5v/fQsgwhHd7CFUtz/qkw4CSv0kFjDwE4qtdoyQxtrk6/MkBT56bQFWaA1IeV7g
         UdwnO/bt+788P/WPUT7WH1y9lDbWAw9bwGv4EO/yRJUJPmCvFlPcUqvtIHoO0A27trLO
         P+2NZcKr67PDXdLFO+AZN/kxDthOZEdEY6SfNa8cLcNiyZquzlvpupTckKAxnAYw0kfE
         wtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NocFHobML3Kvh5HOcMiUsxLrqgkYwa3jJ1l2qWZxl+w=;
        b=qpFJJ+kltYXzHpMshAbLEprHIX8e9QiTYX4sdJyy1Q/aro16cs7zFwfq9Hp5D4+q3r
         ZXS9x9oQjt8/d83BroJS+Jb70w7fQCVI1uCQrLadpe4R51Q2uK14C5lP/bcHB8KQEwHF
         6gwEPWDeBNqDh4WbClgk1sCp/h9YkjBoUsw7NcVuwDsp3r8aeLhS3Gg1h7DBM8C8/ZR+
         4tDdO2e3AXeFi/mr2gpj9KQpx4mzbz7/Bi7BkgzkULqKYG19rul8Y7l1R7vHd2r8LOVe
         0wpgL3LmTxw6zcsP0AIPSTg81sdiHomHwVQUqP2jmTdLRTPLaky0c4C9NTd5XdOvcL0K
         +jEQ==
X-Gm-Message-State: AOAM533vu+NU7AmW5ImcGsEVpIGX9QatgnTEL5CtskGl5mgcqEASOPCc
        QMMTjFIProteoBBJ6AZqvj29bg==
X-Google-Smtp-Source: ABdhPJxOLl2akea0SmpdY6ZEeQP0QpcKVyBk++z0/lrrDaC15FuXJNXKubzj1eDzIIVoYS2qIsemcg==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr20505096wmc.146.1649502709334;
        Sat, 09 Apr 2022 04:11:49 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm12893174wmb.3.2022.04.09.04.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:11:48 -0700 (PDT)
Message-ID: <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
Date:   Sat, 9 Apr 2022 13:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
> arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is too long
> 	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu', 'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
> 	'simple-mfd' was expected
> 	'ingenic,jz4760-tcu' was expected

Trim it a bit...

> 	From schema: Documentation/devicetree/bindings/timer/ingenic,tcu.yaml

You need to explain this. You're changing the effective compatible of
the device and doing so based only on schema warning does not look
enough. Please write real reason instead of this fat warning, e.g. that
both devices are actually compatible and this has no real effect except
schema checks.

Best regards,
Krzysztof
