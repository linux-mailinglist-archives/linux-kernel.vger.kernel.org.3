Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D05251B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356130AbiELP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355940AbiELP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:59:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C412469F3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:59:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j6so5160577pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+GNQEVhDTg5gSuglbo+Hey8Sv7o9UNbWWWJQEXw3sck=;
        b=Pqn23zJQOXfjoESt3cYI2rKF7zKu9ft+h/jAzhoptzse3aMeyXTuNQRLNDnNNdgpR7
         IJVnKIWYCYqb4o1qS9KYF2OxXP82zuvg8l9H0G+2CltZLL78hzI6p9a47Gvdxv0L2J4u
         GiqhNeNJOedYHGC8wYbUoNF68g7KLfn0g/RJYbFx8E3g6PCSwm61BUA8m8qwu3ocMoMv
         6/PGP9bpKVCP2v6S0Zq13R5oqMthkhn4x7UNnb82qrbzdVoW1vGZ4+s0cKO73alltMtd
         /rF+OazdL7D8NVXIVafNS2pIRducvHyehkKTFN+zxtynVcGyCW+PL0zmd9Q5y+MjJSE3
         2KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+GNQEVhDTg5gSuglbo+Hey8Sv7o9UNbWWWJQEXw3sck=;
        b=qpsCe6CAwqTQhmEbNxZ123eBmCoOt9+a/rOFeTg4sTcGd8ByTtjdtU2pJOoSw/gEMl
         ofBPznMLalfQjSFAm6rp9Tx/mXN5jQxBGuNetRvUM+4jbwbvNRRVVotJ8puU7A+4evKo
         uMGTD2dOWpKr2Cly7zq7zlyJNRz/wa9+M8aq8JIlmmnNuFibD4lUwtSwYaTl1cTw909x
         HYL/SkXdBHFcHkGBRBecA7AcDMFa9flba2IJNdGWdQy56hSk6FAf/XNU+lr4XUMHQlKE
         UenIABRViaCAS+5y46qKbGMFVxLWfwcKFTnKbxK6lfw9DYZoRJsIBBWh5tIVSMXjWMpI
         45qQ==
X-Gm-Message-State: AOAM531QjyJ5bCsedzj4QjLKKi39T/MS8ckMnTakCbBf4F7q5i+/d27f
        aghTrLaL6kwNVQHZh19G2HA+lKnKILzxuZiPkWk=
X-Google-Smtp-Source: ABdhPJwoPwgabfsixufyOm+4d9sHcFdO0bSZg8yR/mGAumz3a6j06/bcxRWrdPPp9rkRwhEnsGm0FpUlBe9QUNhv0mU=
X-Received: by 2002:a63:df10:0:b0:3db:8bb8:bf01 with SMTP id
 u16-20020a63df10000000b003db8bb8bf01mr265703pgg.163.1652371146582; Thu, 12
 May 2022 08:59:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:d2c7:b0:7f:757b:3407 with HTTP; Thu, 12 May 2022
 08:59:06 -0700 (PDT)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <huisterlui75@gmail.com>
