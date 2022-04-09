Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C784FA1A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbiDICWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiDICWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:22:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3242DC27E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:20:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so20549084ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLqDifYAkCjbqxgwOT9vXFiBs8iIdqCb4gO1G0bwpb8=;
        b=A8ywAY9u1Lr+QmhTA5WfA3JnnocjunoNKsa72DCym45N1HaYtiunOHoDpfMPAOoKLo
         bQoxKlEgo69jf93NcFV/+ErJZTdgxjyJUNbQ+xv6TjmRH2JB/lb8UYbI73NBoDqNz6um
         zgaYn1NF3UTH4yVAMttd8ox5PJtV3FSz7iACfmh2Wm438JbzaTencg7/P4rmcs8PZKy6
         y9dsA2BzotMJ8BtvD/Z7miNoXuY4YyK3wDTV8fQvnuwvZBIDtB9AIFnQ6EUbvD/qMKkJ
         xHnAN8yYzUMSIJzhHvlF6wLWc5piegxVToWIIzOPyRy8YPx0eZFFVTFsPvf8WM94wyjK
         OWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLqDifYAkCjbqxgwOT9vXFiBs8iIdqCb4gO1G0bwpb8=;
        b=HBzMFqQW6EoYMVy0syfT9+kAjmpw0xBbr7kIliWEZfj2BkYsoxpmRo6wod554RZlIg
         MSJ0UNEx55IltYuneQV19Aa2q+hbLFVf76gK/uuyse7kKnOaNjd2HOYbN05MVHcRWW05
         qzAnX41MyTN8m99fN1ukrZ1Yx9xBfO7kltDYPedihJas2OyX8LQ8f0zLPI1DvK/XMjWW
         O6FmqQ5nAK5PmU2xXyFPDzyDX8aKTc7lfCslZ1oVX6tEfaD22hNR7Y0wGN5U5126zRON
         qv/SS+RDDJKXRlwLIi6izQgHSPl/qHEWKiy8GaLpeKTt7ZsM62nm3e5QLhHk5L+47xr7
         Cc1Q==
X-Gm-Message-State: AOAM533JNi5jBmoBIo5z2bgZUZx0sw6DcGpF9FuJnWMePKJSkMZe7mtm
        7g1im4aKXjXAD91csBsei0wiBtKdBaRZRnqTGHcw1g==
X-Google-Smtp-Source: ABdhPJyulJLecxjVWksSZL6PtYmWt5y8+13DrPt9f3Y6/UqGhYzxYeG7hKgDUXU8McVE9deFiuO8bqEkfHJDgOA9vos=
X-Received: by 2002:a17:907:3e95:b0:6e8:358:6b7c with SMTP id
 hs21-20020a1709073e9500b006e803586b7cmr21169398ejc.236.1649470808845; Fri, 08
 Apr 2022 19:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-2-brad@pensando.io>
 <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org>
In-Reply-To: <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Fri, 8 Apr 2022 19:19:57 -0700
Message-ID: <CAK9rFnyRrS_LvoZ_j66cKDHgecqcqzJN5krSxdCquBanViKyHg@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 11:45 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> > Change from V3:
> > - Add description and board compatible
>
> That's a bit confusing... the subject is for v1.

Goal was to identify in the cover letter patch the key changes from
the V3 patchset to this V4 patchset.  Then in each patch that had a
material change highlight that in the patch itself.  Will try and make
it more clear.

> > +$id: http://devicetree.org/schemas/arm/pensando,elba.yaml#
>
> I propose just pensando.yaml, unless there is going to be hundreds of
> different families of SoC from Pensando?
>
> This patch should be after adding the vendor prefix.

pensando.yaml is good, I'll change it to that.  I'll order this patch
to be after the vendor prefix addition in the next submission.

Best,
Brad
