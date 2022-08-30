Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DD5A686D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiH3Q2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiH3Q2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:28:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C7D8B29
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:28:01 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 62so9675698iov.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=ljt1msDQIdw3/XSMupQE90lgVlsNEZUL9fSl+XU13v4=;
        b=cgdWDladoMlwY46B/oIfIm/9U1ny1N2TQ1E+ZEX8BQHMlsLqfNHO39Bl3W8X/2ZUe5
         YjsojUkxuW5N2dyTkeY791YMNUMOyRDERFPDetJ77fFBuNFFiFRyaV1IwdKj/FAfXjcm
         KiKtmaPSZc04d54unaEPogPTTkhAzjs34lSpgTabJaGe3Qqg1mAvD0B/ymxUsNpPStoN
         Jhk2BSHLCvWoNdV9cQtVsS7S+jcJd5GoN08783uoDFBZIELbKL6wtmjNuwYCL0r+7b/k
         Oqg580ENEz+L1lBNWPNcXdXRfkT8950wWIF5xWn4XtP8D5+DPAzbJ7jRKt5qLHV4zSIm
         /W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ljt1msDQIdw3/XSMupQE90lgVlsNEZUL9fSl+XU13v4=;
        b=6AdYAf2ZEmIrfE7yvu/Ugfk+q2qaeSmAcE/zSB3WEjRbGpQnafITuZfCacBrvOzcPN
         2Kc6feang5/tz/u+bl7450TSk6Vp/rbY7uCtuAd71QyMH2PZoCCFnjktMXMcgodBD6Mm
         +iGuYEGGAKBcX0XV10iNhmJtS2ZJNvitfeVpiXQ7jASo6zz92K2VxgzeAjZ9Ge86Caka
         5aTAhLaSJOBIxTJm2gRlCN2OvxkzOQkFLMjL1UWhC0zCN3zzEMXU8pOw2FbQ9kRYHAnI
         4OH1yy8Vx4Uhw7Vhogqi2LLOPSDnATOHl1LhTpqZUwifHk7vTi1BRi491PNrBcoTVXKA
         j3cQ==
X-Gm-Message-State: ACgBeo0PgQb9+JnNwHLtudUofREqYMlVc09TPNu4vsLVvwTeCyMkP8hl
        49IOYKmngpXp/XBZmHQ0pWqSRpxHOAUfXow8REw=
X-Google-Smtp-Source: AA6agR7kVYZepuHRqkRKo9NzNoanzrIEjhMEOyk+ZSkmfrJgGfE/Sj5MSp9zZKLopZ3dzztsZMoq65ZpqPcrruu6MPA=
X-Received: by 2002:a6b:5f19:0:b0:688:2173:1ae3 with SMTP id
 t25-20020a6b5f19000000b0068821731ae3mr11091161iob.12.1661876881340; Tue, 30
 Aug 2022 09:28:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1aaf:0:0:0:0 with HTTP; Tue, 30 Aug 2022 09:28:00
 -0700 (PDT)
Reply-To: jon768266@gmail.com
From:   johnson <adjassou665@gmail.com>
Date:   Tue, 30 Aug 2022 16:28:00 +0000
Message-ID: <CADTOecKYJE30eo5DxQdzYX3TEanX0c-CDmyRe-SX5-4Tk5t-=A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adjassou665[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jon768266[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [adjassou665[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jsem r=C3=A1d, =C5=BEe v=C3=A1s mohu informovat o m=C3=A9m =C3=BAsp=C4=9Bch=
u p=C5=99i p=C5=99evodu t=C4=9Bchto
prost=C5=99edk=C5=AF ve spolupr=C3=A1ci s nov=C3=BDm partnerem z Indie. V s=
ou=C4=8Dasn=C3=A9 dob=C4=9B
jsem v Indii kv=C5=AFli investi=C4=8Dn=C3=ADm projekt=C5=AFm s vlastn=C3=AD=
m pod=C3=ADlem na celkov=C3=A9
sum=C4=9B. Mezit=C3=ADm jsem nezapomn=C4=9Bl na va=C5=A1e minul=C3=A9 snahy=
 a pokusy pomoci mi
s p=C5=99evodem t=C4=9Bch prost=C5=99edk=C5=AF, p=C5=99esto=C5=BEe se n=C3=
=A1m to n=C4=9Bjak nepoda=C5=99ilo. Nyn=C3=AD
kontaktujte m=C3=A9ho sekret=C3=A1=C5=99e v Lome.Togo, s jeho n=C3=AD=C5=BE=
e uveden=C3=BDm kontaktem
jsem upustil certifikovanou v=C3=ADzovou kartu do bankomatu, po=C5=BE=C3=A1=
dejte ho,
aby v=C3=A1m poslal v=C3=ADzovou kartu do bankomatu ve v=C3=BD=C5=A1i 250 0=
00,00 $, kterou
jsem mu nechal jako kompenzaci za ve=C5=A1ker=C3=A9 minul=C3=A9 =C3=BAsil=
=C3=AD a sna=C5=BE=C3=AD se mi v
t=C3=A9to v=C4=9Bci pomoci. Velmi jsem si va=C5=A1eho tehdej=C5=A1=C3=ADho =
=C3=BAsil=C3=AD v=C3=A1=C5=BEil.

Tak=C5=BEe nev=C3=A1hejte a spojte se s moj=C3=AD sekret=C3=A1=C5=99kou a d=
ejte mu pokyn, kam
v=C3=A1m m=C3=A1 zaslat bankomatovou v=C3=ADzovou kartu s obnosem. Pros=C3=
=ADm, dejte mi
okam=C5=BEit=C4=9B v=C4=9Bd=C4=9Bt, jestli to dostanete, abychom mohli spol=
e=C4=8Dn=C4=9B sd=C3=ADlet
radost po v=C5=A1ech tehdej=C5=A1=C3=ADch =C3=BAtrap=C3=A1ch. v tuto chv=C3=
=ADli jsem zde velmi
zanepr=C3=A1zdn=C4=9Bn kv=C5=AFli investi=C4=8Dn=C3=ADm projekt=C5=AFm, kte=
r=C3=A9 realizuji s m=C3=BDm nov=C3=BDm
partnerem, tak se s n=C3=ADm rychle spojte a p=C5=99epo=C5=A1lete mu va=C5=
=A1e informace,
va=C5=A1e cel=C3=A1 jm=C3=A9na, adresu a kontaktn=C3=AD =C4=8D=C3=ADslo pro=
 snadnou komunikaci,
dokud nedostanete bankomat Visa karta. (jon768266@gmail.com)

S pozdravem
Orlando Moris.
