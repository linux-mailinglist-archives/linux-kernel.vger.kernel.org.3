Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8C544566
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiFIINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiFIINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:13:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E825F246
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:13:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fu3so44413617ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=EV/DomxXS21W3StJ7TvuHijfw2cs47/ctB2bRMZrMuFXc5UMH7tKjjR9uSqrRQX3Nb
         Yw282h93xRrPEcW3j3LPkFdGcq2+qHJLpKPx/AP5xFXNfBXStWZ1svCG/BFbXhHdb8GS
         Ycbvm8piP9LqsEXyaatybKn7hGXqnzl0pJHzvrwjwxl4XUMeRVYhgLw7YiwdR5G/wlWn
         kgT+x7mL1Fr0URTg+AGyKVtVS/dZsG4j4OvPT7yjNDla4nF/HZdtsH8jEYgizwEjx+Qf
         c1PcU1eyPBc92HP1qOHccRZEMPmUeAQXn9nKp4dnwAnFg8mKncGAVaz/3+2x4miK0nSh
         XSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=4VgmW3ewxoj/DI6hRQ4D1sPbxdut5bF732o+NtvV2h6rQrlaGxhrMTquJVJKQ4itun
         UoxGMktGhxe27ZE7WNfvvUHIfgUvvLRNNI7PnSNj3D4XPKf/8nkGZdU5uBxMBpS/iPxY
         MDKcB5LNrGAG2xoc7btFT1RUNM6JIWCpadzjq5vvPAQKbLeiFZTctPUrom8hqeKco/nO
         GnrWqzOqOOdBE9qNv//VFjFQIvnU5DrAQ3l0laju4zqyCOGOYeIe28YgSCznIb2bM1oK
         mDunZRucuzqKRc/ppDYQCkm8uNMaOHNwYl7X4D6TwVxplnhqOg4hei/FgESil0iPmpWm
         HVag==
X-Gm-Message-State: AOAM533QZ/WfvrHBXPq58QqPEFwvWX6c6XniXs7IH1aFtD3aSHQdRYfK
        vnaLS33YHxGW4rgmWTl6Dxm2zBUTmri1/Z3jXAg=
X-Google-Smtp-Source: ABdhPJx52pSKtX9UrbCcV85SCVRZ2WwxB7gUs5FO1FCc4sV0ha9ILIDbtBg9ouBgsGiWfGceFdlLaF6Gol/LNuFeVtU=
X-Received: by 2002:a17:906:1d1:b0:711:f5fa:4114 with SMTP id
 17-20020a17090601d100b00711f5fa4114mr6011996ejj.228.1654762394663; Thu, 09
 Jun 2022 01:13:14 -0700 (PDT)
MIME-Version: 1.0
Sender: wizguy687@gmail.com
Received: by 2002:a17:907:970e:0:0:0:0 with HTTP; Thu, 9 Jun 2022 01:13:13
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Thu, 9 Jun 2022 08:13:13 +0000
X-Google-Sender-Auth: TlLqc5Vp0z6MsN3wlkxkKM4cuC8
Message-ID: <CAGNBjBecnha7R_Do+BG9ePEJ7bPMd2isSsGL34J5Q-vtQG48tg@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7139]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wizguy687[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wizguy687[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley. Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Howley. Mckenna.
