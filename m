Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E517E4D40D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiCJFis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:38:45 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A963B033
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:37:44 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id a186so4806423vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rlmmf/r4fOxvBR1v8trJafjunzp2vrV7N2Tezonrr1s=;
        b=mosiJRrH3AaVXnCmOM+k/KF7lIgYcqkZ/UnusbD7YvrhCWzf14FsoZNjSkLn8QYcQg
         490z2UwO7vZux9RIQOvvfeypOrDTa+kaOLRx0S4rdTEXK6TsgHH8omG6jtEawi8uyVw9
         FIua0Z7TTdBG4iIuC1wmCf8b7yWG+QDJz3GNyEuDegSfWDyenfCXY1loja2BdDklJoMQ
         bkkbdRHDDs3xqcDPoXDOi7BiJkgTSUWHd/dt8a3saFR80Pd2mvrju6VMyOFt40tOyu2x
         CeVkpRYQsha/OScoh+Fx9nSCdx2qSdc37ENv5cijEClEfh9a4Xp95lZyHYmYvZn4CUOr
         jnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rlmmf/r4fOxvBR1v8trJafjunzp2vrV7N2Tezonrr1s=;
        b=JWyMl/YuwkyP64ruAR+Zs0smU2/ISccZIFlP+DX/bcnK0AAsMtELgWiO3RBNmUWWlO
         TZzpdXst7bpwfEMZH+gJaH8L3qqoD4ll4P6EGgFLQWtx7zb5avh6K/hZIP2gC+WhfxYA
         /i6h9FkrNtMVhtIEzqaigx7Ja8Onq/Z8qNIyOh7pH/UsHShGAT6yggI/As7+Rp5me0Kw
         pYfUAe/bycuzqkP0TZ78QuuXNfuAGIHW1vtWivOPpXNba3d9I5WJS22Q1aSGr2pHD00q
         Z9K3Pn4LhM2WDvSupvaJfSemmtN0ThIO3whWyKN+/mowbX4pRzhDOnU9W14iMznR0qGb
         Pb7Q==
X-Gm-Message-State: AOAM533GyVqsxYF1669I5sYO9dU+JSFs0MOSZP9aFq4yYnZTUUDLwgFH
        HWSjwZdB+02MLqOirwg/GH0xH/6S30uFSJIr8eo=
X-Google-Smtp-Source: ABdhPJyTvmkhMbggW7TnAaiX7Oj3Wj9tN6h2YUPtt3utsBmpc7j2g//WgMSVPMghbQlvcbt9+2ftKvqBZOVEcWBqwD4=
X-Received: by 2002:a67:e444:0:b0:320:dbc4:6372 with SMTP id
 n4-20020a67e444000000b00320dbc46372mr1886562vsm.72.1646890663874; Wed, 09 Mar
 2022 21:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20220310004433.5713-1-yusisamerican@gmail.com>
 <3179f015-58d9-6786-c2c4-6a54088c9221@infradead.org> <CAJoG2+9EN9uP0-S+vpfgiRzu_ZXx017vXEZMY7wcuZ+5BZoEYQ@mail.gmail.com>
 <daa82c42-d677-c007-3295-e3f533a28b87@infradead.org>
In-Reply-To: <daa82c42-d677-c007-3295-e3f533a28b87@infradead.org>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Wed, 9 Mar 2022 21:37:32 -0800
Message-ID: <CAJoG2+9pKqhpgCbFFGGK0+KTx9g8bgu37EvqABzmpTvAa8FJkw@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: ddcci: upstream DDCCI driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
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

(2) I agree, it seems fitting.

(4) bootlin a really great source code browser see
this link: https://elixir.bootlin.com/linux/v5.17-rc7/A/ident/modalias,
someone in kindergarten can realistically debug kernel issues and
fix them with it.

