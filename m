Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A841539412
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbiEaPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbiEaPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:32:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD45C66F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:32:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rq11so27423578ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7oH+Xfrz6r1oCHRj13L+MKtIYqHbHCauXBBSfBoEsls=;
        b=iBSzsZYB5EYZKcKC5//wUQeyyW0oxp4n24R/tKG3dR0GYcqTBhgMPek4aumHJghODn
         3dteQDwTuR/pPewFSPATGPmi43Z+uq0awCHv+Aj+cw3KUe5g2iUVYjMIPMNiaUqa+VJf
         Wa/5FgwXN3ULf0bkyyfL4ShM0hKTGiRVjt3ROQ7Xt+GUVQUwrG3qGuczGhIT6FBGWhok
         MMX/3s0gQUBOidJ9Evp1N0IiL+qdZjgGZ3rI/LiXnPoDW33WXFyRB2ASV7spW2Rodu5W
         lCE+1Wi3HucOSq6BC2Iv010Oh9v/6AQmYjd0Yj+84Y/zZK/iJsM9Q5dyMd+qdEGBf94d
         Jw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7oH+Xfrz6r1oCHRj13L+MKtIYqHbHCauXBBSfBoEsls=;
        b=CcAGu9DTqj7jqiiuNrgY6rDJY2KLHQeHBI2mObJSolk8tdnQ1bgkdryxdzlTIN14Tc
         ZvXKltkqpUm+DdGgiALmPvbufR5vjnMYvShxJvoI8c+e74xCG7i3Inde52jP6qZusALx
         DqFv1iSc5iPewXJ0IhzGcUJMy7OikDt929FFYzNZT5Do7SdWMiTlE/Tct1YY2zUNsLUG
         uqdEJWSBNPozGUZT6Uwe/3YSECb6zbxU06JLULJ1fKzwhS+wHsruJ4qI92ZvBnCd/T/N
         pp/7cUKpFueUk2ogjcGezHuvg2DLXxYKaQWKTAzkAwsF6JRctxklJ7kYo76koCQ3uIQa
         C5gw==
X-Gm-Message-State: AOAM531X4Up6vJOFG4Tdjz+k8maF2p8T0HLVVMAtroRIfBoEUsuS/giw
        aYdb6juwIrOegNrzWgvjqe5owOdQMX68jAb5Uho=
X-Google-Smtp-Source: ABdhPJzSdFpiB3UKhEuLrOZd6SoM3Rtq4HA+CMl5ojqV1x0bklFwokETK59J5UAkvGK8iS1RnP84JqGeAlZlSyg8JyQ=
X-Received: by 2002:a17:906:7308:b0:6fe:f979:6b05 with SMTP id
 di8-20020a170906730800b006fef9796b05mr35177455ejc.577.1654011166962; Tue, 31
 May 2022 08:32:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:96ac:b0:6ff:41a3:f4bd with HTTP; Tue, 31 May 2022
 08:32:45 -0700 (PDT)
Reply-To: lilhilal200@gmail.com
From:   Lil Hilal <lilhilal77@gmail.com>
Date:   Tue, 31 May 2022 08:32:45 -0700
Message-ID: <CAB_6U_MtRVmHpn17bEoZEbcR8rX_exC=u5kzZ5FDMEwW9psj9g@mail.gmail.com>
Subject: =?UTF-8?B?SsOzIG5hcG90LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:635 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4945]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lilhilal77[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilhilal200[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lilhilal77[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J=C3=B3 napot,
A nevem Lil Hilal (=C3=BCgyv=C3=A9d) Kor=C3=A1bban =C3=ADrtam neked, de nem=
 v=C3=A1laszolt=C3=A1l.
Seg=C3=ADts=C3=A9gre van sz=C3=BCks=C3=A9gem k=C3=A9sei =C3=BCgyfelem (8 50=
0 000 USD =C3=A9rt=C3=A9k=C5=B1)
p=C3=A9nzeszk=C3=B6zeinek visszaszerz=C3=A9s=C3=A9ben, amelyeket a bank biz=
tons=C3=A1gi
oszt=C3=A1ly=C3=A1n helyeztek el biztons=C3=A1gos meg=C5=91rz=C3=A9s c=C3=
=A9lj=C3=A1b=C3=B3l. Vegye
figyelembe, hogy az =C3=96n vezet=C3=A9kneve hasonl=C3=B3 a n=C3=A9hai =C3=
=BCgyfelem csal=C3=A1di
vezet=C3=A9knev=C3=A9hez, =C3=A9s ez volt az oka annak, hogy felvettem =C3=
=96nnel a
kapcsolatot, hogy seg=C3=ADtsek visszaszerezni a fel nem haszn=C3=A1lt =C3=
=B6sszeget,
mert a bank hivatalos felhatalmaz=C3=A1st adott ki a kedvezm=C3=A9nyezett
nev=C3=A9nek k=C3=B6vetel=C3=A9sre t=C3=B6rt=C3=A9n=C5=91 beny=C3=BAjt=C3=
=A1s=C3=A1ra, k=C3=BCl=C3=B6nben elkobozni =C3=A9s
bez=C3=A1rni a fi=C3=B3kot, ha nem v=C3=A1laszol.
Ha tov=C3=A1bbi inform=C3=A1ci=C3=B3ra van sz=C3=BCks=C3=A9ge ezzel a k=C3=
=B6lcs=C3=B6n=C3=B6s haszonszerz=C3=A9si
tranzakci=C3=B3val kapcsolatban, s=C3=BCrg=C5=91sen keressen vissza. Megosz=
t=C3=A1si
ar=C3=A1nyunk 50-50%. 4 250 000,00 doll=C3=A1r lesz a saj=C3=A1t r=C3=A9sze=
sed=C3=A9se ebben a
tranzakci=C3=B3ban.
S=C3=BCrg=C5=91sen k=C3=BCldje el nekem az adatait
1) Teljes n=C3=A9v ----------------------
2) Mobilsz=C3=A1m -----------------
=C3=9Cdv=C3=B6zlettel.
Lil Hilal
E-mail c=C3=ADm......... ( lilhilal200@gmail.com )
