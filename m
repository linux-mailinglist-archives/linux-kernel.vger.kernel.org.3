Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B153060E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351516AbiEVVDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbiEVVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:03:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF63A187
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:03:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z7so1045022ybf.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxiplx6RkaytXlrRSYKEQ3O7D7iVT1tPh1nthwSj52s=;
        b=RbDrWXHdFHp710mS+KTiAsacnf8zZILcSCFAvEkg5tmJgLLY/OtbMort7xqYxWhFm1
         B63F83m/TsJitosRLG9h1UU7sTJgEl2o0kxZLELo45zT7IQbsHmvcQLe85BW4Hwg39R3
         RF6agLIV8dwzLNzS0ZneQZfYKDN+0zJEyEqF4KrbH/7NdQbPKsgTypg7ov0+ZyIxNfn0
         K4Yx7/ANDGLxI4vpoC8vaRzg4kQer11hgvl5J5PUOZQ886qcziOGaC4DbWnyJ6iRGiwm
         Pwv5e1iC13g8GFOolW4/mrl5DycCQ0GMGRuBZ+H/CRK/dzIRiT/h/UN6Kqcdak6QtZCu
         AcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxiplx6RkaytXlrRSYKEQ3O7D7iVT1tPh1nthwSj52s=;
        b=MwNtdNHNJQ+EyIl+oie9jVYLeXKKowsnm3AVv9qh8aZytdHFZki9lzHrcl+mz6hh1n
         jnmeVtF26RGtGeJoSuKQU2fNx2sm+NnWvX9Bseng+khPDpikTCO1o/Wzb9U8dApqnQvJ
         AH0biLESX3HLjLUn/XxCiDy9yEApH8PkIVNGb7jx46Vdq6jPHWoVHIMkA+/Wx/SWVpuC
         NRageF/OrwoIZc6MRoG7J2SfwDh0lBz4KNq+1OHcdG/r7robvRbD6OVm/fZRdSb8JO0x
         k1vpjA+K3k0oYYHDCpYjJ6u7vYPYYk8aVaTLRgJlkaEcILS1CCatfzzx/DNdZezSHD7p
         Bi3g==
X-Gm-Message-State: AOAM531/MdSDGFfu9z3D4DZI//8IDzOGr/Qj3grDrP/AbTVZTR82d1Og
        lRCZXBF7A+Ea9wPA0PalwcLYufqNR4fg1kEvreO+636I/LQ=
X-Google-Smtp-Source: ABdhPJwTBwnyeOqQ+H1oLaBkNCWS83VGkpo6Am+xihPb5+nNh3oq+bfFbsJAeD9vmSzwzBPnHIMQc7QlkN/SRG5gFlU=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr18570383ybp.492.1653253419976; Sun, 22
 May 2022 14:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220521200734.421223-1-a.fatoum@pengutronix.de>
In-Reply-To: <20220521200734.421223-1-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 May 2022 23:03:28 +0200
Message-ID: <CACRpkdbKUHu-T2whY4wgk5xnR7X-hptEg+Jm5Hudq8ieQi3VwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 10:07 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> The BCM4349B1 chip is a single-chip Bluetooth 5.0 controller and
> Transceiver. It is contained in the CYW/BCM89359 WiFi+BT package.

So the BT and the package have two different names.

> +      - brcm,bcm4349-bt

Then why do you have to tag on "-bt" on this compatible?

That is typically used when the wifi and bt has the *same* name, so
the only way to distinguish between them is a suffix.

Yours,
Linus Walleij
