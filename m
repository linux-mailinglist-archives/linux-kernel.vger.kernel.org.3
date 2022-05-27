Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6CB535F58
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351332AbiE0Lgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350996AbiE0Lgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:36:38 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F430540;
        Fri, 27 May 2022 04:36:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s14so7416388ybc.10;
        Fri, 27 May 2022 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2I3hQXa2wguUKKHpEr9lzRtvv8oSEArMwe0oODAyyTE=;
        b=msgUO1QeXFPr+hkvzfvrxs4FoDJjLMTOA9M4A9Z94nPaT7bEArs6LoJWzUyk+X0P0A
         ONgQ5IqwOjrJAz1l62PSoRAj/a/qlwvLj/+zUtCaDVuXkuF81DNhPkOoGn2xO9sXme3n
         d3+RcmlmG1PzhVMvc5m7baJAfWeB6W4lRTVHmvdv/O81ucdVW6tqwR6M5nhC72sygqhn
         PVE2hUUJRjEQTGnICd0RdZQovQdAqMz9n8C+sgf3gemJdBsSdk17vZKnoEKvsdeBiNf9
         buUVo7NLy8hRGRx5xfra0MHBDJhF3qkeHnCzZXQA97wnVeUl0bBti200R2k4Gc+6NE0m
         RMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2I3hQXa2wguUKKHpEr9lzRtvv8oSEArMwe0oODAyyTE=;
        b=FWJthurcON0FTuBcOmmzYtpwuMNuoOH6sSvWYDA6pZCiMHa21hEfskDwvQO7mwrW+H
         W98BRFoLiV6ygGmkfwecrarzAK4t54yyxkTm+SMz24CWS18wKZjWqsys9BymfIc463UX
         xm9+TtYGTL+WvzMs8lIB9iCLj0salm2b1N+UYzjmQLpPyJLznjLyAWJ6JWDNL7vKyvyn
         yJvVrZeD8Sud6RVnH18gBD4ispy0SxOHCbT+oqi/FDtA1bM+qsGXaTYsZbAo1GOt4BVD
         lTonurV3cFUWWINrO+k4YeGivAiee5er2hBJ/12hEBX46Z8FBvH+i3QwR3Thf9AfFqbh
         0RQg==
X-Gm-Message-State: AOAM531H4cPUVn316c0q5PlLRHMbk0bXEKiQSk6WvIQ75LG/pU3zZCl+
        LXb+BnuiLBRfVF0YI4vS6uiN+j7awolmu45GlSQ=
X-Google-Smtp-Source: ABdhPJxzyeow9Ugsr/D0jxn94+JebANkocWS3pkw2xrIkT7/YjpU4U9s7zkXbU3kv3N4U2XX9Jen+B+loZRNx6Q2nC4=
X-Received: by 2002:a25:abd4:0:b0:65b:90a6:900f with SMTP id
 v78-20020a25abd4000000b0065b90a6900fmr1044493ybi.52.1653651396670; Fri, 27
 May 2022 04:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjGWp4+Ub_Ccaw+tx1NQrNcqyjUG5K30uPH3uYTF_wxfw@mail.gmail.com>
 <CAOuPNLgzBA2Sbn6vS4856LwYyBo67OYKQp49+xpwX=Bi+KpLZg@mail.gmail.com>
 <65f1b675-84ac-b5da-6075-2a9f0353ab37@quicinc.com> <CAOuPNLh-NJ=GK63+iHFE-th9J8yfWZg_S3xmLgHGM_-nCFexvg@mail.gmail.com>
In-Reply-To: <CAOuPNLh-NJ=GK63+iHFE-th9J8yfWZg_S3xmLgHGM_-nCFexvg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 27 May 2022 17:06:25 +0530
Message-ID: <CAOuPNLgk8zRHwq7PP56NYpFagjnf_+1j1c_TYvdo6kmWQBwwuQ@mail.gmail.com>
Subject: Re: Queries: Using ifdef CONFIG condition in dts files
To:     "T.Michael Turney" <quic_mturney@quicinc.com>
Cc:     open list <linux-kernel@vger.kernel.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        linux-mm <linux-mm@kvack.org>
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

On Fri, 27 May 2022 at 15:34, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Thu, 26 May 2022 at 19:53, T.Michael Turney <quic_mturney@quicinc.com> wrote:
> >
> > Kernel developers correct me where I go astray, but this seems like the
> > CONFIG_XYZ value is not available in this file.  This would explain why
> > the disable case works.
> >
> > At top of dtsi file are you #include <config.h> or whatever the correct
> > syntax is to see the CONFIG values?
>
> Thanks for your comments.
> No, I could not find any specific config,h to be included to make the
> CONFIG values visible to dts.
>

BTW, I tried another approach but this also doesn't work when CONFIG is enabled.
a) I have created a new header file such as myxyz.h and defined a new
macro with config check.
=> myxyz.h
+#ifdef CONFIG_XYZ
+#define XYZ_CMA
+#endif

b) Then I included the header file in my dtsi file and used ifdef with
the new macro.

#include "myxyz.h"

#ifdef CONFIG_XYZ
&reserved_mem {
        xyz_region: xyz_region {
                compatible = "shared-dma-pool";
                reusable;
                size = <0x600000>;
        };
};
#endif

But unfortunately this approach also did not work when CONFIG is
enabled. So, when config enable/disable its same behavior.
However, if I put the #define in the dtsi file itself then it works as expected.


Thanks,
Pintu
