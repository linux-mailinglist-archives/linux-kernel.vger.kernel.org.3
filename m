Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E16A4D4087
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiCJFDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:03:12 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844D12D902
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:02:11 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id v128so4697991vsb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jySgR1fPqvfZZBv3yGCaJQ4lf1qw1dUcgQtpnFPURqE=;
        b=h8SBs4rDLu49fksfllIIjPGjgV5jW7CKnbzJLQlQoO3VwAPuiQI+ygkooS7IWH3FFe
         FBUrNarfwEI+CrF+WWhQWYNlef47dUddWo1rywH7LAOCbFDTCVdCEgOtfiS22n+pUKYj
         mwN0fTrHza2CylD/RHfq3UYh7stBStazcrrRidF1gR3+Tpwl6w3qmkZ9iePVearq7LRb
         CQD3v4x5aiS5M6W3qT+dxPm+bBQYydJAnWTH0pPJXWEO9GGFhAWu6jlIGX837NLno1jj
         yj1C+V3h5A5Qn2nzSiUniazjhlpvM8z4+pN9iY6966o6kz0x05RoXM90MCDf0GBZzA7R
         K66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jySgR1fPqvfZZBv3yGCaJQ4lf1qw1dUcgQtpnFPURqE=;
        b=T88CX7hUkoiecaj02B9iFoq1WWVuBXol0vuChWL9/L1frmq4E3gMC958pqRlMtTJnm
         pTKFwzJ/ym70H5MYhlay6pRNjJTXWM4ig3qkjNJ2Zrbe6DGYapOtuUsMhhBQlX2KD2rS
         0Vxv7cu+L+jHj3A4Kz0R4B0jwjqodRS8HsGTcqzI3Pi3rqlrpWJjuRoqNj7jspsSwbst
         VbPjbIAK6tMPBkIayKy0vtAYrK7UpYwkMD3JDiV8bcP6+8VgISry4ugYoAET+FaARN3k
         PnX1T4M496UUG4658UTLXpii/S2QNswS/QSZnUKmQq0/DwwamKa4Yv9f1/p5usaZxwgA
         W6zA==
X-Gm-Message-State: AOAM532EHZpp7WX5C909PqRiBbjkWsRdsomFQJuS600igNPbS6gj3MtO
        y57uMHFfZlM0ECW1+Fx5p7/cPDYl0I0k3WR6iSM=
X-Google-Smtp-Source: ABdhPJyUHTMrGjquWxH7hg+MV7pXbbe530wn3kPO+knMHye85pECQSvXtnNvTgzhb89dzGHtmlqNCxv2gky9hdaLI0E=
X-Received: by 2002:a67:71c1:0:b0:31e:c4b5:b1ea with SMTP id
 m184-20020a6771c1000000b0031ec4b5b1eamr1668833vsc.54.1646888530733; Wed, 09
 Mar 2022 21:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20220310004433.5713-1-yusisamerican@gmail.com> <3179f015-58d9-6786-c2c4-6a54088c9221@infradead.org>
In-Reply-To: <3179f015-58d9-6786-c2c4-6a54088c9221@infradead.org>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Wed, 9 Mar 2022 21:01:59 -0800
Message-ID: <CAJoG2+9EN9uP0-S+vpfgiRzu_ZXx017vXEZMY7wcuZ+5BZoEYQ@mail.gmail.com>
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

Thanks for the feedback!

(2) Where would I place that documentation then,
documentation/devicetree/bindings/?

(4) A quick look at bootlin shows a symbol called
"modalias referenced 176 times.


