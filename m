Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE6467596
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351708AbhLCKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhLCKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:54:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE4C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 02:50:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q3so4812582wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QcF+l5bxXvtlevCx7Zr3XRmHnTSAGcextsc6b2RTbnE=;
        b=REtLPeXKrovJCDXe1uVHNen+AMMqYqS6tOv73PooICV0Gul/ZqoZrBJxPgph99Vk/y
         90QeFD+RPq//ggQZnYAowJ2BZdI67r1KDCeEeeRVKdUXHIFjyNFN81Lg4t3q7gBd3yKh
         GPNgWCB0EaVOJeuXm6TMh8xJSXxib7jvaw+7GAJKggEQEp4BF2uJew3rpq77G//+VA60
         SbBpeMFMCfsHMSygAmb9B5C2lsQ3vXaWQ5T2TEnTYBIF0OG5KeozlZurU5SMoSHjz+Wg
         SIZPmnXET3Fsmb9vZy7ObI7cn5p8s0lTc0dPi6rvHWtZOA9zWbO8W05XvRX+CACCUCO1
         z2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QcF+l5bxXvtlevCx7Zr3XRmHnTSAGcextsc6b2RTbnE=;
        b=mGTf59lehRMcbFb6CPDChmt+rC5fqq5gZQVpQN+tQrkspTJVxuQJjPOQCRJDBVuVVR
         amr1pG9JHMPaz3SlN0FKuejORCisBnFm0qPu/rg2C0DIjlSHZMuMlRWwmD7tIFGBAEMz
         2bzElPHTFQVBJOi2lzP5Eazg9BPbW+7Lhe0DAVgJwEHeAnds2P+iYZFlDShONqoSIg0G
         WJM//ituG/mExKiHfZGGEfttVIZ/fKHif0HRM6tVe01CJqoMP2l11VLc593djAMZOtaK
         4nrEMKv5iQHZ9FvUPQ+I7lehlLnRsnSnDuwlFoCcuz2p1pdI5M0A0Gme37rw9iR3crDm
         OVcA==
X-Gm-Message-State: AOAM530oUcp6OMWHf/aGCqrEBce1neCtCssvpCw5BHaSFk5Af7FDuTbA
        oSNpYEdT5cTyDtFtH0CtUYIFYQ==
X-Google-Smtp-Source: ABdhPJwtE7MY6B9ILicxX+ipAFjRWWhoqcsyqm9KXIhK6J1ESCTtU6qGOsrgXqzeLU46AdZEjiOiEA==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr20888702wrr.444.1638528647512;
        Fri, 03 Dec 2021 02:50:47 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id o10sm2897628wri.15.2021.12.03.02.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 02:50:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/1] riscv: dts: fu740: Add PDMA node
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20211203095744.1717706-2-v.v.mitrofanov@yadro.com>
Date:   Fri, 3 Dec 2021 10:50:46 +0000
Cc:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC14F9FB-D4E8-48DC-958A-CFEF2115F803@jrtc27.com>
References: <20211203095744.1717706-1-v.v.mitrofanov@yadro.com>
 <20211203095744.1717706-2-v.v.mitrofanov@yadro.com>
To:     "v.v.mitrofanov" <v.v.mitrofanov@yadro.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Dec 2021, at 09:57, v.v.mitrofanov <v.v.mitrofanov@yadro.com> =
wrote:
>=20
> HiFive unmatched supports PDMA but is not implemented in DT.
>=20
> Add the PDMA node in SiFive FU740 soc-specific DT file.
>=20
> Signed-off-by: v.v.mitrofanov <v.v.mitrofanov@yadro.com>
> ---
> arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi =
b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> index 64ff2e758336..833fb4f4376b 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -164,6 +164,13 @@ prci: clock-controller@10000000 {
> 			#clock-cells =3D <1>;
> 			#reset-cells =3D <1>;
> 		};
> +		dma: dma@3000000 {
> +			compatible =3D "sifive,fu540-c000-pdma";

I know the PLIC and CGEM devices abuse fu540-specific compatible
strings (which it would be great to fix; FreeBSD is already prepared
for that, though it=E2=80=99d also be nice to introduce a generic =
compatible
string for the SiFive CGEM rather than having just a SoC-specific one
given the FU540 and FU740 have the same interface), but let=E2=80=99s =
not make
things worse. This should say fu740, and there should also be a generic
SiFive PDMA compatible so we don=E2=80=99t need to add a new compatible =
to an
otherwise-unchanged driver every time a new SiFive SoC appears.

Jess

