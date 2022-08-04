Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C450589A56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiHDKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiHDKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:15:30 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504722BD7;
        Thu,  4 Aug 2022 03:15:29 -0700 (PDT)
Date:   Thu, 04 Aug 2022 10:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1659608122; x=1659867322;
        bh=OOAFqj5jOkefjruY4cVlXMt+tgX3mni0RziYWRLgIA4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=vgzmNSefYqbQAcl0K3I8J9pqBZUcN+PyC2c/vCe4wbDQqcFJcHhoAnlj8Z8Em5DQz
         JWS7tlP/hvnHk6JaRbkdRHoHMBf++vfxuESbZ6EylAq7tnjsm2KANhRl/ytzG+lgt/
         83DiNZYOaMWL83Hxnf3GB5v1YQjTT2uZbfUcmSiojqQmueOxaiufyS4ioFKw37sDdr
         iQ4pGGrcCKdHygZhGxf2YNdaOH1H3lQKqoU1jIgoHD0qLuLPnMruOHePKP+szeSr3T
         4LY3dyECkfc1hvGBXwhAIXPO/0qFE+RdR9L4jWk8aT2WuRuJCuKvnBkg3pEysjihnj
         o2K4E2/as99hQ==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   bjorn3 <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>
Reply-To: bjorn3 <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v8 29/31] MAINTAINERS: Rust
Message-ID: <LADPltvgY9H_4iPGAi0MyFOayCnS7NQhMPq6tPhBV2GoPIOu2jzx1gmZXYsKQWCIfmywn1Q8z61ye6OkSX-RsX8bfloQyhEespyyWPonnfM=@protonmail.com>
In-Reply-To: <YuiLM6ca8Ih0WiS3@boqun-archlinux>
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-30-ojeda@kernel.org> <YuiLM6ca8Ih0WiS3@boqun-archlinux>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 2nd, 2022 at 04:25, Boqun Feng <boqun.feng@gmail.com> wr=
ote:


> On Tue, Aug 02, 2022 at 03:50:16AM +0200, Miguel Ojeda wrote:
>
> > Miguel, Alex and Wedson will be maintaining the Rust support.
> >
> > Reviewed-by: Kees Cook keescook@chromium.org
> > Co-developed-by: Alex Gaynor alex.gaynor@gmail.com
> > Signed-off-by: Alex Gaynor alex.gaynor@gmail.com
> > Co-developed-by: Wedson Almeida Filho wedsonaf@google.com
> > Signed-off-by: Wedson Almeida Filho wedsonaf@google.com
> > Signed-off-by: Miguel Ojeda ojeda@kernel.org
> > ---
> > MAINTAINERS | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 64379c699903..a4f90593b59c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17477,6 +17477,21 @@ L: linux-rdma@vger.kernel.org
> > S: Maintained
> > F: drivers/infiniband/ulp/rtrs/
> >
> > +RUST
> > +M: Miguel Ojeda ojeda@kernel.org
> > +M: Alex Gaynor alex.gaynor@gmail.com
> > +M: Wedson Almeida Filho wedsonaf@google.com
>
>
> May I join the party and become a reviewer?
>
> R: Boqun Feng boqun.feng@gmail.com
>
>
> Also given their activities on GitHub, I'd like to encourge Bj=C3=B6rn Ro=
y
> Baron and Gary Guo to become reviewers as well. Of course, they need
> to be aware of the possible upcoming email volume and sign up themselves
> ;-)
>
> More eyes (especially from Rust language experts) are helpful ;-)
>
> Regards,
> Boqun
>
> > +L: rust-for-linux@vger.kernel.org
> > +S: Supported
> > +W: https://github.com/Rust-for-Linux/linux
> > +B: https://github.com/Rust-for-Linux/linux/issues
> > +T: git https://github.com/Rust-for-Linux/linux.git rust-next
> > +F: Documentation/rust/
> > +F: rust/
> > +F: samples/rust/
> > +F: scripts/rust
> > +K: \b(?i:rust)\b
> > +
> > RXRPC SOCKETS (AF_RXRPC)
> > M: David Howells dhowells@redhat.com
> > M: Marc Dionne marc.dionne@auristor.com
> > --
> > 2.37.1

I've already told this Miguel in private, but I did like to join as reviewe=
r:

R: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

Cheers,
Bjorn
