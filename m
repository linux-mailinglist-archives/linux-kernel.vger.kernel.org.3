Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F146C1DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhLGRg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhLGRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:36:51 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:33:21 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id a11so14653503ilj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItbOlealijmUoY42Kqnrg2wEzqeEb/n2rzZw9C9eu6A=;
        b=M+Y/YJt01EeMA5mZq9/nxrzPx5fohaj3GbdOh/mQoxYoiNogCFxUTQlRo/r4tGUqND
         KLt2aHweS4geXwZNpwP9ezDbutIm97ifzVykwK5E2K4o02TddsgFdlRIhIr3saiBzMv/
         bOW84keI3p5cSys9GGOPO6Ei0S3DAL81aLOmr8Z32oNIOy635eTDfXo9JRxjYRZtgEVp
         ogggvGjC+ciED5bLbgTb7g+LgRq+1ox5V0rsShP9rL+KW+D98bdODTmUX4EOCsRPQl0b
         sk2eMTUse3JbAXXeSNH0YbuLmpHXh8Cd9pCZjkZIcTWA/7mbXPmmFFX+yAo+14aZ2e5Z
         OJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItbOlealijmUoY42Kqnrg2wEzqeEb/n2rzZw9C9eu6A=;
        b=ZVMoiFqmDBvWZd9MpXgMGvMwlQmbHqs3kBMM6D1RaKc4dcDTVTUDrRApNN1OK3OMWf
         jTnpcQYn7B3K+si6jXAugx6US/4TX9Ck3IljnLajc4WgQQtSO+67mJDEo3tT4lCgw9l1
         9OX0g9ZJDRpUI86rFbrYkP+WgATLQlG+0iN/zr+bdvJw4/Lc+Pkyi0eByHAV4R3bgfI3
         VyaiTWhceAgXQp6/+TMhEHPgsDBIC5Ni/WbQ2WF6/uLo9WSvXtjNRYkg74ETaTnMxHGV
         LOC6pshUZL8ykzAOLCCwpyisxlqa7n6IajPegSqVWelYgNUPr/2tMdYIWkHVsTIv5Cfd
         tMXw==
X-Gm-Message-State: AOAM530Bo0Hg3ws+FjVGeg1W3xX4fodpcHO7z0DJVXZv2jxZChiO3MI6
        Ibq6LLfWV0Mx4+cRlvRiZToMpJF7DPWzQT6MdLw=
X-Google-Smtp-Source: ABdhPJwne3CtL5BWF81WzKPmedVdh/6R/bXMqz7Tj1idiw2eplNFk6ub4hEQIlTM1HxTTR4zax6z9CF5h+5gDcgLhDA=
X-Received: by 2002:a05:6e02:1a69:: with SMTP id w9mr726522ilv.81.1638898400487;
 Tue, 07 Dec 2021 09:33:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638825394.git.andreyknvl@google.com> <a2b2528f6d96fbc6a0c68f16e7212f80f3ef1505.1638825394.git.andreyknvl@google.com>
In-Reply-To: <a2b2528f6d96fbc6a0c68f16e7212f80f3ef1505.1638825394.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 7 Dec 2021 18:33:09 +0100
Message-ID: <CA+fCnZfQr191GvWf+T2=HB3bLK2-sE4DgHSJcXsahM5BN_nPPg@mail.gmail.com>
Subject: Re: [PATCH v2 07/34] mm: clarify __GFP_ZEROTAGS comment
To:     Peter Collingbourne <pcc@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:44 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> __GFP_ZEROTAGS is intended as an optimization: if memory is zeroed during
> allocation, it's possible to set memory tags at the same time with little
> performance impact.
>
> Clarify this intention of __GFP_ZEROTAGS in the comment.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/gfp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b976c4177299..dddd7597689f 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -232,8 +232,8 @@ struct vm_area_struct;
>   *
>   * %__GFP_ZERO returns a zeroed page on success.
>   *
> - * %__GFP_ZEROTAGS returns a page with zeroed memory tags on success, if
> - * __GFP_ZERO is set.
> + * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
> + * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
>   *
>   * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poisoned
>   * on deallocation. Typically used for userspace pages. Currently only has an
> --
> 2.25.1
>

Hi Peter,

Could you check whether I correctly understood the intention of
__GFP_ZEROTAGS and give your ack on this patch and the next one?

Thanks!
