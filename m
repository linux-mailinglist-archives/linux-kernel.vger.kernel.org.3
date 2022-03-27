Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE85C4E8782
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiC0LnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiC0LnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28A473B4;
        Sun, 27 Mar 2022 04:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796F060FCC;
        Sun, 27 Mar 2022 11:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB47DC36AE2;
        Sun, 27 Mar 2022 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648381291;
        bh=t6VoOcLomeFANprad8EaurUJN8+EeVJVkUX7A97oYUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vAuaW8qdbt32Sps3YQjCuRzvyZxR3J30RLTO9MZ6RhZ/reUJOKaULrD0/8011qhOt
         ntipwcBsejX64J4OdPXCT+xnfjS8hZwrbusKemmIfqDCct0KWjg4GJIwF15Fm8NMwO
         zuik+C9EkdKfNM+Wl+mgMtylMmQuCh7z3ch7MD8XIcE8ig46uUu1UPBSVIAp3mr0DZ
         ZgsVL73x3GzcVsojpVVFCJPg/4QwY8WaZvLe6OWQBzzkxR6piTE9PluVuYXwZbKihd
         g1aopNABXZsrs1XPBhQfhacNc3QY4EyFAe/+i5ZBFMDCd6A1XXBBBUQC+/KwBpgJjo
         o8NlU2kC02w7Q==
Received: by mail-ot1-f42.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so8864482oti.5;
        Sun, 27 Mar 2022 04:41:31 -0700 (PDT)
X-Gm-Message-State: AOAM533wEd57HtjhizLo78Paiu1qejrzDDEZkFcPFVCVBj7CH0lo1ehD
        RNlygsaqO5frEqlX+KcK4iO5lZ3q2iJefrWMvY4=
X-Google-Smtp-Source: ABdhPJwbFzNiF8UXyMQB0oPJA8iaxP5kyH9o9CKgVspvtL2guF9j+aorv/84jG2eXsbuXsiyhz/DR2or3jw3VcaJxzg=
X-Received: by 2002:a05:6830:1e9c:b0:5cd:8c15:5799 with SMTP id
 n28-20020a0568301e9c00b005cd8c155799mr7946760otr.265.1648381290883; Sun, 27
 Mar 2022 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220326172051.14722-1-thepaulodoom@thepaulodoom.com>
In-Reply-To: <20220326172051.14722-1-thepaulodoom@thepaulodoom.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Mar 2022 13:41:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQtTAMPLTtgc=9sDYvgxs+oihfnY7Q6bggC0p5u-V1Hw@mail.gmail.com>
Message-ID: <CAMj1kXEQtTAMPLTtgc=9sDYvgxs+oihfnY7Q6bggC0p5u-V1Hw@mail.gmail.com>
Subject: Re: [PATCH] crypto: aes_generic: fixed styling warnings
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2022 at 18:48, Paul Lemmermann
<thepaulodoom@thepaulodoom.com> wrote:
>
> Fixed all styling warnings from the checkpatch.pl script.
>
> Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>

Did you test this code after 'fixing' it?

