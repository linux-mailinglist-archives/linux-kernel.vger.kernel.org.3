Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8CF4D3CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiCIWbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiCIWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:31:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3183B121504
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:30:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so3566260pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RsWokZGOFJHPSzwoFuRByNyvzp3uTbc23/Q6qnvKW8=;
        b=iHQ1uKunf0NymIhVJIIqi7PFPBXTAa1tiZGNpujjf74K/kDazamSmkiR4Dg1s5QZHK
         iMusadKiN5y+2u5Djnr7bVioodOs4MwoVwqcMRXI5RhgBIhh0oFImZmU6YONj6IK1GVI
         KuasjKumBG9o/CEYrZ60+Ps+Yva34+UWZNAqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RsWokZGOFJHPSzwoFuRByNyvzp3uTbc23/Q6qnvKW8=;
        b=s0Pj9XlLRw8nejLkxD3rDRtyfnnW+XXPiy6VMK/3YYLNgIpbOKjxwJDv4API8gdjtX
         JrrA7JvNf5eR0ZFbaaGJfGF/3yaXfapLtvUq7u5Cp+OhC+7C10OFOWc4SfL7kOYMWFYg
         hsI+x3bRRCUtfPkUipCrzNUvmXm0vNGIJYLnljtAGhcOyw6ORLegQsR5qM3xL18iXaCI
         8LXkFQjpON4ZqFNWulxNzGSjBXIJ7zXMUH875l5vt+wd9dh90mgm+r8ol0j/y9H/OjCj
         siKBBI/VYXZvN+M3ygDaF5hBjNTIvYj765rSJOSSp55a9/rTBLQEZx1UXlasEpjYFnig
         WASw==
X-Gm-Message-State: AOAM530vg55U0kYCAeeNaAdZUm70BBUFaEushPbaoxTAu3PIFis9UxTD
        qVesv2+RADcVCII1cjvH3zFFGkFjr4nOfQ==
X-Google-Smtp-Source: ABdhPJzk41JSXWcW34bjqfUXoqxr3Nnwu+D8v2uRr1teCwfKj5gE526iKqY1TLXi4uMMEMMUZLYlzg==
X-Received: by 2002:a17:902:bc47:b0:151:ac43:eae0 with SMTP id t7-20020a170902bc4700b00151ac43eae0mr1969023plz.117.1646865013674;
        Wed, 09 Mar 2022 14:30:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b00380c8bed5a6sm1802737pgf.46.2022.03.09.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:30:13 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:30:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 06/13] task_work: Remove unnecessary include from
 posix_timers.h
Message-ID: <202203091430.8D5A105@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-6-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:47AM -0600, Eric W. Biederman wrote:
> Break a header file circular dependency by removing the unnecessary
> include of task_work.h from posix_timers.h.
> 
> sched.h -> posix-timers.h
> posix-timers.h -> task_work.h
> task_work.h -> sched.h
> 
> Add missing includes of task_work.h to:
> arch/x86/mm/tlb.c
> kernel/time/posix-cpu-timers.c
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
