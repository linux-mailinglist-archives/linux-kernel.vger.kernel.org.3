Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1324BBD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiBRQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:10:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiBRQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:10:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33F105AAA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 139so8292245pge.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HAYrDphdekGq8Y2YdxSlByL5fP4/mKHO4xQXVEQlRIA=;
        b=WtOl1Gg29/RXqP6+l0OXUA7jj3EGFt3yNmclK999v8XN6uBArMXVClQ5BwJBGv27IT
         BGn5tyTnaQM8s8Qt0IZ8zzJS53z8duXCnHVMmXMw0O1+eMscP65VAWsOENGj/inhp5OX
         9XBhFpnpSCPLMN57fyFbWCoLfruG34fNyaahsdlRtnAUzM3nNq3twp27QmFVPCpfUtgE
         UrzW9dtFrptd+xjnw0PsjCJDIKKnP569LFbWwej8zp3ObBjJshq3lJhweZSBAAIncxrp
         JcegXpKPzjQqLOyNPkT4/G76KEAzNhs744LP+1r+cdV7yKCv/aSyCTBnTNlcHe0WkE34
         /4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HAYrDphdekGq8Y2YdxSlByL5fP4/mKHO4xQXVEQlRIA=;
        b=oERm8L+y6WBhwjMn1JpeWVMJuqEezESc2MCkVAgzsQZ/d102Jh9/qO5py90pXtzccH
         3/tJckmfe8iToXiJ3pzVNkODbsrTRqNHCmthMFCQiGHHDmeg/mxL2qR6T/PWVZdjvCoY
         JGNDfDCILsdAo7dsxvf/v00GQCi+M0PUiTU/F0Nz4aRyVA2oVb7nQzIWGPfIOZUC+tJF
         9AoAyVOuzdf1kaoxlwXHctK9L8EQfi/ifn6/TlBttQkcAPY05fgUQGQfDIjeAwr6PngW
         H7nCD1O6SmdlIq0eBh0kc3AUJTFXut63hYScm5tu7M9FefTKLmFnja25zq+XSSHe43w9
         1mzw==
X-Gm-Message-State: AOAM532iw0nTTTv4WAMevpYBzmri1XEFd+8zEfP9AJhIs1NC63B1UTBs
        o9YKXwgvqnIp/S00eciQCWZWRA==
X-Google-Smtp-Source: ABdhPJwcLmDZWmg0L3526xbxQ3iTxJHpDES/UOFw0XqtXvvvDJ8V2+nR1w2BOMdmn38i0LpaESo6cQ==
X-Received: by 2002:a63:5911:0:b0:36c:4394:5bfa with SMTP id n17-20020a635911000000b0036c43945bfamr6763463pgb.519.1645200627893;
        Fri, 18 Feb 2022 08:10:27 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x5sm5130665pjr.37.2022.02.18.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:10:27 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:10:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4]  x86/kvm: remove a redundant variable
Message-ID: <Yg/E71MbiFWq9A0p@google.com>
References: <20220218110747.11455-1-flyingpeng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110747.11455-1-flyingpeng@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar comments to the other patch.  "KVM: VMX:" for the scope, and a more descriptive
shortlog.

Also, this patch isn't part of a series, it should be simply "PATCH", not "patch 1/4".

On Fri, Feb 18, 2022, Peng Hao wrote:
> variable 'cpu' is defined repeatedly.

The changelog should make it clear why it's ok to remove the redundant variable.
E.g.

  KVM: VMX: Remove scratch 'cpu' variable that shadows an identical scratch var

  Remove a redundant 'cpu' declaration from inside an if-statement that
  that shadows an identical declaration at function scope.  Both variables
  are used as scratch variables in for_each_*_cpu() loops, thus there's no
  harm in sharing a variable.

With that,

Reviewed-by: Sean Christopherson <seanjc@google.com>

> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ba66c171d951..6101c2980a9c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7931,7 +7931,6 @@ static int __init vmx_init(void)
>  	    ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED &&
>  	    (ms_hyperv.nested_features & HV_X64_ENLIGHTENED_VMCS_VERSION) >=
>  	    KVM_EVMCS_VERSION) {
> -		int cpu;
>  
>  		/* Check that we have assist pages on all online CPUs */
>  		for_each_online_cpu(cpu) {
> -- 
> 2.27.0
> 
