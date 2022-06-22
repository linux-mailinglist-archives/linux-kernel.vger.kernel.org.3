Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BC55535A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359681AbiFVSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiFVShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:37:53 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C406285;
        Wed, 22 Jun 2022 11:37:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 983B13200A9A;
        Wed, 22 Jun 2022 14:37:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 22 Jun 2022 14:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1655923070; x=
        1656009470; bh=G//CkjAGkuIcoptemdXndQWn8Sa4+wndH+LOM6l7TvA=; b=n
        PEcyOHEtW0K+ETUp+g66Lc6Z88MJBFha1ofsD1XFG5htaV716jQGQM9EzbfCJPjZ
        UIB1yXaT3jkg2UFZxFEE3gZVmDyB0oEkt5Ypew+rPh/yCWyZV6IUJ2uv8rhbp9M0
        r1IvSUrHV/RvGxwh9Fhk16qTZdjRa1Rap3m/08VQ7h/tuVhmYzas19B/fzXKuJ0B
        j1K3IVi0yr28zH89jdHmUDuLrevS1zZqw0Sgr1O6kJyy5QmtUGlRm/j4rHuUJxzT
        cSHgJwtwerKdB/0JySWG3WmAP4uyRlvbYDMZ/sUwM4hrXBI9pYyzwTLG0S8dUQA0
        bgs5YDTgv2QCSUoLAmmUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655923070; x=
        1656009470; bh=G//CkjAGkuIcoptemdXndQWn8Sa4+wndH+LOM6l7TvA=; b=u
        uWOx219fW6zjPxYL2C13oMAgtA+1eYJoFyp8onqHqKU4w8gVOkEYoCPpNf6FUp/N
        ROCcDFMNLyKmRq5JA7pBdEyZPk3ZuxlTCDpzdyShZYv0LmqEZkJOTIQOqwcoySkw
        0PZlneck89KLIL12LviSYPMB+xoViW94xmfjR74IkllzBRnLUg1whkCkLgQ6Wq8L
        vdFLTML6bfd8IhwpJYDtyyqynxNUouIYISv1h9O5B60LKIrsH8ESOIhUt6FF0Aip
        Juu8DXuqWsgYBLQcjFskqHv8jRLE2HSfYaTJ7BoEbXGcif9g8OAVL3zXzsb7ecuZ
        ob1u8pDRI8SJBXIV9/jvw==
X-ME-Sender: <xms:fWGzYg4qY9npe2RMrMAVV8QFd_P8wxcoW0Z0lNaCR_uKRQAsLVYs4g>
    <xme:fWGzYh6Y39eHy69A1SuP7YAOOtPNgOfcYUAKCAxFDaI29MMpK-N0WZb5Remn1WDPC
    7WZpYwS-a32799yzg>
X-ME-Received: <xmr:fWGzYvcQ5wMnVXW16iYHNQ6CFHruoOBIeeAKt1EbOB_FtKfz0lLReOHRN39UqQ-r4_pDKHhAv8NxdpPSvZ03pWvPWE4D8qGVC2SB7gNbvC9WYV3k-aVrpT8x1kYu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefhedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheptehn
    ughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecugg
    ftrfgrthhtvghrnhephfeitefgleevtedtffejvedujeekjedugfdtveffjeelvddtfeek
    gefgjefhgfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:fWGzYlKPN11Lt1H9dFsxEar1lwO3k_hhezikt1A88iw1SNIuFEbyQw>
    <xmx:fWGzYkJ2RxNxp6JH6kH7tmiYv76cl5X0V14Hacul6GtCxXA5JAdgsg>
    <xmx:fWGzYmxCaysowl7Y6m5_2CO6ejbAS656_cpuvK4I_SJU6nU1vMjtdw>
    <xmx:fmGzYizIRrTjSmNiUjRHfC814ZqPh7PsNdnJKxfp5En40magH5qBQg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 14:37:49 -0400 (EDT)
Date:   Wed, 22 Jun 2022 11:37:47 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
Message-ID: <20220622183747.mhhlfr6aufbkyhag@alap3.anarazel.de>
References: <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
 <20220609192308.GB10732@1wt.eu>
 <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
 <CA+icZUUCOoE8x3Js=DYEjgyV_rz-T-M7gPZdFQu7tsKcUoA0hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUUCOoE8x3Js=DYEjgyV_rz-T-M7gPZdFQu7tsKcUoA0hg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-06-09 21:31:44 +0200, Sedat Dilek wrote:
> On Thu, Jun 9, 2022 at 9:25 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Jun 9, 2022 at 12:23 PM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > IIRC you can also disable the deprecation warnings by defining the
> > > OPENSSL_SUPPRESS_DEPRECATED macro. It doesn't require to change the
> > > compiler's options and allows us to put our head in the sand.
> >
> > That one had the downside that you have to know what you're doing to
> > make such a change ;)
> >
> > I just wanted to be able to start doing pulls again after mistakenly
> > thinking that an upgrade would be pain-free.
> >
> 
> My first approach in making this work....
> 
> From 3b019a241a72742c7f239965ed92385e9ffd9ed3 Mon Sep 17 00:00:00 2001
> From: Sedat Dilek <sedat.dilek@gmail.com>
> Date: Fri, 27 May 2022 09:25:45 +0200
> Subject: [PATCH] extract-cert: Suppress warnings with OpenSSL v3 API
> 
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
> certs/Makefile | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index d8443cfb1c40..52f71f0925e2 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -75,4 +75,5 @@ targets += x509_revocation_list
> hostprogs := extract-cert
> 
> HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> +HOSTCFLAGS_extract-cert.o += -Wno-deprecated-declarations
> HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2>
> /dev/null || echo -lcrypto)
> --

FWIW, these deprecation warnings also cause perf to fail to detect libcrypto:

test-libcrypto.c: In function ‘main’:
test-libcrypto.c:11:9: error: ‘MD5_Init’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
   11 |         MD5_Init(&context);
      |         ^~~~~~~~
In file included from test-libcrypto.c:3:
...
cc1: all warnings being treated as errors


Perhaps it's worth applying this fix a bit more broadly?

Greetings,

Andres Freund
