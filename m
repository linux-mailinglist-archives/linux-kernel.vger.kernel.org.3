Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11D47DA86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 00:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbhLVXWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 18:22:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbhLVXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:22:52 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXoxG-1mz6bm3mqy-00YESJ; Thu, 23 Dec 2021 00:22:50 +0100
Received: by mail-wr1-f44.google.com with SMTP id r17so7897108wrc.3;
        Wed, 22 Dec 2021 15:22:50 -0800 (PST)
X-Gm-Message-State: AOAM532Y5jKLGHkYeoGYo9loKWciernRSpn7B88nsc5PD5GrsvIMe5M6
        2NwO9AR2gUMP4+FgayDl84qCLQ4lNQDkjYiTVFg=
X-Google-Smtp-Source: ABdhPJw9uvBVgsr2Gcg3Nra+s0VShilg43p0yBw7r08mPnnGpKyICZ9z8hi55OCoFPQKV3SgsyicfeMLJf8K3g2dLrA=
X-Received: by 2002:a5d:6d0e:: with SMTP id e14mr3594325wrq.407.1640215370376;
 Wed, 22 Dec 2021 15:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20211223085944.0095eaf5@canb.auug.org.au>
In-Reply-To: <20211223085944.0095eaf5@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Dec 2021 00:22:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3WxP1x60fj7oPzY2=gTUEgA68x1vc17tRHEJ-O19-UTQ@mail.gmail.com>
Message-ID: <CAK8P3a3WxP1x60fj7oPzY2=gTUEgA68x1vc17tRHEJ-O19-UTQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:UJgjNx4krcB90RxxDGdJr08xY+xMCoH3h5yyD/elk5c8aS/f91y
 7d4TUoZ2hADedbjcTrnSoDiSPgB1jyXv7kgdjs3fGuEYsDGM6OkN6uMQX0qX9cHwoifr3u9
 0i2cEn2q+JoQRdZiDv3j7fjsmUkN7L1jqlIPQcXoUlnnvzsETSCqw58sQk0JB3SQrvZV195
 0g3u5sZ2OKKV6U+N2lDIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C5Co6cZAREo=:3rrE46Q6nB7y9rXQVQ79ef
 cXfkXO66G7psmk0uTlwJVPp41ohKK/MsU9370WEp4Ca29fh28OCrKD63Qivn8uFlMvwN2vySW
 mNhxdoFH66jKkQWiL5LUPSYnffCXL6MVNR3Unx07s5D8cboMGcFsPBtyUVWQCCGpLUXBRNsEb
 OgzAIiJUw/uwI0k2G7jeyIUR7ipGo3pdHUo9vWWqMFzPJAXYSyvU7S62KCM27kzsR+52s7bLa
 IsqfJxX7HI0VMTBz7j0jahCfMrx7ee1cSvIKklQPR2ZCcDlTtJBJnPOTbtvWh+WXgvXUxJK1t
 nGkWyig+GVy43CxmDGyCVF5k3zI8WayPMpxeweCLqAEwnMV4RZ/eeeoHZR9TFyYvXjenPFmk3
 BeXN8Rsx++BJ15BcjoBpxKeSE0AUp1XEcdcV+sEpMN3KbRq7/kHY2VAW7oxHFcpmAa6q/e/8H
 3EC7ntZnDY+h2EEPYsGuYSQdcAAUemd0TEXRU21Bujhhaa+eN1Y3sdwnWX8eaNG2hdCHUW/qV
 CEKa1gZh1Bitxm7JJpE++j3zO2JSIaOZf0IHfwFKwR7STnCM4YHL4sgUX2G1Am4kRbfkTsyfp
 b0Q/zfZXj49lrbjJHnorEgu7Z0Wt3RVu2L2vleE2fpICwghbvSiS1m6FfX+JIrmTmfI7HZGpQ
 J2e5/SbGnv6vSYVXqLDen2RvFIY/WNLiftCKx8z9Fy1YNnivBpPUQB7fh0BAMcgBX8as=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:109.4-14: Warning (reg_format): /switch/ports:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_default_addr_size): /switch/ports: Relying on default #address-cells value
> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_default_addr_size): /switch/ports: Relying on default #size-cells value
>
> Maybe introduced by commit
>
>   3d2d52a0d183 ("ARM: dts: BCM5301X: define RTL8365MB switch on Asus RT-AC88U")

Confirmed, and now reverted as I'm already tagging the final pull requests.

Arınç, Florian: Feel free to resubmit a fixed version for the "late"
branch that Olof
may still pick up when I'm out of office, in case this is an important
change. Otherwise
I guess we can leave it for 5.18

        Arnd
