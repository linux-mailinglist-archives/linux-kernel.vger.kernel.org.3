Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756BD55B232
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiFZM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiFZM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:59:35 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE7BE38;
        Sun, 26 Jun 2022 05:59:34 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id i186so6582511vsc.9;
        Sun, 26 Jun 2022 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=37nZCE11jdK8Rc36vFIBOelXQW1kiUiyXAdrdtitw3s=;
        b=a9zdDz4sd5oa7DTYKhWGOmR8TyE2Fc/ckEVdYjndAqfwkjBMUeSbjyTCODCfUkK+7Y
         BsR/FqQzmRBUTnN9rISx3iUUbGOY8bSqrS/V5qzZL+6j1EfzN6XvKnxqjKsfOSyqK5kD
         /zOxL2p1MkpanJKr2O+qzv8cPyiUHKnjAtaYDrIv1VoUGWdLgZBZ/BfjLIJr60mkppmV
         uIpKnWihsnBapwHlfRWdxbD4hnhIhIhRm0pGlODwDH0PoegvFmMx8De3Hdku3tMYWcmB
         ntIck53ET4QL8UspIKYgmC/c8kVCZ3dSKcJQhOrcAek1+SCR8g1oazYeEB5tAxQ/NReK
         VQvw==
X-Gm-Message-State: AJIora+xXHskzvyn49TpBAbeEG6ODaXU2ESP9rQfSHGRl+uSXcZhdm87
        YDGcJo++0Cm3jz9bDLPShpzBaRa0SzgvMw==
X-Google-Smtp-Source: AGRyM1sGDcYIvncDsLAkB7wfozTBvslTXqS0cToxoMnoy+eYuoLjrz2h7hEW24YVRpaXP5DIRRmCPw==
X-Received: by 2002:a67:d787:0:b0:354:6074:f63f with SMTP id q7-20020a67d787000000b003546074f63fmr3017103vsj.1.1656248373472;
        Sun, 26 Jun 2022 05:59:33 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id m62-20020a1f5841000000b0036cf5adf823sm639832vkb.21.2022.06.26.05.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 05:59:33 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id e7so6562616vsp.13;
        Sun, 26 Jun 2022 05:59:33 -0700 (PDT)
X-Received: by 2002:a67:e095:0:b0:354:50f1:b708 with SMTP id
 f21-20020a67e095000000b0035450f1b708mr3015443vsl.58.1656248373070; Sun, 26
 Jun 2022 05:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220621034224.38995-1-samuel@sholland.org> <20220621034224.38995-3-samuel@sholland.org>
In-Reply-To: <20220621034224.38995-3-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 26 Jun 2022 20:59:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v66eaFsb+JaXpd4rZQbsgMkOHGhdmA8ZKYRe6FH9TQwWfw@mail.gmail.com>
Message-ID: <CAGb2v66eaFsb+JaXpd4rZQbsgMkOHGhdmA8ZKYRe6FH9TQwWfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:42 AM Samuel Holland <samuel@sholland.org> wrote:
>
> These PMICs all contain a compatible GPIO controller.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
