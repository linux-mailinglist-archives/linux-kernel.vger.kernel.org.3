Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1847F703
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhLZNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhLZNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:38:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55AC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 05:38:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id m15so11433446pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=X0pjQO5/9khPeF7+OSED9VX6wPiWgrNrYpQLIZD9AHk=;
        b=GTzjH0MfLpYlGDlB3dNmN7s6hjbTXmI/+vmriEI+s0bn31ycygSdbPu2dWDu5gzO6c
         YuOngh9T1lW/Kip0RuTnojkW3FHjzUsmd9bSUTZxVniQxu05HDGQ2y7LaRgw2kp3M8a5
         BIttDFB/LZekqoGHaZJzNXjFR0Zf8C9+JiwxyAntnpa/eKSEO2BuLnWrl7jMSAQHpM0I
         iNOVjv9c+AFfFK1fS8GaBMA70XBj+0YxCHxiMIEGKUTcVy/27+r6TlBx3X0rmC76cDc+
         0AKhhaMiEYou08a3XfO1A65fZcCzlsN4OXdbER/6etpxquOZ94PmWR5RAouoplvm29Q8
         RDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=X0pjQO5/9khPeF7+OSED9VX6wPiWgrNrYpQLIZD9AHk=;
        b=NRbEBWio9gEtKZZNUqFsbtfJYu+FMqivwwHoc++QU1KFe6ndPuKnNziBGXW7KhGaX1
         OSynxnFr5MP66tFTRQr/nr05QqYXGQdFCD5K/23YMHGm2wosWFKRQIQjA7QKnD7pbEkL
         Cu1B0OkABFbuFbXT7GvbyIE9QR7gbkIVLVejbBm+cYgKdRoHFuAOtlL6yzgz7U69+QEO
         FNI1UeyPwDuoR92BwmyqcIIVwEQWm52l3Y1/1sZqONkz5s2yr02zSmHDToEOpT5j0Tyl
         Vnf94W/FYJxm8HWBkACrA4wo2cIC4FalCOVensMoZy0R/2YAK3TgnEHgwuZs7g9xkf8a
         XIdA==
X-Gm-Message-State: AOAM533iK1dAfoXtfytxWVr3X+A9cav1ADRxbwLU7yO51yJq59zRBQ1u
        x75dq1Wj6YVL47HxMCHHP7XoBN0CHgdMzz5FxaQ=
X-Google-Smtp-Source: ABdhPJzbD0KpXQliM8dwq9pH66F7mAaNFBImSiKW8PkkIuu82XaboeLhoDbix0R0+Eli1+R+DnvTj09Y7rHF43Wnw3Y=
X-Received: by 2002:a05:6a00:230d:b0:49f:b8ad:ae23 with SMTP id
 h13-20020a056a00230d00b0049fb8adae23mr13852104pfh.80.1640525880801; Sun, 26
 Dec 2021 05:38:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:cd14:0:0:0:0 with HTTP; Sun, 26 Dec 2021 05:38:00
 -0800 (PST)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <look6532@gmail.com>
