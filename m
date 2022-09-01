Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765455A95D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiIALhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiIALhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:37:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8D139D5C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:37:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h22so13129875qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=UTdKbOp1WIihacpgzcGLsJZCpkS1HE5cq3MG6vnftP8=;
        b=YeIOl2H2kvJi16wj3E6fj7gDFPLR0Wqmbg/GPLfrbXF/LtcjhZnsEv3QxiseN3SOD2
         uxftE6Ls7+mTzZqg6+jsw8xWGqgB+sRKqOENSAyVIzdRSjjF0lFssI0WJ+CU1NffknDj
         FXHRhorDfkc+35dgQ9YH3fN0DEnVY9dvkWdvyFSXx8jt+8j5KJ+CylrGHxZujlRLBDbx
         0xbutZG81dbm8CeaMerfdLp/0yz4zxRRkM09f7z4LBVO2EklygzXK++GnqKanvJF5aNd
         p3cHR6Dv1+75syPn/9D+iznM4oO9uaMDNydMvJNHMGzrM7nUI1wa2NQlNCzmvCvZepiu
         9BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UTdKbOp1WIihacpgzcGLsJZCpkS1HE5cq3MG6vnftP8=;
        b=DeRTCm9caNHxgqxPupBXGy32NROVNnBq+JGS8c10IdBbSxKqnskqp1ZjHfgVAuXceW
         BEXcH/80IFqIeTMyYRcGpqC71o1mmzztBtI/CG3iaeosw6mWI8RKOvoDPg9u78XJLVwB
         YcHIXze2ZNEOHFbIhq3qQ6HhB3Z7i7VPH5bxtNIKOBx1dZjxNagvxuMus9SzbEzkgqrF
         dAno4fhRoni9GokaYEM4frx6IRl5lFDHyUMeyItAk8T08QsII0HXypKchIk8rfwkUExh
         NwhkfdYZl3BMR8365+s4e+VrGX6HNQs7CqkKjJAoFpilkXTsF/9SzDtfo4nsnxy0N3cm
         9UQQ==
X-Gm-Message-State: ACgBeo0VNVhZVjKhfi+VYQrGXASioHsUUsehvO+QiJOXXlEQiyJPcefW
        za/eFDRhSwtlAiELdJHWHmFxO2QDZb7k4eor5Wk=
X-Google-Smtp-Source: AA6agR4y7kvbuUojDnDc26jfPLSktivf4yrTYsO1RQ4hs3rAZ7+ONJwM+PiVC3xFAEY6I16qIrHSwKOCNhuhqbyRPt0=
X-Received: by 2002:a05:622a:118f:b0:344:a6fa:1ef5 with SMTP id
 m15-20020a05622a118f00b00344a6fa1ef5mr23306176qtk.313.1662032259989; Thu, 01
 Sep 2022 04:37:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:5e89:b0:46b:a78:b506 with HTTP; Thu, 1 Sep 2022
 04:37:39 -0700 (PDT)
Reply-To: jon768266@gmail.com
From:   johnson <novelav950@gmail.com>
Date:   Thu, 1 Sep 2022 11:37:39 +0000
Message-ID: <CAPCDeF+nenYRbmEPsVnOJ5xHX-Nfk_vgZ_CGHAtq9BPgJd==_g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:833 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [novelav950[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [novelav950[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jon768266[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
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
sum=C4=9B. Mezit=C3=ADm jsem nezapomn=C4=9Bl na va=C5=A1e minul=C3=A9 =C3=
=BAsil=C3=AD a pokusy pomoci mi
p=C5=99i p=C5=99evodu t=C4=9Bchto prost=C5=99edk=C5=AF, p=C5=99esto=C5=BEe =
se n=C3=A1m to n=C4=9Bjak nezda=C5=99ilo.
Nyn=C3=AD kontaktujte m=C3=A9ho tajemn=C3=ADka v Lome. Spolu s jeho n=C3=AD=
=C5=BEe uveden=C3=BDm
kontaktem jsem upustil certifikovanou v=C3=ADzovou kartu do bankomatu a
po=C5=BE=C3=A1dejte ho, aby po=C5=A1lete v=C3=A1m v=C3=ADzovou kartu ve v=
=C3=BD=C5=A1i 250 000,00 USD,
kterou jsem mu nechal jako n=C3=A1hradu za ve=C5=A1ker=C3=A9 minul=C3=A9 =
=C3=BAsil=C3=AD a pokusy
pomoci mi v t=C3=A9to z=C3=A1le=C5=BEitosti. Velmi jsem si v=C3=A1=C5=BEil =
va=C5=A1eho tehdej=C5=A1=C3=ADho
=C3=BAsil=C3=AD.

Spojte se tedy s moj=C3=AD sekret=C3=A1=C5=99kou a dejte mu pokyn, kam v=C3=
=A1m m=C3=A1 zaslat
bankomatovou v=C3=ADzovou kartu obsahuj=C3=ADc=C3=AD =C4=8D=C3=A1stku. Pros=
=C3=ADm, dejte mi ihned
v=C4=9Bd=C4=9Bt, jestli ho dostanete, abychom mohli sd=C3=ADlet radost po v=
=C5=A1ech
tehdej=C5=A1=C3=ADch =C3=BAtrap=C3=A1ch spole=C4=8Dn=C4=9B. v tuto chv=C3=
=ADli jsem zde velmi
zanepr=C3=A1zdn=C4=9Bn kv=C5=AFli investi=C4=8Dn=C3=ADm projekt=C5=AFm, kte=
r=C3=A9 m=C3=A1m s m=C3=BDm nov=C3=BDm
partnerem v Indii, p=C5=99epo=C5=A1lete m=C3=A9 sekret=C3=A1=C5=99ce va=C5=
=A1e informace, va=C5=A1e cel=C3=A1
jm=C3=A9na, adresu a kontaktn=C3=AD =C4=8D=C3=ADslo pro snadnou komunikaci,=
 dokud
neobdr=C5=BE=C3=ADte kartu s v=C3=ADzem do bankomatu. (jon768266@gmail.com)

S pozdravem
Orlando Moris.
