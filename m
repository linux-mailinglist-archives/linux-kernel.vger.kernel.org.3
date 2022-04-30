Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C8515ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359568AbiD3GaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbiD3GaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:30:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9D167D3;
        Fri, 29 Apr 2022 23:26:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so8989166pjm.1;
        Fri, 29 Apr 2022 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=65gbH99Ie2ps8ltGauBlx8zj/8q89alb6NfyqqfPWs0=;
        b=PLle8i7v1ah8swjXYmP8S90WynzBnfpKzN6Cz6PEgvaAaFi0u5PyWS1pYSLuChxQTG
         OdPiYb/2/eXtwND7ZVF9GailXR9mbiEOUJMOKdNWh1nhbGwDc2mJRngV/RP6uR8bzhEa
         46SkWsnAzExxg3q8yAdxejtwMSExZZFG+1BMzyoBZcfxGCYQQeOGlDOL0/8BJMxwXuiZ
         kYWR9z63cTGxMdo0kKoyev3LCmUm5qHtQEqmxiCkTfAkYWCb8Lf+0yFrny9qFRGAlKV3
         e7buWDjhimSq7ueLbuxeZYC5jrvPro3TJyrX8sLvDWbywXjECsFVyN5QQis7Veh1uvCz
         epPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=65gbH99Ie2ps8ltGauBlx8zj/8q89alb6NfyqqfPWs0=;
        b=MaUC5mTFO2tdTuh9e7RU4nvucUmHPBu5tNAgcPcbLRwIRgaQ+PGv9TkJxZ2crJZ4n7
         /4+aAfpUwnW24yorefk6exy4uDiyUR7mF7b5215mRhL34TO8OgGiYpoW4ahyY6tjlQ/S
         Ce72yIPmcAgrBLAtaGb+kCJk3QMJQ0rZjoWcokZtsiqeTek6YJGVDU71+ZGIpqsUlj3V
         m6sMOjipmjnvq/aXBvWIUzC+cTWyVdA5k0AjyJTsd4xfb87U8+ZRKI8Kydj4LeVyOYrO
         85TyoiGtyaUSbc7hUFthAddBoy1nbxnpnNy/vLeHZnK4m2N/SBVwfEYkQZsdxgD8gH7E
         G1YQ==
X-Gm-Message-State: AOAM533hdNJRN9CjT+n1tKOfkAo7/ab4YO5fAdCILnMSnUqDvMR+IXjU
        /njoI246zZyc7EFyoLE4q68=
X-Google-Smtp-Source: ABdhPJwbKzUBYecx9iUN8S9t4j0DIEa0/LbYLEsUEp+pk2rJMNujd+Dr+AjV1dcvPIGtQAMHmcBYYg==
X-Received: by 2002:a17:903:208:b0:15c:7dd0:eb64 with SMTP id r8-20020a170903020800b0015c7dd0eb64mr2798843plh.40.1651300005702;
        Fri, 29 Apr 2022 23:26:45 -0700 (PDT)
Received: from smtpclient.apple (121.142.5.103.wi-fi.wi2.ne.jp. [103.5.142.121])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b0015e8d4eb2bcsm644169plc.262.2022.04.29.23.26.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 23:26:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4] docs/trans/ja_JP/howto: Don't mention specific kernel
 versions
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
In-Reply-To: <475af784-ae64-1a8c-6e81-cf64cf3079b8@gmail.com>
Date:   Sat, 30 Apr 2022 15:26:41 +0900
Cc:     Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7E94B97-84F6-4BDB-B5C3-33AADE91D877@gmail.com>
References: <20220429230001.6124-1-fujimotokosuke0@gmail.com>
 <CAO+cJp0T-OrC1x+pTezPqWdkOKcSXutLF6yb=YO7TCVMh7BxwQ@mail.gmail.com>
 <475af784-ae64-1a8c-6e81-cf64cf3079b8@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 30, 2022, at 15:01, Akira Yokosawa <akiyks@gmail.com> wrote:
