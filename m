Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171674FCEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiDLFWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiDLFWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:22:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0A21E2D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:20:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s4so12906581qkh.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=LZj/z7DhAOHaUM9dKS+TtRpj4fn8d0WPchftGeepFy/YrNSCaSF6lC8lUbI21fAekd
         /9zxUvsvPc67Ey7EwyJabJotbPBy+3Zps1SbuP9vqZJHHyI6GZKegC1PveHCUdKTrBft
         af2RCqaKdBsI+oHV7f2In2HC2kzQrrkcu1LtW5prBm7Xu1ibST8/PFBAd13xArjgpPEQ
         3MuGoEL14hS7dZZt5/XB4WB2TR0zdioV5hcvHryN65sR+b8ci1fbQyNYkLP3YWZ4ITvO
         kNo1p9VNF61GL5G/PDt+JL5o7JEz5rGIPW/saiUbp91c+cOkaqOmXJ7qkMmMhqD7hxJm
         n6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=43xvKfJgDvrnnjIl+NI+Lt9mgm4+Ac2QUSTh8WgW3xgd8CfSUpRTQAXFob+w4Rz3PD
         gYSoAOLdJTXk3l5WrFNmlKJQ3JFEciBpx2i43cG4g2IrY2jn/QPr1Kxwr6tlDpy+ltGo
         iH4/NJMJ5X9eORnUn8h5lHgZ90Nn1Pfv5CUHhvqzrWjvNddxUzBTb/4v0Bp/5VBHZKVI
         cWQaFXPlIpNd4jlPwJ33yQF3eqeGWu2Ghb2YrZYkmSvJXYJaq78ZOB4dBqgNccg8Jir/
         rAWkjpcO/RzfQaFhs4V+VXbymXpoK+BBrrbDNM+PPiRUxCqyPzj8HP/GuFdKDz+eBOYt
         zwJA==
X-Gm-Message-State: AOAM533rr4VVy6xgPXDuRpkgv36ag/5t4A14YUTAvgTD+ICfYB8hRE4I
        0LYQEXl8dJC6eLNQs26rq6rQbjOKvVyrRwHAC4E=
X-Google-Smtp-Source: ABdhPJy3eT2NpWviJCH6N7/4ruVxdfp9CiAS2HcFrN0HePjI4/4JTYWvFcKg7zPp/Ox4XZboJj1cPkCjI583gGIK20k=
X-Received: by 2002:a05:620a:170e:b0:69c:3721:b8e6 with SMTP id
 az14-20020a05620a170e00b0069c3721b8e6mr1907591qkb.593.1649740832315; Mon, 11
 Apr 2022 22:20:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4987:0:0:0:0:0 with HTTP; Mon, 11 Apr 2022 22:20:31
 -0700 (PDT)
Reply-To: fred49508@gmail.com
From:   "Fred Martins." <dors893@gmail.com>
Date:   Mon, 11 Apr 2022 22:20:31 -0700
Message-ID: <CAJuQ9ha+wX2m+k5A7CTTQ83n1RKcq=UWgHdZJ2Wo0YNDpkuywA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:732 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4866]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dors893[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fred49508[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dors893[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
