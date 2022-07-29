Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69C4584FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiG2L6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiG2L6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:58:34 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F387F54
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:58:32 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o4so4273032vsc.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/spAceZjGo7hEwRbpkX1KXC8t1LyoBwzTnObopY/QLY=;
        b=SsiOOrdfrV2DQ8TtH+sSgrg0Pun8eMdcz6g1Z0GwMgE6gPpavYGVgFzg3I354nZU0J
         IAAl2O50BkgxzXf4BCTNhTxf+fDKDYxBGHfq1I9OkDPqtsVWxBnnNpcHA9OwLmrpLLQ4
         0Ea/9ER+v4Fcb/hiw+TBYeVoVbyr84gTGQkU0xslX4i+HKRpZAYtmzmzxSBqyJM1R5yP
         xzDMZZwsbc9E2vyaPiSGT0rJNcl2hFLH0cCBxaEncwSj4OzCEMidpFxO9dk5Xoeb791v
         742e5tCvJZooJbln6WI5F451slLvFGwVxu9CcCsdnojhwRAJL/aB8lFdcz7QODlaSZUP
         JHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/spAceZjGo7hEwRbpkX1KXC8t1LyoBwzTnObopY/QLY=;
        b=mHzzYj3mPV/vXN8JODA9VYswROyPcY3oHqq7Phl6gk93VpESM72vhAi3W/uiSBSurh
         RdoCFvFJZ3MTEB11H+rcRM+Whj6rdIN372M71CvT6ap3OXonM31JFcVR/UYyaOxziT1a
         7pggG50Vfj1CdHTWrUbIpVPR8uu23Po6GeiNjeI77cbGwJO7kNvqihpyUDhRzDaGo4O4
         wFE/MDdVibzLslBgRiO28vSy0VHArplmubspnkwG1fZzC2A82+MsD/0S8vn49gbYVzpS
         C9nrillBy3yk+CAfX4Ae4Z4NEIBc9+nMRLdziSXOrQh/D+Z1aENb8V/cWAMKjImSWqND
         +Lkw==
X-Gm-Message-State: AJIora/KnxFCtzRFfimN0D06xPeP+betwuCPbFHXw39voj4P9uFFObNT
        7heEWRb63x4PBlN2vpp9xrWfA/Km3L/z1kB+VwQ=
X-Google-Smtp-Source: AGRyM1sxmj0EyI6+Qpt6J4Y6kaq4emP6TMRdrAW7Lgcdhz7lD7BE63Z32vm4gnlkCGa1R0saGQ2SVmtwNyEEEjwNmq0=
X-Received: by 2002:a67:c803:0:b0:358:5a65:fd27 with SMTP id
 u3-20020a67c803000000b003585a65fd27mr977250vsk.15.1659095911804; Fri, 29 Jul
 2022 04:58:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:2582:b0:2b2:4bad:2cda with HTTP; Fri, 29 Jul 2022
 04:58:31 -0700 (PDT)
Reply-To: attorneyjoel4ever2021@gmail.com
From:   Felix Joel <geltu800@gmail.com>
Date:   Fri, 29 Jul 2022 11:58:31 +0000
Message-ID: <CAEczkUfPGBa5XW0Qiz9O3ALfQcteuWEURtqQQ0DsQJcpcBDr+A@mail.gmail.com>
Subject: =?UTF-8?Q?h=C3=A5per_du_har_det_bra?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [geltu800[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [geltu800[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [attorneyjoel4ever2021[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo,
V=C3=A6r s=C3=A5 snill, godta mine unnskyldninger. Jeg =C3=B8nsker ikke =C3=
=A5 invadere
privatlivet ditt, jeg er Felix Joel, en advokat av yrke. Jeg har
skrevet en tidligere e-post til deg, men uten svar, og i min f=C3=B8rste
e-post nevnte jeg til deg om min avd=C3=B8de klient, som har samme
etternavn som deg. Siden hans d=C3=B8d har jeg mottatt flere brev fra
banken hans hvor han gjorde et innskudd f=C3=B8r hans d=C3=B8d, banken har =
bedt
meg om =C3=A5 gi hans n=C3=A6rmeste p=C3=A5r=C3=B8rende eller noen av hans =
slektninger som
kan gj=C3=B8re krav p=C3=A5 hans midler, ellers vil de bli konfiskert og si=
den
Jeg kunne ikke finne noen av hans slektninger. Jeg bestemte meg for =C3=A5
kontakte deg for denne p=C3=A5standen, derfor har du samme etternavn med
ham. kontakt meg snarest for mer informasjon.
Vennlig hilsen,
Barrister Felix Joel.
