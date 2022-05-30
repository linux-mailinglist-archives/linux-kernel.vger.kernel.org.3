Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB884537564
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiE3H3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiE3H25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:28:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632EA712EC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:28:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so19090902ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=B9L6G9B5eN5Puf1M+NouHaRWrtqC0JwMcCfdy6UJJdw=;
        b=OZAJcflM2iCm/RirirZn6iQLv8JoxceKnzSyEZOVBh9Y5X4tQv6eEqSgriPvTvEFeW
         2WGqsMGgNlHndmG2QSC/MKZ5ZnDHEzcS3ytsDmS9rpwwsLZN3YAK65gUae6Qijnd8i1U
         DmncVSxdISrEyJdlw0YBawdSBbHsL1689HJXDH5JXec44H3Mp/ucc4YdJ9ggWw9v/sM1
         iD7Suoad9+WijBFbIaYegzSz39ywYEcCJC/ukWczmjtJmIDHaf+8Y3b21h/QTXWYCFQM
         islnukRpLYO5FS8p4DEMaERmMZ5coHAA/o1bfue8Feb96Bzsg++gVeQVqkMeOMC1yv7a
         ewEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=B9L6G9B5eN5Puf1M+NouHaRWrtqC0JwMcCfdy6UJJdw=;
        b=dRZuAhR43QpIi4liFIbuTn0RRrN0SVt0sRaRWRUwJJ9jq87GK/BvN/qcBpYAUpayLF
         Tbwe8eFBCL+8OltnqvGE95Wh+tXspXtLJc/OjWd0SRSKX/XJIN1OTZ1WcrH/JtH5iDGO
         QCS0u3yCl01MBp+stGELWgZtC43cMgN8kyKUQ/fM2XtQJXIVI88dbb4hVNG1Ysm1KKpM
         RaGfidii+OQ3JqsnxZTZ1onsKHLw2SIxwv8jI5tlZHDE5MfZKb3oHALk4UMdhioAEPei
         TPxYgOm9/tL2QQB5kzvFcNWaTDIUJM+inNRNoNIZrtJX5jQFDaZQAdFTrYujs+aoiGoi
         EaiA==
X-Gm-Message-State: AOAM532L4lo0OiC1yD/7paTyKTc0NSW0tFgsYSX7Yyv242GiRW7uU5bi
        4JTtSXV9zcyyYDgzVhvxYo2kHj8BGI9/i7xY9tU=
X-Google-Smtp-Source: ABdhPJx06eC7ZRIEhMwvrpvvZypSQUPxZqgrqNwJlD7tZXX684pB/M2vrLv8fhHsCJazKG6RDHmbgs3XcpA+Jaz4BJQ=
X-Received: by 2002:a17:907:1b1c:b0:6fe:f1a9:ef5a with SMTP id
 mp28-20020a1709071b1c00b006fef1a9ef5amr30705728ejc.233.1653895734352; Mon, 30
 May 2022 00:28:54 -0700 (PDT)
MIME-Version: 1.0
Sender: djmacdon5@gmail.com
Received: by 2002:a54:3b11:0:0:0:0:0 with HTTP; Mon, 30 May 2022 00:28:53
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Sun, 29 May 2022 19:28:53 -1200
X-Google-Sender-Auth: -8KVmABulLFDQSmQ1unOy3FzCUw
Message-ID: <CAKGPEqiQisc05_3K6opmy=woSPTHo_maZF+E7X9W_T6cL5FjAA@mail.gmail.com>
Subject: Calvary greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9980]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [djmacdon5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina mckenna howley., a widow. I am
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
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Mckenna Howley.
