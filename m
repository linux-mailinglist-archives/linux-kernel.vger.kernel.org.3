Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC54E380E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiCVErj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiCVErc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:47:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677545529
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:46:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p5so11117798pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lFxTHRTFYfEev1oLkp9KfW6L+EPK8sUIMG2QD7blAA=;
        b=DbsQIj5L3GwdJ5DDRRdFqngmGWyLPyQLKUhljcK3Aa6MVPh2YZS2ZctRStfXM1EktN
         NxF/ryfa2YMh/rI6H8ru2aC+Knt7GUuHri2WGTMHLr3PkI+ADSVUtrg5wLNf8LxFRt4F
         7Jw4fnyVFlZ75uE7VUsTzLQ5NWsLWcW/gRHWEZ48mNqBrswojETw+2UXsFgQijPdfCYd
         S6PeeHK/JeIkCdKFs0/ovt+4LB5pju0v2U0FOA6gmAPemWsx5QT65pisMQWMbXiZG5ut
         k6CgUzflCuOFasVz5Lowmu41cgpG+Q9DeJlAE5LXGEVtBM05pwWyz/F5k+hgDcC36P20
         8F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lFxTHRTFYfEev1oLkp9KfW6L+EPK8sUIMG2QD7blAA=;
        b=cRiczjcNkwZq0Z0MTmXQBgP00vA7ifcQuJIFKnNGatimWPWAmNALLGgoPaLPB8KaWC
         qvWRRbetMEOPut6elKZ36UgWMlTmQn3kArM+PwAavGBJzhnQdZH6G8L+yccEZKzJi67+
         tEjdUWYyl242uN92FLoUv1aK82hKpZX9fUkVGm7IN7lwS1NL/IcxkdsRcejv6w15oy6p
         YpYjXkUwASzg7dNJFK6v6Xx3u57TAeLhxFdfcyD/OMl7gaY2LZYYFTNrYnU7o+CTUkNE
         9hiOX8p5z9+pudtuXQYxFxfkris0sDJvhRbID5xKJrSpzHrJR0+VdX25TIXUNF07MQ6e
         X0ig==
X-Gm-Message-State: AOAM532hcfQesr/CiUtBywpMQhLyvUQ+gWUvBc8JIVME05Dj0S+dIb2S
        GM7IKiE4U5VDaUpBT8bOiux9kIvWIP+DVt8JAOXV8vRy6ec=
X-Google-Smtp-Source: ABdhPJyJ+aeKWnvdIKqxTVN5KakOwzGy6UrysVHdWSlktVS9YzHogRl7RIYCPl4lZi6NwtVXAMyd3UY0w3cYi4olDVs=
X-Received: by 2002:a63:c00c:0:b0:37c:942e:6c3c with SMTP id
 h12-20020a63c00c000000b0037c942e6c3cmr20877038pgg.336.1647924361404; Mon, 21
 Mar 2022 21:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220308153011.021123062@infradead.org> <20220308154318.877758523@infradead.org>
 <20220322134320.1feda670153a7132f78ea417@kernel.org>
In-Reply-To: <20220322134320.1feda670153a7132f78ea417@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Mar 2022 21:45:50 -0700
Message-ID: <CAADnVQLdrztokMv8V+oJq2qs-8UNcoKUeOr67Vvb6Tk0MPbizA@mail.gmail.com>
Subject: Re: [PATCH v4 29/45] x86/ibt: Annotate text references
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        joao@overdrivepizza.com, "H.J. Lu" <hjl.tools@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
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

On Mon, Mar 21, 2022 at 9:43 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 08 Mar 2022 16:30:40 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > Annotate away some of the generic code references. This is things
> > where we take the address of a symbol for exception handling or return
> > addresses (eg. context switch).
>
> Ah, I got it. I need this annotate lines for rethook too.

Masami,

Peter already proposed a fix:
https://lore.kernel.org/lkml/YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net/