Date:   Thu, 12 May 2022 15:59:06 +0000
Message-ID: <CAAcQqWhv8Z4LfLhXDjQAvoRBXSpfX+vU=OXF4rRcjDqzUf+y5A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4957]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [huisterlui75[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [huisterlui75[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [msbelinaya892[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pakun oma s=C3=B5prust ja usun, et v=C3=B5tate mind hea s=C3=BCdamega vastu=
. Mul
paluti teiega =C3=BChendust v=C3=B5tta ja uurida, kuidas saaksime =C3=BCkst=
eist k=C3=B5ige
paremini toetada. Olen pr Kodjovi Hegbor T=C3=BCrgist ja t=C3=B6=C3=B6tan e=
ttev=C3=B5ttes
StandardBNP bank limited Turkey operatsioonide osakonna juhina. Usun,
et see on Jumala tahe, et ma kohtun teiega n=C3=BC=C3=BCd. Mul on oluline
=C3=A4rivestlus, mida tahan teiega jagada ja millest ma usun, et olete
huvitatud, kuna see on seotud teie perekonnanimega ja toob teile
sellest kasu.

 2006. aastal avas teie riigi kodanik minu pangas kalendri 36-kuulise
mitteresidendi konto v=C3=A4=C3=A4rtusega 8 400 000 naela. Selle tagatisrah=
a
lepingu kehtivusaeg oli 16. jaanuar 2009. Kahjuks hukkus ta 12. mail
2008 Hiinas Sichuanis surmaga l=C3=B5ppenud maav=C3=A4rinas, mis tappis
=C3=A4rireisil viibides v=C3=A4hemalt 68 000 inimest.

Minu panga juhtkond pole tema surmast veel kuulnud, teadsin sellest,
sest ta oli minu s=C3=B5ber ja mina tema kontohaldur, kui konto avati enne
minu edutamist. Siiski, h=C3=A4rra
 ei maininud konto avamisel l=C3=A4hisugulasi/p=C3=A4rijaid ning ta ei olnu=
d
abielus ega tal polnud lapsi. Eelmisel n=C3=A4dalal palus mu panga juhtkond
mul anda juhiseid, mida teha tema rahadega, kui lepingut kavatsetakse
pikendada.

Ma tean, et see juhtub ja seep=C3=A4rast olen otsinud vahendeid olukorra
lahendamiseks, sest kui mu pangadirektorid teavad, et nad on surnud ja
neil pole p=C3=A4rijat, v=C3=B5tavad nad raha isiklikuks tarbeks, m=C3=B5ne=
d aga ei
tea. ei taha, et midagi sellist juhtuks. See oli siis, kui ma n=C3=A4gin
teie perekonnanime, olin =C3=B5nnelik ja otsin n=C3=BC=C3=BCd teie koost=C3=
=B6=C3=B6d, et
esitleda teid l=C3=A4hisugulasena/konto p=C3=A4rijana, kuna teil on temaga =
sama
perekonnanimi ja minu panga peakontor vabastab konto sina. Risk
puudub; tehing tehakse seadusliku lepingu alusel, mis kaitseb teid
=C3=B5igusrikkumiste eest.

Meil on parem raha v=C3=A4lja n=C3=B5uda, kui lubada pangajuhtidel see v=C3=
=B5tta,
nad on juba rikkad. Ma ei ole ahne inimene, seega soovitan jagada raha
v=C3=B5rdselt, 50/50% m=C3=B5lema poole vahel. Minu osa aitab mul alustada =
oma
=C3=A4ri ja kasutada saadud tulu heategevuseks, mis oli minu unistus.

Palun andke mulle oma m=C3=B5tted minu ettepaneku kohta, ma vajan selle
tehingu puhul teie abi. Ma olen valinud su mind aitama, mitte minu
enda tegude t=C3=B5ttu, mu kallis, vaid Jumala poolt. Ma tahtsin, et sa
teaksid, et v=C3=B5tsin aega selle s=C3=B5numi p=C3=A4rast palvetada, enne =
kui v=C3=B5tsin
sinuga =C3=BChendust, et jagada, avaldage mulle oma arvamust ja palun.
k=C3=A4sitlege seda teavet T=C3=84IESTI SALAJASena. P=C3=A4rast teie vastus=
e saamist
ainult minu isikliku e-posti aadressi kaudu msbelinaya892@gmail.com
annab teile tehingu =C3=BCksikasjad. Ja fondi deposiitsertifikaadi ja fondi
loonud ettev=C3=B5tte asutamiskirja koopia.
Jumal =C3=B5nnistagu teie kiiret vastust oodates
Parimate soovidega
Proua Kodjovi Hegbor
msbelinaya892@gmail.com
