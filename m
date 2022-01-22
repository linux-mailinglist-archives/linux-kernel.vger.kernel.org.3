Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB679496C51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiAVMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiAVMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:21:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF9C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 04:21:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so11603917pjp.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 04:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=QZNU9fj7yz/QO3BkTv7wNCRHLAXKVND9PUuJ109fZWI=;
        b=eCOKGZyc4+IYdbn0C9qfIzeF/MTklVdeyZphKY2C0PwAJMZAoTVO4yiEvWfawINyxL
         +xd3PsPkkDKVJam4bT58I574NZ/hF5Ty6MbtPRxag4cg7Y0bxn/Nt9urA0RrK6V/gnLw
         9qTgmJMVFnBe2LOYcRJ+viu6yi40I/AnSvk3d/+IIrqUEYcdbJJ6ymMPED/g6c0ZKAeS
         oIdIxqrU/t0xSxtN0a7CBebagdS9dLP9GbZurreQysaM98cMnF5V8H4m7rfKqxELm668
         54DCd1/7w3u8XULsiuetU5RMcbCMiEhVekf2x6qSN7JEnMtgi28cMq3VpRdFzyrxn0NA
         OUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=QZNU9fj7yz/QO3BkTv7wNCRHLAXKVND9PUuJ109fZWI=;
        b=lNcT6VFT6Jw8Lge+zq+s9DvsIieg/R8NIzKBzaZLt0Og8dQ9PWtogiKtVg4M0kfdVU
         a8EzhFDMzVzWZ+U/s2ETdmeG/IpKoCS5pqKhQTpCCOezrpTBZ22cMzi9NpcoJn60s1AN
         +NrGLhCO2ul4DF08mBQy44Ud5PO/7pKicPmnh89taouLgo9+uqTNUm1ky91alndqQZ3b
         0abQ1YF6iCRGAyAwx5gfugr+0eAVBPa+Riew/9l8AkcfaOYaKDklEZWqUJdOpG5SNQry
         h1yq94w46KaRegeffMcdt1W7je0h5rM1pHtz8y5jCm7QOcpppFRI6iXPDtD86Xfndtax
         LQZg==
X-Gm-Message-State: AOAM531GFjtyZ6nqbIkXzXBThSBgGf+Djw5tXCM6Chgirf+1G2lE2fIL
        MgDnFXzal9sUPZ54jnmA47O+Z+j24nxl9kbnjQQ=
X-Google-Smtp-Source: ABdhPJyo5P+FGdwt3ySyUBpNN9oUSIECeOYdjIU8YMmKOw37vEX+SisrGz6Ytgip3WEwRmdeftG1qf2RW0dHaadoFhg=
X-Received: by 2002:a17:902:8695:b0:14a:f006:db03 with SMTP id
 g21-20020a170902869500b0014af006db03mr7267652plo.173.1642854087273; Sat, 22
 Jan 2022 04:21:27 -0800 (PST)
MIME-Version: 1.0
Sender: rosejohncarlson@gmail.com
Received: by 2002:a05:6a10:440b:0:0:0:0 with HTTP; Sat, 22 Jan 2022 04:21:26
 -0800 (PST)
From:   "helen.carlsen" <helen.carlsen26@gmail.com>
Date:   Sat, 22 Jan 2022 13:21:26 +0100
X-Google-Sender-Auth: YmmpnwNY3SDCdLVLnpigs7nmPdo
Message-ID: <CACeO-SmvWBNggRZqyF18=ep8i5kumQ5z19AuEOZjywO=Mpve+w@mail.gmail.com>
Subject: Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Dearest,


 I sent this mail praying it will found you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day.am Mrs.Helen John carlsen, wife of late Mrs.Helen John
carlsen, a widow suffering from long time illness.I have some funds I
inherited from my late husband, the sum of($ 11.000.000,eleven million
dollars) my Doctor told me recently that I have serious sickness which
is cancer problem. What disturbs me most is my stroke sickness.Having
known my condition, I decided to donate this fund to a good person
that will utilize it the way i am going to instruct herein. I need a
very honest and God fearing person who can claim this money and use it
for Charity works,for orphanages, widows and also build schools for
less privileges that will be named after my late husband if possible
and to promote the word of God and the effort that the house of God is
maintained.

I do not want a situation where this money will be used in an ungodly
manner.That's why am taking this decision.am not afraid of death so I
know where am going.I accept this decision because I do not have any
child who will inherit this money after I die.Please I want your
sincerely and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account.am waiting for your reply.

Best Regards,
Mrs.Helen John carlsen,
