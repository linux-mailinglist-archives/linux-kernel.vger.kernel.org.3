Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3174474D69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhLNV4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbhLNV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:56:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C70C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:56:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso17260725pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiEvH3dZ8w35Q8uQwULrDyHbTCopVSdgddLU5lCK1NE=;
        b=mxozc5s3P18ZtBr6IsRAl8jEWYh7YmHv2GwKyGLFsGlz3VuP0AfcV3IagVUQWasgk8
         RaNItu47yDXU4yKq277UzVnJByennK5NZiHFEK+R68xSdvfB4HB5wLgxFu0/UkAgLhj1
         WW7vmmY5f9VwEZxI5OU9qKdjdZCCQr1pV0TIs9oz2WVrczo6RCviDUUctV8QRbSYrH5k
         hG6B6fZEQnxu3EQEKo5uFu/6lYwKRmn6xwJtK8OI/tNM8p+PLhE7Z0P0Q6EeX17uEjwk
         jtOJLoLYvkCDnqXSmXAKAUUFsDnfzwj2dqI/wSJEap3wgcZJ+WiN+uwhNNzr9HqGcoE3
         H9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiEvH3dZ8w35Q8uQwULrDyHbTCopVSdgddLU5lCK1NE=;
        b=BSpK4ZBCgFqzvbO4pJBKoOaQI/0TnW5qlfjbzjkQgQ5jQn8+MQ9HhPBIArH0I8TDdT
         WQPLf5y8zwE1eho2idoSqD0e3mDFKr662lyKu7SVA7sdnhiZlST8iW+ai2OwRA25MLlb
         7bDrLp82hNPMCiDT2Z25gyfc5pMMcKng5Ogr9bv122+TQNaqHo8PaQIciIf2JbY3X9Kt
         KoKixqoNIy8cMYH112GLdhz3+ZiNHEaf07I/2o/gaA9LgbEoLev7iNDYEhdg9VzDVyfJ
         WNlHjmrMtA8mSDPp8edwFTa691DGq5lw+T6V1joBMB4zPqrLuCRJZ9IThiEb9WzPYRwx
         Gd6g==
X-Gm-Message-State: AOAM530/2ffIF+RBWUftbmFQzzlRVgMza7lWpFsZljiaSHb6CoxI+pcL
        P98RbtY/qL5Qmjh7x6maG2rxI2KI6w5Ku1wQYEFApw==
X-Google-Smtp-Source: ABdhPJwWXh5x2Kdkq+Wqo2GI/D6Q9ftBr7WvjdQ75kt6YVEv2eTX/Qqb4OdDZMw7PmCpBxbxiPfQ9VgoesOCjg1k1RY=
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr8175284pjy.95.1639518992546;
 Tue, 14 Dec 2021 13:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20211213204441.56204-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211213204441.56204-1-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:56:21 -0500
Message-ID: <CAFd5g47FXzwtnxOH_Qc3VsWnS2RBNEreVAepWPizboZTo4KRfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kunit: Replace kernel.h with the necessary inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 3:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
>
> Replace kernel.h inclusion with the list of what is really being used.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

> ---
> Andrew, please take it through your tree since KUnit maintainer is non-responsive
> by unknown (to me) reasons.

Sorry, I did not see the previous version of this patch. But this
looks fine, and does not appear to break any tests.
