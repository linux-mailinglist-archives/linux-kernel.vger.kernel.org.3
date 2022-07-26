Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F55580E20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiGZHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiGZHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:44:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553191FE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:44:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i13so7603366edj.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2KeWrOzAXHDnSJ3/65qH1ppJmiHemG/nnbZgxI3jzE=;
        b=Ym+bHhwvskOMHiERPb5yUCs1eGp56rwLMbKAaFS98pgXStoOLSihNMoH4rQRFQfGuz
         4OsAYQ6EuIuFKf7+DuQNVGuwkMfeiTFgH/ipAz5QY0Xb9l5hSk+wOj/Hgb+a9sxvG3gt
         M4+lMQCwSksyAf0ccK2kEPdHrQKIqanxxPsp3IdtPy7hZlPMXpRrb65kmOGPals3Pyv/
         bxIepVZ0fxG5q+LhgCQZ7C6adGImqG4UIfkCiZmULp24+O3hIQBZYlZdU7gT3Y3giI6q
         /93PPLLu/X18mf258zOF/Y8kmUIJIB1Xda+FFHnE/9cpup+/pwo9LEKW9Gz0fey7yrzL
         Lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2KeWrOzAXHDnSJ3/65qH1ppJmiHemG/nnbZgxI3jzE=;
        b=xaLNAkDDsYZmSBmju4TFoRai+VPsec0IvIR9meDkotOP2OqTM7T4S94G0fHKV2ph8j
         xKa6qnpV1XF19ImVMGwMVCJ58Jdlf343Xmf/qseJEwO2RAv8MoBGjGthFENCGSVJCtlf
         4mkyjc3JbYaocNneORrNc/wvGSLyidia2wafWI3bfaC5n+6ZhrgIcD2Ok6GON46fPM/P
         fvKfn58Q81syy7a14ZmyrMAlRK4X2MMEswuMM7emha/QEwNs814B9vTqEFXWLiryn1uP
         GNooI1wT8hztLwhinAz404GN+nUC1OGVr1u0Q0UCnad3CJOArrvrA5K/ohMnmiXa32Qp
         9Zqg==
X-Gm-Message-State: AJIora8UTZjzQGBIbh7KaLyKVaEOEgGClW0AeF5DuIZ4F17++OXCpu63
        Yo2F5tiQIoCy3cXjOUHPqBxofquUNHRcGRQMqwNneA==
X-Google-Smtp-Source: AGRyM1v3kT3K37Yj20BSAcGqG5U8pY1U1AGavoRoQliTz7JyTg1UgxHXgP477tw1Qfv05bbtXF75pBZUuP5jsCDzKdk=
X-Received: by 2002:a05:6402:371a:b0:43a:ece9:ab8e with SMTP id
 ek26-20020a056402371a00b0043aece9ab8emr16905320edb.126.1658821441691; Tue, 26
 Jul 2022 00:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220720112152.22918-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220720112152.22918-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 09:43:50 +0200
Message-ID: <CACRpkdYKn1rLRXs45J4ZDP1G9nsWkH-8g25_onOsY+39+n01bw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: ti: remove sound support for DaVinci DM644x and DM646x
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 1:22 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
> support for DaVinci DM644x and DM646x boards.
>
> Hence, remove the sound support for those boards as well.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
