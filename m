Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA064B83F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiBPJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:20:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiBPJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:20:29 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC262335E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:20:11 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so1756847oob.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KZmG6EDkoRdtUDauMZY2HVIsqlIFv5c+VrLstKC769M=;
        b=D6kFOOze/iMQrev68CDk1zdfuSqPXg3pdi6px5IWcVdLx9JFPVXJmNNjCIuAcp92si
         Ag1If6eq2e23cK1vGhVKlvu6xRtCbw7DY1m+UFqZa9SRTWXLLxx5XlBQ4pNGflLukzCL
         vjL5Z0xbM1vhCquxMkCmtb1t9dvRigrzWA2yKRFpEx0SP51cwkjtT6KxSE1QwnljfOFX
         9F6dmBn7a4KiYZvUbhjm5y5NmElRsAfvrltD+1JrHHCw1w++F+RQNfQOzVG5D51RIyYc
         cA3aXvvIlA11WTCyfLCncqLi81vOOUsdW2dDqx45S+Hh8v/I0G7wE3PsU/ttEuMQBCI4
         HoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KZmG6EDkoRdtUDauMZY2HVIsqlIFv5c+VrLstKC769M=;
        b=uNUktyBzDIbRqb1wTEMpct35jB7M6Y180hDOuMRcR8ji63+AubqyEAOWbrJkACLjiG
         TPeGLqrtat6IbyCGkuJVdMYYWyi1gMDgb3xPaT9x2q/DF0dPpjX4fsGJWYksL3A0ilTQ
         vdiUQZWEpCmd/cJCc9LAXS8sMgphhN82siVYidAm3rvlIzDOuhjdaPmcY7vjHViHyaH5
         c0I406g7ezG/hDl1vmz6Lp5c5S2hFPp7OWNbC24BBMSM8szgwWjL1CAhAXP8dLEB33qr
         esWLR16ywuW3iLcL36byYSA7wOl1hla4kUWc8rI4cJWFfoTH+HYpetR6NE7BsunsbJUn
         d3BA==
X-Gm-Message-State: AOAM530tJ7MQJ1w67OXCiJjrkjYI/VD8k9g2S+bqQcUH/l5BsxCnPNUN
        LRFPZLybbYyn//jMzs8dnyR4IdZ3AY0wRoPfPGc=
X-Google-Smtp-Source: ABdhPJy3rA1aigmFSHSspbIOgep80fh+UxEjR3AUFFtS2rCFzUGMzo5Y61pWmOyxI6X2DP2jipr2xNHUpaoAA7tx7M0=
X-Received: by 2002:a05:6870:596:b0:d3:5287:5567 with SMTP id
 m22-20020a056870059600b000d352875567mr170630oap.38.1645003211028; Wed, 16 Feb
 2022 01:20:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:9731:0:0:0:0:0 with HTTP; Wed, 16 Feb 2022 01:20:10
 -0800 (PST)
From:   REV FATHER NOLAN <glblscrtsrvc@gmail.com>
Date:   Wed, 16 Feb 2022 10:20:10 +0100
Message-ID: <CAH1WQQM9RaCzKc-qDyy7AAp8cWgjGgUPGDj3nXQA1aSFZaWCVw@mail.gmail.com>
Subject: REV ,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLY,FROM_LOCAL_NOVOWEL,LOTS_OF_MONEY,
        MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.5 FROM_LOCAL_NOVOWEL From: localpart has series of non-vowel
        *      letters
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [glblscrtsrvc[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Beloved,

I'm Reverend Father David Nolan, I was born in Brooklyn, NYC, 1970, I
was ordained into the Catholic Priesthood. Please take your time to
read this message, although we have never met before, this is no spam,
It's a real message sent to you. I know also that you will be amazed
at the level of trust that I am willing to place in a person that I
have never seen nor spoken with. I have been a catholic priest for
over 22 years. I had a heart surgery on the 23-11-2017 and the Doctors
have informed me that I cannot live longer; I had a serious bleeding
after the operation. I have decided to will to you all the money which
was deposited in my bank account by a dying elderly woman in my
congregation the total sum of $5,970,000.00 (Five million Nine Hundred
and seventy Thousand USDOLLARS).

I want you to use this sum to make the world a better place for the
poor and less privileged, help the needy and also help your family
members. I took this decision because I was raised in an Orphanage so
I don't have relatives and presently, I'm hospitalized in Cabinet
Medical Le Sacre Coeur, where I am undergoing treatment. That's why I
have decided to contact you so that you can make good use of the money
which I will to you.


Regards,

Reverend Father David Nolan.
Email : rev.father.nolan@gmail.com