>=20
> On Sat, 30 Apr 2022 14:44:33 +0900,
> Tsugikazu Shibata wrote:
>> Hello Fujimoto-san,
>>=20
>> Thanks for the patch.
>> Unfortunately, I found one more issue..
>>=20
>> On Sat, Apr 30, 2022 at 8:00 AM Kosuke Fujimoto
>> <fujimotokosuke0@gmail.com> wrote:
>>>=20
>>> This change is based on commit d2b008f134b7
>>> ("Documentation/process/howto: Update for 4.x -> 5.x versioning").
>>>=20
>>> Replace "4.x kernel version" with generic term such as "mainline =
tree"
>>>=20
>>> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
>>> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>>> ---
>>> V2: Reformatted commit log messagae (Yokosawa-san)
>>> V3: Updated some expressions (Shibata-san)
>>> - added "version number" in mainline tree section
>>> - updated from "stable kernel" to "stable tree"
>>> V4: Added reviewed by tag and removed extra characters =
(Yokosawa-san)
>>> ---
>>> Documentation/translations/ja_JP/howto.rst | 44 =
+++++++++++-----------
>>> 1 file changed, 21 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/Documentation/translations/ja_JP/howto.rst =
b/Documentation/translations/ja_JP/howto.rst
>>> index d667f9d8a02a..deac41eb038a 100644
>>> --- a/Documentation/translations/ja_JP/howto.rst
>>> +++ b/Documentation/translations/ja_JP/howto.rst
> [...]
>>>=20
>>> -=E3=81=93=E3=81=AE=E3=82=84=E3=82=8A=E6=96=B9=E3=81=AB=E3=82=88=E3=81=
=A3=E3=81=A6=E3=80=81-next =
=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AF=E6=AC=A1=E3=81=AE=E3=83=9E=E3=
=83=BC=E3=82=B8=E6=A9=9F=E4=BC=9A=E3=81=A7=E3=81=A9=E3=82=93=E3=81=AA=E3=82=
=82=E3=81=AE=E3=81=8C=E3=83=A1=E3=82=A4=E3=83=B3
>>> =
-=E3=83=A9=E3=82=A4=E3=83=B3=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AB=E3=
=83=9E=E3=83=BC=E3=82=B8=E3=81=95=E3=82=8C=E3=82=8B=E3=81=8B=E3=80=81=E3=81=
=8A=E3=81=8A=E3=81=BE=E3=81=8B=E3=81=AA=E3=81=AE=E5=B1=95=E6=9C=9B=E3=82=92=
=E6=8F=90=E4=BE=9B=E3=81=97=E3=81=BE=E3=81=99=E3=80=82-next =E3=82=AB=E3=83=
=BC
>>> =
-=E3=83=8D=E3=83=AB=E3=81=AE=E5=AE=9F=E8=A1=8C=E3=83=86=E3=82=B9=E3=83=88=E3=
=82=92=E8=A1=8C=E3=81=86=E5=86=92=E9=99=BA=E5=A5=BD=E3=81=8D=E3=81=AA=E3=83=
=86=E3=82=B9=E3=82=BF=E3=83=BC=E3=81=AF=E5=A4=A7=E3=81=84=E3=81=AB=E6=AD=93=
=E8=BF=8E=E3=81=95=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82
>>> +=E3=81=93=E3=81=AE=E3=82=84=E3=82=8A=E6=96=B9=E3=81=AB=E3=82=88=E3=81=
=A3=E3=81=A6=E3=80=81linux-next =
=E3=81=AF=E6=AC=A1=E3=81=AE=E3=83=9E=E3=83=BC=E3=82=B8=E6=A9=9F=E4=BC=9A=E3=
=81=A7=E3=81=A9=E3=82=93=E3=81=AA=E3=82=82=E3=81=AE=E3=81=8C=E3=83=A1=E3=82=
=A4=E3=83=B3
>>> =
+=E3=83=A9=E3=82=A4=E3=83=B3=E3=81=AB=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=95=E3=
=82=8C=E3=82=8B=E3=81=8B=E3=80=81=E3=81=8A=E3=81=8A=E3=81=BE=E3=81=8B=E3=81=
=AA=E3=81=AE=E5=B1=95=E6=9C=9B=E3=82=92=E6=8F=90=E4=BE=9B=E3=81=97=E3=81=BE=
=E3=81=99=E3=80=82
>>=20
>> This would be:
>> =
=E3=83=A9=E3=82=A4=E3=83=B3=E3=81=AB=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=95=E3=
=82=8C=E3=82=8B=E3=81=8B=E3=80=81=E3=81=8A=E3=81=8A=E3=81=BE=E3=81=8B=E3=81=
=AA=E5=B1=95=E6=9C=9B=E3=82=92=E6=8F=90=E4=BE=9B=E3=81=97=E3=81=BE=E3=81=99=
=E3=80=82
>=20
> Good eyes!
> I'm beginning to think I can't be a good reviewer...  :-/
>=20
> Fujimoto-san, please keep my Reviewed-by: tag in v5.
> As Shibata-san might catch something else, v5 can wait for a day
> or so, I guess.
>=20
>        Thanks, Akira
>=20

Hi Shibata-san,=20

Thank you for pointing that out.=20
I will fix it and submit tomorrow as Yokosawa-san suggested.

Thanks,
Kosuke

>>=20
>> Thank you for fixing this document.
>>=20
>> Tsugikazu Shibata

