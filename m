Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E468857F1BD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiGWV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGWV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:28:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823A19024
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:28:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t3so9622065edd.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ZwzSWKe8aJcF2q7NRCCrMkrvQ9eS4Q9joDzntgIKPec=;
        b=dGEIAirjeq4hn0Lu/p4fisE6I6+eFjKTUpDdybHpor/jtWTLX9DxgmUfiFRCjqweth
         pai98lC5v8hMOwbR9nipN7afjKKOA1zXsnc5I1IowQ+PC4ZuX8o9q03MztaHrownhLmK
         LfBOOrz8/K3I0C3vhH78yvswWvqoJdBCd4BUHT5bWv7kCe7ThQ/9HCMuPv/JJKujXkJb
         5Db5zUsRKseD6PF4D+DU4QBmJNpbsOazypAC9Gt5QOjn6+vO1+QrPc1pDpBW9zrBW7Ou
         /16/yWfOuP4YGerwJ3i8WPxVyW6YydEGCxjxBqeaDnWp0rmM1Iph6XriVm1GEoYTLBYK
         3icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ZwzSWKe8aJcF2q7NRCCrMkrvQ9eS4Q9joDzntgIKPec=;
        b=c1WdqfSvcBCx+ImHGUtvU1J8zl53OfFdGOMkjNnqWydoSCV6N4morc4UIW100fUUYw
         G7M/wjVfGqGz27i0NpxmryxNnzGJN1MFOy6U14XIn6XjVjhg/16JMy6jDrhZDjJndak3
         a867x/RkwtPRM2Bb6r0V388Xf59qIlrvpnJl7IBT9HPkSr+5x9g8jjwd86556AgFLHV/
         jR5sbCiawTa7sooMcRH61Hdp5gy3JalfN9OLYWoXXraNWSzcvOOt+5hplUnelBizkSuj
         mfgK6o1YL+avFd0Sa4c0l0+6LfOhO2yAC4WHfsWOIoEZtvnspYp/n15bpgocgszsKMe+
         +n8g==
X-Gm-Message-State: AJIora9jAVPiK2rxRFFDFl7JrWNgJbZ+PRFbXmb3beW+eUCZc5N7ydDC
        Tm274gmr5urWSMhbmcaf6Fwf1gbHZLo5+2uK6nQ=
X-Google-Smtp-Source: AGRyM1s1N8f2Fr1QpmgcfHOwFkIMhFPHTWpzWv4lE20IHg3H1RPVklyk8zQQ11TebjSEmyhBtsDQnhLx4cZYNCe026s=
X-Received: by 2002:a05:6402:354a:b0:43a:d32f:cc62 with SMTP id
 f10-20020a056402354a00b0043ad32fcc62mr5888082edd.48.1658611733949; Sat, 23
 Jul 2022 14:28:53 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem02@gmail.com
Received: by 2002:a05:640c:1f06:b0:179:6aa6:f7b4 with HTTP; Sat, 23 Jul 2022
 14:28:52 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Sat, 23 Jul 2022 14:28:52 -0700
X-Google-Sender-Auth: EL8ZS2v-CDlENkdLbYp5KW4AYiI
Message-ID: <CABBDEbgKCKTPTnn2eY2-SMXShXmwDG4QX06YjfyUtiYRLNyG6A@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alimahazem02[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimahazem02[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
Mrs.Doris David, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
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
Mrs.Doris David,
