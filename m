Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3460A4CA0FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiCBJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiCBJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:41:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614435864
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:40:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r13so2457774ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=a665Vh1AQEI8/JHOaUtolrVCd5eUvzoKFIu0MORh4DE=;
        b=V+kDDNDBbkWYgbedXcmPEmuyhRIOPi7Wn09NUBJqNQyKxEvyKgY16ou+8U3YsO9TCr
         3y6Kns2qAFNGKDmZJvrWGkgPZnL3boVi2WbOCQbMYSVIdJw61ehgL46CHo32dYhPwopZ
         bx41H+zMqoi7pMPe6GuH1xmOWa4ALA0Vy3NDCoqJk0/0rUR2JyE3NeF2cqqojDGeArnW
         x261ZBGb6RyZU7nrhhQCqtC1/XN9QfsBwjNAkQbUAzNLHoISR6lP9amBQgQL/EQcbCME
         hP4rrUE2jb93WIHrUlPPFUVd7WpZKfbpYC7hBdWcT9n/VgmEI3au6BU/Zmk3s+KRqEMg
         zG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=a665Vh1AQEI8/JHOaUtolrVCd5eUvzoKFIu0MORh4DE=;
        b=cvcTCZS77x8xiGdrq5iO7ykMFizg48PN8uotKE4pcGoekpIWvKsCmeH50ZWix+FfDi
         BHHFjoc9ECkZcl7V8lpRilRjDmLlVSTta1GGY2ENJ02YFTX63rnv4UBCk+iTWuROaBGI
         E9/i9BSEPYfUAlzjaKp0Slkmt6BUIO4H7nnjj2PpSIuLmB7eM2VHbPe18JTwibKQoiQ2
         zCwMQOKEc3jl0ZiGG22MOBrJWhJwXg5Z0Wtxm1Teep3SaNO/7y4xhOVd2USLJ3Mjfb3Y
         MTMBCvneWgvOG2nTAyv48bvgYt4ELYBLCMv2A0DXw0CsQqFSUbGbw150EbheLMyhaYaX
         AMkA==
X-Gm-Message-State: AOAM5302d3JQPkCs+5RagMuEx2mY1tJ/q+7Wdo4DDKjvVEczMjml+Jec
        BA4AFhGYO2FiSBzl6KcCtLGDMnv+PNPRcA6qPAA=
X-Google-Smtp-Source: ABdhPJzY9KbaSzemk0bqXQSO8xXFu4X/3e8QXlmI3ezzctHJ8NvRN/pPy4WYtRBe0WF6gRLjyFrtkxRjvLZV/kmtGeI=
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id
 m3-20020a170906160300b006ce0362c938mr22421257ejd.253.1646214052790; Wed, 02
 Mar 2022 01:40:52 -0800 (PST)
MIME-Version: 1.0
Sender: mrsaliceragnvar@gmail.com
Received: by 2002:a17:906:1e83:0:0:0:0 with HTTP; Wed, 2 Mar 2022 01:40:52
 -0800 (PST)
From:   Aisha Al-Qaddafi <aishagaddafi1894@gmail.com>
Date:   Wed, 2 Mar 2022 09:40:52 +0000
X-Google-Sender-Auth: -2jT5061v7ng9L5iN0b-FsWVuTA
Message-ID: <CAGHGhXCrcT=on2zFmkhCq5_5MwVaqwt1rcK1D46BumR1UbchoQ@mail.gmail.com>
Subject: Investment proposal,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:631 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5055]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsaliceragnvar[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear Friend.,

With due respect to your person and much sincerity of purpose I wish
to write to you today for our mutual benefit in this investment
transaction.
I'm Mrs. Aisha. Al-Gaddafi, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia, I'm a
single Mother and a widow with three Children. I am the only
biological Daughter of the late Libyan President (Late Colonel
Muammar. Gaddafi). I have an investment funds worth Twenty Seven
Million Five Hundred Thousand United State Dollars ($27.500.000.00 )
and i need an investment Manager/Partner and because of my Asylum
Status I will authorize you the ownership of the investment funds,
However, I am interested in you for investment project assistance in
your country, may be from there,. we can build a business relationship
in the nearest future..

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds.

Your urgent reply will be appreciated if only you are interested in
this investment project..
Best Regards
Mrs. Aisha. Al-Gaddafi..
