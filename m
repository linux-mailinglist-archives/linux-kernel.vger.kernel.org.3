Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50600564B01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiGDA5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDA5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:57:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE45FFA;
        Sun,  3 Jul 2022 17:57:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w185so3880259pfb.4;
        Sun, 03 Jul 2022 17:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUHFnbqwNEVN17EvJuePSVwUNXtUTyncIemEozto/MQ=;
        b=qWegJ9/DDa1NZdfxH1bfH0i6YRaIKyY4yo6ag67IDPBUhcXn/4Z2NiyvNL5M/chc6l
         mM/ZonUIhWMaGaOnh+jGYUxCZuWOosBs4igIu9USlxL4O8yn/eN1/wfNndirgT8BUv/t
         vcrpWqNQ1ltytfkVjGzQ5EdJp75gAmuw7icdHjOm14slVO7FURwo+34IK2GcTkh+HGoq
         s8EjngmjUh7dE6L0hb+Kw1YMRTJTUd0f3at1iy+thJhcvDcsir9Xi/SidiEXuenqqRTF
         49PK+73QVgaPTYyU6OGzehKXemnWGVXpZ018nZ0hAQp2RmmtfsYC2n5vWOl3UDe2VAPa
         5jDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUHFnbqwNEVN17EvJuePSVwUNXtUTyncIemEozto/MQ=;
        b=NySur2IyhsF1YhthVk/xH3w890Mng7SHeRdZ7MnbvgXVwMVFwP6RG1kxr8kVQQmJgQ
         pyYrUYlxL3ZNU3NiQ59BJqTBWeuLqsqe3OYvaWxOopBBKieWZdqzRCv2U69SdeoVrMsb
         oeQ3AAYwtQ0bTZHxqoUWBHtXBvkBVYPdrDpVU2D70IhfwVlGUTo7cI4Sur8MHRv/53Ob
         ln/iJkGGlJuoYSuWyLKq/MM+/q8ay55TIbUfhcEASdQSBfgJUib+sAWeoCNMjkt+523H
         dF1I81eIJaKdBezsazAh9XneJOSjm404hyYbtPYD4JO4Nas7fVkOcplwVAcq/s1at3t+
         lDHw==
X-Gm-Message-State: AJIora9qXg0ZGIYbn6dppVLQvBfXPSd5baFLtrfCvlf+HfSgTUxG/Zu3
        s2/uwY0aaDfV0GR997f4VZt8aG2Y92xo/FF3bPRdYB4fd/PFMg==
X-Google-Smtp-Source: AGRyM1t9ZgPMHvKg2LidQWjeOEJECVSnSMfKaRp0TFrqWWj7dergTaM7Fsdcgt86v9anGxPphLyBwTgx146c3H62MWo=
X-Received: by 2002:a63:385c:0:b0:40c:bd3a:1506 with SMTP id
 h28-20020a63385c000000b0040cbd3a1506mr22740409pgn.366.1656896230396; Sun, 03
 Jul 2022 17:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220626022114.4020-1-jrdr.linux@gmail.com>
In-Reply-To: <20220626022114.4020-1-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 4 Jul 2022 06:26:57 +0530
Message-ID: <CAFqt6zYcWC3-=mVBYRowViu3_MrZuSDQKZ0S79zH4juVye423A@mail.gmail.com>
Subject: Re: [PATCH] ia64: old_rr4 added under CONFIG_HUGETLB_PAGE
To:     linux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

On Sun, Jun 26, 2022 at 7:51 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> kernel test robot throws below warning ->
>
> arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
>    arch/ia64/include/asm/mmu_context.h:127:48: warning: variable
> 'old_rr4' set but not used [-Wunused-but-set-variable]
>      127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
>
> Added it under CONFIG_HUGETLB_PAGE

Any comments on this patch ?

>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  arch/ia64/include/asm/mmu_context.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/mmu_context.h
> index 87a0d5bc11ef..06257e355d00 100644
> --- a/arch/ia64/include/asm/mmu_context.h
> +++ b/arch/ia64/include/asm/mmu_context.h
> @@ -124,9 +124,12 @@ reload_context (nv_mm_context_t context)
>  {
>         unsigned long rid;
>         unsigned long rid_incr = 0;
> -       unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
> +       unsigned long rr0, rr1, rr2, rr3, rr4;
>
> +#ifdef CONFIG_HUGETLB_PAGE
> +       unsigned long old_rr4;
>         old_rr4 = ia64_get_rr(RGN_BASE(RGN_HPAGE));
> +#endif
>         rid = context << 3;     /* make space for encoding the region number */
>         rid_incr = 1 << 8;
>
> --
> 2.25.1
>
