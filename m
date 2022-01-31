Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6AB4A4614
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377410AbiAaLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378591AbiAaLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:38:16 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C6C035464
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:25:05 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v186so39467814ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q17FI0J/6Td6y/Zs5qVqHGExbrzgfzuZcJ5zgEigLzw=;
        b=ZnElFUnbfP6teOsTKtvs901N1Hz69FpXEbf1997Iw2lKz2XlmF9HQNruVH6TT6RIyj
         9tcfN29+lHToMPagXQsoz13RjMV0EtGJu+5Hc/WF6A2kbWK2rnmQwa5himp9CH2j8m6k
         nkovIr3hnb1RdSoySrf7OOXS94Im6nFxfiOgDh76mO6CgIKjvbheqfaz5bNxRvjtYvhN
         Y9BATgWz6+FgENI0EkRTN2/RuHp7wcQh+qfRmzbADJBSBDmqt0RUxuiiqeDw7KCOjol6
         X92v1D8sJRejBj7latxYG7MmQZp8tl9vVTLB8WNL01Jf9yOHTkW4eLXjh0aE4BW+xexW
         Z1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q17FI0J/6Td6y/Zs5qVqHGExbrzgfzuZcJ5zgEigLzw=;
        b=qrJYBI6LuTWQUH4bLi3z5owrnzNxEfEHCPEFR7ULHk2W+N55RV7HTCMF5H2HNc1iJ8
         MRgRHnfkUxS2dFsJhRKem9dBnp9gCO6/+HebZVJ6MhByHV77B/p1319sJuYaJpV/UQJK
         dWPBkDxXyUWmSLzsdmdg/26hrccVrIv/tiX6ZAfmTAHRgwRcKpVsi7cH9w68FBRLz5Kp
         uh/xQnl8Zb7fv74r1FTlUJd95FzaKvQIJin/g4fG3cf/3pqG/pCrxJ6JOHs+L++55kxR
         xqz4JfaLf94Atn4+3WCibSl3QqqxwFYsM/JrEgr3YXO9WwEinZqYf/SE2qBgRl1qx7Y4
         yWBw==
X-Gm-Message-State: AOAM533gQUBOjXKQ+lpNEUXMHkmnV9qFllAd9HPhUH0xGVvshlDtAn9Q
        lvtKW975MM3ryu5RUmSpTzX7dCDC6xXlC5i4D6mv6w==
X-Google-Smtp-Source: ABdhPJwp0dwnq3IdPpsxlsV0YJY6W/PB25vgHg+xrDLVleyc9L5AyaBJM0oHkJLfXeIzmiy9J7rAM7YsPwck8cwtBOk=
X-Received: by 2002:a25:df56:: with SMTP id w83mr28275297ybg.110.1643628304646;
 Mon, 31 Jan 2022 03:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20220130073103.26792-1-rdunlap@infradead.org>
In-Reply-To: <20220130073103.26792-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jan 2022 12:24:53 +0100
Message-ID: <CACRpkdYsqXqfxDbovvKOED-wbBOC3Q0OQqN-20LtmLt4SD-Orw@mail.gmail.com>
Subject: Re: [PATCH] gpio/consumer.h: don't use "/**" for non-kernel-doc comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 8:31 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> Use "/*" to begin non-kernel-doc comments instead of "/**",
> which indicates the beginning of kernel-doc notation.
>
> Quietens these kernel-doc warnings:
>
> consumer.h:13: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
> consumer.h:13: warning: missing initial short description on line:
>  * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
> consumer.h:22: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Opaque descriptor for a structure of GPIO array attributes.  This structure
> consumer.h:22: warning: missing initial short description on line:
>  * Opaque descriptor for a structure of GPIO array attributes.  This structure
> consumer.h:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Struct containing an array of descriptors that can be obtained using
> consumer.h:30: warning: missing initial short description on line:
>  * Struct containing an array of descriptors that can be obtained using
> consumer.h:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Optional flags that can be passed to one of gpiod_* to configure direction
> consumer.h:46: warning: missing initial short description on line:
>  * Optional flags that can be passed to one of gpiod_* to configure direction
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-gpio@vger.kernel.org

In this case the ambition was to provide proper kerneldoc for sure.

Is it possible to just fix the documentation?

Yours,
Linus Walleij
