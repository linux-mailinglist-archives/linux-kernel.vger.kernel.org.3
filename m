Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876DE4C9700
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiCAUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiCAUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:33:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907BF1AD82;
        Tue,  1 Mar 2022 12:32:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n14so22300758wrq.7;
        Tue, 01 Mar 2022 12:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CrQXtLIGnRJeaQHQZnoEPNrRNT+7/qaBjqmC6+8ZDYA=;
        b=gwPNVZYiRqm/ONMrZpXb5c/9raUwfFAFa5xWtypoXxpNWHjRwbdBrN7ce1jsSnUi5E
         qu4tjsQE+/eFRINGfuAAC8fxvuigawD6NshWh2jJsNbNyD5ncd4CGkmQN7fiCcvHqNJv
         hpt8YYho7cEwf6o+a4lgCnCb7BgzNWGqovXSt3wU93Kr5yG8/ajgaZ6H5Du/HTLG/mEF
         VY+xszOpxm1UffGR4FrA3BcWhCSDC6tSNi9zV7kFRamiK9cNTlrMkhP+LqXD0yl/nv4E
         h4ZZYlUUsYobbY33WFhIOejaEVjjSnXLyiXi29U2rgYN+KGhINIWsTc8QGkdYlRtEWuW
         RZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CrQXtLIGnRJeaQHQZnoEPNrRNT+7/qaBjqmC6+8ZDYA=;
        b=M2xravbuQW0cnUBQnhz/aYdOgpm0H/62iv03JDukhyCpVlVsZteDyiXp8+mUU6SCtW
         vjjh6aDOxOb0JmwxgyNeDRPkWcP9Mus8tsnENvmgaYg/u7kZtvZtZRJWbaKDunE9d1zH
         JlBkh31v+TqUJrfS1J59vDnDoNFSpKb7MZ/09SQUbb6/QgHwH1+SRsfIsoQYfEo/Iyxa
         o6W/fleGXk1dNTmRIWc4aUAOQPfmZ49Fe68OrFIKq1zcaw+7zgkVS5ZtDr/uPei4+Wye
         /W4IwE+uuPJKE+dhvH5ht97okzmRyVmRzRGRNgj2LIe96daWbNlg5b615JqTvpmF+/sa
         3IyQ==
X-Gm-Message-State: AOAM530ZQyStTUG5qPuqp/nlnI/1hC6DAKIgMF/WNtr76jJwJ2kcLiZj
        W3ARBmAUOHcbvyAHpyMnhUiAShWzxm8bVH9C/cST+vusmBgGrw==
X-Google-Smtp-Source: ABdhPJyOyqrAmq0du9j8vJye29kK1c8pmM58hk4zrpISMGQfTykc6McfVWvFM94evxgpJmtoTmCcTROBwR2hlAwTSlk=
X-Received: by 2002:adf:efc6:0:b0:1ed:f546:bd94 with SMTP id
 i6-20020adfefc6000000b001edf546bd94mr19989617wrp.33.1646166758969; Tue, 01
 Mar 2022 12:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20220215163926.894-1-paweldembicki@gmail.com> <CACRpkda=ky29PiTjWimnNihLDHSTfYWk68qg5GcLqZTD76ba=g@mail.gmail.com>
In-Reply-To: <CACRpkda=ky29PiTjWimnNihLDHSTfYWk68qg5GcLqZTD76ba=g@mail.gmail.com>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Tue, 1 Mar 2022 21:32:27 +0100
Message-ID: <CAJN1KkygDrGPzJj4nobS-ZFSRqP+g9LQ49tbcLA8V7KvPhfYOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 1 mar 2022 o 00:43 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Tue, Feb 15, 2022 at 5:40 PM Pawel Dembicki <paweldembicki@gmail.com> =
wrote:
>
> > +&i2c0 {
> > +       status =3D "okay";
> > +
> > +       rtc@30 {
> > +               compatible =3D "s35390a";
> > +               reg =3D <0x30>;
> > +       };
> > +
> > +       lm63@4c {
> > +               compatible =3D "national,lm63";
> > +               reg =3D <0x4c>;
> > +       };
>
> Think about adding chassis thermal zone for this sensor,
>
> I suppose you don't have any active control of cooling (fan)?
> This often sits on GPIO...
>

Hi Linus,
It has a fan controlled by the lm63: PWM controller. But the fan blows
only on disks, board temperature won't change even when PWM =3D 100%.
It should be controlled by hdd temperature.

> In that case just add a critical temperature so it can't burn
> down the house.
>

Patch it's merged now, I will add critical temperatures in a separate patch=
.

> See:
> arch/arm/boot/dts/gemini-dlink-dns-313.dts
> node thermal-zones {} for an example of how to do this
> quick and easy. You need CONFIG_THERMAL and
> CONFIG_THERMAL_HWMON for this to work.
>
> Yours,
> Linus Walleij

Best Regards,
Pawel Dembicki