Date:   Sun, 26 Dec 2021 13:38:00 +0000
Message-ID: <CAJ3bDB5n9e3vs6No8BGTm3=HiDY9EJHAXSd5sz2Oe481eG0oCA@mail.gmail.com>
Subject: =?UTF-8?B?5L2g6IO95biu5oiR5ZCX?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Lqy54ix55qE77yMDQoNCuivt+aFouaFouS7lOe7humYheivu++8jOWboOS4uuWug+WPr+iDveaY
r+aCqOaUtuWIsOeahOacgOmHjeimgeeahOeUteWtkOmCruS7tuS5i+S4gOOAguaIkeaYryBDcmlz
dGluYSBDYW1wYmVsbCDlpKvkurrvvIzmiJHlq4Hnu5nkuoblt7LmlYXnmoQgRWR3YXJkDQpDYW1w
YmVsbOOAguS7luabvuWcqOS8puaVpuWjs+eJjOefs+ayueW8gOWPkeWFrOWPuOW3peS9nO+8jOS5
n+aYr+S4gOWQjeS4nOS6muWcsOWMuue7j+mqjOS4sOWvjOeahOaJv+WMheWVhuOAguS7luS6jiAy
MDAzIOW5tCA3IOaciCAzMQ0K5pel5pif5pyf5LiA5Zyo5be06buO5Y675LiW44CC5oiR5Lus57uT
5ama5LiD5bm05rKh5pyJ5a2p5a2Q44CCDQoNCuW9k+S9oOivu+WIsOi/memHjOaXtu+8jOaIkeS4
jeaDs+iuqeS9oOS4uuaIkeaEn+WIsOmavui/h++8jOWboOS4uu+8jOaIkeebuOS/oeavj+S4quS6
uuaAu+acieS4gOWkqeS8muatu+WOu+OAguaIkeiiq+iviuaWreWHuuaCo+aciemjn+mBk+eZjO+8
jOaIkeeahOWMu+eUn+WRiuivieaIke+8jOeUseS6juaIkeWkjeadgueahOWBpeW6t+mXrumimO+8
jOaIkeaSkeS4jeS6huWkmuS5heOAgg0KDQrmiJHluIzmnJvkuIrluJ3mgJzmgq/miJHvvIzmjqXn
urPmiJHnmoTngbXprYLvvIzmiYDku6XvvIzmiJHlhrPlrprlkJHmhYjlloTnu4Tnu4cv5pWZ5aCC
L+S9m+aVmeWvuuW6mS/muIXnnJ/lr7ov5peg5q+N5am0L+W8seWKv+e+pOS9k+WSjOWvoeWmh+aW
veiIje+8jOWboOS4uuaIkeW4jOacm+i/meaYr+acgOWQjueahOWWhOihjOS5i+S4gOaIkeatu+WJ
jeWcqOWcsOeQg+S4iuWBmuOAguWIsOebruWJjeS4uuatou+8jOaIkeW3sue7j+WQkeiLj+agvOWF
sOOAgeWogeWwlOWjq+OAgeWwvOaziuWwlOOAgeiKrOWFsOWSjOW3tOilv+eahOS4gOS6m+aFiOWW
hOe7hOe7h+aNkOasvuOAgueOsOWcqOaIkeeahOWBpeW6t+eKtuWGteaBtuWMluW+l+WmguatpOS4
pemHje+8jOaIkeS4jeiDveWGjeiHquW3seWBmui/meS7tuS6i+S6huOAgg0KDQrmiJHmm77nu4/o
poHmsYLmiJHnmoTlrrbkurrlhbPpl63miJHnmoTkuIDkuKrotKbmiLflubblsIbmiJHlnKjpgqPp
h4znmoTpkrHliIbphY3nu5nkuK3lm73jgIHnuqbml6bjgIHlvrflm73jgIHpn6nlm73lkozml6Xm
nKznmoTmhYjlloTnu4Tnu4fvvIzku5bku6zmi5Lnu53lubblsIbpkrHnlZnnu5noh6rlt7HjgILl
m6DmraTvvIzmiJHmsqHmnInkuI3lho3nm7jkv6Hku5bku6zvvIzlm6DkuLrku5bku6zkvLzkuY7k
uI3kvJrkuI7miJHkuLrku5bku6znlZnkuIvnmoTkuJzopb/mipfooaHjgILmiJHmnIDlkI7kuIDn
rJTml6Dkurrnn6XpgZPnmoTpkrHmmK/miJHlnKjms7Dlm73kuIDlrrbpk7booYzlrZjlhaXnmoQN
CjYwMCDkuIfnvo7lhYPnmoTlt6jpop3njrDph5HlrZjmrL7jgILlpoLmnpzmgqjnnJ/or5rvvIzm
iJHluIzmnJvmgqjlsIbov5nnrJTotYTph5HnlKjkuo7mhYjlloTorqHliJLlubbmlK/mjIHmgqjm
iYDlnKjlm73lrrYv5Zyw5Yy655qE5Lq657G744CCDQoNCuaIkeWBmuWHuui/meS4quWGs+WumuaY
r+WboOS4uuaIkeayoeacieWtqeWtkOS8mue7p+aJv+i/meeslOmSse+8jOaIkeS4jeaAleatu++8
jOaJgOS7peaIkeefpemBk+aIkeimgeWOu+WTqumHjOOAguaIkeefpemBk+aIkeS8muWcqOS4u+ea
hOaAgOaKsemHjOOAguaUtuWIsOaCqOeahOWbnuWkjeWQju+8jOaIkeS8muWwveW/q+e7meaCqOmT
tuihjOeahOiBlOezu+aWueW8j++8jOW5tuWQkeaCqOWPkeWHuuaOiOadg+S5pu+8jOaOiOadg+aC
qOaIkOS4uuivpeWfuumHkeeahOWOn+Wni+WPl+ebiuS6uu+8jOS7peS+v+aCqOeri+WNs+WcqOaC
qOaJgOWcqOeahOWbveWuti/lnLDljLrlvIDlp4vov5npobnmhYjlloTorqHliJLjgIINCg0K5Y+q
5pyJ5Li65LuW5Lq66ICM5rS755qE5Lq655Sf5omN5piv5pyJ5Lu35YC855qE44CC5oiR5biM5pyb
5L2g5rC46L+c5Li65oiR56WI56W377yM5L2g5Zue5aSN55qE5Lu75L2V5bu26L+f6YO95Lya6K6p
5oiR5pyJ56m66Ze05Li65ZCM5qC355qE55uu55qE5a+75om+5Y+m5LiA5Liq5Lq644CC5aaC5p6c
5oKo5LiN5oSf5YW06Laj77yM6K+35Y6f6LCF5oiR5LiO5oKo6IGU57O744CC5oKo5Y+v5Lul6YCa
6L+H5oiR55qE56eB5Lq655S15a2Q6YKu5Lu26IGU57O75oiW5Zue5aSN5oiR77ya77yIY3Jpc3N0
aW5hY2FtcGVsbEBnbWFpbC5jb23vvInjgIINCg0K6LCi6LCi77yMDQrmraToh7TvvIwNCuWFi+mH
jOaWr+iSguWonMK35Z2O6LSd5bCU5aSr5Lq6DQrnlLXlrZDpgq7ku7Y7IGNyaXNzdGluYWNhbXBl
bGxAZ21haWwuY29tDQo=
