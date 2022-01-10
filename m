Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0248945E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbiAJIzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:55:38 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:45663 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiAJIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:52:45 -0500
Received: by mail-ua1-f49.google.com with SMTP id x33so20761198uad.12;
        Mon, 10 Jan 2022 00:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRrhnzxIx33BHyJCSHFJIK780dP5z6iPEtjsS253KxU=;
        b=WcFO35xyCFYjjj7SnmiJKy6qnMPrM6yIffUXL+gQM2rwMxsBaFvI88G3o7b+LwihpE
         kVLxBzRXDb4F/uOH0+YlAx8qBPq82/rn8VwmMmoXELWv24B+9w2rVUiG3Qr22thXsAu9
         VuMWIiJzvL/WsMyfBq8wuMa46E/zt1irZTrxB7I7xFbR2eIsWeqOQqkPo/flNkvpHO+q
         xvWao8lYG8o3TUILv/HMzI3kh2dSxjXKI5rj5M7+bEO65qhSdSBT+/oXYApf5u7lVOiN
         04Wfj64VPySqXIXmtvQ7vm4LZChXbMb7qjrP/MwJwlBBP4xHg5szubtlIwJ6Fq5NtjMS
         hStw==
X-Gm-Message-State: AOAM530o48ZFNxEOhogqm2m8O5VBsP8E3ITOLTjaNiSKjrgUQNya+Leo
        S0otgsTfTirtstfXiSD3CBtE1ReGlnNUbA==
X-Google-Smtp-Source: ABdhPJyJcZU9vEOvXR4Nf/DfbUD/KFl20UQCrzlNG9QS2SvgeBlNvh7oNcvwqwnTEqD74gMBTGlQVQ==
X-Received: by 2002:a67:6a42:: with SMTP id f63mr613188vsc.9.1641804764617;
        Mon, 10 Jan 2022 00:52:44 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id q5sm3601985vsl.10.2022.01.10.00.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:52:44 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id p1so22077830uap.9;
        Mon, 10 Jan 2022 00:52:43 -0800 (PST)
X-Received: by 2002:a67:e905:: with SMTP id c5mr191335vso.68.1641804763769;
 Mon, 10 Jan 2022 00:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com> <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 09:52:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHMzZipXaUE_SrkHtj6edZATefC908P1ngLrnOry8KCA@mail.gmail.com>
Message-ID: <CAMuHMdVHMzZipXaUE_SrkHtj6edZATefC908P1ngLrnOry8KCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 6:23 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Add the missing lvds0 node for the R-Car M3-W+ SoC.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
