Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BB4C5DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiB0SND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiB0SNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:13:00 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C7639F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:12:22 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q4so8451224ilt.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ie9R3kn8UrFErPZNTabZX+bV5rPgBvbemFazR1ScXg=;
        b=G85nEoEfvkSdaMqOwXlse+RXA7cNSbZR9kA8ylgZjHjkq3SGUzugLktvSJBAOcBC8v
         PGHJBNtVRuup/vBLcdUDzESV9vi1n+Pe40mnZBmOYVcesNQf9jQrBnbI0GdjbedrN/rI
         GlqwPah7aV/S5f8D+0tCPmEf3PMOHVSMjo+Wiong8t6PEcUxx/nKyOtyAMaTCQU2AuhL
         +rtea4Da/29yBkeV9RwIdT43Np8OKn2S6RRmtUIo5kSnpk5cqlzwblRFWcOMDWwv9FIN
         ns8k7J88cjRQmFtfdpZGF8Xq0+W6ZKL1ae61++9iYdVVK4NqRZgtIjzsn73IIb68PBpB
         EcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ie9R3kn8UrFErPZNTabZX+bV5rPgBvbemFazR1ScXg=;
        b=WrmYhXXSkOJK0p1618fu3a3UiaWti8sbHDN+5KlqIoTlFiLpsZmEVOYkS9pTOLupFH
         7geOFLLv+DDMA8hlqELjs/su3CQM8UqFaEmMEoZ1rfhYVkU/aSqZmYU/6K5l7NdjJUpf
         LqDkb3AVRqnLSLc2B/TgrwSUVXKy946sP/yW1oQPpmUB41Uhu5pxaSD72WJ5HYnNgFtJ
         zgJ7m5EFz5PflyyHbt/ZyFWVW+QTGdLX9sM3yGWmYXXUOTq8r5e0MVOvt24QRl9txJ/y
         YLQSBOA3akfkAYyARonVfLCiClPDn4OzXXm0gGnjXMs7STfzZr4rDFxRuSaTm/fivElI
         dYEw==
X-Gm-Message-State: AOAM533nklGa6Hv1OIc73BAnMnYjP26NYx164CT4k4OrEC5pkeUfxDiB
        EVOPHgASp6yd5WrqwrcuEfrOd3l6w7yUMfYjJAg=
X-Google-Smtp-Source: ABdhPJygC60EwppdVxqHwfKYlBSl2+UmLKH/aulN9osik+Vdl4alGmUpautlnYzNvkuG9pKts21LV0Kwh92xIECRnUs=
X-Received: by 2002:a05:6e02:188b:b0:2c2:5444:afb9 with SMTP id
 o11-20020a056e02188b00b002c25444afb9mr14970812ilu.237.1645985542219; Sun, 27
 Feb 2022 10:12:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
 <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
 <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com> <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
In-Reply-To: <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 27 Feb 2022 19:12:11 +0100
Message-ID: <CANiq72k_PUBPVL1Fx4HLm_WO66RuSsi0oSsKRhssCYRNGbY84Q@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Martin Uecker <uecker@tugraz.at>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sat, Feb 26, 2022 at 3:43 AM Martin Uecker <uecker@tugraz.at> wrote:
>
> Roughly the same group of people / companies that
> write the compilers also control what goes into the
> standard. They then like to point to the standard

Indeed, at least to a substantial degree.

> For signed overflow, I am not entirely sure what the
> right choice is.  Wrapping for signed overflow also seems
> dangerous. I use UBsan to find such issues in my code, and
> this would not really work if signed overflow was defined
> to wrap.

UBsan and similar tooling may still be used to find whatever behavior
one wants, whether defined or not. UBSan already has non-UB checks.

Cheers,
Miguel