On Wed, Mar 9, 2022 at 9:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 3/9/22 21:01, Yusuf Khan wrote:
> > Thanks for the feedback!
> >
> > (2) Where would I place that documentation then,
> > documentation/devicetree/bindings/?
>
> I like the way that you have all the info in one place, but the
> current way Documentation is organized has /sysfs interfaces in
> Documentation/ABI/. Then I would put the rest of the doc info in
> Documentation/driver-api/ddcci.rst.
>
> > (4) A quick look at bootlin shows a symbol called
> > "modalias referenced 176 times.
> >
>
> Well, bootlin is not a kernel driver.
> I see places in generic ACPI or generic (other) firmware code
> or SPI bus working with modalias strings. Maybe it's OK --
> just seems odd to me.
>
> >
> > On Wed, Mar 9, 2022 at 6:49 PM Randy Dunlap <rdunlap@infradead.org> wro=
te:
> >>
> >> Hi--
> >>
> >> On 3/9/22 16:44, Yusuf Khan wrote:
> >>> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> >>> index 740811893c57..c7aa439d23e7 100644
> >>> --- a/drivers/char/Kconfig
> >>> +++ b/drivers/char/Kconfig
> >>> @@ -451,4 +451,13 @@ config RANDOM_TRUST_BOOTLOADER
> >>>       pool. Otherwise, say N here so it will be regarded as device in=
put that
> >>>       only mixes the entropy pool.
> >>>
> >>> +config DDCCI
> >>> +     tristate "DDCCI display protocol support"
> >>> +     help
> >>> +       Display Data Channel Command Interface is a
> >>
> >>                                                  is an
> >>
> >> Also, the line above ends with a space. Please check the entire patch
> >> for lines that end with SPACE and remove the trailing spaces.
> >>
> >>> +       interface that allows the kernel to "talk"
> >>> +       to most displays made after 2005. Check your
> >>> +       display's specification to see if it has
> >>> +       support for this.
> >>> +
> >>>  endmenu
> >>
> >> (2) ddcci appears to be a char driver, not a misc driver,
> >> so its documentation probably should not be in Documentation/misc-devi=
ces/.
> >>
> >> (3) The documentation file ends with:
> >>
> >> +options ddcci dyndbg
> >> +options ddcci-backlight dyndbg
> >> \ No newline at end of file
> >>
> >> so please add a newline at the end of the last line.
> >>
> >> (4) What is the modalias stuff about?
> >> Does the kernel have other drivers that play modalias games
> >> like this?
> >>
> >>
> >> (5) This standalone comment might need some more text.
> >> Doesn't make much sense by itself.
> >>
> >> +       /* Special case: sender to 0x6E is always 0x51 */
> >>
> >> Does that mean something like "reply to 0x6E is always 0x51" ?
> >>
> >>
> >> (6) Be a bit more generous with spaces around operators (kernel style)=
.
> >> And be consistent.  This first line is OK, second line not so much.
> >>
> >> +       xor ^=3D ((p_flag << 7) | len);
> >> +       *(ptr++) =3D (p_flag << 7)|len;
> >>
> >> This line could also be improved with some spaces:
> >>
> >> +       ret =3D payload_len+3+((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)?=
1:0);
> >>
> >> (e.g. -- I expect that there are others.)
> >>
> >>
> >> (7) Too much use of likely() and unlikely().
> >>
> >> (8) I don't see anything in the Kconfig entries such as
> >>         depends on I2C
> >>
> >> so do these 2 drivers work without I2C being enabled in a kernel?
> >>
> >> Oh, if I build ddcci without CONFIG_I2C:
> >>
> >> ../drivers/char/ddcci.c: In function =E2=80=98__ddcci_write_bytewise=
=E2=80=99:
> >> ../drivers/char/ddcci.c:104:8: error: implicit declaration of function=
 =E2=80=98i2c_smbus_write_byte=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
> >>   ret =3D i2c_smbus_write_byte(client, addr);
> >>         ^~~~~~~~~~~~~~~~~~~~
> >>   CC      kernel/delayacct.o
> >> ../drivers/char/ddcci.c: In function =E2=80=98__ddcci_write_block=E2=
=80=99:
> >> ../drivers/char/ddcci.c:165:9: error: implicit declaration of function=
 =E2=80=98i2c_master_send=E2=80=99; did you mean =E2=80=98i2c_match_id=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
> >>   return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
> >>          ^~~~~~~~~~~~~~~
> >>          i2c_match_id
> >> ../drivers/char/ddcci.c: In function =E2=80=98__ddcci_read=E2=80=99:
> >> ../drivers/char/ddcci.c:216:8: error: implicit declaration of function=
 =E2=80=98i2c_master_recv=E2=80=99; did you mean =E2=80=98i2c_match_id=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
> >>   ret =3D i2c_master_recv(client, buf, len);
> >>         ^~~~~~~~~~~~~~~
> >>         i2c_match_id
> >> ../drivers/char/ddcci.c: In function =E2=80=98ddcci_identify_device=E2=
=80=99:
> >> ../drivers/char/ddcci.c:413:10: error: implicit declaration of functio=
n =E2=80=98i2c_check_functionality=E2=80=99; did you mean =E2=80=98in_lock_=
functions=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >>        && i2c_check_functionality(client->adapter,
> >>           ^~~~~~~~~~~~~~~~~~~~~~~
> >>           in_lock_functions
> >> ../drivers/char/ddcci.c: In function =E2=80=98ddcci_module_init=E2=80=
=99:
> >> ../drivers/char/ddcci.c:1835:8: error: implicit declaration of functio=
n =E2=80=98i2c_add_driver=E2=80=99; did you mean =E2=80=98ddcci_add_driver=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >>   ret =3D i2c_add_driver(&ddcci_driver);
> >>         ^~~~~~~~~~~~~~
> >>         ddcci_add_driver
> >> ../drivers/char/ddcci.c: In function =E2=80=98ddcci_module_exit=E2=80=
=99:
> >> ../drivers/char/ddcci.c:1868:2: error: implicit declaration of functio=
n =E2=80=98i2c_del_driver=E2=80=99; did you mean =E2=80=98ddcci_del_driver=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >>   i2c_del_driver(&ddcci_driver);
> >>   ^~~~~~~~~~~~~~
> >>   ddcci_del_driver
> >>
> >>
> >>
> >> --
> >> ~Randy
>
> --
> ~Randy
