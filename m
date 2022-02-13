Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553774B3CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiBMSZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:25:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBMSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:25:30 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AB575C5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:25:24 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v63so12808452ybv.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=KXZYDEEC2LO17f3/X0MoAyEpPa/p71NZIgTKJd4XqT3mcfW13rd1bEmWoTvu777urk
         Do2Vv7/uOyY9WQe6t6MGGPgI8co8sWaDEgVa7pu7PF0rW1cxpkdwOwggLSIOkwQx/Gzh
         rWB8TCrfKvY78BCOMogYoPLnQF2gUTqf2QAuq4iOJt8Ug+YQATBl4gVX3L87dRh1kvcf
         Gqhh9gG/mhFS5ODzpJjwIo8bzJCCxLKfU3MUKERVRTfuqvEMQbHfbzuO93oFc5dq+wV8
         vxTUrl4lWietN+xM/BYe6PAdT2Q3n/jKXm2koSI8QFR21U8vwms2CjmuiH3HljIe1Z1M
         FYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=bGJFBrUFHCXJpAOZkiLV7EF82M7n4Y7t/B7yxqRFW35aUAjPhueDq5jT8njF1kn4TE
         LskDhn3t8tYTF0HdsVkvbQwthv5WZlXi55E3DMazb/YIbV4Uylty6Q+7FrRO5mZ3r+Lo
         L7gnzVEC6j0aWttw3fU5QdXFACDSuELC+E+KrPyjaxxx9fOMwFk5jV3n0UrMsZOrqeZJ
         coNSj98iyUinOx5DppetgNi0aykZoqO8E00IXYAajj1eRaPk8PlbSb/w3zx2rCQAsg5f
         0UH+HqZY2szNkpgJpf6cgmI/U6blFdOYsgSTBT+6QFOlpnqiPhiE0NBb4zOllgDRyd1F
         GX6g==
X-Gm-Message-State: AOAM533FBMVAi1tMCknVn41UfXF2XzL4Dg5Vdh8SNY4O8YZy4OQHGjov
        vN/MyIiTM2HULpn3I/D0+ZYtArgdhaPNBkSQ5DA=
X-Google-Smtp-Source: ABdhPJwE4aAduq6ESisISvUQJXAz+p/Gw+S+z3+mx9YZWLu276c6sfZ0RhpUpZcL23fwNYExdRmoOm8lFvXOR7EZSCM=
X-Received: by 2002:a25:9247:: with SMTP id e7mr5354117ybo.747.1644776723912;
 Sun, 13 Feb 2022 10:25:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7011:812:b0:1ff:f81d:242a with HTTP; Sun, 13 Feb 2022
 10:25:23 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gracebanneth@gmail.com>
Date:   Sun, 13 Feb 2022 10:25:23 -0800
Message-ID: <CABo=7A0075rYFH2UBBC0-bKXVjSQCMXig5gunAJ_BH+BvfUK1g@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0818]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gracebanneth[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
