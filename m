Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7A473518
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbhLMTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLMTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:35:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E2C061574;
        Mon, 13 Dec 2021 11:35:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so54816545edb.8;
        Mon, 13 Dec 2021 11:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tBM5ZfbWX6V2p7x+5DVPlv3iogKlsKZY1L82SLcnXw=;
        b=Za6FthlkkdEObAUwtqMAZxoYcQiqyzQeYtIE4OAxZfHtltGb7zjqDsBg19/Y2cycLk
         fHEij+XJ5g5y8vlEvu3y7YTHpCM2kkJG2tJ2PbuMlOwa3DyMxrTDASWJ0mNhBBZxaK0x
         G2dc2BcFG/AQ1XeNCc17NjrdFkWANCXraE+HSaalOwGOGGyMHdMOP0noV6RH9r0yggnZ
         FE+Tl86Z/Q8r3F5P6z1muR58OhLH1433NePUHx0KCZWPKfZqNRSDOwxQRI0IdIVAI6+T
         n5ZEQtfGwCS3n4NdtTQIxDtjUCMaOqbeTdghyIVcUIY3MAGpW/JBP/2YmjoeFv9Hz/jD
         gJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tBM5ZfbWX6V2p7x+5DVPlv3iogKlsKZY1L82SLcnXw=;
        b=lOEJm3wQp7iixZjBIoVEWS7vR0HjuBIZrjDKi3mVWEYNGDvl191abracv6oJvbsUfu
         OykDhT85QKrnYD9pw44Wf8O4m2K5KErZP4/l6R6hyP54xTCafsg6UH+jT0eqiANjiQcX
         t34m3+wjcNKb2IULzEly4E3NYy/dzuqdvcz533U/k5bFuSRG6gXrhg63Oo5D6LZ2W6j/
         L8+NlhLHWKPQiV5yQKPkCdFenMo5UWQxVyltMmH458H0kcfc3I5eaS5ddXWR57KZcFjY
         I7SHZuhS28vG1nbIw0G4kpTlddXk5BVoTlXSGvWS/eaQ3M+UFocylXQRh/LtNC3r2LUV
         ZHkQ==
X-Gm-Message-State: AOAM533/Y1RJXKVRext/ifrWqz2BFOIZttBKRGXda1CXWJ/dmLAKDCnJ
        I/R/p1SYN4vrKTY+llXjNgnku8Rx5RjvYvi6DvEZcHpK
X-Google-Smtp-Source: ABdhPJwGo3z+4BlJtsq6F82LAfVkHACdaYe4m0WuKNyX9Lqlls4GXYnwqfX1u3GZOKT3+Znm92b3salpgD45tO1PgNs=
X-Received: by 2002:a17:906:395:: with SMTP id b21mr378913eja.13.1639424112369;
 Mon, 13 Dec 2021 11:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com> <CAPDyKFoqGFJQ=i301+xXvP1he-tzL8pzZO3q6P+tERYFUNZskA@mail.gmail.com>
In-Reply-To: <CAPDyKFoqGFJQ=i301+xXvP1he-tzL8pzZO3q6P+tERYFUNZskA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 13 Dec 2021 20:35:01 +0100
Message-ID: <CAFBinCBHVSpabbWr_=SLe_onVZ-pUwagq4HfV3pOBeQvJjzG-Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: meson-mx-sdhc: two fixes
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, Dec 13, 2021 at 2:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
[...]
> I noticed that you didn't cc the Maintainers from Baylibre, perhaps
> the amlogic list is good enough?
The Amlogic mailing list is typically good enough - they're all
subscribed there.
Also Kevin, Neil and Jerome are typically taking care of the
meson-gx-mmc driver which is used on newer (64-bit) SoCs.


Best regards,
Martin
