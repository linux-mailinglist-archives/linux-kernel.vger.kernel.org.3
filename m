Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13EF479AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhLRMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhLRMFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:05:17 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622ECC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:05:17 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v64so13961176ybi.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+Y2CW3FU7Np6BiQVUMozXDENdMi4If2dH0S2b0JuT48=;
        b=TRhdVPbcE1v4Uet2kvDbG9a1cqrIpk8rj+AFFeJaDX+Vy/u90pDr3trkiYrTHFhtQt
         1aZuONonNTbphj6Oob0psqF3NFkfHLZ8ib5utsg2Tp4jPIMUYMwSG2I5QlmnIkkRYpE/
         MWYIK6GWYRrJTYS3vqq24ars29b59PGArWuHsR76YcrR8hGXZH10/9c1G7Wk3mSRgPWC
         Pue9loB7TvyZVSmtGfgeWVYc2s9BE05dWGRBuYptwLzJfCOXe+H0SdmY5B1eqTx7A27S
         qDu1gbUC3ODlGu3Sm8tdgj9ihY+i8H2e3smTzycHfdQ/8EDiHekY6NlPxYeSzCe7edBE
         dosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+Y2CW3FU7Np6BiQVUMozXDENdMi4If2dH0S2b0JuT48=;
        b=qPZQGodxV9y6Vs3v4K0hYIhV7RGElGSOCl6T9Te2HNgA1yC/VZynrviuDXxKpI3ET2
         phdjg8nHHEyZgMJTSQ1UJnQ3SEu66NUL8vb0IiSi6/n/mc3jhylHL3ANCkgEbb+ZHts1
         hCaBNEZGpLB/J3OUVX4mUzfoysUsl12BGA4f5ZDHJsNPr5HH3anlYDBG9fGZwbjx9dKd
         HuccHwcqwaveUWIPA7+fHxMGiwkBaxsnY7Nu8gakQHC9H7lb0nTHhr2uEo/bO3JGmjhX
         PImt450WqffFeMhOf4tzFqqjT22BpAc9cIDQ4RadPRAyAIl7WnYBCYdyzvPCw03GTIYn
         C99Q==
X-Gm-Message-State: AOAM533axS37BZPSQtujnulK5T0wWj37khfhf63J8mK1DhQKjrz77uks
        vPwyF5VK2ol8k4l6zJMiHRbMdaR+mRR42sFq3ZY=
X-Google-Smtp-Source: ABdhPJxsXSKcE3PkdTpEk3KNtcMpHh1DCRJSx34wVHSf7RM5WP+0IK/ChcJEJQV2PdjEXs3avaDUPNQ82G4HtLPULcQ=
X-Received: by 2002:a25:2c97:: with SMTP id s145mr9988262ybs.408.1639829116510;
 Sat, 18 Dec 2021 04:05:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:8caa:0:0:0:0 with HTTP; Sat, 18 Dec 2021 04:05:16
 -0800 (PST)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <john69345@gmail.com>
Date:   Sat, 18 Dec 2021 12:05:16 +0000
Message-ID: <CAFEch-B8EEnLFHp322buRpRNexjCghkwJWTM97u4LyXTUVAfpw@mail.gmail.com>
Subject: =?UTF-8?B?0KLRiyDQvNC+0LbQtdGI0Ywg0LzQvdC1INC/0L7QvNC+0YfRjD8=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber geliebter,

Bitte lesen Sie dies langsam und sorgf=C3=A4ltig durch, da es sich
m=C3=B6glicherweise um eine der wichtigsten E-Mails handelt, die Sie jemals
erhalten. Ich bin Mrs. Cristina Campbell, ich war mit dem verstorbenen
Edward Campbell verheiratet. Er arbeitete fr=C3=BCher f=C3=BCr die Shell
Petroleum Development Company London und war auch ein erfahrener
Bauunternehmer in der Region Ostasien. Er starb am Montag, 31. Juli
2003 in Paris. Wir waren sieben Jahre ohne Kind verheiratet.

