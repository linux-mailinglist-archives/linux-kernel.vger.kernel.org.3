Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235FF49B7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357737AbiAYPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353958AbiAYPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:32:41 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB9EC06175C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:21:05 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s18so7543084ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IEMma1eGW5sQblzU1//BqOEn5E488+F+nzzq2q8j3TU=;
        b=abojG9rrff4AUDetCmIU3yS+RjItV5kdFTGth9T7CxUW/DKDovnyfeWCSHqWB5T6zw
         jm1gKxNkVQGaR+CknejNYsnQwMEgkEn+yOvLNyJ3i/TBI8G20Ayz1OIMJ9voT9uFyhbv
         6sKJociTD2px6UMyXib+DBxCswWNEnhAksMQs0yaFgOaL0zlG/hs2TL++mkBxPRpnQq3
         vHQsVS/fMownCYwzvKKeFsln1wcuFblZN3pK54Kci4TfaMRcmygvSLH0SvAsi1gRmAZU
         WkJt0isC9AvdUAvTWPjuhsS6p5jfd+Lwn0l6dDm7ETQ36SQ/+9kI6yoTWN7s7yqLsM03
         R2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IEMma1eGW5sQblzU1//BqOEn5E488+F+nzzq2q8j3TU=;
        b=RbppBKZOmMp0uQR/9ILmDDpyaeGZqgIKuAXZY+hjLepB+mwS4fDCT9WXV8gUyQhEpp
         A95+oWIMWkbl4xnOTBsRGKd86XvifoulF/5DDFbiRV8NIUdVb7MSTNCqINRm7/J330bR
         VxBXRJL5B2H95Kas3rSnI5K/MoUTot6/HG1N8zUxASQfj/ec2ZvzQh+Xv7/HoHwgaIml
         vBJ1BDk1kDJf7yL1vWxbqPg07p1O8usJjS8cwCl7BZyINULBgCJyqgBI3w0S/E/76tSU
         4Iyg8lDCz0fdHusTBtiHaAGy/mWheyOrKz+2o9s9rdd2HWpD37fmVBT6/LOxKPlf8qJq
         gJsw==
X-Gm-Message-State: AOAM532W/GA8ikmSyYrV7kmmGusG8r5yBDxzFXi1ss1rtXWAHM7vw4wR
        /PPBH8EmypduMihI77KxmGE5FQamr7EfHrrw5Xk=
X-Google-Smtp-Source: ABdhPJyCwDkRDA+sEA/6p0ug8T+3Z5c9Cl4N0LwqVJmgWWWkEUlPKB2oPr9mG7F3P8TOCRYUa/WtzMsGB4tJ/oi+ppY=
X-Received: by 2002:a05:6602:14c9:: with SMTP id b9mr10861726iow.3.1643124064707;
 Tue, 25 Jan 2022 07:21:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1566:0:0:0:0 with HTTP; Tue, 25 Jan 2022 07:21:04
 -0800 (PST)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <awochambers004@gmail.com>
Date:   Tue, 25 Jan 2022 07:21:04 -0800
Message-ID: <CAH2diS5-Bfhs+cv2y_VOUTGtUY87-_tHBd1aMwFiTHgakv+FDw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prosz=C4=99 o uwag=C4=99,

Jak si=C4=99 masz? Mam nadziej=C4=99, =C5=BCe jeste=C5=9B zdrowy i zdrowy? =
Informuj=C4=99, =C5=BCe
uda=C5=82o mi si=C4=99 zako=C5=84czy=C4=87 transakcj=C4=99 z pomoc=C4=85 no=
wego partnera z Indii i
teraz =C5=9Brodki zosta=C5=82y przelane do Indii na konto bankowe nowego
partnera.

W mi=C4=99dzyczasie zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 ci sum=
=C4=99 500 000 $
(tylko pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w ameryka=C5=84skich) z po=
wodu twoich
wcze=C5=9Bniejszych wysi=C5=82k=C3=B3w, chocia=C5=BC mnie rozczarowa=C5=82e=
=C5=9B. Niemniej jednak
bardzo si=C4=99 ciesz=C4=99 z pomy=C5=9Blnego zako=C5=84czenia transakcji b=
ez =C5=BCadnego
problemu i dlatego postanowi=C5=82em zrekompensowa=C4=87 Ci kwot=C4=99 500 =
000 $,
aby=C5=9B podzieli=C5=82 si=C4=99 ze mn=C4=85 rado=C5=9Bci=C4=85.

Radz=C4=99 skontaktowa=C4=87 si=C4=99 z moj=C4=85 sekretark=C4=85 w sprawie=
 karty bankomatowej
o warto=C5=9Bci 500 000 $, kt=C3=B3r=C4=85 zachowa=C5=82em dla Ciebie. Skon=
taktuj si=C4=99 z
ni=C4=85 teraz bez zw=C5=82oki.

Imi=C4=99: Linda Koffi
E-mail: koffilinda785@gmail.com


Uprzejmie potwierd=C5=BA jej nast=C4=99puj=C4=85ce informacje:

Twoje pe=C5=82ne imi=C4=99:........
Tw=C3=B3j adres:..........
Tw=C3=B3j kraj:..........
Tw=C3=B3j wiek:.........
Tw=C3=B3j zaw=C3=B3d:..........
Tw=C3=B3j numer telefonu kom=C3=B3rkowego:..........
Tw=C3=B3j paszport lub prawo jazdy:........

Pami=C4=99taj, =C5=BCe je=C5=9Bli nie prze=C5=9Blesz jej powy=C5=BCszych in=
formacji
kompletnych, nie wyda ci karty bankomatowej, poniewa=C5=BC musi si=C4=99
upewni=C4=87, =C5=BCe to ty. Popro=C5=9B j=C4=85, aby przes=C5=82a=C5=82a C=
i ca=C5=82kowit=C4=85 sum=C4=99 (500 000
USD) karty bankomatowej, kt=C3=B3r=C4=85 dla Ciebie zachowa=C5=82em.

Z wyrazami szacunku,

Pan Abraham Morrison
