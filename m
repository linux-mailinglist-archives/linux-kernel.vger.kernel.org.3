Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609B6486727
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiAFPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbiAFPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:55:20 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A822DC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:55:19 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so3485056oti.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tw8dbN6LTxQWfiKFnX9KbeZopZ4r1xaWZ10BszxRW60=;
        b=mTG4nG2/jDeNIY4TsL+foyrjjhHZihe/vURCOjfAXjQTXaf3nZc0KjjukNJokHAapS
         T+pYrCGTGhPW52gU326/f6NE0G1cGsG07HfXtLnn4jtftVm4rtb8SXXHAr3ivi58Wtzl
         uucig6PYL7Zjb4wa8RD6YOKCP7Dlg0qIQlZZnQDhBoXcJjotftNO9Y8DijgsyTGAnioT
         +cs6UJLdUyeY6zg1r2uFqy+AwzZP3Tqgt8477d6OwKoLIzam7vVXsO0sus2I/K5eSd0C
         gUn75t4TF7XqzhWm0ZQOHSe5JKuLhKgDlB1vMRWoSyPIf6eFrOV7K9emwpV2z2Ogw3YH
         e3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Tw8dbN6LTxQWfiKFnX9KbeZopZ4r1xaWZ10BszxRW60=;
        b=vgjcLQ11yDpz4MqIejfj3MlRwDT6V+bHhmT5+peXEzHQMUhxgXRZTXhLjHA+e2+48Q
         w4kNikNXwnR2XG6pXozJ6iavh/xrnzwvC0/Nc1xpekI06hrOuzzsLV2/u5/QxJwb+fqK
         EU0+nM2DZB38iP5M088dgtMB6NiubKjUwYAlWVVqnSEJgxNpwzb9ijS1t7cHY4Td+pqr
         rEeYtprgnw/B6xGQ2so5Q5MnlD3um0sXwuRXkx6QFPZnsuLBzIGu1j1P5oiqIj/cwvta
         qMnYQ2dU0/NTmK4nl6ZLW3jbUmW8q0riCXyQvfUKYfEdwGJ7elNjX3lbwKK02xH3wqbd
         Q1JA==
X-Gm-Message-State: AOAM531WDHEekje8MfszzWuXuevLm4EEEP3FSFqwgcIHeqIT0xBSNU8w
        kHVdU/rpEqLfq4HeFNGcIJSSt9ZKZEbN5x71Jxo=
X-Google-Smtp-Source: ABdhPJyUOcrE75V4+Fe04DlaEC37l3ua3xNDvywQvLcNHB2xBTDCNdHkAbZqykjRSUne6nihUwFPho1YSvlfxJwQvQc=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr43406598otf.127.1641484519049;
 Thu, 06 Jan 2022 07:55:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:2c15:0:0:0:0:0 with HTTP; Thu, 6 Jan 2022 07:55:18 -0800 (PST)
Reply-To: crisstinacampell@gmail.com
From:   "Mrs. Cristina Campbell" <sp0276303@gmail.com>
Date:   Thu, 6 Jan 2022 15:55:18 +0000
Message-ID: <CAMZ1grS66SgLfEwgT8+mnXyJD81St0aPFZf=SSfhEgFw1QJBgw@mail.gmail.com>
Subject: =?UTF-8?B?Q3p5IG1vxbxlc3ogbWkgcG9tw7NjPw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drodzy Umi=C5=82owani,

Przeczytaj to powoli i uwa=C5=BCnie, poniewa=C5=BC mo=C5=BCe to by=C4=87 je=
den z
najwa=C5=BCniejszych e-maili, jakie kiedykolwiek dostaniesz. Nazywam si=C4=
=99
Cristina Campbell, by=C5=82am =C5=BCon=C4=85 zmar=C5=82ego Edwarda Campbell=
a. Pracowa=C5=82 w
Shell Petroleum Development Company London i by=C5=82 r=C3=B3wnie=C5=BC do=
=C5=9Bwiadczony
wykonawca w regionie Azji Wschodniej. Zmar=C5=82 w poniedzia=C5=82ek 31 lip=
ca
2003 r. w Pary=C5=BCu. Byli=C5=9Bmy ma=C5=82=C5=BCe=C5=84stwem przez siedem=
 lat bez dziecka.

