Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5A493402
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349342AbiASESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiASESH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:18:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68114C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 20:18:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso4987071pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 20:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QADJhwGfWeBD6Mab8IMEbikObuIWFnSn6JyMiF5l1f8=;
        b=cqL+3sNCG7rhdiOQGbVqo9iFDc2RbBerMjygIZ4wJNMAXmwCOGUZlQFoCMF1AN3toN
         X8QW76PgubFLCYcEYsnvFbgpDfIoH9he38wPkhvNt9FdCPICm94wXvTXp4O3+L2TECIM
         KGAyUQLLf/mX1hWz6AoNQmHSZuEAmSgYjCoFjSvB6wFcHnzP3QIq/2iXF1H1pOqgjd5p
         5iWK2NR/gXiqcy0cULeKJV/UOI5KtRLYphFtkoXprgWopl6uxAmGY25zk+L86WL1Kkl9
         rlC9k59JdjUmXYprts8cBswOBejQwqoRNjjXM8qsQHTXHrbgiK+c0Y29ZyBlNzF6Kf0E
         nkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QADJhwGfWeBD6Mab8IMEbikObuIWFnSn6JyMiF5l1f8=;
        b=gjnk5CtLtg1i/CEPtrGaOBJQmGuyyZlGmjdRyH61p6LsdnTdLc/hCEa7JL11+kRBrt
         17wANjDL4YDyhrTIHE3H9janhCWR487PDSUf244EChrFtH7TIloIe1QGkb9dl4x4LVh0
         0N1lulm0Bh7oYyJgpSb6KQZ0XW0/44MVDKztp4XWxFpnSU58VL9oFD6wgNY3a+W5klU8
         YVbQfrInsqXPHaYQu+tDzUKbJcdu3xSoco4aCCNv7SSJ8pdWkaqoXUR7FhvrpO9gSqH3
         8XROEPRpB6VfRgfCYKnQAwsNeHYszbL9p5GF/XTBZlL5tM87TdZ006TtoyfqsbK+6HAI
         xF4w==
X-Gm-Message-State: AOAM532zFvo04BnfAfmSprCkYTzpS1Ij8qzh5e8jesR1LTyFkt8+M3n+
        CgA8tXkyRvbuwTS51GMOG6A1tZ+SV8j+L7rL
X-Google-Smtp-Source: ABdhPJyqt7d6eQXwc+2wp7Hxk4r7Nky0zs1z4l6wz0Nd5lYlTO6ElLmf138Xdym1GbNaTrc+Ll9v8A==
X-Received: by 2002:a17:902:e5c4:b0:14a:70d1:4347 with SMTP id u4-20020a170902e5c400b0014a70d14347mr31123714plf.12.1642565886978;
        Tue, 18 Jan 2022 20:18:06 -0800 (PST)
Received: from vultr.guest ([141.164.42.249])
        by smtp.gmail.com with ESMTPSA id p10sm19888069pfo.95.2022.01.18.20.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 20:18:06 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Yuntao Wang <ytcoode@gmail.com>
Subject: Re: [PATCH] tracing: Remove redundant assignment to variable ret
Date:   Wed, 19 Jan 2022 04:17:37 +0000
Message-Id: <20220119041737.1805441-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117074117.3770-1-lukas.bulwahn@gmail.com>
References: <20220117074117.3770-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 3:47 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Dear Yuntao,
>
>
> when you consider removing dead-store assignments guided by some static
> analyzer, you need to check if the code you are looking at is actually
> missing an error-handling branch.
>
> In this case, ftrace_process_locs() may return -ENOMEM, and the caller
> needs to appropriately deal with this error return code. Your patch
> does not change the code at all, i.e., the compiled object code is the
> same as after the patch as before.
>
> Think about how to deal appropriately with the -ENOMEM return in this
> caller and submit a patch that implements the right error-handling
> branch or argue in your commit message why that is not needed at all.
>
> If you do not understand or cannot check such basic code properties for
> dead-store assignments, it might be better to work on some other aspect
> and area of the kernel repository. E.g., the kernel documentation build
> also has a few warnings that deserve patches to be fixed.
>
>
> Best regards,
>
> Lukas

Dear Lukas,

Thanks for your reply.

Actually, I had read the source code carefully and noticed the possible
error return code -ENOMEM of the ftrace_process_locs() function.

At first I was going to implement an error-handling branch as you said,
but after digging into more details, I discovered:

- The ftrace_init() function did not handle the error return code of the ftrace_process_locs() function since the first version.
- The ftrace_module_init() function did not handle it either.

To keep consistent with the existing code, I just removed the assignment
in that patch.

Maybe we should deal with the error return code more appropriately,
at least print some warnings?

Best regards,

Yuntao
