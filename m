Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD75579B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiFWMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiFWMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:01:37 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439E4E3B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:00:22 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-101b4f9e825so21862495fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SH1826VGivRTcWTFt6CirTUpizldtIW6lapFTxm7Gbo=;
        b=dL4ZdfjGobK7bZ5zNav1+xGQiGde1Zc7ClvHsT7kk6LqobgfylVSX6CBG5RjcoVDTa
         P464n62qmhgQVmko817GDYihyl7pvjfwkgES8JkCRGmr9xxgu3PjHmBrdfIKpKF+gxtz
         ck0sfdPmzNP6PJDK99aoAJqvIJ6MSx5TfjB1KlqaDZn92DOWiz08x3njQYk7p7AUH10T
         y+GlFokIsHaKh5IwUNZgaGJCE9OJ9vSfBgmQkTnZzySftM6HqqxRqpOIYwT/wd75+23E
         P9+fpjMOoHjPoNoGgly+tjBN6a3v4kxdZSCYsYXbKgVUjjGIp5B1Lh0sXido0MvDOb61
         P1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SH1826VGivRTcWTFt6CirTUpizldtIW6lapFTxm7Gbo=;
        b=C/hjyhfmSWhvwO/j3PEGH/Cr/Sz7xO7EH9EOp6kDRMgHVbEyR5EaL9pa4Ojt/nirjd
         Ov2wktQ/7jvy+SA3CZ2X6oHePF7d8To/HgzrVAk1guXoKUdUWAZ+5/nm+s42OtDbUpuV
         5e9dvQtUzIClke9fDAeP42nt3rEMF6gut2LKVGORWGDu2ZPyvKeP8TpL5H85lNK5H6S6
         FNVepOq8jAOwn/1/Cytnq1s4oi34OYjoR/rP9FsrICQRR72jlPz2HX0NHe6ClXlCQ8Fk
         I3qxIll6r81pqlnP9Qh2slTldjbLFhkTkBWCceYbeb+mde1WwkqIX4fkSEGCi63zBrLy
         2eNw==
X-Gm-Message-State: AJIora8HCCKtnjMYHhewYAXJ4V8yilal8V8bLhW61ilqf6hsX64pi3OW
        XB1z/PysrBBeNAfE/Bht1PAc4bT9qZNM5AnVrIk=
X-Google-Smtp-Source: AGRyM1u9XqAMSItZNhegX/ZymFvhNBQP3xenHiWf00X4SNsH0rLed72zRQSP+YVxHt9F6Yhn4fsa6RzBdFD/GHKyBzE=
X-Received: by 2002:a05:6870:311:b0:f2:d46a:b370 with SMTP id
 m17-20020a056870031100b000f2d46ab370mr2282258oaf.169.1655985618110; Thu, 23
 Jun 2022 05:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:e60e:0:0:0:0:0 with HTTP; Thu, 23 Jun 2022 05:00:17
 -0700 (PDT)
Reply-To: ibnahmadmustafa.aseelfinance@gmail.com
From:   "Ibn Ahmad Mustafa(ASEEL Islamic Finance)" <alexaziz900@gmail.com>
Date:   Thu, 23 Jun 2022 13:00:17 +0100
Message-ID: <CA+ZonYFVf4r4TP5OjTABRM+sUUb77Yi8rA2ZjaW7-M57GTtrGA@mail.gmail.com>
Subject: LOAN AND INVESTMENT-ASEEL ISLAMIC FINANCE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_60,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:43 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7771]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alexaziz900[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alexaziz900[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir/Madam

I would like to introduce you to Aseel Islamic finance PJSC which is a
private joint stock company that was
established in 2006 and has built a leading market position for itself
in the UAE's Islamic finance market which specializes in loan finance
and investment activities in real estate, hospitality, industrial &
sustainable technologies, strategic financial investments, specialized
education, healthcare services, agriculture, manufacturing,
mining,energy and additional environmentally sustainable projects.

I would love to send you further details with your consent.

Regards.

Mr.Ahmad Ibn Mustafa
International Business Coordinator
Aseel Islamic Finance PJSC
Telephone: 800-ASEEL(27335)
