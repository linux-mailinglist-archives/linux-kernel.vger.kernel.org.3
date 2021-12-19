Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0C47A296
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhLSWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhLSWOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:14:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F4C061574;
        Sun, 19 Dec 2021 14:14:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D90AB80CEA;
        Sun, 19 Dec 2021 22:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBE1C36AEC;
        Sun, 19 Dec 2021 22:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639952076;
        bh=HP6D72vHsJz+3SuMHStuOjCwZz6yni1egGdsYKfvtq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iiCliS8rlxSpK7ZSKsMXG5TOY01duolI0vZcIKl1SnkM6nRqvR/2jPddBn/7+AeXx
         Smcf+kaWWG1xMUhj1vntFKglBvJb7JH6RHuDweKnoGmVDcCprb9FNVEECdWveW20Is
         DylQo4hVwC9jVPap/qNpI+Tpp1oL0wcTckOP934LMeePVAdaetWgW+FV291lgczbqH
         QGrwIELRQOTuLoDqg4fppCrF9gq5k7GGww1J734rS+sMsLlBygntCDhQlXgy3U4QuW
         F1Svn+JnrqmCD6eXLblQdaQso/sSe0Py44/PeSMtOaX/dDQQbVEnCNnrRzj0uin86y
         /nuwlHKioUF0Q==
Received: by mail-ed1-f46.google.com with SMTP id f5so7782275edq.6;
        Sun, 19 Dec 2021 14:14:36 -0800 (PST)
X-Gm-Message-State: AOAM532kQGpxk1Sgrq1LPlrJfJaumxWbE6GijrZ+FMUIV2VQKX8CpnU/
        p2w91SII3/aqSoBs3Kwy6VZ2cQg3+uYXUMHSng==
X-Google-Smtp-Source: ABdhPJzjQht3KyJniv0l0LSkFmt4saIEjVinWkcMnkDmDIZzEJnLyrHD6/sdsWN5qF36bqcU9AjNEi3K1AM91x8jBB0=
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr10683673eja.264.1639952074754;
 Sun, 19 Dec 2021 14:14:34 -0800 (PST)
MIME-Version: 1.0
References: <mhng-854afd5f-800b-4b58-af68-cdc6afdc0a4a@palmer-ri-x1c9> <5471232.RFuYXYORHR@diego>
In-Reply-To: <5471232.RFuYXYORHR@diego>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 19 Dec 2021 16:14:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWZL42A8G4y3J3uyC5n+Md70rnJjZz2Tt8eJkSPPuAPw@mail.gmail.com>
Message-ID: <CAL_JsqKWZL42A8G4y3J3uyC5n+Md70rnJjZz2Tt8eJkSPPuAPw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] riscv: dts: sifive unmatched: Expose the FU740
 core supply regulator
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Vincent Pelletier <plr.vincent@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        qiuwenbo@kylinos.com.cn, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 3:57 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Freitag, 17. Dezember 2021, 06:35:00 CET schrieb Palmer Dabbelt:
> > On Fri, 19 Nov 2021 14:55:40 PST (-0800), plr.vincent@gmail.com wrote:
> > > Provides monitoring of core voltage and current:
> > > tps544b20-i2c-0-1e
> > > Adapter: i2c-ocores
> > > vout1:       906.00 mV
> > > temp1:        -40.0=C2=B0C  (high =3D +125.0=C2=B0C, crit =3D +150.0=
=C2=B0C)
> > > iout1:         5.06 A  (max =3D +20.00 A, crit max =3D +26.00 A)
> > >
> > > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> > >
> > > ---
> > > Note: checkpatch.pl complains about undocumented devicetree binding,
> > > which is fixed by:
> > >   https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krz=
ysztof.kozlowski@canonical.com/T/#u
> > >
> > > Changes since v2:
> > > - Fix end-of-commit-message separator so change lists do not end up i=
n them.
> > > Changes since v1:
> > > - Added missing "ti," prefix in compatible string.
> > > - Remove trailing "." on subject line.
> > > - Rename tree node.
> >
> > I see this in Rob's for-next as 761de79adc2c ("dt-bindings: hwmon: add
> > TI DC-DC converters"), so I'm going to hold off on this one until the
> > bindings land.
>
> Can't this patch then simply go into your for-next branch then?

Yes.

> The split is most times binding goes through the driver-tree
> (or Rob's dt tree) and the dts patch through an arch or soc tree.
>
> But in general once a maintainer accepts the binding it is ok
> to also apply the dts patch for the same cycle (aka merge window)
> the binding will be in.

Until there's issues with schema warnings showing up in specific
branches, going thru different trees isn't an issue. There's a lot of
warnings to fix first.

Rob
