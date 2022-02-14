Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0F4B4EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbiBNLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351815AbiBNLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:33:44 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E8E66FA2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:19:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so6660964ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+bcLMvCU05dUNAf4f7RZu+pLnqyD2ng62j2iLKkEC8A=;
        b=L9TfSlO1SA+K4gj77IOyRR7D7AoN4YqBoFK+S7dALzBn9vLDemGgslquHJZSfKT3Io
         GEbStGWcxLuzuRj07gSLicA4Eg5wo3KEi8e6VGo9qmNRK2TNKLKwhoozJPbPaivAZV2w
         OPL0Zgi4fefEZ4Q30F4iXCXBAvSGZ0CABlA/F5fuX4Z3tm3Lzu9j9QLoW2RUeOTZkJK8
         MQLdK3w7KhXq79odeiT6HdbrFstCrJn2ZYWv8a/MxewnRZjMFSg8RW6f/MYWGyJFQiop
         f5fiZ+b1d764aaEZOnG9wYWGQDeZcrwQWXnxURsZ99WrdgmhTnYcSHV2xSAxh0tgWKO+
         zdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+bcLMvCU05dUNAf4f7RZu+pLnqyD2ng62j2iLKkEC8A=;
        b=mT9cPAYy7GCOGB86+7qFnHcxMP0tyyidbNfbqV6P7wx4UaPsvMEhrqqWXmqao92Zmn
         z8OnrfARR7ZlKA/phVsRBRoitk/zJ42OUZVI5ZgFO14j2Brk4LTJmxBXgNU7jwiDYBw5
         0tVtHB/WaoAWWwiBvpXSrdYklyAoWoChFY54N+GMRSb2Ofgf4wSwt34TqD16PKnYZXKs
         5R/c+psKz7G7NOjctLXVTQnIecOKNELM4ztpdAK7XenQg9TcKTwSLsWm2qur0wVWVh2c
         jCb7Xjrcdxo91etU68ACesQHuDCPE0BUbEcWqtPAy8rdN9GtahxLdGhc8BYrQvcF9GSN
         6O8g==
X-Gm-Message-State: AOAM533FIk0jVav9qlImR42OmL9VtGJqBRj7fxBZALvO0w/9WFRbGdeK
        HWKRj7J0YWsLoK2h99+g2ClKnj1GxmN2U5JgHfQ=
X-Google-Smtp-Source: ABdhPJxcBySB2xEVG8EufTOiDyu1mHZiieArq6CMXEqkbpAPMWgi78uOeDAVm+qKi5O7qfcK7qoDSUhVS7Xiqu70dnM=
X-Received: by 2002:a2e:a49b:: with SMTP id h27mr2879809lji.421.1644837571210;
 Mon, 14 Feb 2022 03:19:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:28cd:b0:198:630:3407 with HTTP; Mon, 14 Feb 2022
 03:19:30 -0800 (PST)
Reply-To: attorneyjoel4ever2021@gmail.com
From:   Felix Joel <davidovaa15@gmail.com>
Date:   Mon, 14 Feb 2022 11:19:30 +0000
Message-ID: <CABVEX-oBefWD-UaY+d-1UdEMX2XfVdS3Y8SYS7o5Stx_tvt4dA@mail.gmail.com>
Subject: =?UTF-8?B?dsOhcm9tIHbDoWxhc3rDoXQ=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hell=C3=B3,
K=C3=A9rem, fogadja el bocs=C3=A1natk=C3=A9r=C3=A9semet. Nem akarok megs=C3=
=A9rteni a
mag=C3=A1n=C3=A9let=C3=A9t, Felix Joel vagyok, szakm=C3=A1mb=C3=B3l =C3=BCg=
yv=C3=A9d. Kor=C3=A1bban =C3=ADrtam
=C3=96nnek egy levelet, de v=C3=A1lasz n=C3=A9lk=C3=BCl, =C3=A9s az els=C5=
=91 levelemben
megeml=C3=ADtettem =C3=96nnek n=C3=A9hai =C3=BCgyfelemet, aki ugyanazt a ve=
zet=C3=A9knevet
viseli, mint =C3=96n. Hal=C3=A1la =C3=B3ta t=C3=B6bb levelet kaptam a Bankj=
=C3=A1t=C3=B3l, ahol
hal=C3=A1la el=C5=91tt bet=C3=A9tet helyezett el, a bank megk=C3=A9rt, hogy=
 adjam meg
k=C3=B6zeli hozz=C3=A1tartoz=C3=B3j=C3=A1t vagy b=C3=A1rmely hozz=C3=A1tart=
oz=C3=B3j=C3=A1t, aki ig=C3=A9nyt
tarthat a p=C3=A9nzeszk=C3=B6z=C3=A9re, k=C3=BCl=C3=B6nben elkobozz=C3=A1k.=
 Nem tal=C3=A1ltam egyetlen
rokon=C3=A1t sem, ez=C3=A9rt =C3=BAgy d=C3=B6nt=C3=B6ttem, hogy felkeresem =
=C3=96nt ezzel a
keresettel, ez=C3=A9rt ugyanaz a vezet=C3=A9kneve, mint =C5=91. tov=C3=A1bb=
i r=C3=A9szletek=C3=A9rt
s=C3=BCrg=C5=91sen forduljon hozz=C3=A1m.
Tisztelettel,
Felix Joel =C3=BCgyv=C3=A9d.
