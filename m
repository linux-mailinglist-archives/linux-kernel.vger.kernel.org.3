Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EF4967B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiAUWMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiAUWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:12:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B33AC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:12:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l17so3686080plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W5fZ4/3+YDkiPOESVuTV8Qsje56I2iPwkvvGyw3F90=;
        b=QVxTzTt5hSy+20MsNu5t2oMrg4eOCs5D/sfzCPtsw8JCbOE+k81GeR5RwhVwR/SKh/
         dzVPfJnXT2zBgu8iiczmUszLNFxWOUOeNrNhVdPKkybQM7NGcHQ6rijsvW9ZO3rAZFGw
         4gJYvOwZOTAma8cgTdL5k12rO+o+mbdVWovKWrXjTou6wvOrs5A+NVX/KtAuQICYZZek
         QJPoDalxVDDO4vweT7E5FKksmG4DfRZqYYAAxLVLDnavOyT1a/HIr6FDucvQhbW7v+BU
         1GM3sFxwxnQGIunaLJ5hHX4v8bbDmTjLcYApdlz4y82JU2tAC1XscUWykeaKIwoXhcpu
         qwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W5fZ4/3+YDkiPOESVuTV8Qsje56I2iPwkvvGyw3F90=;
        b=Wr23ia671EVbIGjREZzw3TXXSwlb1ZlV7P07MVPOuq5JA1WjbzJbOmtrYYu2D8KiDL
         8J4VMtHMZmVTtuRAJO8IjGQlwWxRsfKi+/jMPKDm6uQMn1/TcIig5aKeBGWQeJOiYP8j
         KgQUcCmPpIhiCTSCnuPUkuANIXARvcDGe3oQ5Po4WuxgM2nCmFt8BvZP5z157EU+O8rI
         6oMYwo5XIwmNMzZLjgWLPa9w2AtixnISYcgtDtBvO/RYwnTDan5D9V2GPCKS2Z3cS9ci
         U1WDrO5tYp0NcEuhsXkPaywFljibPjUF+lu9Xj3NxDqq0Ke3sqJQUs7/aBJzu9KnbIyS
         yMzw==
X-Gm-Message-State: AOAM531lwLZi0wZjJeo+L8EP/K5NVgoTqWeWLjNa7Da42g5oltGbzg0c
        Y+RLb1IIjdFogjlBPPrzUGjAeILE+suWBHiqqDP4ow==
X-Google-Smtp-Source: ABdhPJzfvhsCjDXBj8JKkx9G7ywzhIYYm4i3GTBaEHnQVpjzrriW42Q9cpif6KvRN54GayL6xNH45D9QxSCtpsTRwM8=
X-Received: by 2002:a17:902:dacf:b0:14b:2225:2f06 with SMTP id
 q15-20020a170902dacf00b0014b22252f06mr3347976plx.123.1642803158536; Fri, 21
 Jan 2022 14:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-3-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:12:26 -0500
Message-ID: <CAFd5g46vj-+SyXP-B+AVZ58aNbD2weRCQ63tDG=HfBn3dttbUQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: drop unused intermediate macros for ptr
 inequality checks
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 5:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We have the intermediate macros for KUNIT_EXPECT_PTR_GT() and friends,
> but these macros don't exist.
>
> I can see niche usecases for these macros existing, but since we've been
> fine without them for so long, let's drop this dead code.
>
> Users can instead cast the pointers and use the other GT/LT macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Oh, whoops, I didn't even realize we were missing those variants.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