W=C3=A4hrend Sie dies lesen, m=C3=B6chte ich nicht, dass Sie Mitleid mit mi=
r
haben, denn ich glaube, dass jeder eines Tages sterben wird. Bei mir
wurde Speiser=C3=B6hrenkrebs diagnostiziert und mein Arzt sagte mir, dass
ich aufgrund meiner komplizierten Gesundheitsprobleme nicht lange
durchhalten w=C3=BCrde.

Ich m=C3=B6chte, dass Gott mir gegen=C3=BCber barmherzig ist und meine Seel=
e
annimmt, deshalb habe ich beschlossen, Almosen an
Wohlt=C3=A4tigkeitsorganisationen / Kirchen / buddhistische Tempel /
Moscheen / mutterlose Babys / weniger Privilegierte und Witwen zu
geben, da ich m=C3=B6chte, dass dies eine der letzten guten Taten ist Ich
tue es auf der Erde, bevor ich sterbe. Bisher habe ich Geld an einige
Wohlt=C3=A4tigkeitsorganisationen in Schottland, Wales, Panama, Finnland
und Griechenland verteilt. Jetzt, wo sich mein Gesundheitszustand so
stark verschlechtert hat, kann ich das nicht mehr selbst machen.

Ich habe einmal Mitglieder meiner Familie gebeten, eines meiner Konten
zu schlie=C3=9Fen und das Geld, das ich dort habe, an
Wohlt=C3=A4tigkeitsorganisationen in =C3=96sterreich, Luxemburg, Deutschlan=
d,
Italien und der Schweiz zu verteilen, sie weigerten sich und behielten
das Geld f=C3=BCr sich. Daher vertraue ich nicht sie nicht mehr, da sie
anscheinend nicht mit dem zufrieden sind, was ich ihnen hinterlassen
habe. Das letzte von meinem Geld, von dem niemand wei=C3=9F, ist die
riesige Bareinzahlung von sechs Millionen US-Dollar $ 6.000.000,00,
die ich bei einer Bank in Thailand habe, bei der ich den Fonds
hinterlegt habe. Ich m=C3=B6chte, dass Sie diesen Fonds f=C3=BCr
Wohlt=C3=A4tigkeitsprogramme verwenden und die Menschheit in Ihrem Land
unterst=C3=BCtzen, wenn Sie nur aufrichtig sind.

Ich habe diese Entscheidung getroffen, weil ich kein Kind habe, das
dieses Geld erben wird. Ich habe keine Angst vor dem Tod, daher wei=C3=9F
ich, wohin ich gehe. Ich wei=C3=9F, dass ich im Scho=C3=9F des Herrn sein w=
erde.
Sobald ich Ihre Antwort erhalten habe, werde ich Ihnen den Kontakt der
Bank mitteilen und Ihnen eine Vollmacht ausstellen, die Sie als
urspr=C3=BCnglichen Beg=C3=BCnstigten dieses Fonds erm=C3=A4chtigt, dieses
Wohlt=C3=A4tigkeitsprogramm sofort in Ihrem Land zu beginnen.

Nur ein Leben, das f=C3=BCr andere gelebt wird, ist ein lebenswertes Leben.
Ich m=C3=B6chte, dass Sie immer f=C3=BCr mich beten. Jede Verz=C3=B6gerung =
Ihrer
Antwort wird mir Raum geben, eine andere Person zu diesem Zweck zu
finden. Wenn Sie kein Interesse haben, bitte ich um Entschuldigung f=C3=BCr
die Kontaktaufnahme. Du kannst mich mit meiner privaten E-Mail
erreichen oder mir antworten: (cristinacampeell@outlook.com).

Danke,
Dein,
Frau Cristina Campbell
Email; cristinacampeell@outlook.com
