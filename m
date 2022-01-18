Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5A492B78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346231AbiARQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346274AbiARQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:45:07 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3423C061747
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 08:45:06 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cx27so8747944edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KpPLmlJqSe5enL4H8Q9iaiPPjau/vD3KzQyahonR9f0=;
        b=a2mJyduGfQCaivkxvFMzUibSXLnSsrqZ7DJ9zFn8ZrVf0/V/1nZ8jxgMbl3mC79yku
         Hywe37CJSSRcVplKEGOj1Yd/QhbBtFJgQDuWNy1orpnu3oJmejpcpfAsmymaO+clXZd1
         Apobwj9snZr0MLMyTYb8tvcxZKqqrexFLXR4IG0M9Uiph+740tTipOttDBkdxebqHEv1
         I8xGer2kJaQwRNqYg1QB1khoObFElfPGU+gLuDLREzxqHnOLmG65QpBqkdV6gPallDj/
         UXcEayTj0McCEb/X+VKYBVI6kadyXV7R5E3Ffl1mIe2pGPp7F7Oa/Bgi33KxV2FEonch
         Fn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KpPLmlJqSe5enL4H8Q9iaiPPjau/vD3KzQyahonR9f0=;
        b=SB24CailmdC0vI7sVF14MHKvece92rPXvJkU2GolHTwkRceTnxBypnAf0OCUhuX25H
         WAN8F/iwGXqP7HXjbWwJXAEjRl2shY5S+T2PXHRweGA8c+ctVTlrj+GwP7UXZ0AmNsBE
         tu5AOqs4sL4lKOKWB06cOjted4tDkXlQKaOVnBq2Wh06H/gbRzv4bcBWjWZAX7+uFelB
         3MWRgtbHpqJblh+PzoRMZOw/6qOR3TAtFqQsJmsHwkILqmWlHNqlAyF8qR7CL/CXnaep
         QRvFkJ4IemgKi+zUDRzU1mco1Xg6t0b1+mcBRlHS+Q0V5s0AW5BEYGDtn1B/pc4wcS3W
         UG6A==
X-Gm-Message-State: AOAM533RsXIfJ2o85ssKXyJYrjBmeRTRwHRwbn7lkhz+hZFV9ypVYvLy
        fa2xxqwAXZ/HANrPpdFx1Lx3DRlISxsBViiF3o97705G5dcVeQ==
X-Google-Smtp-Source: ABdhPJwSdTvWL7q8CMaQDTJoT1mC2snXl2HvymDeTGb2UExahdEa9juYDBjc6CbsoA22kCkhH3pBZMukvvJEYh9C+1E=
X-Received: by 2002:a17:906:471a:: with SMTP id y26mr21286744ejq.753.1642524294792;
 Tue, 18 Jan 2022 08:44:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:3e02:0:0:0:0 with HTTP; Tue, 18 Jan 2022 08:44:54
 -0800 (PST)
From:   robert anderson <robertandersongood5@gmail.com>
Date:   Tue, 18 Jan 2022 08:44:54 -0800
Message-ID: <CAD7QbCA5_RpNobzF4-wHELPg8M_MfXacfvhwWSR9B+9PiLpB4g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pros=C3=ADm pozor,

Ja som Bar. uchenna ilobi , Ako sa m=C3=A1=C5=A1, d=C3=BAfam, =C5=BEe si v =
poriadku a
zdrav=C3=A1? Chceli by sme v=C3=A1s informova=C5=A5, =C5=BEe som =C3=BAspe=
=C5=A1ne uzavrel
transakciu s pomocou nov=C3=A9ho partnera z Venezuely a teraz bol fond
preveden=C3=BD do Venezuely na bankov=C3=BD =C3=BA=C4=8Det nov=C3=A9ho part=
nera.

Medzit=C3=BDm som sa rozhodol kompenzova=C5=A5 v=C3=A1s sumou 350 000,00 US=
D
(tristop=C3=A4=C5=A5desiattis=C3=ADc americk=C3=BDch dol=C3=A1rov) kv=C3=B4=
li v=C3=A1=C5=A1mu =C3=BAsiliu v
minulosti, hoci ste ma v tomto smere sklamali. Ale napriek tomu som
ve=C4=BEmi r=C3=A1d za =C3=BAspe=C5=A1n=C3=A9 ukon=C4=8Denie transakcie bez=
 ak=C3=BDchko=C4=BEvek probl=C3=A9mov a
preto som sa rozhodol kompenzova=C5=A5 v=C3=A1s sumou 350 000,00 USD, aby s=
te sa
so mnou o t=C3=BAto rados=C5=A5 podelili.

Odpor=C3=BA=C4=8Dam v=C3=A1m, aby ste kontaktovali moju sekret=C3=A1rku pre=
 bankomatov=C3=BA
kartu v hodnote 350 000,00 USD, ktor=C3=BA som si pre v=C3=A1s nechal.
Kontaktujte ho teraz bez zbyto=C4=8Dn=C3=A9ho odkladu.

N=C3=A1zov: =C5=A1alam=C3=BAnske brandy

E-mail: solomonbrandyfiveone@gmail.com

Pros=C3=ADm, znova mu potvr=C4=8Fte nasleduj=C3=BAce inform=C3=A1cie:

Tvoje cel=C3=A9 meno_________________________
Va=C5=A1a adresa__________________________
Tvoja krajina___________________________
Tvoj vek______________________________
Va=C5=A1e povolanie_________________________
=C4=8C=C3=ADslo v=C3=A1=C5=A1ho mobiln=C3=A9ho telef=C3=B3nu_______________=
________

V=C5=A1imnite si, =C5=BEe ak ste mu neposlali vy=C5=A1=C5=A1ie uveden=C3=A9=
 inform=C3=A1cie =C3=BApln=C3=A9,
bankomat v=C3=A1m neposkytne, preto=C5=BEe si mus=C3=AD by=C5=A5 ist=C3=BD,=
 =C5=BEe ste to vy.
Po=C5=BEiadajte ho, aby v=C3=A1m poslal celkov=C3=BA sumu (350 000,00 USD)
bankomatovej karty, ktor=C3=BA som si pre v=C3=A1s nechal.

S Pozdravom,

P=C3=A1n uchenna ilobi
