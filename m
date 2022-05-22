Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C649E530550
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350211AbiEVSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiEVSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 14:54:17 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07FA28E1F
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 11:54:16 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id a127so13035495vsa.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=pPeK6CqbM118bIQrH1SZlypxIQET/K0xmeb+PYKUd0YoY6Xk5obyQW4xT3KYjwQoF5
         FYsYSaY+8605qTVi3Lq0+EXRhiSGvcFGwXXit55iVSSLaUBFmDp1MOk9Las3m9/bF66u
         qaBtWJLSsr1JZfgAV/EhM5oiqm2Fs50OOSB1IY6do5lCEYxy22gUbrD8TlQ1KxSFMvPK
         VQOBF1YHhVY3vdzaWMhA12mXxrnRiuRr8MEBVuhyGIRe9TtiozW1LvcedZa0vrA1dexU
         HCsrGbCcM6ZfjSOkcM9NtcVT2/BzIqu+Sm1fbd/MzYMLzYk9j/yoPDuCs/YK/Sw4EYmi
         Va7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=vQcZmHX3YchLfIYM9Mdaoq5lmM2BNXFAJEvQif2feAggrHQoW+3sFnVv7AmsKh2MsR
         oFpyDNPvyKhluFcTuboq54/DVaapGNqM5bK/WNQgK9gEMnv2pLa0XSvb9Cm3CFUlZNVt
         aMUkaPzZqcoe5lcgXjMm6PRBbR7lzcZxTowIlnSoio58ahH8dtnmPR9yUeAuipB1n7Pe
         0BYXR4wSFUeChcZnW1XKhQ9+3GQRo6sNdg/74LWr9LZeTiDLa2edO3KE3LltUMHlw2aa
         su9MByojl87+uKGaXNR5Ni/+24xYDMG8BrxcPzySxQw2amzjgMmG+jqIGCt7QnqW+lLq
         BRwQ==
X-Gm-Message-State: AOAM531ZZTO0h8Hi9y/46r5O7xAUhrJSz3GsZvuBCKZqeLE5P6hgdhDW
        f8Ded/BTUMCQu/V4IVAS4m9v5drS7s9AsWq56eE=
X-Google-Smtp-Source: ABdhPJzeWGaSWwnVmLCsJvzYoDkDU14wh9sxSA0X1C9aUNDyXlBDd6xD5/1aGO9icsFFCr5kIcuefzoAGq1gZmccLzU=
X-Received: by 2002:a05:6102:e96:b0:335:f2ea:bb84 with SMTP id
 l22-20020a0561020e9600b00335f2eabb84mr5307143vst.77.1653245655979; Sun, 22
 May 2022 11:54:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:ab88:0:b0:2b5:6002:bab with HTTP; Sun, 22 May 2022
 11:54:15 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <okoriemartins632@gmail.com>
Date:   Sun, 22 May 2022 19:54:15 +0100
Message-ID: <CAFgZtccGYVM9uWF_T7FF-g42FZvSGvanfXJqHVk1toVoe57Mvg@mail.gmail.com>
Subject: SICHERES KREDITANGEBOT BEI 2%
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [clmloans9[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okoriemartins632[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okoriemartins632[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Mobiltelefon:
*Land:
