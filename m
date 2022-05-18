Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45E552BFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiERQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiERQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:19:55 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788D1EEE13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:19:55 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ff1ed64f82so30421007b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNQ1Sa8MZ2F954WTku5lIs6bezzi8M4d/JzexPqTkEI=;
        b=fuukVjSGGYTWbJMh/yBcEw8dHvuu4PEx3FHNDRLqR7NKu60rnIJx02YBO5994skMbT
         u5xPEzDUd+jLjKMcPAyYpjdJ7oOFgiSjLCpsH6FdqQ1NaqpIDjHibGpdFkG5G7ybeSEJ
         f+mN3GRJE4fjEtXo0Hzuy4124GXXpHdNyK6kAtQvU70tn2XhvZDhxIHSlPWs0RNnXlak
         fgS9fmVNq/HLync824wEwPuv3SjrdXf8eTYlN/0yc4QrIBvN8pMswFBJ4mYXwdnhRw09
         3/VqgxmtgO7os7Ul7xsUUzTHpCGCicou+eR8KC4WNU9SCe8H1gpfdV4v8dWDGabiM3rG
         v9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNQ1Sa8MZ2F954WTku5lIs6bezzi8M4d/JzexPqTkEI=;
        b=X8KJCj4Q4xlvk3fTsZBsrKHZDblYev91XEkU760s8TBwmBqFj3ccg4fs3Crtd4fR0U
         pYue7UQpYtSk7baplXPMTJWvDUuvhFsm0aZabL9vJ0DcWMpMxbrR2Foh3IUWQwVH8ouS
         JnV8IFVfMaXF394VwQje8HgJjIcSS4E+qfGY0GKCxxl84Sj9mM2ju9C4A2z9s34RYCXW
         hAe3lwMu+5JPFt1HTFwkMUwyX51uIQmQGwGgnNakl6AETY/JkswB6Ah6Gv7Qctw2R7IA
         EXiRGaHHBut3Vw87h6luHYg7YO7EvLRP2rphtnb5Yft58WgFb80CjDOpbIjw3yxgSnTx
         aMfA==
X-Gm-Message-State: AOAM531RkqusNu0RDdzFWXeOQyPnyS4bX6ORRyvwYD6dNSHTvDyCqjGL
        XcJoGN5/jSDhRhZNYezuMp4qS/lXcKNXp50S8UJF7A==
X-Google-Smtp-Source: ABdhPJxqzMdIcOL87yz5TF1jKPIrr4XeCqmKaldQ0Y4MMtbT5EEsngoSDAW4iYMlsjmCFhHVDfSS1Qr4vlYQCUgc+VQ=
X-Received: by 2002:a81:d54d:0:b0:2fe:e1c2:eb35 with SMTP id
 l13-20020a81d54d000000b002fee1c2eb35mr151712ywj.285.1652890794100; Wed, 18
 May 2022 09:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649219184.git.kai.huang@intel.com> <3f19ac995d184e52107e7117a82376cb7ecb35e7.1649219184.git.kai.huang@intel.com>
 <b3c81b7f-3016-8f4e-3ac5-bff1fc52a879@intel.com> <345753e50e4c113b1dfb71bba1ed841eee55aed3.camel@intel.com>
In-Reply-To: <345753e50e4c113b1dfb71bba1ed841eee55aed3.camel@intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Wed, 18 May 2022 09:19:43 -0700
Message-ID: <CAAhR5DFFGTHAG9U74v9YXZkjfgfQ9vD4B76ky-MtM5fkjTgRFQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/21] x86/virt/tdx: Shut down TDX module in case of error
To:     Kai Huang <kai.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, len.brown@intel.com,
        tony.luck@intel.com, rafael.j.wysocki@intel.com,
        reinette.chatre@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Apr 26, 2022 at 5:06 PM Kai Huang <kai.huang@intel.com> wrote:
>
> On Tue, 2022-04-26 at 13:59 -0700, Dave Hansen wrote:
> > On 4/5/22 21:49, Kai Huang wrote:
> > > TDX supports shutting down the TDX module at any time during its
> > > lifetime.  After TDX module is shut down, no further SEAMCALL can be
> > > made on any logical cpu.
> >
> > Is this strictly true?
> >
> > I thought SEAMCALLs were used for the P-SEAMLDR too.
>
> Sorry will change to no TDX module SEAMCALL can be made on any logical cpu.
>
> [...]
>
> > >
> > > +/* Data structure to make SEAMCALL on multiple CPUs concurrently */
> > > +struct seamcall_ctx {
> > > +   u64 fn;
> > > +   u64 rcx;
> > > +   u64 rdx;
> > > +   u64 r8;
> > > +   u64 r9;
> > > +   atomic_t err;
> > > +   u64 seamcall_ret;
> > > +   struct tdx_module_output out;
> > > +};
> > > +
> > > +static void seamcall_smp_call_function(void *data)
> > > +{
> > > +   struct seamcall_ctx *sc = data;
> > > +   int ret;
> > > +
> > > +   ret = seamcall(sc->fn, sc->rcx, sc->rdx, sc->r8, sc->r9,
> > > +                   &sc->seamcall_ret, &sc->out);

Are the seamcall_ret and out fields in seamcall_ctx going to be used?
Right now it looks like no one is going to read them.
If they are going to be used then this is going to cause a race since
the different CPUs are going to write concurrently to the same address
inside seamcall().
We should either use local memory and write using atomic_set like the
case for the err field or hard code NULL at the call site if they are
not going to be used.

> > > +   if (ret)
> > > +           atomic_set(&sc->err, ret);
> > > +}
> > > +
> > > +/*
> > > + * Call the SEAMCALL on all online cpus concurrently.
> > > + * Return error if SEAMCALL fails on any cpu.
> > > + */
> > > +static int seamcall_on_each_cpu(struct seamcall_ctx *sc)
> > > +{
> > > +   on_each_cpu(seamcall_smp_call_function, sc, true);
> > > +   return atomic_read(&sc->err);
> > > +}
> >
> > Why bother returning something that's not read?
>
> It's not needed.  I'll make it void.
>
> Caller can check seamcall_ctx::err directly if they want to know whether any
> error happened.
>
>
>
> --
> Thanks,
> -Kai
>
>

Sagi
