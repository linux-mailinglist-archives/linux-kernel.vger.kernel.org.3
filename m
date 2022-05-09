Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F5E52076B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiEIWTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiEIWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:19:10 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949B2469E9
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:15:15 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id a127so15322746vsa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=VkIB8RTh7r2qNyW14PeWZZsu/axpsoUHILJB+vopRy5mfx2M/vk0HHh/8J4inaEUTi
         5z4HY5yTYco4hjFNR7ed9IXDqmPOz+tnSNp/x86IHcebjQgZ6+6RMlF1h1G54mkNXt0N
         tMSDm5vl/fiPWEbaYMnLJYw+CZI2ZvDsKzkvWufyKdCQFiGmOqxQ2w58782XhtyXmWMH
         yuq3c14po9+ooPOSfdlogSBniIQGxUtUpC+o7m7OlT5cmI+ZtBf4BjF8Bxcs2WBSSxez
         XdQouDLYolJhxee1lNHXDsAR6BTOEP8G/zDUD0PMGe3tjfsA1D6Ia56GBO5ktgIcKYhK
         vhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=XdpVy6bK2q+2UkAXGQOZvQqQK4M/qhBA3EW++zVCfqxVmTdWG+qsgWS7q+8ooS4Jz9
         yDvtQpkFWGuLxhAa/m9GuUft9E4hR1qO178B6k5keIUJnJt4X1s7VjiKF8hrL1WE5o9s
         Q/PqCEyLweLD1vbRzzbpRKD8vmvHI3Syj/hcMfILdB1eZONlrKhjlJwBFZvQd/PHs2SL
         Y6El/nwf+O35ZD51MJ3eF8umT9WOrTHd+7tkaDLNChwvZA0/4HLXbwwTdsoYLYnXd7Cn
         sLZXrwESbgCikiYJCqYXt8ZIMDjncSUwCVPvImTA8FMgYAXGbAFT0vv/VmiBpbH/AsJF
         fygg==
X-Gm-Message-State: AOAM531hSpqBuld1CE3T/lTykwqlbEvy/BqdjPddqgZ64t6IOvxdKoK9
        Mtrw8Pi+uBGryy2FtHnAry8lL4omC7E1vgwR+SM=
X-Google-Smtp-Source: ABdhPJzDU3Qw/kan5MWegLdUyWd3e82rtF9gTBaGwNu8HW7d+XUmC1JLUSAWyN5NJKpIuZghWColMWin5TqaeDnTCJ4=
X-Received: by 2002:a05:6102:c13:b0:32d:518f:feaf with SMTP id
 x19-20020a0561020c1300b0032d518ffeafmr10104674vss.84.1652134514139; Mon, 09
 May 2022 15:15:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:221e:b0:2a9:aa30:c488 with HTTP; Mon, 9 May 2022
 15:15:13 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAGcnDd1fkiaxCzKsGYj21JnoTVxWvFDBD7dEAneDp3FwV1akKA@mail.gmail.com>
References: <CAGcnDd28kPHzw1L4gL4a0Fe2Q854ALK6NHQYw-=htSkBmDPBTA@mail.gmail.com>
 <CAGcnDd1fkiaxCzKsGYj21JnoTVxWvFDBD7dEAneDp3FwV1akKA@mail.gmail.com>
From:   Warren Buffett <koamididiera@gmail.com>
Date:   Mon, 9 May 2022 22:15:13 +0000
Message-ID: <CAGcnDd3-nj_C+2qTYE1V6Vf9k6nF3Umw3jcgVeu4Mf0fkpBiQg@mail.gmail.com>
Subject: Fwd: Mr. Warren Buffett from America USA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [koamididiera[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
