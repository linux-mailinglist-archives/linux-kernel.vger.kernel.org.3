Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8A545543
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiFIUDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiFIUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:03:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF81ABA7B;
        Thu,  9 Jun 2022 13:03:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o7so16279236eja.1;
        Thu, 09 Jun 2022 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65BKb6+QTnEhJJ0Vp4EQuB44eWGIpxtLTjcmvbPa/Q8=;
        b=Emp0E+5ZxCn3BLb90p4QITBjZiOgXtq9gcju7V+lZINA/YbIJQvdKPYv/H+HAI3qdr
         v3odiCW/sg1rz55NsstJQfMbjM+0cKeb4V1dgkeONQd6WbK/k5XLPQ1CNO+Ne9dkCX13
         aeVUsUCiGxtMYwgPo0cvLAJgHQdfddrgVPIqyKjWvwD3LLIsm3JGBJ1Lleg/QO/A9cF3
         xY9VqZZdQmcdUSpl5co5d1gYh0gFmez3VXE0PbMxNA4W/pt29g/2J+SK0aXDYPR54oq0
         a1+FMG3tXEkm8NR2gDdbm72+qF1y0kTwUyJJOafmA7/U/FCBQThsyIGCUmUECf370ACE
         a/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65BKb6+QTnEhJJ0Vp4EQuB44eWGIpxtLTjcmvbPa/Q8=;
        b=nzWq/g8Gzwf7yQaVIr26vmUbovLRtAIF9jtisBheIyBjAUcUi11gbjyoMNyOCGDmGP
         yH/DCwGwRfjDn/zdOnhnOHnYmixacnOzJV15UXGHIW4DCnZHSNVaQsMNdzRRf7ODblxa
         rw+62kNLNlEHKaYCogn4W6pwTby7d0/w3W2QO1opNChtEpMG8tWzFPhpoOSvLZat8pYz
         xcvbyttZD8+QM6XO1ffDMaSw3RaGAY5rmGMNwW8w8tJ2fmpD44+/xNuwhK5GQj02CjME
         o9tJIhAg9La0rqZ74sXBuWNk7wTQsAoJYNJ7Ni81bSs0Ys63oEPQzgqUwRFh+PqE/wDm
         lBJQ==
X-Gm-Message-State: AOAM532UAF/0NagufiF74czqkkP9RFndhzdJiEo6uCyBI3WE+FHhzxkg
        tPkJjyQJogm0sWtyfNYP9aOcLbp0+775KImVP/uH+v2Xyns=
X-Google-Smtp-Source: ABdhPJwfjXkI4NfrY0Ak8ggvGl+owfQ44h7IsmFLeTxpiYz+agoIaeTAoH5NeXgbZqJNRr4AYiO6dtCK5cHgctlK6qs=
X-Received: by 2002:a17:907:7246:b0:6ff:241f:200a with SMTP id
 ds6-20020a170907724600b006ff241f200amr37297815ejc.543.1654805015941; Thu, 09
 Jun 2022 13:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113911.380368-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609113911.380368-6-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 9 Jun 2022 22:03:25 +0200
Message-ID: <CAFBinCAwS2zYksWUbQiPY+XNhQHFz8Qvfe+Li79Lw16dviWSZA@mail.gmail.com>
Subject: Re: [PATCH v2 07/48] arm64: dts: amlogic: correct gpio-keys properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 1:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> gpio-keys children do not use unit addresses.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
