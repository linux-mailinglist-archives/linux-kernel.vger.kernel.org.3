Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD548FC90
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiAPMNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiAPMNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:13:46 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27259C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:13:46 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so9511081oto.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UO8vyFXvwX7SYghDbHUuZM8heKAVpRc2v8cLwYWVW4o=;
        b=DjeVuuDA0KdW/nC+q7IdYmQb9nZIn8j7wxygw5t2/5T4newz9evcma+miU7y1/p/0I
         eXwnj1nfNhOiiI4ws48ScbwqL+cXjT5j8t5aCZ4dgEanylNdJ7FR+7u1lg57iT/+tAVE
         ysgkLMRcOs5vvV74olBjf56f8WxLVe9FVgQg/O40Xz+7ucN2n0Q+oP7MDD1x99ondwqF
         FFR8ITiPDvE015UKgutcCc7IxeocpTcQC6JUQiAcB0xbql2rVXF+UXffzyY9kEj9M7Lo
         zQqsczhvBg5Fs1mCgIbWyUbeUHz3G9DwbuEofmpHMITCk8GEQNe6eSYW5JSp5PR1+a3O
         6sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UO8vyFXvwX7SYghDbHUuZM8heKAVpRc2v8cLwYWVW4o=;
        b=lK4IUWEyN9sLU3NdgO7VzU3UKaKphbQ48u85oJpW0BHCl8D5kU4uSpNXKRVglVTFek
         l2YgFgEt6VJmG7RhB2kjYV1O9+0rgmUNOJQfJi0yOZkEjFT443SCr55Lm25yKFdTeZEV
         /ylrUGgw2/30/oQDU+p73WRZDRAFQ3x4wU4K4bz9EUSse/f0pce3kXLLDqR1I+XUQYSa
         Wn4lOGvlZ8RF91BSYoGQ6BGZTi8rwadtShzH1Eed+VuvpYJtkCl/WRahdERNDe54L9ZF
         b6Zqnu5UkrjxtMwdRiAtmgyJ6nuUuFYu3wrV+sydVlHE51zXWKQqRwjkmvRQZXFYp6Io
         EghA==
X-Gm-Message-State: AOAM531RjP/ARah8fVlSaMCcFrBLb7miP/2tUqPox+3dNj48AGZpi7yG
        cfkKSzSaq8Jv+gqydPP9vxUS0yfbhTbDEN6r4s/bww==
X-Google-Smtp-Source: ABdhPJzdicsKDrKNgLtStCnnhN2DtxD7a6BfPYtUCC55jkQfRghWaCtzmmu1EZ0JbC7fzfUIvqyXnGrAUYFMDAGTJy4=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr13252447otg.179.1642335225538;
 Sun, 16 Jan 2022 04:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20220114141507.395271-1-marcel@ziswiler.com> <20220114141507.395271-3-marcel@ziswiler.com>
In-Reply-To: <20220114141507.395271-3-marcel@ziswiler.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:13:34 +0100
Message-ID: <CACRpkdb+62jojDXTjEXjgMrpo6XkZy8AZg+jDdhqt-7w6nVQig@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: gpio: fix gpio-hog example
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 3:15 PM Marcel Ziswiler <marcel@ziswiler.com> wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Even if this is no yaml yet at least fix the example to be compliant to
> later schema as e.g. found in gpio-pca95xx.yaml, fairchild,74hc595.yaml
> and gpio/fsl-imx-gpio.yaml.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