Czytaj=C4=85c to, nie chc=C4=99, =C5=BCeby=C5=9B mi wsp=C3=B3=C5=82czu=C5=
=82a, poniewa=C5=BC wierz=C4=99, =C5=BCe kiedy=C5=9B
wszyscy umr=C4=85. Zdiagnozowano u mnie raka prze=C5=82yku i m=C3=B3j lekar=
z
powiedzia=C5=82 mi, =C5=BCe nie wytrzymam d=C5=82ugo z powodu moich skompli=
kowanych
problem=C3=B3w zdrowotnych.

Chc=C4=99, aby B=C3=B3g by=C5=82 dla mnie mi=C5=82osierny i przyj=C4=85=C5=
=82 moj=C4=85 dusz=C4=99, wi=C4=99c
postanowi=C5=82am dawa=C4=87 ja=C5=82mu=C5=BCn=C4=99 organizacjom
charytatywnym/ko=C5=9Bcio=C5=82om/=C5=9Bwi=C4=85tyniom buddyjskim/meczetom/=
dzieciom bez
matki/mniej uprzywilejowanych i wdowom, poniewa=C5=BC chc=C4=99, aby to by=
=C5=82
jeden z ostatnich dobrych uczynk=C3=B3w Robi=C4=99 to na ziemi, zanim umr=
=C4=99. Do
tej pory rozdawa=C5=82em pieni=C4=85dze niekt=C3=B3rym organizacjom charyta=
tywnym w
Szkocji, Walii, Panamie, Finlandii i Grecji. Teraz, kiedy moje zdrowie
tak bardzo si=C4=99 pogorszy=C5=82o, nie mog=C4=99 ju=C5=BC tego robi=C4=87=
.

Kiedy=C5=9B poprosi=C5=82am cz=C5=82onk=C3=B3w rodziny, aby zamkn=C4=99li j=
edno z moich kont i
przekazali pieni=C4=85dze, kt=C3=B3re tam mam, na organizacje charytatywne =
w
Austrii, Polsce, Niemczech, W=C5=82oszech i Szwajcarii, odm=C3=B3wili i
zatrzymali pieni=C4=85dze dla siebie. Dlatego nie ufam im wi=C4=99cej, poni=
ewa=C5=BC
wydaje si=C4=99, =C5=BCe nie maj=C4=85 do czynienia z tym, co im zostawi=C5=
=82em. Ostatnie
z moich pieni=C4=99dzy, o kt=C3=B3rych nikt nie wie, to ogromny depozyt
got=C3=B3wkowy w wysoko=C5=9Bci 6 milion=C3=B3w dolar=C3=B3w ameryka=C5=84s=
kich, kt=C3=B3ry mam w
banku w Tajlandii, gdzie zdeponowa=C5=82em fundusz. B=C4=99d=C4=99 chcia=C5=
=82, =C5=BCeby=C5=9B
wykorzysta=C5=82 ten fundusz na programy charytatywne i wspiera=C5=82 ludzk=
o=C5=9B=C4=87 w
swoim kraju, je=C5=9Bli tylko b=C4=99dziesz szczery.

Podj=C4=99=C5=82am t=C4=99 decyzj=C4=99, bo nie mam dziecka, kt=C3=B3re odz=
iedziczy te
pieni=C4=85dze, nie boj=C4=99 si=C4=99 =C5=9Bmierci st=C4=85d wiem dok=C4=
=85d id=C4=99. Wiem, =C5=BCe b=C4=99d=C4=99 na
=C5=82onie Pana. Jak tylko otrzymam Twoj=C4=85 odpowied=C5=BA, podam Ci kon=
takt z
Bankiem i wydam upowa=C5=BCnienie, kt=C3=B3re upowa=C5=BCni Ci=C4=99 jako p=
ierwotnego
beneficjenta tego funduszu do natychmiastowego rozpocz=C4=99cia programu
charytatywnego w Twoim kraju.

Tylko =C5=BCycie prze=C5=BCyte dla innych jest warte zachodu. Chc=C4=99, =
=C5=BCeby=C5=9B zawsze
si=C4=99 za mnie modli=C5=82. Ka=C5=BCda zw=C5=82oka w Twojej odpowiedzi da=
 mi miejsce na
poszukiwanie innej osoby w tym samym celu. Je=C5=9Bli nie jeste=C5=9B
zainteresowany, przepraszam za kontakt. Mo=C5=BCesz si=C4=99 ze mn=C4=85 sk=
ontaktowa=C4=87
lub odpowiedzie=C4=87 na m=C3=B3j prywatny e-mail: (crisstinacampell@gmail.=
com).

Dzi=C4=99kuj=C4=99,
Z powa=C5=BCaniem,
Pani Cristina Campbell
E-mail; crisstinacampell@gmail.com
