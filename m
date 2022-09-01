Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97EF5A8DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiIAFuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIAFuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:50:03 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67801D313
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:49:56 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id o123so16719196vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=va5LwdG/KkICDWruNiNDecsyqrVzJ2RcSpNnEI7SnTI=;
        b=q6V9VT2Bj1GsroyhjYJ6hvwt3w/hvfP1qJlgKalor7Urk+uwwccQ3NHobuPpKKK4yg
         6wwg4iUsFeDjoUExcsOeqTpKDKhTNHvUFT369zqNX1NMHxb5Jbx+LofPXlYswCAsHC7u
         8w9KIlZl02SW27l92RwiMFJoVwu/wTcZcJC0rBoE7l8kPrjSCr+sKjQ67yxJmOOg6PCE
         WaID4wFShMNB6NbP84BunHizDktu/IXnWmQwD4E29TKhnSY2+jQus/+O2faPVKM4Okm1
         6nFdTNLHFN1bYBjI4HFbm7oE1VQ5vAq+di0qK0gta9kPaT43IEhmsajSQv6VYpXvKbWC
         cgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=va5LwdG/KkICDWruNiNDecsyqrVzJ2RcSpNnEI7SnTI=;
        b=ITHJtmKvvLongkwy89BQjHGFF6shnmGIO/vi4jVW1lgTPC7CfprVmqVH1pIRUA1pPI
         Rss+vMLy0a8L/DHsIg4Y5cBib1m6swCMFB1Xpo8ySr5caDBLrLABsl8gKnrIOGS0gQn5
         j7xmnPuenYsBhVRA493VPUI0/fGxVCMs+b6KjZmOPmtsUveuckPrPA4l8ngs5YvdaI0n
         Qdh+jE2OOl6PV416H6G5KI+7EQ4Epbmq12HuT/PB863cOn2VEshxqnU0WiUwdJ0iJ3Eb
         anPnvUgLf5ttbR2GlaTH3IxwAw0Mcrndx1wRSWd5CXN2IZNFQf1Fco8mP2Cz9UmJk+iq
         fHVg==
X-Gm-Message-State: ACgBeo0Cvn1tbHzCDPqcAMIfqFiJMvxwT+QMoeadFg/oN4nl8MtIoRMn
        wC+Qny9BYtbtsbS0RaCF9NFgM+YTM5BTRwEXRh8=
X-Google-Smtp-Source: AA6agR4jDN/yEqExzJbcjr5+ti2rVJy21Nhqg+8T5jxYNnL+B+fZtGe7jC8ABybNER/HzjyudxBX8uaFlWjhJsOaerg=
X-Received: by 2002:a05:6102:3353:b0:38c:9170:a96b with SMTP id
 j19-20020a056102335300b0038c9170a96bmr8854571vse.26.1662011395044; Wed, 31
 Aug 2022 22:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:11cb:b0:2e3:3da7:7ca9 with HTTP; Wed, 31 Aug 2022
 22:49:54 -0700 (PDT)
Reply-To: azimhashimpremji9090@gmail.com
From:   Azim <ekuabella7@gmail.com>
Date:   Wed, 31 Aug 2022 22:49:54 -0700
Message-ID: <CAGfh03QrdFTrz9Yuy9dH-D3qBwU3SPjJB1s5M_F_QKberEAj8A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,MIXED_ES,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4769]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [azimhashimpremji9090[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ekuabella7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ekuabella7[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  1.4 MIXED_ES Too many es are not es
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Potrzebujesz pilnej po=C5=BCyczki? Oferujemy po=C5=BCyczk=C4=99 edukacyjn=
=C4=85, po=C5=BCyczk=C4=99
biznesow=C4=85, po=C5=BCyczk=C4=99 mieszkaniow=C4=85, po=C5=BCyczk=C4=99 ro=
ln=C4=85, po=C5=BCyczk=C4=99 osobist=C4=85,
po=C5=BCyczk=C4=99 samochodow=C4=85 i inne dobre powody w wysoko=C5=9Bci 3%=
. Skontaktuj
si=C4=99 z nami pod adresem e-mail: mikemorgan9867@gmail.com, podaj=C4=85c =
swoje
imi=C4=99 i nazwisko, adres, numer telefonu, kwot=C4=99 po=C5=BCyczki, mies=
i=C4=99czny
doch=C3=B3d, zaw=C3=B3d i czas trwania po=C5=BCyczki.

Dzi=C4=99kuj=C4=99 Ci.
Mike Morgan
