Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23254D1D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiCHQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348486AbiCHQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:40:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E751E53
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:39:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so2910253pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jttNtqOCv/g/jfkTi8WCuPi9YGKOdMF84fDPlTGUuek=;
        b=fqEBFQebFeTvjMPqx1KU0usJ9t9uHgl6HeTepPeEjOhZsS/+LMF8WkKgPbB5aubZMX
         c9PRgR3F0VqaerE+/1d17p0hYi7W19lhL8Ke/DxWxyNk47FLaHlm4MQS9EarwwG7L2JC
         J9bw/i4yjpFwbGfkRn8sTA4J0WmyLBqswrwhTvbAoc0TTRCWYensXpOq/lPNwo7kyYks
         hIxzYPzwmwGTfXFe9xuTWg/z/rGIEHwyEb6m0p6VkhcwGJRkonm2jFt+uCg+doiVqlfg
         i76tdHnnv2L6mZdeUjImHxvE8Pm46DRID3Mcfvs0qijD5VRL8CkF8Kfor3tlrXlqZz0a
         ipkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jttNtqOCv/g/jfkTi8WCuPi9YGKOdMF84fDPlTGUuek=;
        b=wIjws5ZIXGLfenz2pIHgnrj2A7Rd5n9uvXSBigPpaanDfk7Nk9coMupAkStexkQe/I
         2r1SCQVn+Hjzj/o3lt9xrtoLxCV1ahHwrdP1aUimKckybAHlhKgh6CMkQLrlzNTMqlcq
         R7C+kc3NBFoanKw2ZVK2yRnp3MAuk/768tznjkCsHL2kKfCAU64t1ItOMaJLlzNi5kC8
         KkweKtwXJmB4kNm4LNU6kJ7pOgP6AGga8VOzi06h2UJUDvvnclhbIC/8DR2xDEDC/SpG
         U4aQkVe/iOvt9/SSJSteXnDF/3LT83dINXSsRfYiZv8hKXJjUETy0WQpfBgK/vJIqtRt
         XrEw==
X-Gm-Message-State: AOAM5317HivRI6coTDKxhZ8PpVhvTwQkKCrjstgHDTX+dHCX+r39cTKG
        ZN2gXh2WC+DX5hCjg5ZzidlraA==
X-Google-Smtp-Source: ABdhPJw22MgZHcaD6/vU/aiK/EoNSPWtz9sq3vJ/NB/X8/lT3V1JK+jb1IWH13VCCg60z3oHl9gosw==
X-Received: by 2002:a17:90b:4c44:b0:1be:f4be:d69e with SMTP id np4-20020a17090b4c4400b001bef4bed69emr5577702pjb.163.1646757596305;
        Tue, 08 Mar 2022 08:39:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm15513048pgc.8.2022.03.08.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:39:55 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:39:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 05/25] KVM: x86/mmu: rephrase unclear comment
Message-ID: <YieG2J+CdoUTTAB9@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-6-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> If accessed bits are not supported there simple isn't any distinction
> between accessed and non-accessed gPTEs, so the comment does not make
> much sense.  Rephrase it in terms of what happens if accessed bits
> *are* supported.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 80b4b291002a..d1d17d28e81b 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -193,7 +193,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
>  	if (!FNAME(is_present_gpte)(gpte))
>  		goto no_present;
>  
> -	/* if accessed bit is not supported prefetch non accessed gpte */
> +	/* if accessed bit is supported, prefetch only accessed gpte */

Can we just reword the whole thing?  A/D bits being disabled is the anomaly,
leading with the "if" makes the logic we really care about seem like a secondary
concern.  E.g.

	/* Prefetch only accessed entries (unless A/D bits are disabled). */

>  	if (PT_HAVE_ACCESSED_DIRTY(vcpu->arch.mmu) &&
>  	    !(gpte & PT_GUEST_ACCESSED_MASK))
>  		goto no_present;
> -- 
> 2.31.1
> 
> 