On Wed, Mar 9, 2022 at 6:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 3/9/22 16:44, Yusuf Khan wrote:
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index 740811893c57..c7aa439d23e7 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -451,4 +451,13 @@ config RANDOM_TRUST_BOOTLOADER
> >       pool. Otherwise, say N here so it will be regarded as device inpu=
t that
> >       only mixes the entropy pool.
> >
> > +config DDCCI
> > +     tristate "DDCCI display protocol support"
> > +     help
> > +       Display Data Channel Command Interface is a
>
>                                                  is an
>
> Also, the line above ends with a space. Please check the entire patch
> for lines that end with SPACE and remove the trailing spaces.
>
> > +       interface that allows the kernel to "talk"
> > +       to most displays made after 2005. Check your
> > +       display's specification to see if it has
> > +       support for this.
> > +
> >  endmenu
>
> (2) ddcci appears to be a char driver, not a misc driver,
> so its documentation probably should not be in Documentation/misc-devices=
/.
>
> (3) The documentation file ends with:
>
> +options ddcci dyndbg
> +options ddcci-backlight dyndbg
> \ No newline at end of file
>
> so please add a newline at the end of the last line.
>
> (4) What is the modalias stuff about?
> Does the kernel have other drivers that play modalias games
> like this?
>
>
> (5) This standalone comment might need some more text.
> Doesn't make much sense by itself.
>
> +       /* Special case: sender to 0x6E is always 0x51 */
>
> Does that mean something like "reply to 0x6E is always 0x51" ?
>
>
> (6) Be a bit more generous with spaces around operators (kernel style).
> And be consistent.  This first line is OK, second line not so much.
>
> +       xor ^=3D ((p_flag << 7) | len);
> +       *(ptr++) =3D (p_flag << 7)|len;
>
> This line could also be improved with some spaces:
>
> +       ret =3D payload_len+3+((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)?1:0=
);
>
> (e.g. -- I expect that there are others.)
>
>
> (7) Too much use of likely() and unlikely().
>
> (8) I don't see anything in the Kconfig entries such as
>         depends on I2C
>
> so do these 2 drivers work without I2C being enabled in a kernel?
>
> Oh, if I build ddcci without CONFIG_I2C:
>
> ../drivers/char/ddcci.c: In function =E2=80=98__ddcci_write_bytewise=E2=
=80=99:
> ../drivers/char/ddcci.c:104:8: error: implicit declaration of function =
=E2=80=98i2c_smbus_write_byte=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
>   ret =3D i2c_smbus_write_byte(client, addr);
>         ^~~~~~~~~~~~~~~~~~~~
>   CC      kernel/delayacct.o
> ../drivers/char/ddcci.c: In function =E2=80=98__ddcci_write_block=E2=80=
=99:
> ../drivers/char/ddcci.c:165:9: error: implicit declaration of function =
=E2=80=98i2c_master_send=E2=80=99; did you mean =E2=80=98i2c_match_id=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
>   return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
>          ^~~~~~~~~~~~~~~
>          i2c_match_id
> ../drivers/char/ddcci.c: In function =E2=80=98__ddcci_read=E2=80=99:
> ../drivers/char/ddcci.c:216:8: error: implicit declaration of function =
=E2=80=98i2c_master_recv=E2=80=99; did you mean =E2=80=98i2c_match_id=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
>   ret =3D i2c_master_recv(client, buf, len);
>         ^~~~~~~~~~~~~~~
>         i2c_match_id
> ../drivers/char/ddcci.c: In function =E2=80=98ddcci_identify_device=E2=80=
=99:
> ../drivers/char/ddcci.c:413:10: error: implicit declaration of function =
=E2=80=98i2c_check_functionality=E2=80=99; did you mean =E2=80=98in_lock_fu=
nctions=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>        && i2c_check_functionality(client->adapter,
>           ^~~~~~~~~~~~~~~~~~~~~~~
>           in_lock_functions
> ../drivers/char/ddcci.c: In function =E2=80=98ddcci_module_init=E2=80=99:
> ../drivers/char/ddcci.c:1835:8: error: implicit declaration of function =
=E2=80=98i2c_add_driver=E2=80=99; did you mean =E2=80=98ddcci_add_driver=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
>   ret =3D i2c_add_driver(&ddcci_driver);
>         ^~~~~~~~~~~~~~
>         ddcci_add_driver
> ../drivers/char/ddcci.c: In function =E2=80=98ddcci_module_exit=E2=80=99:
> ../drivers/char/ddcci.c:1868:2: error: implicit declaration of function =
=E2=80=98i2c_del_driver=E2=80=99; did you mean =E2=80=98ddcci_del_driver=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
>   i2c_del_driver(&ddcci_driver);
>   ^~~~~~~~~~~~~~
>   ddcci_del_driver
>
>
>
> --
> ~Randy
