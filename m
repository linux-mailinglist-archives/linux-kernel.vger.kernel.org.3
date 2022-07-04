Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F18565288
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiGDKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiGDKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:40:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C353EE28
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:40:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k15so8268183iok.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1JWAJTEOjSekzmejCmdpgbqSNq9je/ySUKRvPMIxAQ=;
        b=LMlfsPdOfVITI4dl8E7OU7YYCW19dQbPx9y/Va3qy7kHc65T/d2j/vnoOXY/4y1OQZ
         LnOpiZ7sCPEnHkyURyQufvEITNGFP0XG3lG6Suks2aZJidCBmKITmMZqQaFvXDbnbX6l
         1cdioinBWUZc7Cuv8nTz9BEBmIEa2wc1dxTfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1JWAJTEOjSekzmejCmdpgbqSNq9je/ySUKRvPMIxAQ=;
        b=uMmVCBvnO3Nx9x8Xp/OxUO8WvBNNVOlsdBjRrd4KKtRKpBjjUmC3WEqeytuOrkOQKy
         01OGGL4SnVPuzSgcVHMP9dj9mIjuf/Orkazl/SDfksXt4Qm2+9gIfE0y0xRDfYXt06QM
         lvnbObExpxnPaXdj4DxU/HDBzvF74nydrW4Y5Mehi34aN1PVWrQ1Eiq2vH1tINFBWyJg
         ML6SQ34v/DmEBhug8wv4oHuBqgNF69dbyxQg4/z+FH4egyyPS7kCMpdct1pcxMuDNc5X
         0wy//CVUR6XfH22zQ1fyrlbw4FFGQCzffgQlr8pccUo0Vjl/0J0tQ6VZ3d0JFhNpZs37
         7gwg==
X-Gm-Message-State: AJIora+QTy3YSDeGzZW5bfSFqwSbA0sFrMBOlbTisK53zSrA+5/BTjSt
        NtukD21fsYPm3OM9/KGzwB7TDVPTroYs8hYgmQ7Fig==
X-Google-Smtp-Source: AGRyM1sDeureVe8Mc5RO8bhBUxXsxSCnlsxHlB6RyuJ3f0pg+lsAI3hjwsKpEwoYpN4btKBhazYU23QFndpIEdv/DLw=
X-Received: by 2002:a05:6638:154:b0:339:e14c:867e with SMTP id
 y20-20020a056638015400b00339e14c867emr17534600jao.190.1656931219880; Mon, 04
 Jul 2022 03:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220630140506.904-1-ignat@cloudflare.com> <YsAD1rHPsG8OG36x@silpixa00400314>
In-Reply-To: <YsAD1rHPsG8OG36x@silpixa00400314>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 4 Jul 2022 11:40:09 +0100
Message-ID: <CALrw=nEBAARO5bxyqqzzpSTwYSukC9MdXugqgFC0sFmQ84Yp4A@mail.gmail.com>
Subject: Re: [PATCH] crypto: testmgr - populate RSA CRT parameters in RSA test vectors
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 2, 2022 at 9:38 AM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> On Thu, Jun 30, 2022 at 03:05:06PM +0100, Ignat Korchagin wrote:
> > In f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster
> > private key operations") we have started to use the additional primes and
> > coefficients for RSA private key operations. However, these additional
> > parameters are not present (defined as 0 integers) in the RSA test vectors.
> >
> > Some parameters were borrowed from OpenSSL, so I was able to find the source.
> > I could not find the public source for 1 vector though, so had to recover the
> > parameters by implementing Appendix C from [1].
> >
> > [1]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Br1.pdf
> >
> > Fixes: f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster private key operations")
> > Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > ---
> >  crypto/testmgr.h | 121 +++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 100 insertions(+), 21 deletions(-)
> >
> > diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> > index 8e2dce86dd48..7d503b4e1e41 100644
> > --- a/crypto/testmgr.h
> > +++ b/crypto/testmgr.h
> > @@ -185,7 +185,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
> >       {
> >  #ifndef CONFIG_CRYPTO_FIPS
> >       .key =
> > -     "\x30\x81\x9A" /* sequence of 154 bytes */
> > +     "\x30\x82\x01\x38" /* sequence of 312 bytes */
> >       "\x02\x01\x00" /* version - integer of 1 byte */
> >       "\x02\x41" /* modulus - integer of 65 bytes */
> >       "\x00\xAA\x36\xAB\xCE\x88\xAC\xFD\xFF\x55\x52\x3C\x7F\xC4\x52\x3F"
> > @@ -199,23 +199,36 @@ static const struct akcipher_testvec rsa_tv_template[] = {
> >       "\xC2\xCD\x2D\xFF\x43\x40\x98\xCD\x20\xD8\xA1\x38\xD0\x90\xBF\x64"
> >       "\x79\x7C\x3F\xA7\xA2\xCD\xCB\x3C\xD1\xE0\xBD\xBA\x26\x54\xB4\xF9"
> >       "\xDF\x8E\x8A\xE5\x9D\x73\x3D\x9F\x33\xB3\x01\x62\x4A\xFD\x1D\x51"
> > -     "\x02\x01\x00" /* prime1 - integer of 1 byte */
> > -     "\x02\x01\x00" /* prime2 - integer of 1 byte */
> > -     "\x02\x01\x00" /* exponent1 - integer of 1 byte */
> > -     "\x02\x01\x00" /* exponent2 - integer of 1 byte */
> > -     "\x02\x01\x00", /* coefficient - integer of 1 byte */
> > +     "\x02\x21" /* prime1 - integer of 33 bytes */
> > +     "\x00\xD8\x40\xB4\x16\x66\xB4\x2E\x92\xEA\x0D\xA3\xB4\x32\x04\xB5"
> > +    "\xCF\xCE\x33\x52\x52\x4D\x04\x16\xA5\xA4\x41\xE7\x00\xAF\x46\x12"
> > +    "\x0D"
> Spaces should be replaced with tabs.
> Checkpatch reports 1 error and 27 warnings.
Indeed! Not sure how they got there. Sent a v2.

Ignat
> Regards,
>
> --
> Giovanni
