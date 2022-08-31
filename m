Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F45A7EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiHaN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiHaN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:26:37 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300B7D7B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:26:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e71so4141547ybh.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FQi2F3OOiF0121qUr5Q7RuzQmHvpSimdNedNb895628=;
        b=sqHB4qB4Fc4j91sGEkoQr/5USwtH2tfn5YFDYhQHv+nQWjW/fE9BV4BhTI3TlLOHXe
         xfzLb/ZhCEUqXWjsoQUfCgj8qWQWfM1ktHeTnC7PzNGB6bgJ/8GThuUicezaTpCzBlNW
         jQNAEBPq0syv/aFuFTcktZXjy4sfzUsIcnuw7jPZ9BzQK7wJ3j11CEV23/gGjMwlAJ04
         PwKrsnrsBqv491uGzcufobOKhTDPOCOmnCZIBy7ChtKW7O+Ct6Epo7AdF5fAdMjuip4D
         fEHNsiA+Zhox14GuI4+MpoW1HRjBgWq7M8qM4mYu9u12cku8deQg+jwWNbR0R86Mco90
         vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FQi2F3OOiF0121qUr5Q7RuzQmHvpSimdNedNb895628=;
        b=3McL1NR1r1Z28CByg34TF8Mje/r9BZvMiQVbFZkX9dvwtXDlisUToZjY4kRT/Pf1qF
         1/nIMt7gXEffBVosQEkk7LNUbtYpDdF1gZj+Vn0wQiuFzDg6N1cPdi91fTIcYshDfVGf
         tJzeIeGk9rYGb0snKMteMPJ8IngA7YTa/Wjw9VX7Cjl0hdzQVIIY5+T82V1RJUh8cMkx
         YWQ8VPEI1t2Rb0OlGqfB1ZjRJnjaKDwo5F/ArQy9b1R1qBK4PQ00Fh9fF+1jmN+KcCGL
         RgD0FUfBP/NtUPiVt6z5j+ld80ZeZdnkNIIXjLuB+noyd0LCV+YUkPY5s3Tf08D3JiQE
         bsug==
X-Gm-Message-State: ACgBeo1D0+1sPfJiPz3GZ35/JGKFl0qZY+r4ClbgLypfwXS2drG9JoYx
        SBAEJaMWdmCyO0tYyO6l+4bvwPMUQqYmTM1zP2LJXQ==
X-Google-Smtp-Source: AA6agR5piGHKZmJpBam+qnTNcGww+dtgaY3JgguMnUZV8nShHSFeB4oqzrWBTKDMXO8ZnnoFnfFkRJbS/wNz5rnnBYY=
X-Received: by 2002:a05:6902:124e:b0:668:222c:e8da with SMTP id
 t14-20020a056902124e00b00668222ce8damr15312979ybu.383.1661952395631; Wed, 31
 Aug 2022 06:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
 <20220829133923.1114555-2-martyn.welch@collabora.com> <9db9dcf8-6299-acec-c09e-603afde9a239@linaro.org>
In-Reply-To: <9db9dcf8-6299-acec-c09e-603afde9a239@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 15:26:24 +0200
Message-ID: <CACRpkdb1-LXwLdV3qLMc+i_VaLoJ-mTs=+0QtuJtNaQR_xVpxQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534
 and PI4IOE5V6534Q
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 9:50 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/08/2022 16:39, Martyn Welch wrote:
> > The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> > Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> > Inc.
> >
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>
> Then diodes should be followed by fallback (and use only one compatible
> to bind).

Ugh I don't think we have done a very good job at providing fallbacks
(several compatibles) for this hardware. Just looking at the list makes
me suspicious.

The fallback scheme is pretty hard to maintain when vendors are a bit
unclear on whether things are really compatible or not, and sometimes
they are compatible but rather not say :(

Yours,
Linus Walleij
