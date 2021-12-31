Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A75482553
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhLaRQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLaRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:16:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4FC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 09:16:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v7so56811787wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nW3DRwBXlWxCsw3rkSWFhL6nZOR/Uw6StM6XHT9/rAY=;
        b=SUARbtRK/Q6wxcxjjpNA+tLAytZ3tSIuGys93vOAubdM7+oXzozKqsZ1nueUKAxpOo
         YryBJDO4rPwzJnOx/6fVZSC+M6wwegsjnc3vayRdEdeLq1KZo5nvaH5jzc4/5zAWPuXV
         tHM5FDTraUVJ5a82TMuZkWdjpuJ+/sABDEtuaQ1igflT15IZrVwMWdgD513/AU62c1Bu
         10MBvp8oU0aTNKfPAADeCBw8xPiXsC2YUItXFeizdLVHQ+wRWQm5ToNdqYl6wxFrAbgb
         j1cHE2S1H5yBIJrdtEieoi5lVuAI64KK/pAGpSmHA0eYndLEI4T5QoY7gqDax2lGTVAc
         S6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nW3DRwBXlWxCsw3rkSWFhL6nZOR/Uw6StM6XHT9/rAY=;
        b=EJ1ZTxBxPZB4d13ZB9mLpsw5Mf6feQJ8Y/gUGzhwRcPLR/Z0nSY4YZpNiQ0P63gdvq
         4Yahkb7Nvsu6dJlh88V3/0FeiSi1azSyUl+YcP8ussQYyb6MiWQURoT8XWighdWIV/Om
         PXzHtxkfAYl/AIDTVCmzQqqc3opgMW8xoSUAZyhydP2lGWtCTChoBstYaPECtDW6jwY0
         fwWj8WKUTLnzvj5g2X0dAR8wPDvFzMRplVLQSD0PfkhR3gZ/I3GXuXh71rqxH7++35jm
         dh4gtR4znu/dNXeqfVk1QboRn3H74Ar6OIF55MAxomKd9ksuJ25EsLesfAVfjJpdAFFC
         KmMA==
X-Gm-Message-State: AOAM531AJYt+ji/rJEdyKRXkGgVJPrtKok6qh7ScZ3GiuSuMVXpqDIbs
        kk3gQ+PY1ftC9X/dl9Wn8OB73g==
X-Google-Smtp-Source: ABdhPJxHr6RcCJR4Xr5xMJYG4onusmC3VQwM62AcBuYQhyzFRV3AB/cgcID+72uMYWwAPxjDbNjN9w==
X-Received: by 2002:a05:6000:2a6:: with SMTP id l6mr29788136wry.76.1640970961775;
        Fri, 31 Dec 2021 09:16:01 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id z5sm26518553wru.87.2021.12.31.09.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Dec 2021 09:16:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Add gpio poweroff
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CADWks+Yjh1B=Fu8NFS4KYrvNh_bU8P5pzb+_yNvseS+1+D5H7Q@mail.gmail.com>
Date:   Fri, 31 Dec 2021 17:16:00 +0000
Cc:     Ron Economos <w6rz@comcast.net>, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED7B7FCA-182C-45AC-90E7-17559762DE0B@jrtc27.com>
References: <20211231061110.89403-1-w6rz@comcast.net>
 <73F7FAE3-5113-48DD-B0F5-0EEAA0A8B0C1@jrtc27.com>
 <CADWks+Yjh1B=Fu8NFS4KYrvNh_bU8P5pzb+_yNvseS+1+D5H7Q@mail.gmail.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Dec 2021, at 16:49, Dimitri John Ledkov =
<dimitri.ledkov@canonical.com> wrote:
>=20
> However, in some configurations uboot loads kernel provided dtb, then =
this pin needs to be defines for SBI to provide poweroff via this pin.
>=20
> Kernel, uboot, opensbi dtbs for unmatched must be consistent with each =
other and all should define poweroff pin.

U-Boot SPL loads its embedded DTB for OpenSBI=E2=80=99s use. U-Boot =
=E2=80=9Cproper=E2=80=9D
loads the kernel=E2=80=99s DTB for the kernel=E2=80=99s use. The DTB =
loaded for the
kernel is never fed back somehow. Just as we don=E2=80=99t provide DDR =
timing
information in the kernel DTB, only U-Boot=E2=80=99s, there should be no =
need
to provide information about this GPIO to the kernel. Either the kernel
will prioritise SBI power-off, which renders the DTB node a complete
waste of space, and possibly confusing to exist, or the kernel will
prioritise GPIO power-off, which should be discouraged as you=E2=80=99re
supposed to use standardised firmware interfaces for these kinds of
platform-specific things.

Jess

> On Fri, 31 Dec 2021, 06:58 James Clarke, <jrtc27@jrtc27.com> wrote:
> On 31 Dec 2021, at 06:11, Ron Economos <w6rz@comcast.net> wrote:
> >=20
> > This patch is required for the following commit to work.
> >=20
> > commit f2928e224d85 ("riscv: set default pm_power_off to NULL")
> >=20
> > Signed-off-by: Ron Economos <w6rz@comcast.net>
> > ---
> > arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
> > 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts =
b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > index 6bfa1f24d3de..c4ed9efdff03 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > @@ -39,6 +39,11 @@ rtcclk: rtcclk {
> >        clock-frequency =3D <RTCCLK_FREQ>;
> >        clock-output-names =3D "rtcclk";
> >    };
> > +
> > +    gpio-poweroff {
> > +        compatible =3D "gpio-poweroff";
> > +        gpios =3D <&gpio 2 GPIO_ACTIVE_LOW>;
> > +    };
>=20
> Why? It=E2=80=99s abstracted by firmware, which works.
>=20
> Jess
>=20

