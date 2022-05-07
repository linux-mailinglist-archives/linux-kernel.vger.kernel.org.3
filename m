Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6051E5B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446129AbiEGItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358391AbiEGIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:49:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751493CFD6;
        Sat,  7 May 2022 01:45:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id c125so10388780iof.9;
        Sat, 07 May 2022 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3afSRUyqURqd+oMSYddARQ8dgu6A28njYvK52vqSOHE=;
        b=bsipmcypY4Nr9F6rxV0qF+/yrplNPZ0IzUaGSZBCHKoawh7Fip9CQSr7T9i2N0RRqw
         iGKGF4cDgKmJ6eoHx6k0ezlu79rFPVUtTqpMoe3f6F7fT6iXT3VJHIN02m0SIWnLfzfF
         QtRH3qHSNFE0OUI4opgLeKF/ieievW5RVFPYRS42dhcAXTy4TwANrFbcmxpOabTh4gO7
         x63GRFN2/z+INwysjq9EKstBst8u2GfgG8WJHmpybw7iW3+LWrryu6tbRd1W47Pqa2lX
         DtboSk8/TbzieN8V4f3XB+LTsdhXmDjt7XFb/2yZQ1u+nMvgFUH9kFQUwEvRpiaF1AE9
         7Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3afSRUyqURqd+oMSYddARQ8dgu6A28njYvK52vqSOHE=;
        b=4rHATvJ+ED6VIipoyyX1mI4eOHqXgMrE9rCNfuj0h4oANzTE5oEXzJsnAZYzocWizj
         z/0E0fL0SbxNW+TXDnyrbnMh8bFJmhBIs4oRNyBpmduBJvBHSMtoMfmoOilztqZRy8zi
         KauJbHphOpPUkmJUAxaWFdKKh1M1wvXQZBJVQ2pBmmtxWytUt2ZiBAYCZ7JAEYTw9AMk
         Drgz3CExxotMhv5DnO4QlQYwk2/J9c8gHjO3jHf7d2Ksubfg23UvEBrv/fq4KlmYnkPF
         fwXjplEghvL+31Izq9pH7ti086m03R1TVpLfyKBEV8c/Pc+pPIh4Eej1OT2dpNd+Lchl
         ai/w==
X-Gm-Message-State: AOAM533Q/pLcqMyWpl0MRZYLJv/fYGaGH9Yfxnl2yWOVUTnuypDobuT0
        2w6ez+lQeJSndjJDt/4KNskTDTD2DAie5w59vuU=
X-Google-Smtp-Source: ABdhPJzVvfTAFB1H+iKYF8/l+675Y66bzPEAl6PZoc8GS14ISO+vI49zY9FgcEZBnSnvbXQTIlqAVC8fTwYdsIaDRow=
X-Received: by 2002:a05:6638:16cf:b0:32b:6ee7:8d7d with SMTP id
 g15-20020a05663816cf00b0032b6ee78d7dmr3125574jat.256.1651913152910; Sat, 07
 May 2022 01:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-19-ojeda@kernel.org>
 <202205070114.88C59DF@keescook>
In-Reply-To: <202205070114.88C59DF@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 May 2022 10:45:41 +0200
Message-ID: <CANiq72mfUkZDpsAj6ZRWYhydzRq2F45PWOjw1V=k5zh=TX6a7A@mail.gmail.com>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Julian Merkle <me@jvmerkle.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

On Sat, May 7, 2022 at 10:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> I like the docs! :) It'll be interesting to see how we can grow
> cross-linking between rustdoc and kerndoc.

Thanks!

For cross-referencing, my plan is to start on the Rust side by
allowing to link C files and items (either their generated docs or the
source file), since we do that often in the Rust docs. The goal is
that one can just write an "intra-doc link" in Rust docs just like any
other one, e.g.:

    /// Wraps the kernel's [`struct sk_buff`].
    #[repr(transparent)]
    pub struct SkBuff(UnsafeCell<bindings::sk_buff>);

so that it is as easy as possible to add them.

Cheers,
Miguel
