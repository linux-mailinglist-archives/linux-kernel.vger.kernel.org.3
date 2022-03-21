Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80D24E29FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349861AbiCUOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348675AbiCUOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:02:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585FAF1CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:59:35 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r2so10423844ilh.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dbu61RfAwLouDAK/6ENRGBRMkX9WqXG9dwqpw7GxGSc=;
        b=7U2GmjtjG+KrmWmI+8LnHnC6pKk/onL0sIn/KKf2y6YATs19BdLc4K5oEmR+8A0RZg
         0qo4IJb1pJTxOHiGgCYAnY2Q5o18uabgI4uzBVZy9k21HrIblwrfH8Tu3Uk9271zXR/h
         kLvi5r+pVlsH+AG0wOxCtF90HZtHZnkSh3tSxvPZvOFZLXvy/WKVJgpPsdAZrQdRTLFd
         cRC9Y8/Lzkr/TmS80iBEnmytntbMXaig11TNkBgyKq9qByMGV1r1WxJdpp9WTV9re3mr
         a2zakmessXkdnbYh9wmbOthz+MqEBeeMmslgGMnu7hCY14/gsdvMog7Iwulgdrp41IG4
         E3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dbu61RfAwLouDAK/6ENRGBRMkX9WqXG9dwqpw7GxGSc=;
        b=J/8eEv3xC3OAdOu80sdSpqeL4+oLdR4ssxfMA1WLYMiSsF5DfJC7mvryNc+p1YRCFp
         a3ddj0VK2x+zh9minT4Isz2VUKAhXuGc4p0qYlgbqY1dASmhErdM3ujIKZTdfVXpUQd3
         b9jGV74mcBZKlK09xg8A0k9Im6CWYv3DZagakNITfCOcncasNRe501BTEG8WpgnZj9wV
         dwxqkCPqKzdupUg9wSYzkLdeLveFGcuWV5kKs0FaQ4WL6n2DJuiEOUujPNuQ0CfvM+p2
         sBGZK8ZKxhkoN+n5aNjDbX78xqkRtSe9uEZ6CGdcRJANn2ZJUyGeYvf35Tys8TmGTtGY
         GW/g==
X-Gm-Message-State: AOAM533STu/13sFn8Fl2n47xedNzkn5HXS9JSz7Oo8LjfKNMkzFU3SRr
        vOM4FzA/5MPpRgg00G0RWn4jESw3tHc6gI6sMELHcg==
X-Google-Smtp-Source: ABdhPJwFqiFF9wihpG2UV5EQ49HN7qgFBajF2wJoIKoeMVICJzzPqmjxMje563P+A3DunP4nG2b1CqH38mr2jjOtK2g=
X-Received: by 2002:a05:6e02:1a0f:b0:2c8:28e2:72a6 with SMTP id
 s15-20020a056e021a0f00b002c828e272a6mr2418757ild.27.1647871169028; Mon, 21
 Mar 2022 06:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220321121728.414839-1-robert.marko@sartura.hr> <20220321134055.o3uz5al5np7fj273@pali>
In-Reply-To: <20220321134055.o3uz5al5np7fj273@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 21 Mar 2022 14:59:18 +0100
Message-ID: <CA+HBbNE6ULsT1k7ZVsKk0JONsgYz50fzrrWb26_3LSs29p49Gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:41 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 21 March 2022 13:17:27 Robert Marko wrote:
> > Partition currently called "uboot" does not only contain U-boot, but
> > rather it contains TF-A, U-boot and U-boot environment.
> >
> > So, to avoid accidentally deleting the U-boot environment which is
> > located at 0x180000 split the partition.
> >
> > "uboot" is not the correct name as you can't boot these boards with U-b=
oot
> > only, TF-A must be present as well, so rename the "uboot" partition to
> > "firmware".
> >
> > While we are here, describe the NOR node as "spi-flash@0" instead of
> > "m25p80@0" which is the old SPI-NOR driver name.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
>
> FYI, U-Boot now contains copy of kernel's A3720 DTS files, so you should
> send same patch also to U-Boot project.

I am working on uDPU fixes for U-boot as well so it will get synced as
part of the series.
Regards,
Robert
>
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/ar=
m64/boot/dts/marvell/armada-3720-uDPU.dts
> > index 95d46e8d081c..ac64949bb53e 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> > @@ -99,7 +99,7 @@ &spi0 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&spi_quad_pins>;
> >
> > -     m25p80@0 {
> > +     spi-flash@0 {
> >               compatible =3D "jedec,spi-nor";
> >               reg =3D <0>;
> >               spi-max-frequency =3D <54000000>;
> > @@ -108,10 +108,15 @@ partitions {
> >                       compatible =3D "fixed-partitions";
> >                       #address-cells =3D <1>;
> >                       #size-cells =3D <1>;
> > -                     /* only bootloader is located on the SPI */
> > +
> >                       partition@0 {
> > -                             label =3D "uboot";
> > -                             reg =3D <0 0x400000>;
> > +                             label =3D "firmware";
> > +                             reg =3D <0x0 0x180000>;
> > +                     };
> > +
> > +                     partition@180000 {
> > +                             label =3D "u-boot-env";
> > +                             reg =3D <0x180000 0x10000>;
> >                       };
> >               };
> >       };
> > --
> > 2.35.1
> >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
