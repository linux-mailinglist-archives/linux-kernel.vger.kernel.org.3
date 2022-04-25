Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6325250EC00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiDYW1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbiDYV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:28:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4FFE4A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:25:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g3so13755365pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7hl5IFxDI2eHkQRlXGbeDMciir9ECH93wIEe4AG2EI=;
        b=OJOPp5x6ocU08AevEsYvyRugrSR63fLG3uhAcQNzXko/tlxNS4dLzOSy6TOP4qTHY7
         3EylhuL4O3ShsCABXnEpCklGW1WYN4raTNoymTAYIRqGXUEl6Pd7wkV6q4QoxJB36ehW
         Z10y5YmwWpTLQKr+I6SmSdiEvgO7Z5w7qAOqxdJX1O/OgGy2hd1r4OgWbtXlqRkG3vBy
         dqnqJJ0XY4tRDVxOtEGc7LoAMyO+f6qCYGMSM+56h9NWqZZyV8J59JVP39MUs4eZ7Ui1
         TDm+0paEaftGWOhnk73QHvi7K0Bun+9M0L1zTcqLMstbZCosXO6LusdaQsTPlrg1qShU
         bd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7hl5IFxDI2eHkQRlXGbeDMciir9ECH93wIEe4AG2EI=;
        b=fxV2r5yimbi+M/T90AIh2E8xWtDxmj/xzq0IP8dcoxAgCGRYEnvIdzDEZ5m1iG5XIm
         Wb9DA6GN8OcTppjZvM4ylER1ChbpPBkjJvTqFF/hF0KlzKKvMPnYRG5qYoHu+NF+v7Pj
         h17HtiqfjEa3NQxM6oWjA8RqWp/PWmcvtIzGUcf08MEttIlk93BNx/11K6OblBzNv4ix
         sUxv+ocxFe7qo18sobfhe2u9MSeunU1UyMYZNvMyVdPGs4kL2icQLaTFJBMW4+DSXNa0
         mYgTF/jIpOwE72f2gbD0JOykA5x1Ar3lozDyoCwSw9kWZDu38XWMZr9gcH9sxltozI7O
         zmmQ==
X-Gm-Message-State: AOAM531IYNxf0EeOJ08lD6EYXkOC+TokjgAvxD6o+vUSe+ahQRF+Rm2E
        7NkzaYuufv4n1DmkcHmu3yU7ZH/ID2+q147gyX7FfQ==
X-Google-Smtp-Source: ABdhPJyjvuSyMhaDXA5uS4wqJXkzuCx/QHOdMUNQ0WA32JkkTRIkvO9Y+T/QmJNrakGd6o2JPiD3KA9ScfGvzuSGj78=
X-Received: by 2002:a63:42:0:b0:3a8:47f7:bf0d with SMTP id 63-20020a630042000000b003a847f7bf0dmr16823748pga.276.1650921914481;
 Mon, 25 Apr 2022 14:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220424051022.2619648-1-asmadeus@codewreck.org> <20220424051022.2619648-5-asmadeus@codewreck.org>
In-Reply-To: <20220424051022.2619648-5-asmadeus@codewreck.org>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 25 Apr 2022 22:25:03 +0100
Message-ID: <CACdoK4+WVdXz0jqKijF+wg=1M9V-=JpBHeJD5RJfNzq67TD+5A@mail.gmail.com>
Subject: Re: [PATCH 4/4] tools/bpf: replace sys/fcntl.h by fcntl.h
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 06:11, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> musl does not like including sys/fcntl.h directly:
>     1 | #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Acked-by: Quentin Monnet <quentin@isovalent.com>
