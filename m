Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20F2576DA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGPLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 07:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGPLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 07:46:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFEF1CFF8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 04:46:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a10so8310323ljj.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=1JcPAqCYsOWJmuc/lX7lFBXu+/0xneYit2AH0/J8AO0=;
        b=nH4k76YaaAq53etNI3IiHVX9L3z5oJ7R6KihSNR9tXMZd73FjNE407FM6pBs4SsOpK
         3N81vMyMhEv+vW9wvGdigchZIGnDsHuWaynGl+woPNG5vrFxIi35+N2n1nwx/CaibD9c
         8Csbf7SEFbc7/8B5rd0Xhd7RXmCm6yU6ptIYJeDBpdKH8HLZNCQ+5GUj8E2g0T4+HG3p
         n7rwRXRKat1Ogj0nSBmXdcE233Fyaj7OkRrEE4Ai1JD5pD4LLKUIhf7lakSm7xMhC5Tb
         0hp3XNqjqhl5V17agR3ssNifxlTkjrOJPYaVR22Gcw+k7VP8+BWAvgtYn8ZUqtljuG/o
         n86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=1JcPAqCYsOWJmuc/lX7lFBXu+/0xneYit2AH0/J8AO0=;
        b=oau5YbalMIDPiKXPS5jsKnEg0jKvgllA7fwyDk+hk17jqxsXA8Xoxvja8XjhxI6yHM
         RnHsd4AWKhoQjwDoPMp9P7gmS9Q8OltwhFrAvfifPd9lY0jWEZHKxZvlhM+X1Qve0yAJ
         G2xNKX1U2GOZoqbbmT00R3WrVhA3DREIr0blFNq3pzqZWTFqPqxqDWB/zEyCU0DU1Uq6
         WahMpCgf7JHeekAC9gobxt+/TQAXNAOXXbcs9X/F6Nq6BRPCpBDSt+oqgiNjJMwgtRh3
         6B+rIOgY4kMZXlUAzAmOF8nlYBitfyvacIf5rP5I7pcu728Q3z6EKs9DusdqDGJlSRgJ
         fy6A==
X-Gm-Message-State: AJIora/I99PbydobzE4cKu8xTmX/dVoVr55rk8TSgLGzJps1wCzPNatd
        +RCouiJd/sIP1wY8rSop9W/VnRaHFVlXBdk4zgw=
X-Google-Smtp-Source: AGRyM1t/HegrZlpEAy0GEJwaBWaMFeLbbuZmpu72xFyyfhqE7UaMNWMb+X7GVI5Q8/+pq4Vcng9fHkEp4rJnNQ+B+fs=
X-Received: by 2002:a2e:9ec4:0:b0:25d:46da:2b7a with SMTP id
 h4-20020a2e9ec4000000b0025d46da2b7amr8366054ljk.300.1657971984381; Sat, 16
 Jul 2022 04:46:24 -0700 (PDT)
MIME-Version: 1.0
Sender: jamillahnoriah@gmail.com
Received: by 2002:a05:6520:408f:b0:1f9:59fb:a876 with HTTP; Sat, 16 Jul 2022
 04:46:23 -0700 (PDT)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Sat, 16 Jul 2022 04:46:23 -0700
X-Google-Sender-Auth: 3mX62FsF8oG9pie5n2xOBoschbg
Message-ID: <CAOvQhES5nq39v-V93EhcTsUDSSS+iVemY7Q7RpwjfkjQvQ-ckQ@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.doris david, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs.doris david,
