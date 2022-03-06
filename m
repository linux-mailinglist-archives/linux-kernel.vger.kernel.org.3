Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488BB4CED4E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 20:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiCFTJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 14:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiCFTJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 14:09:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D324F1403F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:08:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c19so7365023ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ekX1HeYmlTbn5JJts1f5vfJ6fK+fJd7WHyLZdDS3ca0=;
        b=MpBsPdEVPvd04hQ+6lZdJAnXyjeRH/7dnIxMp1pnx1pZ73EuxRQJJZWiwgaRs4nh3x
         jzdiNtn+8vnmTzqqk5PafwJNnJjq9AjWKQYyhIaR495du2RKA/bmr5pgJVG4aLNR/bec
         cBEDdmgQ75FbeMMwbp6Rocl2nPGtgfNGFJBX/SNxTJFWVsNdtaU9lH9JG529FPGvriI2
         h7+AyyiOt8zT3ybalnMcqpDLNx/J8XoleDtEUXidvgvmackLPu8uYeo2TP3LewpPDRMw
         mLCFG/DRDi/nvpBecfaOzaJT6hUOnYIfqvTisrpFb6S3ceeZAbqBTYY4WDSjeNmV/5Z8
         5zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ekX1HeYmlTbn5JJts1f5vfJ6fK+fJd7WHyLZdDS3ca0=;
        b=sxjr236e1hfuX5N1Xids/XmVzrUoaGi/ee5jTSRtJYc1ZNWLq/AM+BKXs3pyfeapI0
         lD+74RZQmHi+PFIyMcS4VWBLwfotsd5JAmEWIshMpU3PeFoq1ufGW7fqd4rosaqMJX6l
         hj9Vy1z/dCGFUsbsF27a5Irb2PCdmaqyGralLJWlhuoagqimPEg/MKUIoDPXL9dKpUo+
         Ws3Shxan7IdoE0d/3Tdy0hOnlG3jWKbRr4Or6eORXb9s93r0Xta7xy1Uo/ub+MrQDRBH
         mSMcmIW8CCFJRjOR3h04zB/DBIhSZkTEKfR+anCyxuLaulBrq1KGcJwHvnOuUKb8YuXP
         G0Nw==
X-Gm-Message-State: AOAM53057sLDT9u/AJ7IBaUTwLvbHbxB61vN/goBhEHukUnvqWnCpN2F
        lwaY9b72K7lS6BtnVr2PNgg+3HT1vt1uD2bYdS8=
X-Google-Smtp-Source: ABdhPJypEDFjMd7/8//RRvBLNeMR0uFnYk3avgL9FTocgK5mZ7vqC05N/ZnObIDEo8IfVZCe1+/ZRWumjwChTwTf1Fo=
X-Received: by 2002:a05:6402:14d1:b0:415:8df3:bfa4 with SMTP id
 f17-20020a05640214d100b004158df3bfa4mr7708822edx.344.1646593716391; Sun, 06
 Mar 2022 11:08:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:c0d3:0:0:0:0 with HTTP; Sun, 6 Mar 2022 11:08:35
 -0800 (PST)
Reply-To: marinawenzel996@nifty.com
From:   marina wenzel <cmj12458@gmail.com>
Date:   Sun, 6 Mar 2022 19:08:35 +0000
Message-ID: <CAEO0q_U+LTqVoNmD8QPh1A3n8bCtz_qLwogRGam4sJa57mgnvA@mail.gmail.com>
Subject: help the poor. the poor is dying
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cmj12458[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cmj12458[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friend.
How are you doing today? I hope you and your family are doing fine?
I have a fund sum of $5.5 million USD to donate for charity purposes
and I will need your help if possible.
I will explain better in my next mail.
God bless you
Mrs. Marina Wenzel
