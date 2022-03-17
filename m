Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554E4DD102
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiCQXDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiCQXDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:03:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA362B78E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:01:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o5so12991932ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjpeHshr55oXVbRkRUel/sp4CJH7Ek81QT6z+rRB6S8=;
        b=HtQ8698j/GkuPOZp01hGhOmnDThwuykSIVbzZT8HLyvOMehvriKXIHX3PT+MEnXiuu
         9lwzZcsl1IkVVuTIBPZbV5ekm6upDD5S6p6Kl0b7eXclg6iINdHjGxQrKPXdldyuBUsg
         h23/4Q6kkdZ+Etckx4W8ponNMzQ3iRuFDpKSS6Zd/JLP+p0lEYCynNvRPmlClU03Onro
         grI/EMU8xcuHkARp5fDq1FopIwxeXkki1ZHaOsyS0ftNmZinm327BN43hb9lMeYXrq7z
         uzc4oLY/xeBkyTT9bD5cv3Q4uvoEt6o3ccWfoYik6eiY20eZ0Uvsd/AniL+StFDalV+t
         eXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjpeHshr55oXVbRkRUel/sp4CJH7Ek81QT6z+rRB6S8=;
        b=3pE849znWXtZaBKtyqr+w0lRQnGvAul3TbuUJQ9+Ocoq5AtcKlN9jaoHqdbllEDKp4
         KIDG0hE1SmMwYPLAOKvqiIZK+wRO/9tdj0TuOgq1e2qYDPx6TT2blJ66VDzb//7PBUss
         3SrGy5oha9K5SuvADSrIKzWFBx9GhM+4udVvwiMHhUyfNJnJk0lnY9TUMtWrwifphhhk
         gUtwIf0Tt/ee7uh4y2q6L08mEEoqtTICrMQp3qrEOfrQ9m8Behdv90I9FGMtZ6477pPd
         ATWLfqrD7pOGDv91u+5HUC4KuXoklwEBYgudcsTWmO2Na+azgqWfFeyhxFZjeayIglya
         nyQg==
X-Gm-Message-State: AOAM531iVCUpWCEWeDxCEOh+0oqAAK2wEx0RwuyHIiHLYUlBMZOPRf8+
        jYK1QShYotWhyHd5Zj79T7UxbVZLbJ6df7W8PTywsA==
X-Google-Smtp-Source: ABdhPJxUH7FDJL8h8BnBMwdlrY2wLUcnT5H3QzKOyq8DCn5DLiSJpxwc/UeAB4reijZISa/1f6WVJpXdp16QsqcRX/Y=
X-Received: by 2002:a25:ab64:0:b0:633:6d02:ebc8 with SMTP id
 u91-20020a25ab64000000b006336d02ebc8mr7372536ybi.492.1647558107436; Thu, 17
 Mar 2022 16:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com> <20220317115705.450427-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220317115705.450427-6-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Mar 2022 00:01:35 +0100
Message-ID: <CACRpkdafKz7hqinCgWrKuSQjefaN7cZgLbhiYUtVXg3=mrELow@mail.gmail.com>
Subject: Re: [PATCH 07/18] dt-bindings: irqchip: intel,ixp4xx: include generic schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
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

On Thu, Mar 17, 2022 at 12:57 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> Include generic interrupt-controller.yaml schema, which enforces node
> naming and other generic properties.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
