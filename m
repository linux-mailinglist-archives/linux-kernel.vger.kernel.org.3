Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658AC4ED31E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiCaE7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiCaE7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:59:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177133204F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:57:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so1559169pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdZk9i6x3JUMXUMZExcnmZQSoLNlGLPED3J5A3uwvzA=;
        b=AouGX65RPyNIzjTOwJsTyIqO0ld7tKqu63LKiO4H4YaTnus5DJqytPEigiB578vhkK
         XmFHTMTc4O9rBt+kTr1fnDN3YuObyEDhKu+m884aWlNIJHX+XMjLiREYCay8fAkw6Kv8
         tqah5zQ70EEIBChOv3Ivtq/GLvXlS9MpjIYt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdZk9i6x3JUMXUMZExcnmZQSoLNlGLPED3J5A3uwvzA=;
        b=42lYi/tgcFBJibgA2fF7SZQDjuqeWX1dqPLDNJEAg119QqMFdt4AbStBbEHbPq5RUc
         cA3eF1WlYAYm0xi/BIZB8rJmi9bcn2GC38QyTHz4D7dhT8M/4OZA4ju9Yn76TSq5j9HS
         Ry+78eMB3nlQ+2YARyj+VuSnqabt1HdQcLGuKOF/yRnUGTV5Pcr58BKfbgD4bQQGJHUx
         M/HASwRfL7BPzl77CSebfgYBxSaGbqS5Moe3rovCpyulgAbSmVyfaNZVeCs2OjWIkzjy
         GYp3nXwv+1ij070yb7vzqhs5rSxSGP/yGUK2IkKf4lrZLWFlHwnt8o7e5wG/AxzhpBfs
         zOpw==
X-Gm-Message-State: AOAM532AMf8ev/4Zo7r2Cp2QM3GX2h8KcxeEtgBurzMw9/tVL0DdsVwg
        2BQKsGg++yZdPWCexwsT8eDdyQ==
X-Google-Smtp-Source: ABdhPJzfIRpnfEt5n0GvvQSkKx3DziOK9JbR3UnlvHqsQcFI/ZcBzRB0/k/lBwMSJdHfPCI5q3+6wg==
X-Received: by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id r20-20020a170902be1400b0014fce67d0a1mr3162210pls.29.1648702664441;
        Wed, 30 Mar 2022 21:57:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9-20020a63b909000000b003823389e47csm20850546pge.9.2022.03.30.21.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 21:57:44 -0700 (PDT)
Date:   Wed, 30 Mar 2022 21:57:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
Message-ID: <202203302156.87918948B8@keescook>
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234528.1426991-2-nathan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:45:27PM -0700, Nathan Chancellor wrote:
> This flag is specific to clang, where it is only used by the 32-bit and
> 64-bit ARM backends. In certain situations, the presence of this flag
> will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
> out -mno-global-merge from USER_CFLAGS").
> 
> Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
> building kernel with Clang") that added this flag back in 2014, there
> have been quite a few changes to the GlobalMerge pass in LLVM. Building
> several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
> (minimum) and 15 (current main version) with this flag removed (i.e.,
> with the default of '-mglobal-merge') reveals no modpost warnings, so it
> is likely that the issue noted in the comment is no longer relevant due
> to changes in LLVM or modpost, meaning this flag can be removed.
> 
> If any new warnings show up that are a result of the removal of this
> flag, it can be added back under arch/arm{,64}/Makefile to avoid
> warnings on other architectures.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Yeah, this looks right -- the history of this option seems to show it
is no longer needed.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
