Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3F4BDF43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbiBUOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:18:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377553AbiBUOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:18:04 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF7220F6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:17:39 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d62593ad9bso139297807b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gitQnf67UrIYwS+AKYeGa4xkTlw6MkahL4EAHICRPE=;
        b=BiD+aD6kaClH4FFw7EqJ8IiMniNk+z2I2RLppijSnQ2cEZyfC1L7tZ46nhvaddSiH/
         w6q4fz9towZeQ5uxYaKwJuOBFVfKAgZCxInL01/z3RJAzK/ncuMCOpUs0CYUPODaDI6y
         YeJ9HtXZHc1BPNAVDrDireH+QoMdRNNuTKaqRf7nVA0okfnsiXLEyrW1lKfLIh0JY0iQ
         KYoUi/Qrc/ENBkZSsrZzsYVV+Xj9s/2gz2kPzAfobyAXZfpdN+DQMDiwqQW0VK/3EKCg
         xaDpv/l8wJbqi1TurVrvY36Y7H7U6FSUEgnK62MUTzcTXFGdXd4X/r4hRu7zc0Kdq+0u
         mYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gitQnf67UrIYwS+AKYeGa4xkTlw6MkahL4EAHICRPE=;
        b=JRhsbxXP675VZd8bL2ZmVDBIQwBZomEuKWL/59ncy7hXVtgiyoSp3hFufQD02FUw41
         zYK6AvSGZN0LsfgrAfjpqhJEDy5prYCy4o6ZFD/Tgeb30gwzUVO1Eulw8wh6DW9b64w/
         Psj7Ta599WVYkUKnxs+7SDjPloiinYFARhB1eE7za8+YBUhnAsmDklevcUmqKBLNrGB/
         yumFAszLKuUBkBxYdS0CUz5nZqW8v2o3rluna6JQRniz+ZEk32C5MVfmC5fsOTLtVEAQ
         ABqaFPnsMGVVyIzWUz9hpDIXStndRKziuX++RmaBWi22TwqPL6eaXAlkG5uc/VAz0gg+
         vqhQ==
X-Gm-Message-State: AOAM531QhiGaxj76iAtCFELVZc+t+TrDNWCCU+Q3KXu7NWNghkuYJC+a
        ZoH8X4AYWy3Mo/wPJLxUCOPOfW00hFwLoYQqOCQE0g==
X-Google-Smtp-Source: ABdhPJxOLq1Q2AJ4p4Fu1I+KBtPJsr66WMtq0nJR+KXzoJo+HH/OtQlmUOi8aheWu6pASgc/TBk8kbCowQCXPLMeTIU=
X-Received: by 2002:a0d:dd48:0:b0:2d2:58cb:d6f5 with SMTP id
 g69-20020a0ddd48000000b002d258cbd6f5mr19085596ywe.47.1645453058624; Mon, 21
 Feb 2022 06:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20220221095530.1355319-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2202211143310.347934@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2202211143310.347934@ramsan.of.borg>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 21 Feb 2022 06:17:27 -0800
Message-ID: <CANn89iLFEPxVw40zpb=akgvjMM6h-Bq1CGPSTR_G5SW4hOJkcA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc5
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>
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

On Mon, Feb 21, 2022 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, 21 Feb 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v5.17-rc5[1] to v5.17-rc4[3], the summaries are:
> >  - build errors: +2/-1
>
>    + /kisskb/src/net/netfilter/xt_socket.c: error: implicit declaration of function 'nf_defrag_ipv6_disable'; did you mean 'nf_defrag_ipv4_disable'? [-Werror=implicit-function-declaration]:  => 224:3
>

Fixed last week I think.
https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=2874b7911132f6975e668f6849c8ac93bc4e1f35
