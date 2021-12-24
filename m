Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2A47F070
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344079AbhLXRq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbhLXRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:46:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18473C061401;
        Fri, 24 Dec 2021 09:46:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m21so36927599edc.0;
        Fri, 24 Dec 2021 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWLqudzw3rPOkXTg3uLw4bUPdmaGZXOelkQawT33qqs=;
        b=mS8Clobq9wPiU/5RvxXvuhGVw18f56VpcHRXdE38puWRYFpMiY51UFC/P2oZv81yPU
         6295K90YhoimHqNzM4ANW0eXSxizQey2jfB+u6c5wAnfLUwFERwmhoYMzH8WJyZNlGLg
         L6VCr+XZZXDucr2NHliHri4XE/JNk1IGo5UZVda+xTsaBAJenkIHWDumA0BD9Ofi9lQD
         paOYut2eKbYcL2lslsajIY3wmY/pDbeUpQXK38EEPgIkZgGofzl5YkUZ2b2DMScHwVxT
         h2ABOS1hxlbAmWGElFCwm+4k3Qsr0F59k4D0XKvtuF2cVTrFwksaiqQWZGAIn6PnUpbW
         4YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWLqudzw3rPOkXTg3uLw4bUPdmaGZXOelkQawT33qqs=;
        b=7io8+Dl+L1tpoEI502Srx6WgBJ+vADONv4GHWCQdvB3PWwxuOHS56lFWoLv9APaUFZ
         K/uZWycvsWG7ETQdEQ+AYAiEkZS5JwtWx6hxmDK2aPCqQB5goyUWvXJI5CClIuyyDe0x
         TDUD9nz9DNq8HlVoZ5A0e8C2kHt8HvVaM6ioll/h0u+Qjdb1jI+AClioja3lyx7jxiBU
         IQvqWLKWvGTY5ifJwvAev78WyrjxL4imVZ9iMrN08rUAuyweDVL8ba/ZzAjTgfLR2Nc/
         u1/NkjlKrqRIVixprnohOMA0BGMQIKnbV97JpxhNsZHwfI4oIndFoul5zAGh/1weaR9r
         BnOQ==
X-Gm-Message-State: AOAM532hzVK+vn/X1h/FL/aL/k3N0u2LZv+nikf09/b+jxs/JNZojux2
        2/zFlcBd1OGTrYUM7X+pcdMk7ide1yBQe/qruYc=
X-Google-Smtp-Source: ABdhPJwO7D6VLbvq8orz3tQTTtQkEYvyo8XTOkfEiZZlLYVJFaLtUL15VnQe9jwlScjI6HUBJGr7SEL9Nu3a1UjYfWY=
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr5969032ejc.147.1640367981490;
 Fri, 24 Dec 2021 09:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20211224071706.2505726-1-shunzhou.jiang@amlogic.com>
In-Reply-To: <20211224071706.2505726-1-shunzhou.jiang@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 Dec 2021 18:46:10 +0100
Message-ID: <CAFBinCAh2_2B8KXcN5BBNqgfsE09ZW=wQ-UfaYoWGi1DPGrhsw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: add Amlogic s4 power doamins bindings
To:     "Shunzhou.Jiang" <shunzhou.jiang@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, jbrunet@baylibre.com, jianxin.pan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all: thanks for working on this!

On Fri, Dec 24, 2021 at 8:17 AM Shunzhou.Jiang
<shunzhou.jiang@amlogic.com> wrote:
>
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
Here the spelling of "domains" is correct but in the subject line it's
not (the subject has: doamins)

> The bindings targets the Amlogic s4, in which the power domain registers
> are in secure world.
>
> Signed-off-by: Shunzhou.Jiang <shunzhou.jiang@amlogic.com>
I found your name in an Android kernel maintainers file with a space
(instead of a dot): Shunzhou Jiang
In Germany a space between the names would be correct - but I can't
tell what's right or wrong for your case.

PS: as a small side-note: when using multiple patches we typically
send a cover-letter.
You can use the following patch-set/series as an example: [0]
It's not critical but it certainly helps identify which patches belong together.


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/20211214022100.14841-1-qianggui.song@amlogic.com/T/
