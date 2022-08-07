Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130458BCBB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiHGT0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:26:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66796449
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 12:26:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w15so7914170ljw.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=+aPYZ+xKL0i5ycXMj6AArLzK0rM2ShOpuYnXfGdJc2A=;
        b=Ojo5fn0b12MQiyP6uFpm2Fdfc279ZBjBnEcxwT9cWTNG9+rHJqZl/f3A81yxHR7nx6
         BUuzqixOB+WNbt+3JTo3rPLNVdBv0GU/l+Z47Fs3Ti5rOfNyGfCDzbWT2Asldatwx6Xg
         s/AOCkMCG6VnNZqSzss0K2hxgP0iqoRjUzN9pKgdMqKzGwRaj3rftjueLuWatgQGPIyj
         NuPOHvtJ0xojryON/0K0KxRYKx85JrtJBB13yaVP5CuvNibxeGmfKGDRvEJ20VgAm46u
         erHQCwIaF93dMc8yCZePdNYNrrtPysw/uCYAaYawdQ/Dj4/Ful3+Bwf6fgIzK4BNAh80
         874g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=+aPYZ+xKL0i5ycXMj6AArLzK0rM2ShOpuYnXfGdJc2A=;
        b=EpCcpyepCzdm51KyPlCOGKck6LDk+lOd7zbAeW8VkVSf1yTLwqqFLXLxtN5HHVXQDs
         AjtohQho1WrAtTuSu9vpPVoR9p5Rdr7irA/U0V8LXcO0nF4+YxE2Fw0rKqkxbfMFTOpn
         1+PRM7/kGswW9nt9sdnavJR9i5zliWzsCsZRs+UUkgzoiDzqlEaek6ekETogDu5carzn
         2Nv5GSnoG+IBrVWr4TrBudLD3hkvgJmvMRtFEqAlmSYlIZi0MXeZVAQFcFwNMbpSsY4b
         NyMjsSQX/FVQo+sFH1SxAG6cncBh4XNd0lT8niXSeSCTrsmFxCiOFAFxtOq/3eRPijbX
         PGFA==
X-Gm-Message-State: ACgBeo213FhWbdbq7/ge+tYPYPUZCfMYyacgrr1a4sxJi+AOhhf3WA3Z
        NQ2Xt1/m1GnOoewyS9rpuGcqCBsQZ0z0Y9Wln4Q=
X-Google-Smtp-Source: AA6agR6jXI/lFEHfporn2w5yL1TB9zTHM7X4JLoLcUpYED5wCKz8pjFeFgwDmgbznlOOx1b9r0ouxbJXCuzivyPb/dE=
X-Received: by 2002:a2e:98d4:0:b0:25e:5508:ef96 with SMTP id
 s20-20020a2e98d4000000b0025e5508ef96mr5142573ljj.435.1659900390878; Sun, 07
 Aug 2022 12:26:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:a80f:0:0:0:0:0 with HTTP; Sun, 7 Aug 2022 12:26:29 -0700 (PDT)
Reply-To: rebeccaleezhang1@citromail.hu
From:   Rebecca Zhang <theophilusosamede16@gmail.com>
Date:   Sun, 7 Aug 2022 12:26:29 -0700
Message-ID: <CAE8sdstobC-9YCxadna_tACkhtgT7Wi4i9X7bjRUHJaQqWr-pA@mail.gmail.com>
Subject: Reply back
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [theophilusosamede16[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [theophilusosamede16[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rebeccaleezhang1[at]citromail.hu]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear

I hope you are fine, My name is Rebecca Zhang I have some funds for
investment but presently I have a health problem so can you help me
invest the funds.

Contact me on this email directly so I can give you more details: (
rebeccaleezhang@citromail.hu   )

Hoping to receive your reply soon.

Regards,

Rebecca Zhang
