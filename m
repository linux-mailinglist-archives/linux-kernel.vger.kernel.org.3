Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB051718C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350442AbiEBObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiEBObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:31:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538DE006
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:28:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so19771627wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PQJ/katdNCiV6NuMD6Q8JYHjEJO0fdOai4gF5RPTvuA=;
        b=egGNYKxYxioAsa+M+5MDNCxNunG7MPC0Qtz8jwhkVOJL7pcWe8h8anLOvdsHso3az9
         mtspTPjIOB0ETM2hpRqTVwEKPUNYtTP6gCe6lnMH0ib9YCCNV3zvImoKAP5xSdZ2ZLd8
         gjdC5SX6tAblz1pIxmcqWmpOzRSyB2UAMA8QPwVwn3Jt/4rwiORAn2jchnczDJLdZVF7
         yJvR0W3FBaen4SR9hilNuCEOm0yPOTcZuPP+AtDEMrOhAPiDJHVXA5XHghy9TPqEawFz
         BEmfaVzW4r+pD5wNYui6t4ws/yM25n62bVyqmRePpf0VUnG7cYkFdqcRl3pbeKqHiq3P
         YQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PQJ/katdNCiV6NuMD6Q8JYHjEJO0fdOai4gF5RPTvuA=;
        b=Ex0ihs7zZ5VaPtKSsRABys/WqzLVA6VOQswBd9ZH+bfVBidg8YP49wTY4h0hpN7cJY
         lQ14yiiId+iZUkbaVd4ST5ESq3/zmn1KX915fgp5g6tb+tZLo50rhSPd1jPetH8tFzy2
         rK34s6eejokUdEhVCqZuA12C5PHtRbLnK/SbyzJcpO+hbC9g4nkLVyV9qV6A9akomjtE
         JglfwiivfQXkGEODLJa1wD0okOkxdHuzYrVPeyrYaO38BmS1m9jdun5tXdVUIzJrPu+z
         7YeLWrNNtQKg8hh1QxdzUmhnm35+XuKmD4mXd80VehJ3hlo1krq8CdwSCwZhKMChTSCc
         yveA==
X-Gm-Message-State: AOAM53054y8EyN7S1FVLhBOx6k4xzwT4gyG9/dbJw3ImaMGSSS8ZnQuL
        sVjqK+7I/Saz3UDAf4djDQN5VoacYh/CmSG6kXA=
X-Google-Smtp-Source: ABdhPJw3zlSpxfBUZfcd441g4Y+/+8zdDOoMBi7bBret895gql6EwyHwo4AkVSPyMTa2yVH6B/BvcvGwbbjMBCAm6E0=
X-Received: by 2002:adf:f783:0:b0:20a:e0a7:6c33 with SMTP id
 q3-20020adff783000000b0020ae0a76c33mr9414136wrp.187.1651501693397; Mon, 02
 May 2022 07:28:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:168e:0:0:0:0 with HTTP; Mon, 2 May 2022 07:28:12
 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <antonioman388@gmail.com>
Date:   Mon, 2 May 2022 22:28:12 +0800
Message-ID: <CALR66yoqhQvqkR=yxbkHAoYwZwjJP1cqLXn09VteF22OPv8OZA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [antonioman388[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [antonioman388[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands
Call:+3197005033311
02/05/2022

Atten:

RGI Genealogical Investigators specializes in probate research to locate
missing funds, inherited funds around the world. We can also help you find
wills, obtain copies of certificates.

Recently a woman from the Rothschild family, one of the famous families in
Europe contacted our company that we should contact a business minded
person who is capable of investing her funds in a lucrative business.

Our service fee is 2% of the funds and we will be paid after you receive
the funds. The funds transfer process should take just a matter of days as
we have the mechanism and expertise to get this done quickly. Please if you
find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr. J.T Woods, CEO
RGI Genealogical
