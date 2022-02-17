Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E94BA174
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiBQNjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:39:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiBQNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:39:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D02AF91B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:39:37 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f10so511743qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=yrcvHz2XUZ1aK+nJEnwTAP7QQGaydiJXeFH1EG3kH+k=;
        b=eLF3rbZJDOgpiNirfFEJD7DaNVLTwtfTyT7T0S0+26OJ2OPU838MS+AzesjjmC0Z3L
         sENNtXhp25twgFgWjoD0gg+pXkTHlc/HBBn6sz/YVpOjorESqqCIODUBivgOj0Dtr1xh
         1dxNJc4wh1hnxM1j5ugZAYz1s9pBlG1NcnqXRK4XI/EMWrWIdomoNyXI2Ct5yj0IfQPw
         hMZHDSkqVXQvcDMvx6fE5oZ8IA7wZnl/xGdjgsma3u4Qh007hCEIklllP2+u3by9d2RV
         lg4smSnVeMRIRa6FrRpva6dlOzecNHwOhCsv0nMH6IMlZXM1ZRo0aP8Nea4BDNSimy2d
         VfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=yrcvHz2XUZ1aK+nJEnwTAP7QQGaydiJXeFH1EG3kH+k=;
        b=aH7TZtbShvPCv4SUlVkq+443+VAfEqOuoLFwJcbJTMoDiyPWj1ntEFPAr+M0YBTxL5
         FQ7xqsw+XxxrplIbf3W2qcKTjvnxuZfqi/V8dwlNo+3wqVU3PU+Ok1ksTl+MFRUFH6om
         5WExpVwgY6pdKCqUiuGvTwGDyBpQpMRmCV/uo3mXHS7YRzblDNZLp044i6s4P55aRLR+
         EKcFDSMIgp2jYJGb/K2Iqz0n25OVPzpGvoCO7S3S7Cjpo5owdfiDCsPE9MKhWxT/ZdLz
         y4l2Mky9ABlD9YfSoU6x6GcvoV0Kj+WvZ0qdBcaA9BRIdSF6d+MXoHEcYoziFbJtymvK
         KeaA==
X-Gm-Message-State: AOAM531Laf3hh3jX5tqta0nkSZytuVXTjcjj+5zN60R2D1HQGbfGvqPi
        884LkhFZrECEtm517uOmyojBt7Y7sQwzu4qWRRY=
X-Google-Smtp-Source: ABdhPJzgJMpmGLiMX9YDGUTkuOq2BiG35r4+G7VOaALP7dtt95XsQApQ/slsAAN2Of0meq1mUsZth+BL2N93ZINvvfc=
X-Received: by 2002:a05:620a:1724:b0:477:b038:75cc with SMTP id
 az36-20020a05620a172400b00477b03875ccmr1514196qkb.573.1645105176338; Thu, 17
 Feb 2022 05:39:36 -0800 (PST)
MIME-Version: 1.0
Sender: drrhamasalam8@gmail.com
Received: by 2002:a05:6214:623:0:0:0:0 with HTTP; Thu, 17 Feb 2022 05:39:35
 -0800 (PST)
From:   MS VICKY WYNSLOW <wynslowvicky@gmail.com>
Date:   Thu, 17 Feb 2022 05:39:35 -0800
X-Google-Sender-Auth: ilta8vVZ4zLSDTXszuH5pkCtHEI
Message-ID: <CALomdBYSBpeB7GazCe0_e+jHZJV-TVm7nUqvospTiGoN=PTywg@mail.gmail.com>
Subject: I NEED YOUR URGENT HELP
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,GUARANTEED_100_PERCENT,LOTS_OF_MONEY,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:72e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5515]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wynslowvicky[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drrhamasalam8[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.7 GUARANTEED_100_PERCENT BODY: One hundred percent guaranteed
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.8 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you,

How are you and your family??  i hope i can trust you But first, I
want to say thanks for your response and I will like to use this
opportunity to let you know about me, I am WYNSLOW VICKY serving in
U.S Military Base in Syria after we pullout from Afghanistan, and I
have a total sum of $5.9 Million US dollars I wish to use the funds
for investments that is why I seek for your assistance to be my
partner. I have contacted you in good heart and the main reason why I
have decided to entrust all this funds to you is because I am a
military officer, we are not permitted to transact business that is
why I request that you help me to invest the fund, I want us to use
the total fund for our investment with you while you take control of
all investments. I am offering you 30% share of the total funds, I
will be coming to meet with you later as soon as I have a
vacation,although I have more interest on real estates.

Note that the whole process is very simple and we must keep a low
profile until you receive it confirm. I will be free to Travel to meet
you on end of my Foreign Service by February vacation I look forward
to your reply and co-operation. But before then, I will need to send
my funds to you from where it is so once I arrive, I will go into
invest straight away. Like i narrated to you about my proposal to help
received the amount I sheared. This issue I told you is 100% risk free
and its success is 100% guaranteed.

i want to move this money to you over there in your address because
his money is not safe where it is kept  and the procedure is for you
to send me your details such as :.

Your Full Name........................

Your Full Address.....................

Your Mobile Number..................

Your Home Address..................

P O Box ......................................

Please send me  your address as I required so I can forward to the DHL
Express agent who can post my package to your address safety as it was
been register as a family goods and convered by red cross sign.
Please hurry up now and get back to me due to time factor  will be
waiting soonest I am hoping to see you in nearest future.

I wil send to you my photos on whatsapp as soon as i get your response
with informations details.


Thanking You .
Faithfuly
Sgt Wynslow Vicky
