Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6734950EDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiDZAuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiDZAuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:50:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4BF82D01
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:47:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i24so16401590pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=P2gJFoNE7dWaixmeGlxYfGsObAS4qye3UoGLh55I8+s=;
        b=hrXgGAHkJW/8lnrjLX0l0PEpIcgMjRZyi4IH2jnt4WukfLMQiym/u7D6xcqD6+srbN
         EEcfwXdJ5zMdR4myQ4dsVgkFGv6tV12ojWqF4z/PPHToUk0IHVOLXgwqwmQdv5vGxP5T
         G/E+7RbEwOd8MjgQc/1c5GLAuW7nED1U8wh5gQZfe1eTextxPshD+h+3LMaIBiFoHkxq
         AJVtXI/YdfBYGpt9+6P3ZRJEE9wIrnW6/69DTjpM9qiIAv81wos539XDu+KoTLEuNzor
         7ESzEO582KSzU4mwaO1thFsvK/Knsl3U5xWRTDD6FuXVdr8Yi/8sUr/zvo28HYpQs7hJ
         XB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=P2gJFoNE7dWaixmeGlxYfGsObAS4qye3UoGLh55I8+s=;
        b=2XpzURpFx5rCz5DJk+MMss5x9FiwpJloAsU0H2Ti3JU8msM+m1X8bVPZzJ18r84Zob
         RQHp+qyr1zlp+Le5RivkfsTfP9Uct+zUDyZedzqF4wJYQm0l0fpQZ1E1fiLAES+zjch3
         hl9yYG5lpC4Pf4MgE+EmS/iJXeavbyeXD/C+hqTVdW9f+Fmc/8A4CL9za5+Bl5m8Sei3
         d48iOjwHGGOLeGO5/Rb9lhYc2UUPLxm7xJRLtgSSj6lL/YUzb/cJl7Tm6IOP1dor2Fir
         cryYP8LbLD3H9FA7BaYyTkj7PxFLDAK013fRZ6wP1Oecyo89upp1hpEp3WaOIaTw4keb
         h/6w==
X-Gm-Message-State: AOAM531790ZBI7y3mC+e9B1seu5oTV9DFE04LpTwxStAbfvf7ff5jGii
        ZZMASEKrbp0T5VxYp7M4C/EHdZ2ocbNyYUWi2QU=
X-Google-Smtp-Source: ABdhPJx5ZzDaOnmPlwQGFvAEJ9xW+EW82KQ84gaYfymMbFItW746CvvbNauAA4Eq3JRQfEwFioEu1olMyG2mp7XH3gU=
X-Received: by 2002:a63:914b:0:b0:3ab:48:8a16 with SMTP id l72-20020a63914b000000b003ab00488a16mr11082254pge.617.1650934029900;
 Mon, 25 Apr 2022 17:47:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mcb_213@aol.com
Sender: aminukabore774@gmail.com
Received: by 2002:a05:6a10:87d9:b0:288:44f8:f22c with HTTP; Mon, 25 Apr 2022
 17:47:08 -0700 (PDT)
From:   "Mr.Roman" <rm2568590@gmail.com>
Date:   Tue, 26 Apr 2022 02:47:08 +0200
X-Google-Sender-Auth: aZ0Sd3gocePeXmsntsDJJ_DfXIc
Message-ID: <CANm+=4cM72ju5agMOjECOqoedQr9Fa++Z97KFNwMKoD8E8xbpw@mail.gmail.com>
Subject: I Need Your Assistance
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:434 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aminukabore774[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mcb_213[at]aol.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aminukabore774[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20


--=20
My Good Friend,

Before I introduce myself, I wish to inform you that this mail is not a
hoax mail and I urge you to treat it seriously. This mail must come to you
as a big surprise, but I believe it is only a day that people meet and
become great friends and business partners. Please I want you to read this
mail very carefully and I must apologize for barging this message into your
mail box without any formal introduction due to the urgency and
confidentiality of this business and I know that this message will come to
you as a surprise. Please this is not a joke and I will not like you to
joke with it ok, with due respect to your person and much sincerity of
purpose, I make this contact with you as I believe that you can be of great
assistance to me. My name is Mr. Roman Arkadyevich Abramovich (born 24
October 1966)I am  a billionaire Russian oligarch and politician. I hold
joint Israeli and Portuguese citizenships. Please see this as a
confidential message and do not reveal it to another person and let me know
whether you can be of assistance regarding my proposal below because it is
top secret.


I am  one of seven oligarchs sanctioned by the UK government over the 2022
Russian invasion of Ukraine which i never supported, including asset
freezes and travel bans. But now as all my acounts and valuable assets have
been frozen and conphisicated. There is this very account i opened without
my identity and now i cannot claim it with my name and identity because it
was opened in an escrow account  in a bank in Africa when i was scouting
for good african players to play for my club Chelsea,the funds in the bank
is (=C2=A3250,000,000 million British Pounds)two hundred and fiffty million
British pounds.This is where you come in now as the beneficiary of the said
fund because i left the space of the beneficiary open for me to claim the
funds back through a trusted beneficiary like you.

Please if you can stand and transfer this fund to your designated account
as the beneficiary i will back you up with the neccessary information that
you will need. I want you to know that this is a hundrd percent risk free
transaction if you follow my instructions there will be no mistakes.Once
the fund is transferred into your account please take only (=C2=A350,000,00=
0
million Pounds) and keep the rest (=C2=A3200,000,000 million Pounds) for me=
. i
will inform you in my next mail on how to invest the money in your own
country.

If you are willing to assist me on this i will feed you with more details.


sincerely,
Mr.R.Abramovich.
