Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0753EAFB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbiFFOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbiFFOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:32:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5E19F8A;
        Mon,  6 Jun 2022 07:32:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m20so29283807ejj.10;
        Mon, 06 Jun 2022 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LIT3NTOsC7NowXp4Z1Nxh6Sac8z4PgQBaEerVN5FpP8=;
        b=almcHK6LQ2DyRgGvCWV8q7K7XfxP4/2NblraJHlMYjlTl92TI02I9+HCNGP7EEPM88
         GX73xqp8vvf+b3pqB8IDQQTvEWRah+58XPnuFp2Nyooq5sHCUM2uzjgtEkFPzJTfqxN8
         7ywRCM37wEIg8lah6XSyVoIr6Q9nOJ3WIhDGqyHeGAIkswf/iktkC40m7rhDPL7cSeI2
         P5xry8p1VUqb2riidZUbHGqYAIg2wgnVdHkKFG1NLYXUum/LkZU9b877p9yiO3GNOio7
         OhUNPHgKFRuKWBGrEMSj92+1SiMVNDfwvIbwUkPDiY+Vohd5H0C0hm1svSG4urhiMGGj
         FJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LIT3NTOsC7NowXp4Z1Nxh6Sac8z4PgQBaEerVN5FpP8=;
        b=yCwf8Pl1rlLHFWYSFbArdnETIM8LQaow1Pg6cBtvwlax1dhYu0G0L14wNDrzvFuqhJ
         gfWcqdsmERHlN9LvI8On1foNMeQKOgHOSyJcFKqDLO63OD2mbwZ6WcZ+TTY5BrLjwZOq
         YjgLO02CnF0bDP0eUPvKVqkyJ7rrwgiVbuRRtTB5vQ6Qm0kncJySMhpH4aamSqfEtFmJ
         mG+3tRlGNdNyJk7uNXNxbbpqlg7saONf7EgfHwSys0KzhuXjq4oDX2DlW1AkUCMkKiGD
         B8ZyaTSbUVeX1KCKeRJ6AU4DR4n0ZMEgQCqYrP22WCoy7i17AwB4vGvimdzq7746INKJ
         f55g==
X-Gm-Message-State: AOAM533ft4JftjmFiZPGu/sD7dru1I89aoyxMTohCfYeOvft0TGoBOoB
        bATzfwvavgICaIwINWvHoksIQZuXqsozhuFDkCc=
X-Google-Smtp-Source: ABdhPJy6UQPbd2ONT3dQRyiW5E4Yq2lQTA1whZjW8/aroaW09EW7+O9WEkxv0LWx4JEWD5Ja2ZFia5j7aDz12l3YNco=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr10522126ejb.77.1654525941064; Mon, 06
 Jun 2022 07:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <d8e9f4fe-e8dc-67aa-e240-f2f5f1dfca2f@molgen.mpg.de>
 <1880b7a7-2353-c381-5afb-1d4224eb223b@molgen.mpg.de> <YpsgHpRfz0JQcm9D@kroah.com>
 <477007d7-e573-56dd-90de-877eeebd5c4c@molgen.mpg.de>
In-Reply-To: <477007d7-e573-56dd-90de-877eeebd5c4c@molgen.mpg.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 16:31:44 +0200
Message-ID: <CAHp75Vc01Ei5wEKG6kqELD=O3CSz8xs3jd8KJpxnfYJ=+f_nXA@mail.gmail.com>
Subject: Re: Non-working serial console
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 5:44 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Am 04.06.22 um 11:04 schrieb Greg KH:

...

> I am still confused, that `earlyprintk=3DttyS0,115200,keep` works though
> despite `CONFIG_SERIAL_8250=3Dm`. Doesn=E2=80=99t that mean, that Linux
> nevertheless contains some code to initialize the serial console, and
> send data to it?

If you keep x86 in mind, then yes, three different console code
handling (decompressing stage, boot stage, driver stage) + earlyprintk
(on top of the same code for decompressing / booting stages) +
earlycon (this is actually a driver:ish stage).

--=20
With Best Regards,
Andy Shevchenko
