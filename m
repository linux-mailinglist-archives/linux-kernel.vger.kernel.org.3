Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0303847F0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353529AbhLXUJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:09:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:51093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236502AbhLXUJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640376586;
        bh=eNC7I+i361Yog8EK02Z/ORZgODejdYkcfM0BcnGnAAQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IbxrgIInbL5/dni8Yzl4SfgqerPWCBtGredSrbZ22KHN3uYDiOU19Je9Yfy0FyLWD
         Q4dPGMrcnSQZYBE+H8bJGpvV0Dn4dWPHoSKs10q3geRdoWXjlIp+XK0yBpDO44CVuL
         Zjq5UzcGsAuy2NHFW/Lry+r9O/rWGTiCeBOBbneE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1mJZjg1MuE-013dnn; Fri, 24
 Dec 2021 21:09:46 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
Date:   Fri, 24 Dec 2021 21:09:26 +0100
Message-Id: <20211224200935.93817-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J8biOqoz+1r6tydktbk/OZy1RYl0GM40tyPCzFFsnKOswYFi+fb
 zvFe+TF/G/Wsd87624ufP+mgfywnPI8KPsW9KqzfYZyRNA9kXvWk3tCdm6H1xRHRmEYnyuD
 HoDv1bel89zyImbB8tQHIDpIp+lISI4MYYLZflWM6Ia8aTf+56vuRelg7cFEYB1hokqM+0M
 BhzH/9v1V+OZuKhF1Nf+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:52N54s9mEMg=:hRIhPF0BiwUrdSH91Qoclp
 xu1R02JVdJA4FW0Hq1UzcXlJNmBOjG6g+jEnmXbEqeJ55WbCKb67KLQUg6CCIjDzbw7atGale
 SxgKCgGTxgknRbdNi4s8VZ7BM49AHoegqjtmS1B/6fW3CymnWyNW8PPGTfMLmm3fyZvkJNpg2
 gy3ONxwHzcDl6Uu7CUa5mPUM8YtmzM1I/ze7abpTyULD9+9hgX757v3kg1qc0vZCcNC0EVbqt
 +nQQAcNO1VevZOG+nfBpX3GMQHHA4VeKVKhy/gbEC63GCtY3O00Rp11q9DagzeZoMiZzmzRix
 A6dLaUVdA3nWaIMeZjh0O+e/nFKwx6erglwXKDmZq8oko5M78/hXuaC8InKci4BGyl/Xr068I
 BRD5hwwlc2B5sVYnP0eYSZQDnnQIW/t4DF6kVrZjGxfONZw+wSs1D77Mc63CXwpZ72LqjRUEM
 4VlTiAI5qQiE5b07b05x726kl70C0EKDDRKArc7gYH3Q0uHZ5UYLY6V1LkzysM9s5Ty9F1ECR
 UUt5u+2iGTghzRl/RPsN2Dys+CbTuU3GO53cPpvO9ZrNM40oo6u/8/PFiQoos+qiMe7bm/lxN
 s9Mh5IhkH3mi2a8R2LXJR+KU5W/vz8pIz6eOfv/+q1VxeV/EbKsC4EP0pjKkXlpWPjvAJeRbd
 vGJpFZuVNC8i0UN3XdO5Lw9upFkIYlBEmZ/Uwx2cWQPH7rR+TbyMTElp2v0N1nBQ4T1PL4yM8
 9BGTZx8jn7Co3kKg97vB6b1/7lZJD3y+nOU+DKjnOV18h2qztum5NZF2t8jQ7KwQb2VQXSd+8
 imBLvnAyMY3ppxO0TpOCjoVRIlg0P47wIKDkK+MJXAcoFux4WJfrZrsbM0s/szBOOU17egjNB
 qlckvzPTPAEO+t/cVJDpbyC39kTpII/IgpdNUCQc1Xro2yngqabUbkvGDSDsgvVHvX7r6g+EM
 OwbBu/p9Ji4ULD+ObS/XTqbtU7lGYMAIsp4OiUX2O35Ce+POPOQDZfdXKw6i+miqgfORQdZQU
 +yUyqYPrmEVa+ZpVW1p5AueqdyijBwpKW8zp0Z3wgD86enuCOs7LBmwiZvlmM6xyXorTCLZK7
 gzWAMieO66OJeQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 3 of the WPCM450 pinctrl/GPIO driver patchset.

I made various small changes, most of which were suggested by Andy Shevche=
nko
and Rob Herring. For details see the individual patches.

I removed the somewhat unusual nuvoton,interrupt-map property again,
to simplify the DT binding. The encoded information is now in the driver.

The last patch of the series is new. It makes use of the new pinctrl
functionality to associate UART pin muxing with the debug serial port.


Best regards,
Jonathan Neusch=C3=A4fer


v2:
- https://lore.kernel.org/lkml/20211207210823.1975632-1-j.neuschaefer@gmx.=
net/

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-1-j.neuschaefer@gmx.=
net/

> This series adds support for pinctrl and GPIO in the Nuvoton WPCM450 SoC=
.
> Both my DT bindings and my driver are based on the work done by others f=
or
> the newer Nuvoton NPCM7xx SoC, and I've tried to keep both similar.
>
> Instead of extending the pinctrl-npcm7xx driver to add WPCM450 support,
> I copied/forked it. The pinmux mechanism is very similar (using MFSEL1 a=
nd
> MFSEL2 registers), but the GPIO register interface has been redesigned f=
or
> NPCM7xx; adding support for the older GPIO controller would make the dri=
ver
> harder to understand, while only enabling a small amount of code sharing=
.
>
> The DT binding in YAML format might make a good template for also conver=
ting
> the nuvoton,npcm7xx-pinctrl binding to YAML.
>
> Both in the DT binding and in the driver I kept the name "pinctrl". For =
the
> driver, I find it accurate enough because it handles pinctrl and GPIO. F=
or
> the DT node, it's a bit less accurate because the register block at 0xb8=
003000
> is about GPIOs, and pin control happens in the global control registers =
(GCR)
> block, except for input debouncing. So, "GPIO" might be the more appropr=
iate
> name component there.


Jonathan Neusch=C3=A4fer (9):
  dt-bindings: arm/npcm: Add binding for global control registers (GCR)
  MAINTAINERS: Match all of bindings/arm/npcm/ as part of NPCM
    architecture
  ARM: dts: wpcm450: Add global control registers (GCR) node
  dt-bindings: pinctrl: Add Nuvoton WPCM450
  pinctrl: nuvoton: Add driver for WPCM450
  ARM: dts: wpcm450: Add pinctrl and GPIO nodes
  ARM: dts: wpcm450: Add pin functions
  ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add GPIO LEDs and buttons
  ARM: dts: wpcm450: Add pinmux information to UART0

 .../bindings/arm/npcm/nuvoton,gcr.yaml        |   48 +
 .../pinctrl/nuvoton,wpcm450-pinctrl.yaml      |  159 +++
 MAINTAINERS                                   |    2 +
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts |   43 +
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  384 ++++++
 drivers/pinctrl/Makefile                      |    2 +-
 drivers/pinctrl/nuvoton/Kconfig               |   18 +
 drivers/pinctrl/nuvoton/Makefile              |    1 +
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c     | 1132 +++++++++++++++++
 9 files changed, 1788 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr=
.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm=
450-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c

=2D-
2.30.2

