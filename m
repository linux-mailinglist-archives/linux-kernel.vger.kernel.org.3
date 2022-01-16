Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F948FA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiAPBDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 20:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiAPBDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 20:03:30 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E77C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 17:03:30 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r138so18111842oie.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POoT8lZwdwkVxbrtnXG/2kZ2LyDCImg/KhYjt8hMGj4=;
        b=ImMWHs/t2csAyPe/7X6ixftncpaVAciibtgZoT/rplnNeX4Pfltee6fYOFiHBLes6E
         Bxaou6H9Ak5cSokDSdrfZHw3q2tK4NZba9WZ+yuPgrTtSJx7lpurwM8itnWrk0VJbwAL
         EOtl0Tp4XfO+OCNaKmi6ngD/rysN/lYGD18Y1TmDWOxjztOjzjiVkYRpdxap+ERJgZB8
         cWNZ8v0kxr3J2/iwIxS8zP0O34lynqLcFYjDLuCJckQgy5wUCfuEQQvxw+l2K9nE7RnN
         2ZYM38ba6i14Qh1Ab458gzBjPL9lOgqJK3/TMcJaKltrV+jh4UX9j68lmfJ2rHlEWGJ7
         eQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POoT8lZwdwkVxbrtnXG/2kZ2LyDCImg/KhYjt8hMGj4=;
        b=gJhTWVssR3+XmkkG9knDK2pvuVC+LnO5b7OnmG9sdLdf00eQ5Kk36Qpp94xOJrJp8N
         iJFS7PMC5SGDbZau4YC9+PMJqB372bbMAGrJt+ynK4sNHfB+x522/ZxzGOrOoJYLIHzW
         hKph+q7oZwhQKV0TREsu/2CozSCqgTA8wFhx7wMCZMm9L8AaM5mDRF/cZWC+W3zw7J3V
         0rQKbKsHZbVrrqtZRoAFeChCZQZYWrrDDCT1bjN5uUSsgciLsIY4vNILdrhm+eQPPtIc
         G4rqsVv4peGoT51uQtrU+Rro409Ig4tP4dVBMZy4j2xb3uw7s1jEuguMfZYBVkwi2iAn
         1eDQ==
X-Gm-Message-State: AOAM531DUYYOKSLSBrTSbvDiMQfh7Qko/QiT10kmGklpWmKji6YQEOn6
        ahs5Dlnj4T/pq5DaKfJSODEdGgHmXNO/QTybWfAR6g==
X-Google-Smtp-Source: ABdhPJwafqmBY0WphS0TwqHoMtj+/tWMv898aZCQzPJBVKAu0PbBomZDNH+c2p3i/XuChSguAPuDYyYNS0Ri078n69I=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr8359331oiw.132.1642295009533;
 Sat, 15 Jan 2022 17:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com> <20220103154616.308376-2-gary.bisson@boundarydevices.com>
In-Reply-To: <20220103154616.308376-2-gary.bisson@boundarydevices.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 02:03:18 +0100
Message-ID: <CACRpkdZRL8VuY5K_d69VHE6eXCmUb18ZRs5v9shExe4ipmw90Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: meson-g12a: add more pwm_f options
To:     Gary Bisson <gary.bisson@boundarydevices.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 4:46 PM Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> Add missing PWM_F pin muxing for GPIOA_11 and GPIOZ_12.
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

This patch 1/3 applied for v5.18.

Yours,
Linus Walleij
