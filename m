Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8A52710C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiENMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiENMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:42:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93136B6B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:42:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so20747694ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRnLpO/vGNyAzalgBhdGnpdFK3PK2031kfdW64SMwFE=;
        b=daKg/FvsO5TGUS/n1nc7t6pZituJwDpn5A6eSXIcXsT++RFV0Vi0LH+19JSB953FyO
         uOlg+fYwueL3neA+PiCRi3tH7d2SAsT/+u6mNsqn74eEuOg/hc2Nb1w9W+W0rnOOBd5j
         K5Qo4/T/Lg4vtuQJLT1Zxet+R/1t0zoOXhaSXYZErzcUJskcNalryxLGP770qOSb3wpo
         XlVXqQtgU3en55Xy4GjL0wVsAQnTFqwC3JQRdfFHD7p/c2FAfp1jNULQB2RXlNsE30YD
         7AGleocv21nbuYzR3aqkCk+R7f5a1zKO8ugJxVSZ5xFNeNm2uLdZt1PGr5rWi9S7Yn8v
         sGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRnLpO/vGNyAzalgBhdGnpdFK3PK2031kfdW64SMwFE=;
        b=PTo0XW3dGhuqtOjh9j6k6sPpPGJIt4X0SRj3f0Z6+bO65VclYwWjo4plTID30Uaen8
         oW6UjJwpbftnHSa1czJiy7ZpL2R+9zlSk+4SesD9D/niskTVrbAFQk2ENdTeJUBEL6+U
         5tWBmqgyf5mkilKySXZ5m/cfGr345f+ez1kX22gvxZHqD7+Mtmfq1n5hMMwQtkO+jZkj
         qou7MP/qEFeZ73MTVY58qBlJg92vxp+DaALmknd8ixxgZpiIPi49s5/lJgfir3j+c4Ww
         uYyZ9XcCA2a7dP+cU+9QMLgHRqxUETsa8Ih9sNYjY/4ngejkXBJUif+S/K4Wahkr8zf5
         JY6g==
X-Gm-Message-State: AOAM532tz+tDpYzD4s51vguSUwQVOyH0jKnYkYI55F47WVfH+pYFkiK5
        sutec8rK66+qfMu9cuH8rDX1KcneMsKmg0UPSJRJyCwmYvqkuw==
X-Google-Smtp-Source: ABdhPJz12jMhITzZglIWDyOoX0BkDTF8ljtGTSwm8Nn3Elxho/Zr/VVHe2gBR4lyTST9w7Waa2xLoPx9JA8RhGfAMXE=
X-Received: by 2002:a17:907:c28:b0:6f4:2a80:f355 with SMTP id
 ga40-20020a1709070c2800b006f42a80f355mr7986236ejc.101.1652532140919; Sat, 14
 May 2022 05:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220511205959.10514-1-mosescb.dev@gmail.com> <20220512071415.2786-1-mosescb.dev@gmail.com>
In-Reply-To: <20220512071415.2786-1-mosescb.dev@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 14 May 2022 14:42:10 +0200
Message-ID: <CAMRc=MdMfNox-aaE7iN9MkU-6BxWu+fnhc_sP+QHVO+trQVJ+g@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: gpio: zevio: drop of_gpio.h header
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 9:14 AM Moses Christopher Bollavarapu
<mosescb.dev@gmail.com> wrote:
>
> Remove of_gpio.h header file, replace of_* functions and structs
> with appropriate alternatives.
>
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---
>  V2 -> V3: Add missing return in front of dev_error_probe
>  V1 -> V2: Move gpio_chip member to top of the struct
>            Use dev_error_probe instead of dev_err
>            Minor style fixes
>

Applied and tweaked the commit subject a bit (dropped "drivers: ").

Bart