> ---
>  crypto/aes_generic.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
> index 27ab27931..322e345ac 100644
> --- a/crypto/aes_generic.c
> +++ b/crypto/aes_generic.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Cryptographic API.
>   *
> @@ -56,7 +57,7 @@
>  #include <asm/byteorder.h>
>  #include <asm/unaligned.h>
>
> -static inline u8 byte(const u32 x, const unsigned n)
> +static inline u8 byte(const u32 x, const unsigned int n)
>  {
>         return x >> (n << 3);
>  }
> @@ -325,6 +326,7 @@ __visible const u32 crypto_ft_tab[4][256] ____cacheline_aligned = {
>                 0x7bcbb0b0, 0xa8fc5454, 0x6dd6bbbb, 0x2c3a1616,
>         }
>  };
> +EXPORT_SYMBOL_GPL(crypto_ft_tab);
>
>  static const u32 crypto_fl_tab[4][256] ____cacheline_aligned = {
>         {
> @@ -853,6 +855,7 @@ __visible const u32 crypto_it_tab[4][256] ____cacheline_aligned = {
>                 0x7b6184cb, 0xd570b632, 0x48745c6c, 0xd04257b8,
>         }
>  };
> +EXPORT_SYMBOL_GPL(crypto_it_tab);
>
>  static const u32 crypto_il_tab[4][256] ____cacheline_aligned = {
>         {
> @@ -1118,8 +1121,6 @@ static const u32 crypto_il_tab[4][256] ____cacheline_aligned = {
>         }
>  };
>
> -EXPORT_SYMBOL_GPL(crypto_ft_tab);
> -EXPORT_SYMBOL_GPL(crypto_it_tab);
>
>  /**
>   * crypto_aes_set_key - Set the AES key.
> @@ -1144,34 +1145,34 @@ EXPORT_SYMBOL_GPL(crypto_aes_set_key);
>
>  /* encrypt a block of text */
>
> -#define f_rn(bo, bi, n, k)     do {                            \
> +#define f_rn(bo, bi, n, k)     while (0) {                             \
>         bo[n] = crypto_ft_tab[0][byte(bi[n], 0)] ^                      \
>                 crypto_ft_tab[1][byte(bi[(n + 1) & 3], 1)] ^            \
>                 crypto_ft_tab[2][byte(bi[(n + 2) & 3], 2)] ^            \
>                 crypto_ft_tab[3][byte(bi[(n + 3) & 3], 3)] ^ *(k + n);  \
> -} while (0)
> +}
>
> -#define f_nround(bo, bi, k)    do {\
> +#define f_nround(bo, bi, k)    while (0) {\
>         f_rn(bo, bi, 0, k);     \
>         f_rn(bo, bi, 1, k);     \
>         f_rn(bo, bi, 2, k);     \
>         f_rn(bo, bi, 3, k);     \
>         k += 4;                 \
> -} while (0)
> +}
>
> -#define f_rl(bo, bi, n, k)     do {                            \
> +#define f_rl(bo, bi, n, k)     while (0) {                             \
>         bo[n] = crypto_fl_tab[0][byte(bi[n], 0)] ^                      \
>                 crypto_fl_tab[1][byte(bi[(n + 1) & 3], 1)] ^            \
>                 crypto_fl_tab[2][byte(bi[(n + 2) & 3], 2)] ^            \
>                 crypto_fl_tab[3][byte(bi[(n + 3) & 3], 3)] ^ *(k + n);  \
> -} while (0)
> +}
>
> -#define f_lround(bo, bi, k)    do {\
> +#define f_lround(bo, bi, k)    while (0) {\
>         f_rl(bo, bi, 0, k);     \
>         f_rl(bo, bi, 1, k);     \
>         f_rl(bo, bi, 2, k);     \
>         f_rl(bo, bi, 3, k);     \
> -} while (0)
> +}
>
>  static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
>  {
> @@ -1214,12 +1215,12 @@ static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
>
>  /* decrypt a block of text */
>
> -#define i_rn(bo, bi, n, k)     do {                            \
> +#define i_rn(bo, bi, n, k)     while (0) {                             \
>         bo[n] = crypto_it_tab[0][byte(bi[n], 0)] ^                      \
>                 crypto_it_tab[1][byte(bi[(n + 3) & 3], 1)] ^            \
>                 crypto_it_tab[2][byte(bi[(n + 2) & 3], 2)] ^            \
>                 crypto_it_tab[3][byte(bi[(n + 1) & 3], 3)] ^ *(k + n);  \
> -} while (0)
> +}
>
>  #define i_nround(bo, bi, k)    do {\
>         i_rn(bo, bi, 0, k);     \
> @@ -1229,19 +1230,19 @@ static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
>         k += 4;                 \
>  } while (0)
>
> -#define i_rl(bo, bi, n, k)     do {                    \
> +#define i_rl(bo, bi, n, k)     while (0) {                     \
>         bo[n] = crypto_il_tab[0][byte(bi[n], 0)] ^              \
>         crypto_il_tab[1][byte(bi[(n + 3) & 3], 1)] ^            \
>         crypto_il_tab[2][byte(bi[(n + 2) & 3], 2)] ^            \
>         crypto_il_tab[3][byte(bi[(n + 1) & 3], 3)] ^ *(k + n);  \
> -} while (0)
> +}
>
> -#define i_lround(bo, bi, k)    do {\
> +#define i_lround(bo, bi, k)    while (0) {\
>         i_rl(bo, bi, 0, k);     \
>         i_rl(bo, bi, 1, k);     \
>         i_rl(bo, bi, 2, k);     \
>         i_rl(bo, bi, 3, k);     \
> -} while (0)
> +}
>
>  static void crypto_aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
>  {
> --
> 2.35.1
>
