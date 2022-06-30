Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C256105B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiF3Ema (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiF3EmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:42:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A65F3E5F7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:42:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso2523731pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=LjIVvHU4pqStFG3a/7uSUBbaMwdp7GmGj8q1QKxgnk4=;
        b=iQwnnfRCKcRTLfxiLEa7AS6vmO8UL7MiADPL/QZ26eA1lzttSigYkpV/ky/GKtN8WM
         5kCwxtU1hEpJaLt7B+1HlOSxEcC5ljkK/VsRolobOGHmMJgZV3qNtm9PpknDkBtawuHY
         OtnvD81QFPz662dZLHUojVaS3uKwaS57cKtPSdWE68fNnWvzlaGR7heE5ONicPL39P63
         4TILHHIpfrGR8lzTY00jDwzUkb0J/7XZcwuo+tMkCRVzNUsMgG4C6t/1EDIQj+SyNQ3Q
         7vIF3R1buwv1wuktj4P1Oz6ZPzrShPnvSH79AACUfSu+eZmezA4xYmVIW3KlgV2Oo/Uh
         vBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=LjIVvHU4pqStFG3a/7uSUBbaMwdp7GmGj8q1QKxgnk4=;
        b=2Re3feQDZ1Z/DLP37daLxByMTCPd+fuhj/DneFWPWxO6S764ulNSTmJLUM5CrKi4+c
         lNxoRvQ7J2CjIYo0JHvrawBUZKVAohvnqtrGtlxjkxWjh2XLJQKFQX0/T+5p8KjOuv89
         qt3X1KKFDQJsxbaPi6h9ybRvJyHP5J6LKGlVbK72G/yLhsOv/bTLrmiyHPMyfaHoAftb
         0KuNwF4TuOxyiIS4qNxZh81ku6OWoFe6bEULU4x6OV6s2+uFwCiPrmehD2nfsnlxHmq1
         /EgZJLHk0BBlTQSMcg5Lmy81BJXlxswaec7ca0vlmKkGrILkoc/FH8TcQko85/ndH1pW
         XdRQ==
X-Gm-Message-State: AJIora8NTK+ar0NGugJoAfGJrOOmOqEKmd6/BCHJB4i1iLBlU8mKeRzq
        HBmWShEK71Fc623pjgceyUUcQd31UFliMobJvh0=
X-Google-Smtp-Source: AGRyM1sSj4Rtq5rrFUkP32M67pE0I/bW06tjEd5+DlMuvtlTeBfO/jHPcGegSLWA3lXfs2mepM1pbU4rTPy2RANv6jo=
X-Received: by 2002:a17:903:22cd:b0:16a:7492:1fa with SMTP id
 y13-20020a17090322cd00b0016a749201famr14261287plg.59.1656564141469; Wed, 29
 Jun 2022 21:42:21 -0700 (PDT)
MIME-Version: 1.0
Sender: usmanmansur79@gmail.com
Received: by 2002:a05:6a10:e2d1:b0:2b5:b1d2:4ed9 with HTTP; Wed, 29 Jun 2022
 21:42:20 -0700 (PDT)
From:   mrs marie brigitte prouvost <mariebrigitteprouvost332@gmail.com>
Date:   Wed, 29 Jun 2022 21:42:20 -0700
X-Google-Sender-Auth: 5lSg5V8jOTfO9x-oTPsYzLouUsw
Message-ID: <CAAu3EJ1ednHgJNYzCNeLPDkJpxm7X1uzscEqFPKQ9KbEP3eZ-w@mail.gmail.com>
Subject: Dear Old Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_3,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [usmanmansur79[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [usmanmansur79[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 HK_SCAM No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.9 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know you may have forgotten me, I am very happy to inform you about
my success in getting the money transferred under the co-operation of
a new partner from Venezuela.

Presently I am in Venezuela with my partner for a better treatment; I
told you that I rather die than to miss this opportunity. Meanwhile, I
didn't forget your past efforts and attempts to assist me in
transferring the funds despite that it failed us somehow.

Before my living Burkina Faso I left a complete sum of Nine Hundred
THousand Dollars
with the western union money transfer to transfer to you as your
compensation.

Now you are to contact the western union for them to commence on your
payments, Ask them to send you the Nine Hundred THousand Dollars which
I kept for
your compensation for all the past efforts and attempts to assist me
in this transfer.

Here is the Western Union money Transfer section

Email. westernunionmoneytransfer.WU@financier.com

Remember I have already forward this instruction to them and they will
be expecting you to contact them to commence on your transfers.


Bye and stay bless.

But never forget to inform me whenever you received all your money
because I have paid for the transfer fee.

Thanks and God bless you

Sincerely
mrs marie brigitte prouvost
