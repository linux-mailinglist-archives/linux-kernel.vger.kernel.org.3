Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C794FA701
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiDILJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiDILJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:09:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A53B3DF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:07:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so12690915edw.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l6b232XJ/ETd8wzGneSDA700wdN5rsSRSQ2Qey5y8b4=;
        b=jl4r2uwFPz3djX6fCfWHW76QRmZMdCiVtjFzyb5Z7NIqwjWPZJq47/DBNi3gOGGBMI
         3p4aztYhcBawvI9NgXc4ilz/tfoeg3/Tpg1CeG3T1ZXlr7nMJvJOTfG89cdUL/+v6Vsn
         AsjAwYj2mv+oIQyCxMmvSC9071V21rn713Y3NsHHS8uRNShPkoZIEkHtwTD8TVzG8WKQ
         eazHPIrFwZIvXTkICFTh4BxKpw5VocUE1zI0iy6duKk35eWSba6zfuUJQs2FxvbkPgJO
         uhpFo5Ot7Xd+ifLOrCSOFx3ebFlVI2jailEvqC9UdPQrOThomIQXksIgz3DMNImKq7O9
         +9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l6b232XJ/ETd8wzGneSDA700wdN5rsSRSQ2Qey5y8b4=;
        b=gyd7e0H+mBndyd2+J6a9ZHA8SojPFqSb1W0vgUjPvmWjE55yY9vabEmH1vimnZJysF
         dcpbGb3biBv4e4Bsxk3YR01RDzMwH2Kl6hdh5SMoBudsPPF+YIL2HX5iHJDgDDRIpKlT
         UgMgME0RZlX2JaV06tnaMunfvD20QQEoRiVrJrOPcKlZtJDomKN/iGhTdl0W9ADsbE7S
         MMeT3YQOyuGdv+NUHsQBiC6ZRxE18Q1WDmZCW3chZUE/eK66qGbOx3EKwd3bzK1UZ6lz
         YfNCRjIGktuCtJBbZFTJeQahDpkHZyBRD8/fEV3HLyijAKG64ROIoWDwiH1C2Z0hK6GV
         TzLg==
X-Gm-Message-State: AOAM533QiCP0j8edWpMiOiwXXCnSBEozC1g3dhDEmKnTETZrP2En4JeH
        KEts4RERvPMvsvBTrTy9KKJ0d9iu5pEgJqoF
X-Google-Smtp-Source: ABdhPJz1LYVYa04OUQ25X5GnoJ7HFdzl3dqTRD+eP5uDEdNDPzNRIOp8nXp5jdyf5mcQ0xV/N1JM8A==
X-Received: by 2002:a05:6402:2682:b0:41d:2f74:7269 with SMTP id w2-20020a056402268200b0041d2f747269mr6693021edd.255.1649502421757;
        Sat, 09 Apr 2022 04:07:01 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm9397755ejc.66.2022.04.09.04.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:07:01 -0700 (PDT)
Message-ID: <0a0cb08a-3992-7e20-61ca-7856ce273005@linaro.org>
Date:   Sat, 9 Apr 2022 13:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/18] MIPS: DTS: jz4780: remove cpu clock-names as
 reported by dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <064a1f029a82ea3895109efe8fb1f472581d4581.1649443080.git.hns@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <064a1f029a82ea3895109efe8fb1f472581d4581.1649443080.git.hns@goldelico.com>
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
> arch/mips/boot/dts/ingenic/ci20.dtb: cpu@0: clock-names does not match any of the regexes: pinctrl-[0-9]+
> 	From schema: Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
> arch/mips/boot/dts/ingenic/ci20.dtb: cpu@1: clock-names does not match any of the regexes: pinctrl-[0-9]+
> 	From schema: Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml

No need to put the same warning twice (cpu index really does not
matter). One warning is enough.

Fixing warnings is good, but what if the property should be there and
the bindings are not correct? If you know the answer, please add it to
the commit msg.

This applies to all your patches. Blind fixing of DTS warnings my
produce incorrect results. :(


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
