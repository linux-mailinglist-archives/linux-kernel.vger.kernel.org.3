Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A133576347
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiGOOAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiGON7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:59:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C18A7822E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:43 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso3191670otg.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRcx9c8UdpURDQJn1/FwxxpqDetYYI9ywH8GAGTFS+U=;
        b=gtFC5Oqg8xhzmhUgw0Irrwnhki0tPLqR9BejFwaaiBIjCPhOyRnjtS0e/MhDRfvZEp
         pWel7RCg+ldSNukr8AXo5gUxGdJGqejdOeYCBnTemXJsM828rHl1BfwxibWOg0SgIM4D
         KzDI4U/R6UvCdvJv8YmLFWyV/HrlFGdyyY7fQd0SOPwxGRo6qbvVI13JDTwNIoQZJkZr
         HUDMJEx7i7BccgEhBdezfzh9+7tdqzh8Mq8osrTCIPKgvnS41lJ5iDKNdySTfLjTEerZ
         ic+pFPpwJ9narc2AT3FePEMX3fX7rV4px3LxHsqAQuJ5gmH+Khb0JG3UtMsx7bHEtq9b
         P8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRcx9c8UdpURDQJn1/FwxxpqDetYYI9ywH8GAGTFS+U=;
        b=kI2vo5UytYESHXfOe5l8B4RAcBV8AGlTYmW0dvLMXlJK/PaSGQvYJNSLCmESghrCg0
         3H8JqZrvmZEJBU4cVuxbD5EqJhWdxaZ68jhHuqanXNE6gEFeYerXBPP9KxVd/aMxF+JI
         6MCBDi4oOyyQ9cc8jK/aFIAjKIfPkNKTG+lqtAT7AEFLbSKkGOkYIFLwqf+JoQ3HPc/V
         NDpzfDGwsBaI9+RQnRZx2J1dtH56kYDDml56NuucM78MRQDXKsTFP6auabw44calDDYl
         n5CW8XdcrV1ioaiECUo1s2h2QEiwtGsxXTDuAicXoBr8uu4IJReN5GcXpO2WL6TxSNRU
         QQzw==
X-Gm-Message-State: AJIora+zStj6p8fmrBpduLh/GwsyvIcsE0AnFbp6ktJpT3NLZKXw3Sfd
        ASKHtCFjua6a/12f4I1DE/WF3YRKaYfyQB9DOyRC8A==
X-Google-Smtp-Source: AGRyM1vHO/STc1Sj/3EukFJjIixl6baJ3J0IcXnUJe8IzBWtptFSN2Sx5Bh1wsfvM0lhDyfQSxknYauFRHkVPPk85tk=
X-Received: by 2002:a9d:873:0:b0:61c:3f57:39e2 with SMTP id
 106-20020a9d0873000000b0061c3f5739e2mr5396066oty.299.1657893582980; Fri, 15
 Jul 2022 06:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-7-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-7-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 15 Jul 2022 14:59:07 +0100
Message-ID: <CA+EHjTx-yqnkikhsvBdJMPOOyZK+yTeFpZxmQ=u57oezy4KQFg@mail.gmail.com>
Subject: Re: [PATCH v4 06/18] arm64: stacktrace: Add description of stacktrace/common.h
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Fri, Jul 15, 2022 at 7:11 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Add brief description on how to use stacktrace/common.h to implement
> a stack unwinder.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/stacktrace/common.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index f86efe71479d..b362086f4c70 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -2,6 +2,14 @@
>  /*
>   * Common arm64 stack unwinder code.
>   *
> + * To implement a new arm64 stack unwinder:
> + *     1) Include this header
> + *
> + *     2) Provide implementations for the following functions:
> + *            - on_overflow_stack()
> + *            - on_accessible_stack()
> + *            - unwind_next()
> + *
>   * Copyright (C) 2012 ARM Ltd.
>   */
>  #ifndef __ASM_STACKTRACE_COMMON_H
> --

Ideally it would be nice to have a description of what these functions
are expected to do, but that said,

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

> 2.37.0.170.g444d1eabd0-goog
>
