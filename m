Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA73747F07A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353380AbhLXR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbhLXR7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:59:40 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93213C061401;
        Fri, 24 Dec 2021 09:59:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j6so35662427edw.12;
        Fri, 24 Dec 2021 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzi76JCO26dsz7ekYNjFVW3NuBR237n1CHgJUxqZU+A=;
        b=b8Z4+wBsyOH1INV0kGjzIH7Pk+jGDfbGXT+rp3j2vpTQvJ4EnrP9/Erdh9TlN/jXOt
         Lm3A5PYe1XMsvdubBwkE7gVXJ6+pBQtZD80PcAY+IlpLtGrbOZP5oVkoz5JHQY7WpoVd
         UqhXPe5FmVge6yj/zHUINjrXoDGR7498L62jiEAvGbAgsqN8OoBaSu9xyLVA+6pI8LMp
         +VfZKbNcYAVEITEmLuZgitJhCJzItJerd6Uoqx4TTVyxGYahdT4VlQh4GriBPekLqInM
         /9dhL6PRkyU9sl8PuCc29J9I5opN7+iJDrC8jpPZDplLziCcVHes7ZQ19LoBiFDUJMVZ
         06bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzi76JCO26dsz7ekYNjFVW3NuBR237n1CHgJUxqZU+A=;
        b=P807ZFX4MRPQB/+rls+HhXsUdtmbWryArbalctHh3yIp9KSz1nFmLNhtHfFFgZ2LWf
         785aKZxqFRK9Dp++miyytOhLV4vckkmEaKibqqXpoxZFGvzJn3Wvc0Bgh1qG7LEwl4ES
         5vS3NI/IJxyW3t+fsmfb3B0PjOeQHmms5er93p48ZpDX2r/jgcXdcLqjghuRE+RQNmnn
         w9RxoVSY9Tc7SrEOLnevFr4+SoA8+Oaqft9NYTW9/bEytGuu54cFLSJxEgJhTqBdu/5x
         w6/hh5kwUyUQ+efLIladxd79NyWCbjvSjEE0uZpQmPs+8M9VR/ZnC0PI1Qq6/tL4VQ7I
         pF+w==
X-Gm-Message-State: AOAM532yN2OOEXm9MBgDEpnPS8hl6Weh/ny0/poFV8IePuNJMPJQE6nI
        gUOFo25pdc/xzYSxRlNJS5xk/+tR+JDNgVQWqSAR1ig6Y6Y=
X-Google-Smtp-Source: ABdhPJw/WuhOWOstOo6ruXdlZ9UD9s3fq3GZGIP5QNwZiujNB+508lNa3IF+uXh2Mm1UtQFhPw9Rru69akfjKfvrIZE=
X-Received: by 2002:a50:eacb:: with SMTP id u11mr6725144edp.290.1640368777447;
 Fri, 24 Dec 2021 09:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20211224072207.2521367-1-shunzhou.jiang@amlogic.com>
In-Reply-To: <20211224072207.2521367-1-shunzhou.jiang@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 Dec 2021 18:59:26 +0100
Message-ID: <CAFBinCCrpHoLCYMH8JMmdfoSx1004GcV1DrAvCbUwomB50ZBxA@mail.gmail.com>
Subject: Re: [PATCH] soc: s4: Add support for power domains controller
To:     "Shunzhou.Jiang" <shunzhou.jiang@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 8:22 AM Shunzhou.Jiang
<shunzhou.jiang@amlogic.com> wrote:
>
> Add support s4 Power controller. In s4, power control
> registers are in secure domain, and should be accessed by smc.
>
> Signed-off-by: Shunzhou.Jiang <shunzhou.jiang@amlogic.com>
(The same comment about the name as in the dt-bindings patch applies though)

I don't have a datasheet to validate any of this but in general the
code-change is looking fine.

The subject should be changed to "soc: amlogic: meson-secure-pwrc: Add
support for the S4 SoC" or similar so it follows the general schema we
use there (see the git history)


Best regards,
Martin
