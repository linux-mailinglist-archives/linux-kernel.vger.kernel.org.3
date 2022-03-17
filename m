Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F154DC0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiCQIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCQIVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:21:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64782163E17;
        Thu, 17 Mar 2022 01:19:49 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r11so3191880ila.1;
        Thu, 17 Mar 2022 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKpTPc+312tnm2IHxxH6ooZEHljJo10HfiNs2G6uyuM=;
        b=IYovmUnZ+qdsRLQ1RlW0eltHncl82U5coFgPh6DVJO4fxi10qTxiipwvWHXJv95ytF
         BxdyIrDkLxxrh0NtUQrAEymP5BNUJvIlD7S9DQuW83tYtrBNyis7iQLv+HZHi61ggTnZ
         CWo25Tuhd3KSsPrtjjLElSyRdl3e7edyJfS3FqHdUG72ryDfjTmRwLpxh8jcxNnVtzs8
         MsMCjCjD65WFkgOIR8pR8FsprONalIh8LaaFcyuZR199/eOvVb5qTnyYSFGTGKrB3dm7
         BZ1r3zKxx7zHWKfN9DN6aMpGVj6+wg4KHoLDiHzIOwhItB9s3GerQEP5M3q8CL7HaHAi
         nheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKpTPc+312tnm2IHxxH6ooZEHljJo10HfiNs2G6uyuM=;
        b=Y8v95/FanijgXhSndBjd5iTydQ7uetNnFXtwddL3bcrB5s2CiZB6iemsG8Vof8kt3A
         G8A/5NsObzC+x/QckQbPgmyhFzrZjEp3KUxBZzFgfsdNYDkMyEnSfuklTxKGQOUMTxOX
         A6iBQvkU6ywK4Pmq566AJoSLDU/rvQdUuyOmj9jPM/IKWWQ5aB02en69IDhendkgpPFY
         9MeaSXLKlAUplDhxGAq5hemFyW+bIUpRzB2/etAFMhmX67jS5OT+AeVY7RWe8MFYNSKx
         Ac8zNAhtTphJEgZ7tXt+lkRtS+U8y77KJILbi2UwBbcYXyrj0VUp1QJPViSkl90R8BnF
         lIIQ==
X-Gm-Message-State: AOAM5339talGBACLQphWWmyLy788RXK41NDjqk2p3xvur5/sG5euOn4V
        Q/IGD//L+n7swtv2oiPxod5KRr/SSXlYYe0zzxQ=
X-Google-Smtp-Source: ABdhPJwfd1D3uICD728dSd5iiOOL1/UDS2rL5ofpdJpLCCO+BSm5L/BuS1eQfHG36q5hn1JlxT25xACxZHGY8nuqmZg=
X-Received: by 2002:a92:c908:0:b0:2c1:a287:8868 with SMTP id
 t8-20020a92c908000000b002c1a2878868mr1289760ilp.321.1647505188872; Thu, 17
 Mar 2022 01:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220212130410.6901-16-ojeda@kernel.org> <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
In-Reply-To: <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 17 Mar 2022 09:19:37 +0100
Message-ID: <CANiq72mQffofeW4C=AWF4CHu=WpgpwB4hAv_q9QiTX_+U38qGg@mail.gmail.com>
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

On Mon, Feb 14, 2022 at 11:47 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> > diff --git a/Documentation/rust/logo.svg b/Documentation/rust/logo.svg
> > new file mode 100644
> > index 000000000000..65be792a5abe
> > --- /dev/null
>
> How about adding a suitable license identifier in a comment?

For the next round, I did not apply this suggestion, because it is
unclear which license identifier to use: it would be probably be the
same as the `COPYING-logo` one (which would be used also for the Tux
SVG, if it gets merged -- it was sent a while ago).

Cheers,
Miguel
