Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C05A572C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiH2WhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiH2WhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:37:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCE69DB45
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:37:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so7481495pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=J0TjoHwoYgG6Kema+Jak7abzWsujAZC8JXszGFLrhfI=;
        b=k+9UwWbvZCJ8AOI9U5HFXxp64j8MOA6dBIrzwtPzB51R0HstDRxBbw0dOhMAhhaGsl
         i/sBisjRagj/+8tIYoUfR8QgVbr2OYxwT2WQTKmoA3lFytDpo4JwKAd5+z1x/D6vQucv
         vpnbKRw8JNeP34iVnT4l2qY34c6aaez7EadLoIZAWg/7IVcP/X4wZ30N2lZjNNM2Be9D
         XCJxusk0uJzimuXgzNHJeW1uCEs4WJMZYDiab1MkSuaFDdZkOwxEfSD14ZwqKNPjEGoJ
         2BUFMBz+DD+uzVlvOZ0Q8EmCyvZ2u0fBvTFKG8OAD348timrvHtxCWJB6DswsxkOI6Dy
         w0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=J0TjoHwoYgG6Kema+Jak7abzWsujAZC8JXszGFLrhfI=;
        b=iRWuTDwTo3itiEPMCjLsNq1oEbBf9u3R7E+QZnRHKpyeaAkzGMTL5OZbH+LQT9icvg
         TAoDCi0VevYZS4Eg9nWnSmxjJb7/auoaMhI02dSYG4D674ryI0HzujlaLLdoh5WpFbsT
         L4hktwKAra/NF6Ln3fLclJz2ArcNrrTNDUEG4Ko85/kWH0C9UtpH76gatRIcaGyfC4C8
         UBd3bJjauc65QbXWBGGa3Lkd7urxg208DomfAIafv9a4m0+g9swN8aVArWJ3Qe3/gZ0m
         gwBs4BQZob9G5nyoTAlyUje74QG42z7OqKiv2byMVgEIYe0KdCiOtb77wVs1G6q6CTEv
         EG8Q==
X-Gm-Message-State: ACgBeo2tZweLKmvkIySxK6AGLlRubzBecospJlrT9YS7XvTFK3BSSlrn
        X1ig3fKnO9nVPAExGYmfh0+ox53GGm9pekAnfIw0KHRrYbyz4g==
X-Google-Smtp-Source: AA6agR64PLPfNEGcufyUa8DcZMU5x+1Sd/kCjZNDXU9j9E+4ZXLZVGtciHfPKTV0d+uIW7coKaUBHzdLE9o1SxOxLY4=
X-Received: by 2002:a17:90b:4a48:b0:1fd:df0a:eac1 with SMTP id
 lb8-20020a17090b4a4800b001fddf0aeac1mr5561983pjb.161.1661812622035; Mon, 29
 Aug 2022 15:37:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:9003:b0:16b:8a74:d56d with HTTP; Mon, 29 Aug 2022
 15:37:01 -0700 (PDT)
Reply-To: allstatefinancecharteredbank@gmail.com
From:   Allstate BANK <cj6084640@gmail.com>
Date:   Mon, 29 Aug 2022 15:37:01 -0700
Message-ID: <CAKcxpnwWj=FW6cq2KygAbvQLOWd2tSPS7uXweMAog9itRWrwXg@mail.gmail.com>
Subject: ATTENTION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cj6084640[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cj6084640[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is my pleasure getting to know you,well your high reputable profile
sparked my interest to contact you on behalf of a prominent
investor/philanthropist.
As a matter of fact,I am a financial auditor and I also help business
owners,trustworthy and committed individuals, project owners,
investment brokers or companies with sound financial management
abilities and entrepreneurs,i help these professions and more source
loan funding for start-up and growth capital e.t.c.
While currently we have an investor who is ready to fund any project
or any business idea that is flourishing to invest in.
Kindly get back to me on my verified
email:allstatefinancecharteredbank@gmail.com, if you need a loan for
any business or huge project or have someone who does.



Warm Regards

Sent Kelly
