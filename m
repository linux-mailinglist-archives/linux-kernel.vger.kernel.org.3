Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F425B2388
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIHQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiIHQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:23:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03380F824A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:23:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s206so17252848pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=9ZFpt/foVGQHDYdWFxLDfNkzYkIk3H2JJygdZbdIkYI=;
        b=MN0TCfIJUXfXRuQOYsUslH2iwTVvtVL3wo6jKyK9TLQfoyVkXvEO/guAM+iQ78cg0I
         KhhJMNk7AD0+eYNAgovjyFq8Au2XxH4VoVpi/HtR7HyjAH/Uz/lERx7n17naKxuXFO4y
         yzu6zbVlzNjkXrZ+NZoxlPfufMadD7EShuhlJewBy3ZgZIR48T45p3do42bp03MQGwan
         0KVMwVusci5vMe90Y/5qi7NdqnR2YKUvM9dVTJFFh5lFMcXy+V6xgYduNSsUfRTttrZR
         coUCEsqeQtz0yYsiW8lEw+zB5mWpOMtgrwDLLvIlFUlR8m2fyCDj6ZA9iNvSsl8MP172
         ewaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9ZFpt/foVGQHDYdWFxLDfNkzYkIk3H2JJygdZbdIkYI=;
        b=QbbvhXQ3pXx9H9lOJvt1zIy8PCkbbg0PxedklubiNsWrMSwmylNefg9yYSiqPjGDYi
         FnyVuhUkP6xWHT7fcB249qIB83Y/+AcuUUc1Gxan1WL4fSQRrenbkU7gWZQp9SbX59bQ
         ZtozWSn2kSi5F/aaoYM4KOW0HolaP2XQtWB3oZra4Q0uBIy3nX6aRpahUs/F4d/fS72d
         g7lYBZt+XzhJGR3BpXDINULTV6P9G3o38dCZz3qkzt6un1zoqmMCC0WcfmdjfclGoh/Y
         HcD5ilFi/4VnIQKWlM1lz6UNKtHrfA/WWpYWf7HoydJihWqpfyexmoi2fXu0aZMmo+U/
         98Hg==
X-Gm-Message-State: ACgBeo2T4LhoYNaODu1Mzqu49yShhFprS8UiV97qC6+mWvbIV1DYgL/e
        4D4LYnZ7QJeCQcQI2FmWfuwhoyBTvI+8JuJ7jeU=
X-Google-Smtp-Source: AA6agR6ts1imAnI3/nNkx+JJ7dw1QZuQKDUcxTMwEzIHQfxbKFJfgszENJVlmWpYgAwVyBtbBsi1K7r0+iEi5hl1LnA=
X-Received: by 2002:a63:6541:0:b0:435:cb2:ae4d with SMTP id
 z62-20020a636541000000b004350cb2ae4dmr5852446pgb.252.1662654210570; Thu, 08
 Sep 2022 09:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:12d4:b0:8e:e10d:7a77 with HTTP; Thu, 8 Sep 2022
 09:23:29 -0700 (PDT)
Reply-To: cfc.ubagroup09@gmail.com
From:   Kristalina Georgieva <unitedbankafrica962@gmail.com>
Date:   Thu, 8 Sep 2022 09:23:29 -0700
Message-ID: <CAPbXNa3A92rFSUigwot7ULOLPGS7Lqk4WSKSvN1sF7S04s9wEg@mail.gmail.com>
Subject: XUSH HABAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hurmatli Benefisiar,
Men sizga bir oy oldin bu xatni yuborgan edim, lekin sizdan xabar yo'q, yo'=
q
Ishonchim komilki, siz uni oldingiz va shuning uchun uni yana sizga yubordi=
m,
Avvalo, men Kristalina Georgieva xonim, boshqaruvchi direktor va
Xalqaro valyuta jamg'armasi prezidenti.

Aslida, biz atrofdagi barcha to'siqlar va muammolarni ko'rib chiqdik
sizning to'liq bo'lmagan tranzaksiyangiz va to'lovlarni to'lay olmasligingi=
z
o'tkazish to'lovlari olinadi, sizga qarshi, imkoniyatlari uchun
oldingi transferlar, tasdiqlash uchun bizning saytimizga tashrif buyuring 3=
8
=C2=B0 53'56 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 Vt

Biz Direktorlar kengashi, Jahon banki va Valyuta jamg'armasimiz
Vashingtondagi Xalqaro (XVF) Departamenti bilan birgalikda
Amerika Qo'shma Shtatlari G'aznachiligi va boshqa ba'zi tergov idoralari
Amerika Qo'shma Shtatlarida bu erda tegishli. buyurdi
Bizning Chet eldagi to'lov pul o'tkazmalari bo'limi, Birlashgan Bank
Afrika Lome Togo, sizga VISA kartasini chiqarish uchun, bu erda $
Sizning fondingizdan ko'proq pul olish uchun 1,5 million.

Tekshiruvimiz davomida biz aniqladik
Sizning to'lovingiz korruptsionerlar tomonidan kechiktirilganidan xafa bo'l=
ing
Sizning mablag'laringizni hisoblaringizga yo'naltirishga harakat qilayotgan=
 bank
xususiy.

Va bugun biz sizning mablag'ingiz Kartaga o'tkazilganligi haqida xabar bera=
miz
UBA Bank tomonidan VISA va u ham yetkazib berishga tayyor. Hozir
UBA Bank direktori bilan bog'laning, uning ismi janob Toni
Elumelu, elektron pochta: (cfc.ubagroup09@gmail.com)
ATM VISA kartangizni qanday qabul qilishni aytib berish.

Hurmat bilan,

Kristalina Georgieva xonim
