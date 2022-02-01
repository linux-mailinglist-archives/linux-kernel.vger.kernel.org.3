Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4D4A54A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiBABVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiBABVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:21:20 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883FC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:21:20 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b4so9761966qvf.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c65/uOQpJpDnuXGtBIQx/No3NpZidPNM3fLKI1tlsN0=;
        b=GXS29XeB3gfQaZm5ktGnRs/uIYL2phXcWpUyl/dkaPoGbwW6ajdp0quUzUkoFkPunJ
         SxNPMSj7ZiH/xX9gIJ34mziqKjLF1dqAuqFO2drEEBYZatnPq6zvGXk926R83HQl4VS6
         MP4ApohqQxhuYZgG5weqrcaFv4UAYPzwA4I3QMPJy4OVdUKb9edn28AtXzYIfF+K1X7k
         d7dGXosyyQBH/FOa9SZ9qu9XpYKzr9iE8rQrH1nzf9pgt6thEKU/D/zMJ3IIN0GJc0p4
         tZ6pOBBJ5VazdNCru4UkBcIJZSfUtEeIoCs/MHSxMzd46sw2Xd5SAS5DDED4st1p9uS2
         W5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c65/uOQpJpDnuXGtBIQx/No3NpZidPNM3fLKI1tlsN0=;
        b=iub60ivJ0ms//UHtDwnh8lgsyT9zNIWJLQcpm8dYEr7zT/xWnSGrjqWD0j/xbfqL3F
         y3cVMkAo81aTMIbfTfJE1ps0tLrC8waegPAjoPiGj4XSrIxj4hLwACInGZbDTNwbHEh7
         omsORTaZ6lGrQ3njVVOji/50hA5LO+34jWFWUdVR/OCc0llDIjQgg5hLBaUCmSZ+8MhE
         cETPX+f60BhAFXwe+eG0L/JKOhw+txI8EA5pH5c3JJSKOuqfptR5sCB+S9LL3FykbUsE
         3fMqkBKrEdNQvRmNK+QjlF0pW9PPBUCGDG+Axqa/WpTKc/fzIeg1gZUOU+ngMn2YLEV5
         2Ofw==
X-Gm-Message-State: AOAM531zVb1+J7V9A5QQoSaLyCcDmN7ISKAIVMUEfXyOF2aL2z7GeRVr
        vUVBtQxq85HntBo5KG7W4HQvYXsrPOBUbKNxGgeFSJsZOaQ=
X-Google-Smtp-Source: ABdhPJxBm4HRf8ShOL0sGpornMIyLFhBCTSzHMFXEAXThr6eapAontlVBTZZUAWQbK3HIu9X0Ypvx5lG7+Ek7zNVqL0=
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr20594534qvb.13.1643678478537;
 Mon, 31 Jan 2022 17:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20220131003637.14274-1-rdunlap@infradead.org>
In-Reply-To: <20220131003637.14274-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Feb 2022 09:21:06 +0800
Message-ID: <CABVgOSmGr37mf0X0BbGxUAgch7m=aqCQtdzhYN-Wq-wq70Synw@mail.gmail.com>
Subject: Re: [PATCH] Docs: ktap: add code-block type
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 8:36 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix multiple "code-block::" warnings by adding "none" as the type of
> code-block. Mends these warnings:
>
> Documentation/dev-tools/ktap.rst:71: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:120: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:126: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:132: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:139: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:145: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:195: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:208: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:238: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
>
> Fixes: a32fa6b2e8b4 ("Documentation: dev-tools: Add KTAP specification")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rae Moar <rmoar@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---

Thanks. For some reason, my version of sphinx doesn't warn on these,
so thanks for picking it up.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/ktap.rst |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> --- linux-next-20220128.orig/Documentation/dev-tools/ktap.rst
> +++ linux-next-20220128/Documentation/dev-tools/ktap.rst
> @@ -68,7 +68,7 @@ Test case result lines
>  Test case result lines indicate the final status of a test.
>  They are required and must have the format:
>
> -.. code-block::
> +.. code-block:: none
>
>         <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>
> @@ -117,32 +117,32 @@ separator.
>
>  Example result lines include:
>
> -.. code-block::
> +.. code-block:: none
>
>         ok 1 test_case_name
>
>  The test "test_case_name" passed.
>
> -.. code-block::
> +.. code-block:: none
>
>         not ok 1 test_case_name
>
>  The test "test_case_name" failed.
>
> -.. code-block::
> +.. code-block:: none
>
>         ok 1 test # SKIP necessary dependency unavailable
>
>  The test "test" was SKIPPED with the diagnostic message "necessary dependency
>  unavailable".
>
> -.. code-block::
> +.. code-block:: none
>
>         not ok 1 test # TIMEOUT 30 seconds
>
>  The test "test" timed out, with diagnostic data "30 seconds".
>
> -.. code-block::
> +.. code-block:: none
>
>         ok 5 check return code # rcode=0
>
> @@ -192,7 +192,7 @@ line and should end before the parent te
>
>  An example of a test with two nested subtests:
>
> -.. code-block::
> +.. code-block:: none
>
>         KTAP version 1
>         1..1
> @@ -205,7 +205,7 @@ An example of a test with two nested sub
>
>  An example format with multiple levels of nested testing:
>
> -.. code-block::
> +.. code-block:: none
>
>         KTAP version 1
>         1..2
> @@ -235,7 +235,7 @@ nested version line, uses a line of the
>
>  Example KTAP output
>  --------------------
> -.. code-block::
> +.. code-block:: none
>
>         KTAP version 1
>         1..1
