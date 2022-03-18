Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF84DDA36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiCRNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiCRNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:13:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE582D7AAE;
        Fri, 18 Mar 2022 06:12:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h21so5776099ila.7;
        Fri, 18 Mar 2022 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrIi4QJGFZQXTQRQQ1yfJPE3hL92sb68RV4ZifnUSps=;
        b=GKoR2CspEPflCp64pROLF9OhWKe6YDeaiTwv0m2jpbqapjY8eYH7kCjgFYx8rCN6nt
         XE6WyHc42mO6tLNgcDrFM57xZG2dvLNauuMc1vRpBNJa72/I9CwJhBs5CjDMBOiTT5+0
         mFhaYcqxvwdhpD23qa8CSmKpCGhfRVSmZy8m2/kKhNc6IGxg4fgcojAxraSXfJwN4RSM
         s2MMJJsPXl5FjAICbIhwyRKuUY3c87qQehuUmmnkr4dmhslGt18WNqL7oQyApEU9CXF9
         t9tIYWS4w59dq62R5E52URnhL5Rn+tsqtvPF0IZKjlAkdMjpGypJgqMx8MX3Z7PY54ZM
         Xdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrIi4QJGFZQXTQRQQ1yfJPE3hL92sb68RV4ZifnUSps=;
        b=7BRqXL0TuJb3F+p1g36Pc5wJEY9G0wabtjyXgkquXCabpNPIRAxzypAomzG5fdPmtF
         2QVGu8TxoLM8wrSaINjEqG82SQBXQGg6XQRyDgbN/1r8cUu+1gV8HmTTXRK1geb0/oCS
         X/Xv+yH6MxntN51tM8rz6Qr19Y8EMUb46ITgLmivY7QoLhXvx6AGC+oULI13u/Lfqtlu
         v6qPUlN49sgDkuAh3XBTUOOMsosTn75Ol6XrhZz5UA8aaXFD1AEgllQxZCvJeciRJxfj
         OMHtBx/7HgTCtQkhfe09CBswFYSeayAAQbYypu0RSmeVxypdngXVdADPTECmA/L1Pqsp
         eY8w==
X-Gm-Message-State: AOAM532nNhDkVWdCcQDpJQxi0YVio4T9NXNixVlbFf/E2FT5gNyll7v1
        lQrCfDScwJ25vb3NCZ6CPlsO4ns8KyRqsc3NCro=
X-Google-Smtp-Source: ABdhPJyMvLyu0PpiYW1TF8r0UKZiJw+rlNL0SHa27m+oRpQcbWurPUmolhz28zP0VPmBMcZiP9/0k0KFvkxHL8lco0I=
X-Received: by 2002:a05:6e02:1846:b0:2c7:b032:5d92 with SMTP id
 b6-20020a056e02184600b002c7b0325d92mr4318899ilv.237.1647609140724; Fri, 18
 Mar 2022 06:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220212130410.6901-16-ojeda@kernel.org> <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
 <CANiq72mQffofeW4C=AWF4CHu=WpgpwB4hAv_q9QiTX_+U38qGg@mail.gmail.com> <61547556-790f-f74f-ca2e-b2fde714a7fa@gmail.com>
In-Reply-To: <61547556-790f-f74f-ca2e-b2fde714a7fa@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Mar 2022 14:12:09 +0100
Message-ID: <CANiq72mLtvWJ5peSTpYQ8AeLEskga6Pda8Q7Daysv2pfycnyxA@mail.gmail.com>
Subject: Re: [PATCH v4 15/20] docs: add Rust documentation
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akira,

On Thu, Mar 17, 2022 at 3:50 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> As I see v2 15/20, the SVG figure is among other documentation updates.
> IIUC, this figure/logo was in PNG at first, but Jon suggested vector graphics.
> If this is the case, it deserves an individual patch with a changelog
> explaining why it is in SVG, where the Tux figure came from, what was the
> original PNG logo, who contributed the SVG conversion, etc.

Yeah, I can split the figure into another patch for the next round.
Though one could argue the same for other files -- do you prefer to
have more granular patches in general?

> I understand you did all the SVG work, didn't you?
> I don't think those many Co-developed-by tags apply to this figure.

Yeah, I made the logo, but I reused the SVG forms of both the Rust and
the Tux logos.

The Tux SVG conversion (from Larry Ewing's one) was done by Garrett
LeSage and IFo Hancroft, please see
https://lore.kernel.org/lkml/20220207014418.GA28724@kernel.org/ for
details on that one.

I will add these details to the split patch.

> I'm saying this because this figure/logo can be reused in other open-
> source projects on its own.  It would be worth clarifying its origin
> in the Git history as well as in COPYING-logo.

I think the Tux SVG logo would be the most useful for other projects,
which is why I submitted it to be added to the tree with the
permission of Garrett and IFo (see link above). I am not sure if other
open-source projects would need the Rust for Linux one, though, so it
sounds like a good idea. I am happy to split the patch, clarify the
origin and to add a `COPYING-logo` to the `Documentation/rust` folder
too (pointing to the main one at `Documentation/` maybe).

Cheers,
Miguel
