Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08C146B404
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhLGHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhLGHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:36:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A353C061748
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:33:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id c32so31471872lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nYlsUJA2v1NrBNA0bh02dqcVY/I/S+4gUdunq+959CY=;
        b=WYw5pofw2Hy9CKYXVELV6x3Dn+mplsIVOfxkUADyveDfp0jmmucqgphPIzeKKRBEBd
         MYT4ZmWGQ545s/TYpIFVBXaRUf055HZ/kBQNlGwXLPFULAvl12muFU36d/1fQQyyDiOA
         nziJPzhKJUtPJ+l2gKUd33jCpaLz6qRTQJsv0BeklzNBjPqamtdOLP891lCeSzfVzM9j
         vlZkFP22LDwrtj0EgsJqD4Rgd3MljH0bkvkiU6z+qnJPZ7wkxBXjBnPgpnS38C24dbRn
         1ChIegMvr2lx/FwA7Hcq8oaNG/JGXOEn7v7xCt8JFSQv99qu7SDG7dA77Kq5Doyp6Dzx
         3RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nYlsUJA2v1NrBNA0bh02dqcVY/I/S+4gUdunq+959CY=;
        b=qN++O2wZSjFEVT+8nyZnDv5bE0kb1FyNInFIIFLrBXA5ti6Nv6yv2vyzV7P9MZkToQ
         wgCtuexVzdmTp3Q6lm9RmVeu0AlssnLlwhNcu5fnKGS7Ok0pJ8QAC55+EXAbphCshPWQ
         RMp9rphAOUBkuG9bVm+nOSda1jmrPDQfabPN/g2Fd6veEsRFpLmIx9t3Zz0NpFxp8xyo
         WJWWxw+5Eol4hOuNDrc1elS6VpTtAbJHeIiF7torB2+R2RCfMuxRLG4XUEqL3YIlPsXs
         cdt1r1V/zQksnhD6p6N025T1TREVw8YiUQdtZrB2IWUshgit/A59tg1jsx/dD1ClwlD2
         jOhA==
X-Gm-Message-State: AOAM531hu0ihZqoYERNIVi6h6rJOlAD/oQ+5QyC7A4AzLa9gXu7jaaRx
        zyy62f+HbH0SbHJKLKXAZx7eN7Q8DsZTVv96+lb6PE6aFxU=
X-Google-Smtp-Source: ABdhPJzG8ZBDExSmFh/pnJKDGddnE9yfGj/UF8eafs/YVHaKuFcrt9fS9luriwXvzYYrsz1McOvsRxx8CFlMPC8+1zY=
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr39926788lfu.18.1638862398264;
 Mon, 06 Dec 2021 23:33:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
 <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
In-Reply-To: <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 7 Dec 2021 13:03:07 +0530
Message-ID: <CAHhAz+iZe4A9bi9tvwqpHaV1ari76r2bXcO1E6Bm88Cc7XFq+A@mail.gmail.com>
Subject: Re: Time: new clocksource
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 3:18 AM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
> Hi Sekhar,
>
> On 03/12/2021 17:50, Muni Sekhar wrote:
> > Hi All,
> >
> > We have a Digital PLL with 64 bit timer counter hardware and the
> > counter is accessible from the CPU over the PCIe bus.
> >
> > Is it possible to add this timer counter hardware as new clocksource
> > driver? To do this, can someone please point me to the existing
> > reference source code(or patch) for this task.
>
> You can refer to the drivers located in drivers/clocksource
>
> git annotate on one of the driver can give you the initial commit where
> recent submissions explain the timer internals.
>
> > Suppose if it is possible to add a new clocksource driver for this
> > hardware then does any userspace get_timestamp* API would get the time
> > from this new hardware?
>
> It should if the timer is selected as the clocksource
/var/log/kern.log file use a absolute time, like "Nov 29 12:26:13", as
well as relative time in seconds and microseconds since startup , like
"[1263900.984287]

Is the relative time calculated by the clocksource driver module (tsc
or acpi_pm)?

Which module is responsible for resulting in the absolute time? Is
absolute time synchronized across multiple systems connected on the
network?
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog



--=20
Thanks,
Sekhar
