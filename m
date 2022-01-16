Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2A48FF30
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiAPVic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiAPVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:38:29 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 13:38:29 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t9so20831939oie.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR3K23prsUMyCbrYWQNTlRCKaozXns392za1xGffNJE=;
        b=PTHBntgNGcGtWqPyxE+jOxDaAOgIU1CCwc/x1QaLJzZTV6FEBjdXStTwqKGbaEaYhG
         mQO0wuQgpopoZtaDw2iBlltBJUORg8pOj9HZFBKhbMd+wZ9UV6fM+ixKICzz5P7rpacO
         7tjv0XHvP+zuM8nq1+JtNz0LZZUBMBuJeNAtwLef2i+Tow+kHGFjzOtdB9itBx9PNvbT
         KH+md7dVrwj5mLisM6UK7NnzFd78TyeOsPop5ZbQqA5bealuon23ZOdWg9C6Z656L8b/
         xrY3FlQkm16UNgKCX/Hno4CicAOkjMMkkz/xDWdQo1eurfJOeqiAMCxsEYLYrRKCNPkj
         RNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR3K23prsUMyCbrYWQNTlRCKaozXns392za1xGffNJE=;
        b=7CEcjWnDYzKWYPHkUt0Nm30cZNXHEp83+ju+5qjnhnHqhVX44pm2vm+0Bvxg64ivUd
         O9KAroB05yLcpeWmwqZDz89At3MLzKLqBGjGG75XBMYlz3sRMzqas/oH5kagJErWG959
         ItAUgQwjbehp7ePLdVxOKleEHQG8TNPy5JcbpOo9s+xhcaMlfvfEK1f+DoVhFmzmQ3oJ
         sa0IkWVyzGqas6CRcw7+jRN3/D6fzgzGr2/3V0VQPEXgIuX+XbjjYm4FXgfZM75VQhkz
         GvXPONAWXoCRyCD+bmvid/7x0yGN87lLxvZDr5EsKF1/O9sfoLqbiAldc8X7bbiSjaet
         7X5Q==
X-Gm-Message-State: AOAM532St59dFImGtUY9zvnCjNq8frdUQUE9wvpp/Rk7a507WidSpqZh
        IT0gpBuxc6G+KmpRpRyXD0a2eLdYKt7VZ+09iyVhUQ==
X-Google-Smtp-Source: ABdhPJzgjCBYMq6KY6MkbuygV1J/mBuVzD/YEm2ImA0kCK4gMfbXNFUBiT9ygVZV6q2XvrLyOHltZrObbbdPpw17Vxg=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr10857559oiw.132.1642369108822;
 Sun, 16 Jan 2022 13:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
 <20220111201722.327219-18-krzysztof.kozlowski@canonical.com>
 <CACRpkdYTXSOW+sOX3wVtF4jj6xm0jr-F3HKQPGHOdAVjbasP3A@mail.gmail.com> <5047da7c-d3a6-5472-b0ca-7ed3dbe8a5fe@canonical.com>
In-Reply-To: <5047da7c-d3a6-5472-b0ca-7ed3dbe8a5fe@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 22:38:16 +0100
Message-ID: <CACRpkdbhmJ91EW395C5F2WYjWJQdJ-SBHaDm7XnQsxMuyoMmLg@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] dt-bindings: pinctrl: samsung: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 6:10 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> Anyway DTS and dtschema will have to wait for one release, because they
> depend on samsung pinctrl driver change (patch #2).

What about I put that (and maybe this schema) on an immutable
branch so you can pull the commit into your for-arm-soc branch and
put the DTS changes on top?

Yours,
Linus Walleij
