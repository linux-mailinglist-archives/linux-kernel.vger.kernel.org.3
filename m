Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3D584408
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiG1QRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiG1QRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C086FA25
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:16:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so5349251pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xiDt4CGEXpnM9NEKFnyFksPM4nq3Hw4T4BwblzVCemU=;
        b=X97n+o25JJrFRC+7mp6nbPalLntb26lF+F1u76My851tXXdyLSrXix8ClnPPqAmkIP
         1Dngq1o3RaMnZ1DQaTAr3ToE4HxWHBdSvwzHBLJw2F096KBUayVv2rht83z7nhMyRVSb
         uxXT0HnvCoGbjLLHUPJAPA/zY4NTiNcSoqi+ypvJSr/Z68fct7x8PuB/HFvYMP8IASqB
         dqsGYgAyV3Sfv8/rlg3Njiz5okhbh0R2TFbDkrk157hzE4DDqQG51JIm6c4FTNOL8Arl
         c9gurwZTikOoxhwja8stlU0eDBhCnAORf81/8oaclQR29P9K7By3D9RQmDQ+FKPQDZhS
         zpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xiDt4CGEXpnM9NEKFnyFksPM4nq3Hw4T4BwblzVCemU=;
        b=mQSerggnWNDY+MPX7VPQjziyPGwNy/p8diyRWlw6iYRtEch4RK5BxzgrfCzRVZMgp3
         g3KuvbINrrQ+QOxKIDs+qWwtNiSp6M9B3lI6czOLo6WhE5Hr9qsaE8lWMLcIBJzONjsV
         YTb++Yc2jnBTJ7k32E1z6EP6H2RJHc4SqFbojAvusggoLaeJOndAtWuWZeURaRvQBDlM
         k0mb+6c7eW1NtPjawX9SlibH+5Lm/dhKbujyP/gUUdGEcT5GhW/5M2wh0C4VIQUFnT2S
         C4f7yhqu+BSMtKIHOrYK2c+OF8dcrD7RbE67ETQ3Jve42qZKrKpmYmKIDrvWjUSSAJ3q
         Ny6w==
X-Gm-Message-State: AJIora+67XHBaOqST4v+oyfuIFsGLcLCDpdAa85C6XHm00aY0LkN5YCh
        V4JahxEBKXZNw8xvYuxdgrcZLliPdDFV7A==
X-Google-Smtp-Source: AGRyM1sSpeCG4DMEEgM3SoS0VC4vfaNtldweOzDSBor2LcOuF5RCyUwA60TIyqdBnVtD68Bh6Oy+mg==
X-Received: by 2002:a17:902:ebc2:b0:16c:da9d:96dd with SMTP id p2-20020a170902ebc200b0016cda9d96ddmr27225620plg.34.1659025016313;
        Thu, 28 Jul 2022 09:16:56 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b0016dc808f29bsm1333551plg.13.2022.07.28.09.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:16:54 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:16:50 -0700
From:   David Matlack <dmatlack@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] kvm: mmu: fix typos in struct kvm_arch
Message-ID: <YuK2ci/LJ2BTHqah@google.com>
References: <CAPm50aLBuq+zH9VHNDGLiB6Kqwwapus+dFwNqiOm8kruzPnouQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50aLBuq+zH9VHNDGLiB6Kqwwapus+dFwNqiOm8kruzPnouQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 06:37:24PM +0800, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> No 'kvmp_mmu_pages', it should be 'kvm_mmu_page'. And
> struct kvm_mmu_pages and struct kvm_mmu_page are different structures,
> here should be kvm_mmu_page.
> kvm_mmu_pages is defined in arch/x86/kvm/mmu/mmu.c.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/include/asm/kvm_host.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e8281d64a431..e67b2f602fb2 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1272,8 +1272,8 @@ struct kvm_arch {
>         bool tdp_mmu_enabled;
> 
>         /*
> -        * List of struct kvm_mmu_pages being used as roots.
> -        * All struct kvm_mmu_pages in the list should have
> +        * List of kvm_mmu_page structs being used as roots.
> +        * All kvm_mmu_page structs in the list should have
>          * tdp_mmu_page set.
>          *
>          * For reads, this list is protected by:
> @@ -1292,8 +1292,8 @@ struct kvm_arch {
>         struct list_head tdp_mmu_roots;
> 
>         /*
> -        * List of struct kvmp_mmu_pages not being used as roots.
> -        * All struct kvm_mmu_pages in the list should have
> +        * List of kvm_mmu_page structs not being used as roots.
> +        * All kvm_mmu_page structs in the list should have
>          * tdp_mmu_page set and a tdp_mmu_root_count of 0.
>          */
>         struct list_head tdp_mmu_pages;
> @@ -1303,9 +1303,9 @@ struct kvm_arch {
>          * is held in read mode:
>          *  - tdp_mmu_roots (above)
>          *  - tdp_mmu_pages (above)
> -        *  - the link field of struct kvm_mmu_pages used by the TDP MMU
> +        *  - the link field of kvm_mmu_page structs used by the TDP MMU
>          *  - lpage_disallowed_mmu_pages
> -        *  - the lpage_disallowed_link field of struct kvm_mmu_pages used
> +        *  - the lpage_disallowed_link field of kvm_mmu_page structs used
>          *    by the TDP MMU
>          * It is acceptable, but not necessary, to acquire this lock when
>          * the thread holds the MMU lock in write mode.
> --
> 2.27.0
