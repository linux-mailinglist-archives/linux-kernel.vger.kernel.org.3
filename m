Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8B4F8FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiDHHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:52:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3A1E3E23;
        Fri,  8 Apr 2022 00:50:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bk12so4175855qkb.7;
        Fri, 08 Apr 2022 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd03FWWEZ6z3R9zHdDhplmx+tKByFE9yM+qWp1XkieA=;
        b=GSCMFVnVaT8jJ12K90kWhi04C6d7kzAY9GLudaNvYwE1aM3WniSwE1EDlSIDYmXNcS
         ZoskDnyt3oQ5cAYCeF2S04eLs3rPOCoRhu9JBt9sUaSEjVpc5tuHd1ujmf5O49UFC7JX
         0gjbhcWIZOP2mzeshdWpef7I2g5vOMS9fT/+N+9SBLJuv7SKLAd3y0crQl/DKb4n2aF1
         pIujdgV/QwGfUY/OzDEsNFv8V6xe0L/k1y/ouzPodjVnx8HbDqJ6hLss0MHdvuc2r4pb
         BDP9O88Sz3kXLSluV7pm13h4ni2njDLD6wsg4D+ggcP3oMhRbVnX8LLCI2qIyPMddecN
         7jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd03FWWEZ6z3R9zHdDhplmx+tKByFE9yM+qWp1XkieA=;
        b=D8bGhL2dl84DvWX9Xi8+g0NooU7HkErALWFgCAA02axyig066Kz5DQXqu37JEPS9H5
         KwhkrjPH7DG913WTl/JCnVbYnyLRs61nmMd1CMx/M6pEZM9ij7TNDGeK+kAcWtW2bRKp
         Kj5vJ0BMuuQcFYhC/Xk3qQ79zOuxbYsPutZfEX66V+mT2HQ+fxPKXOcJ3Uuxz7UWb0zt
         gYPQ/InmmVoDFclSqjGmG8ntSo+FAwWRvws9v2nhFdJ9PSICxjz7N4X/KYqL82alj+H6
         tU++5KUEkhUtWhQOTSBkpz4aGiQHvdE44FAPA9iRcU4UPaTGiNU1SwVmxMgCGPYasM1O
         KkKA==
X-Gm-Message-State: AOAM533ZAsSuPPcEl9BGxYslAywSYZdw3ysS1a9Vt7hXPTOnAKj6WN0U
        ujoEElMb8AMVmVbOKSStAvnTW8a2BtKLPM5gte0=
X-Google-Smtp-Source: ABdhPJyVf/N0dZeSbLVCmVj1wUMk/MGaGOBT/OOoQXowI5Wkqped1Hq4ptNsGPdoDFZWsarHlb93LyG4RVHhq4yF5HY=
X-Received: by 2002:a37:8d44:0:b0:69a:224a:dc27 with SMTP id
 p65-20020a378d44000000b0069a224adc27mr2598220qkd.563.1649404220992; Fri, 08
 Apr 2022 00:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 8 Apr 2022 09:50:10 +0200
Message-ID: <CAMhs-H8Z=Q3vm6psjp4iqu7z4N4eUKokeJ8VM+_wCscypP1TLQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: dts: align SPI NOR node name with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 4:33 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The node names should be generic and SPI NOR dtschema expects "flash".
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts         | 2 +-
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
