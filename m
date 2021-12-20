Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811347A3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhLTDNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 22:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhLTDNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 22:13:51 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700DC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 19:13:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k2so13671537lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 19:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mF5wYxPSqdxf3ndDaiNpjYh7EExZO+92B2rlWd4Hn/w=;
        b=H/hN9JtCLykDVNHSsTlSCCQbC1jeDpVXuzoQfGiqcOKtC70LixZK3hc4x9DnBgZyYy
         1lLhpZ4uboMNb8eVCBGXv+DAuWFNdo9AJq8iZMJAPl7xxsDE0dNGDqyySE0w4YJ1yLgU
         QaK+fHHXI5tJEgGPBjGRAbFYXb32mQxTV2jCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mF5wYxPSqdxf3ndDaiNpjYh7EExZO+92B2rlWd4Hn/w=;
        b=XrQoi1LJaRkP9Udvzl78m1YkBnuC3Q8PZp7xvvszLWCKB0c+l1MpAHMBflKQCQY8UL
         WGj41M70l06SJeSY7QaQ+mp46LBV+vBN7nQ2kN9BhKNWvbKFb1HN5Ku+0ZLRDyPCjnbi
         is3GY8tgNsXlOey77EupqSFKGeqBEnQD8RuuNyQu6LBJkhQHXQtR4MGkevLvMzqQSOB7
         S/vn0Dcwor2ZLaCIAkDl6baD3o6/+GYw7jNVsOxSHkQ0P6UnTwapB1r5P23orUnBnbIC
         YkEwtW+pzNQevWB/yIUJrpoWgXaeTL3qVHLWCLH9jsxpoOAEeDp5sve9xNbLMn4UGpu5
         07iw==
X-Gm-Message-State: AOAM533Ra0Jayv1kqAt+8GCMsq8zG5/3PIga4Ygz35X9C6FyfOWbnewp
        aglLr3jW5cnVDZ0oxjDC2q1xkY/TqY8HOR9tRD8UwA==
X-Google-Smtp-Source: ABdhPJxunl6swmvnYR15PB/3dHuBiP42NrBlmSpRdVW8fHz4URsaEzdHg45SD9YGC11Q7qsqGbLcNVjoVI+7j1Re0fg=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr13210214ljn.457.1639970029235;
 Sun, 19 Dec 2021 19:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20211106183802.893285-1-aford173@gmail.com> <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
 <CAHCN7xKM9RUE7z-+ug1on+D=nDoEm589R4m03ofys92Aq75ZVQ@mail.gmail.com>
 <8db00a4b6faa99c940d9bc86e17161eb0db5efe3.camel@ndufresne.ca>
 <CAJ+vNU28UJffFv9jQ2KryJMudqYxvCaoVOVcU5dPqRA209iN6A@mail.gmail.com>
 <d91532c2c0772f9aa708ead36b2a97203727a7ea.camel@ndufresne.ca>
 <CAJ+vNU3H-V+bPoZ3qKead45h=W7AhQK6Lhjrx5ssdF4c_qfe=A@mail.gmail.com>
 <CAHCN7x+0LwwU_rEST+TZxGquswGKL19gnTy9WLofsXtGAtWqdw@mail.gmail.com>
 <7f94eaacfddb8c5434c17f1e069ea87a17657ce9.camel@ndufresne.ca>
 <CAHCN7xKRzxMBmPbDobWTuvNNSpTXk5XENvfBnfkhRY3eZKhn6w@mail.gmail.com>
 <CAHCN7xJFLNi_g+HX8PCy1Rkgf0jnWpO5QGYVz8nH19xrJkwHrA@mail.gmail.com>
 <CAJ+vNU3zFd=6k_Emc5aafxKkGwCPp4crgOFezQ-E_MbWsn1_EA@mail.gmail.com>
 <fed6c2fd7cf4971062c417ce41ed1e3812b900e0.camel@ndufresne.ca>
 <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
 <CAAEAJfC1xXvemaFP+vTFVJ3S-SpYtrxyZgDamSOgLC1F3ua5xw@mail.gmail.com>
 <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com>
 <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
 <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com>
 <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
 <CAHCN7xJrM9uZUnmx65uTxWEo6HAkjozd3kD3UoEv-pYd5DV4QA@mail.gmail.com>
 <CAAEAJfBXU-AiKKhkhXzgUSR4p1yefysNuHFycBz3F-GzNewS6w@mail.gmail.com>
 <CAHCN7xL4y67V6AW5MV=8iudvvGVBWs2LoUhu_2CUJf6bSycgFA@mail.gmail.com>
 <8438070708d16c34c0f79aba19e67fa343adb169.camel@ndufresne.ca>
 <CAJ+vNU1ZxAAasKT8j1sfcFz1pk8fyYjwOW6wqxYq_ur8+2MX_Q@mail.gmail.com> <41f0e00cf5e57668b643b096e6bb69c67635c540.camel@ndufresne.ca>
In-Reply-To: <41f0e00cf5e57668b643b096e6bb69c67635c540.camel@ndufresne.ca>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 20 Dec 2021 11:13:37 +0800
Message-ID: <CAGXv+5H1qdvRPK0Qf_aNFpaipateW9ZD4R+AHYT0d4Y8RnWKBw@mail.gmail.com>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media <linux-media@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 1:52 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
> Le vendredi 17 d=C3=A9cembre 2021 =C3=A0 09:26 -0800, Tim Harvey a =C3=A9=
crit :
> > I'm not clear if anyone is working on IMX8MM VPU H1 support. You had
> > mentioned that some support [1] and [2] can be derived from the RK3288
> > using the Google ChromeOS method (a v4l2 plugin that simulates in
> > userspace a stateful encoder). I'm not sure if this is worth pursuing
> > if others are working on stateless encode support in kernel and
> > gstreamer.
>
> My colleagues started last week the project of crafting mainline stateles=
s
> encoder uAPI. This is too early. In older project, we have had good succe=
ss with
> the emulated stateful encoder. It is of course quite limited, but works i=
n
> gstreamer, ffmpeg and chromium. It is also likely safer compared to the v=
endor
> provided driver.

If people still want to play with the old emulated stateful encoder, there
is a forward-ported version in the ChromeOS v5.10 kernel now. Note that
RK3288 (H1) support is untested. Also, RK3288 and RK3399 require different
versions of the userspace plugin. And the RK3288 version might require some
updates to add SELECTION API support.


ChenYu
