Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9858C47C037
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhLUM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhLUM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:57:18 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF05C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:57:18 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso16486688otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7lL5b0OdWvPRyAvOv2A9DvQi6Y6xWHuiYMXntxrIkY=;
        b=psnTM/ToBMjrt5X15R3dV8wJ2+y3wMyN7/PyjLOuKY81Tj/Rb8BmfIVg9xBMyVdXFb
         0F6RS55dpGZA2xoGXF1U6ODG0JdTpedtNYZrTkLDz3WtvizA2UCjKR/85FMjWJQfklU1
         +uYDP3pu95JZo1n88gknuo2p1ILemCQHs2IEUqDDzWNHjosIj4sUnn6N3xjuwPk2SnvQ
         frLTCloOHv3loyKk0rWhLgRA4TMkQl08592sns7ce7hVM/8DEExGTnG94jzlw+1HJEPq
         iExVLQ5m6uXV+hhi58SJyhQkZaz7lZpS6ectdPvkRY4mALGQ0U9sSWGUZsiEmB5L/7Pk
         GxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7lL5b0OdWvPRyAvOv2A9DvQi6Y6xWHuiYMXntxrIkY=;
        b=XoSBE1fRvMiaXqlIKNip18vlbAEPMahqkrkzqrT6M1ndS6GtP7Cj2fWx6hLd7m8PY7
         UlSQo09C239L3Ekd6x9Y6xa1imknLD1ODyCcWbZs6+i2/UAhzDk+m9XlGFPJ98kFhdY2
         VO+MS4U5oOGCmSrh1snP/KszqxwUXtPA4+O2zn21ZnYVKl0ToX25XVw3l5H+7XMFaCgT
         WYmIcIqcqaQu/V/eYHkpORIdrk5gy0OFKk0CuodE1GG+w9Bi09T/d9SjHTBm0SZbuhzN
         IKhi3FGRea81ohsw/WWHfTxjAS//wzcVDMpGPCyFMmX39zxGjkPV9Z7uckCdfOpj2bQq
         WbWw==
X-Gm-Message-State: AOAM532SUYEOTTXH3TrFy5v46T/P46aCD1vR6MHDVPEoBSAQsX9zZW7x
        GR7a4lm+1Az4yw0qev2TdX4LBHMCa/ERM0xuTdrFy/zzPGI=
X-Google-Smtp-Source: ABdhPJw2UTvhE3ILOv23b6deXxv1ttzrr9G2utXB/hL9pcJ9eOTCvmUjfOr9h8T9c6fASi97ZOtxWGBvlJRWdSR56Wk=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr1988936otl.237.1640091437413;
 Tue, 21 Dec 2021 04:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20211221125209.1195932-1-robh@kernel.org>
In-Reply-To: <20211221125209.1195932-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Dec 2021 13:57:04 +0100
Message-ID: <CACRpkdaGG0HNU1j4QaZg7sQKb7Tn7czfU8F5v_rguhc6nFihJw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Add SPI peripheral schema to SPI
 based displays
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 1:52 PM Rob Herring <robh@kernel.org> wrote:

> With 'unevaluatedProperties' support enabled, several SPI based display
> binding examples have warnings:
(...)
> Fix all of these by adding a reference to spi-peripheral-props.yaml.
> With this, the description that the binding must follow
> spi-controller.yaml is both a bit out of date and redundant, so remove
> it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Excellent patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
