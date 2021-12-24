Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33C947F033
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbhLXQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhLXQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:47:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBCC061401;
        Fri, 24 Dec 2021 08:47:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so35316002edv.1;
        Fri, 24 Dec 2021 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFScus/ame76bWpcqZHHvQTmyFNXiXhuTjYyULhGS94=;
        b=mGl0/MzM1+NjhR7NFXNbn/B1UDLF3lkqbp+pEe9C2JOHQf96oIQrTj90KWogmQgDgi
         ctf4pUlYf+OUwMxaCSgFhrS87RgPzckzZAk9q/ksFALfrY9ZhHnz+xUIuZvyeJx1xAwZ
         b+hYxjRHWJIkl3KA9TQluTeN5FYmt4rpDXpYhEE2epnRTjyWA9k1T1zCPenbi72Vy2d7
         ZQiRTilayPv02NthxNNqYgR2kjad0yHkM80SZZBNyPB9v0HbEZB0v+/ips/IeVvvT5PH
         b2Wi/7abKMXs9rzWUTVzfahwSZfWSnGsU36Kr9xA3dyUhRWFoee4YnDtlPG0Qm5hyLYS
         nt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFScus/ame76bWpcqZHHvQTmyFNXiXhuTjYyULhGS94=;
        b=yFQrcgBXrS4cxXjWh1qoA2AConoMbiEnKEliWwHY83It9PquuGzU7HSBkXvI9tUYLy
         xrFKykWsdB+XQP3aj30XMq6xeQo6BkWGTsrAaun4B75AG3cKacZ6/NLFWxMKlHxpHSAp
         NfkR/+tDSCCAmiRSTQGVC2HR5hfzqFdMJLODwyW8/X8BKdg+lyFfHnewCjC7PKYbiDpM
         cj0Zqtx6t7lDRagQKpD1Bl2QLBp8x/5LJHo8h3OxyGVqgp9LUghC9Tmx44iQ8t1MsMXg
         ilz44rodAOfzz8JHI6cQotBdB+wpOOaIIv0YommUS0tZxVgtsoNJEuTOWMUUHKGEvLAC
         TY8w==
X-Gm-Message-State: AOAM530R0IondoPXH8M5Zqdek80A26ItFepGgRffUfbMsUqZYKOXy5Ot
        w9tLmq8nk206kc5pc1IezovQCvYTL+WJ5jJJQ2H9a1Gu4YA=
X-Google-Smtp-Source: ABdhPJwF4nP7nicyl0oIWZZzbzuTU42CJYK1j6bdCh/gCrF5TFetfymQCMJE1bt43WmG8gQGYXad64xrd1EHFQ5RX78=
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr6521577edb.32.1640364429999;
 Fri, 24 Dec 2021 08:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20211217073521.35820-1-zelong.dong@amlogic.com>
In-Reply-To: <20211217073521.35820-1-zelong.dong@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 Dec 2021 17:46:59 +0100
Message-ID: <CAFBinCA7DXG5o1yc=5HTM4R_yYMBMUPZMWvF1W++PBQabRKQvA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: add bindings for the Meson-S4 SoC
 Reset Controller
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 17, 2021 at 8:35 AM Zelong Dong <zelong.dong@amlogic.com> wrote:
>
> Add DT bindings for the Meson-S4 SoC Reset Controller include file.
Are you also planning to add a new compatible string to
Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml for
the Meson-S4 SoC as well?
We do have compatible strings for the A1 SoC in there as well (just to
name an example).


Best regards,
Martin
