Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0C50BC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379068AbiDVQAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378047AbiDVQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:00:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C15DA6D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:57:09 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x12so5772709qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xEXutyfDIovIUK0MPvdB/MiRM9nd/r7hXc5dChLDvms=;
        b=Gn4gpKM1uWn2BSGUeIfRjGH+gXvKy1IdyihjKNAs3uOpxF+Oaz09uz4+oe0muNGouD
         GSaXxYguGbpvxQahRCDe5FupWWXRCSTcREmi2t1ZVV8sWPcQ3fXAlLPnPyfxozkj5tBt
         3SDNRh3iW5kxTzAUnhcsiQjg5Wj0Us1uBLq75/qedEnPEEqkAGhgP5ArmPz5d9pq3ak7
         zuSD9jsFuzGXIDwZdNx5sIiSaRCVp4RpKAAmodtVBWlanB90yU7WGV9oI7PIfxtFMjmo
         nuVDTY0zepe4cJzAhFPvtnCYgCrh6ScpYEoZvpBy5wgodlqd57S8sgRkmlkxtRJqH9Rg
         1HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xEXutyfDIovIUK0MPvdB/MiRM9nd/r7hXc5dChLDvms=;
        b=um111DghfOJF+3Z6VGJbnvc1DyJie7rEGEd5hcMcYurfWyXLJ9tleJmOqfBH9yId82
         Qgk3mouNn7Ata22ztvIrSt1/nuigZJToo5+a0yYy6kqdLva78fYlVVE2iH7lvnATp/zn
         tddWvy6LFgBAiIZ/DWRsOopVLvFE5Q6htomWB/G8SSBc6nqhZ8EiHihvprXSlsP8iU9y
         1E4i60KVFmVDG9p4+ojLcuGoaodMCyx22T2hKmbD/0g5enRynFVvE6SEZJSut4JWv6cS
         iGkyMqUfqQnuRzH5TnsdJS1lYFjDngALOXvOf1uGujXa5UIF+qZYtIVb3wJSLd9pFT9e
         F/KA==
X-Gm-Message-State: AOAM532/96TMd4xd6dNaFxzsQtihQJ/MXVMlCr6IsQ/LN20krivcl+Tl
        jZGAp+mdBYv/hGLPaMH3m5ZWw8Kq/guhzZs56KM=
X-Google-Smtp-Source: ABdhPJxeMV47f+BRLpjd7ybvqieVWuckE/CXNCAWT81BB9HWzS428cwkXoDCAX5tVOXItVGfKyGSaRHW9fTs287BUJ4=
X-Received: by 2002:ac8:7f0a:0:b0:2f1:f60d:2b39 with SMTP id
 f10-20020ac87f0a000000b002f1f60d2b39mr3654262qtk.470.1650643028762; Fri, 22
 Apr 2022 08:57:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:15c4:0:0:0:0 with HTTP; Fri, 22 Apr 2022 08:57:08
 -0700 (PDT)
Reply-To: susannelegitfirm155@gmail.com
From:   Susanne Klatten <zainabhussaini6771@gmail.com>
Date:   Fri, 22 Apr 2022 16:57:08 +0100
Message-ID: <CAGyfEacuXa4D9nKe2MFiYHTo04-ettRDwM6tz72XAJs-Sc3aWA@mail.gmail.com>
Subject: =?UTF-8?B?UE/Fu1lDWktB?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,FUZZY_CREDIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:835 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1928]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [zainabhussaini6771[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susannelegitfirm155[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zainabhussaini6771[at]gmail.com]
        *  1.7 FUZZY_CREDIT BODY: Attempt to obfuscate words in spam
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Witam

Nazywam si=C4=99 Susanne Klatten i jestem Z Niemiec, mog=C4=99 kontrolowa=
=C4=87 Twoje
problemy finansowe bez uciekania si=C4=99 do Bank=C3=B3w w zakresie Pieni=
=C4=85dze
Kredytowe. Oferujemy po=C5=BCyczki osobiste i po=C5=BCyczki biznesowe, jest=
em
zatwierdzonym i certyfikowanym po=C5=BCyczkodawc=C4=85 z wieloletnim
do=C5=9Bwiadczeniem w udzielaniu po=C5=BCyczek i udzielamy po=C5=BCyczek z
zabezpieczeniem i bez zabezpieczenia w zakresie od 2 000,00 =E2=82=AC ($) d=
o
maksymalnie 500 000 000,00 =E2=82=AC ze sta=C5=82ym oprocentowaniem 3% w st=
osunku
rocznym. Czy potrzebujesz po=C5=BCyczki? Napisz do nas na:
susannelegitfirm155@gmail.com

  Mo=C5=BCesz r=C3=B3wnie=C5=BC wy=C5=9Bwietli=C4=87 m=C3=B3j link i dowied=
zie=C4=87 si=C4=99 wi=C4=99cej o mnie.

  https://en.wikipedia.org/wiki/Susanne_Klatten
  https://www.forbes.com/profile/susanne-klatten

  E-mail : susannelegitfirm155@gmail.com
  Podpis,
  Przewodnicz=C4=85cy Wykonawczy
  Susanne Klatten
