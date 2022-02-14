Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6F4B59E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357456AbiBNS3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:29:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbiBNS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:29:39 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCDA55480
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:29:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z16so8799188pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OeMHtDE9obEZUnCLY9IIpoBdEe7yQZndNZpm90jk11k=;
        b=Z9Uk7dmTrek5VLynJESb4e+9foJCIoA1+jmk/r45SPeJwEO6c3eQxJW2R4fBMbKRY+
         7bZ9Guj2sYrNhUPeyZdxjr3Fw/vEIS+DYMwqe7hUbJ1YGuqutgfiqGqe+7Rx4CTGBgbB
         /9ESoh3gDLU1/uChsZqdMBZiKsKO+B+uBeWAK+3xgr5b0tv9wyBBUGa76hFb+riujztX
         gxJZvGcoyolEZOK3RYFtHsHm9hMqpxcOlWivpryOk8F1PiMj4TwCBtWTZCx+iOkyUQUF
         HNjj+263UGpIq1PEptcb4eLSr+rbbKLRkfibGDFyu94Kb5NvOKDejVfZw42YgdejmmJz
         6S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OeMHtDE9obEZUnCLY9IIpoBdEe7yQZndNZpm90jk11k=;
        b=3GJgGnFW2+P8zncHmZD5O8PlJWRftAgHL8s3r1AnTVfeZ2WPdkvpYlWC8o5ckW0PcH
         OzKOTytD4eBt05w30rldB32GRPMrVdiSIorMqgx6MHe7O/CnGK9xUXeHaGwLM2trUCWs
         rWDJYYNRapSnNpyP8f/W2w+vLH249vl+4/IZ04uGhrOX9qz/O7CogbI61RVLT+BPbCZi
         mGhlNsTzCyqjYjoPq3t4q7lzAQgkss/gYrPXeEqLlIoQjlpCNByf6RW9KvM3oEvxQD7h
         tD0c+mtN4tNSPe0/4ZaSpK8EX5+e9TUIxMHz6wxPedOklO9k5douTzsbQRsAcvipXjSV
         arIw==
X-Gm-Message-State: AOAM5333/cXlc37U0VuvSGrwc3s/+TAo6FRgWvopEbajDw5n2oEg3A2T
        LkqjzEwW4VW2SPViNnYK2gjBkqp0BkQlCVKsoqI=
X-Google-Smtp-Source: ABdhPJxmjxH4G8LoI0puxKS7HW1SzSz60X91w/dbnqs1HEIYtgdmANbpK8H01+m/hgf9gXUAsmPAJ2jzv1Ytuc4w5M0=
X-Received: by 2002:a63:ad4e:: with SMTP id y14mr283711pgo.214.1644863371217;
 Mon, 14 Feb 2022 10:29:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:e014:0:0:0:0 with HTTP; Mon, 14 Feb 2022 10:29:30
 -0800 (PST)
Reply-To: m223443d@gmail.com
From:   mr michael <cm09362@gmail.com>
Date:   Mon, 14 Feb 2022 18:29:30 +0000
Message-ID: <CAL1HOXDLLMHu1b2pF4dRj+bWRTpdLxJmgrvwZuPdcbtje3=kWA@mail.gmail.com>
Subject: Please Respond Urgently
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:432 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1528]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cm09362[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cm09362[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

With due respect, I make this contact with you as I believe that you
can be of great assistance to me. I need your cooperation in
transferring the sum of $11.3million to your private account where
this money can be shared between us.

By indicating your interest, I will send you the full details on how
the business will be executed.

Please respond urgently and delete if you are not interested.

Kind regards,
Mr. Michael Doku.
