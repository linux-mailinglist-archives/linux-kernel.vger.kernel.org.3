Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF3501DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiDNV4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiDNVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:55:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC78118A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:53:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t4so5933370pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUWTQrpnr3ofnuYRMoFQ70S/yjLY9Y8vBL8YKw/kQsc=;
        b=fQxaYeYJvYd7b2pp/KGWG5Vx8kcXY4LVh+NHg1G0nqUarkxFClfm73NukH/Pi+jLnx
         J34SXFTJmFSdj7lvBX24p2Fz+TchLrv1hZ/N1cApaiuXVyb5Ago1+udKizVITQ7KFl38
         FicwfMPfGHFvkwu9E8061ROu5W5Jq4RTQ873cNT+SKhF7IFVP+VU09EYEGcHNZzErh6w
         CabYRJBFghGa1uNjjGGcsAFXiOVcfVQ4Zjo+1LAJ7waOf1obtnjnyBSONLfo+zjS7PhL
         LT2ChuPxNbpw9mEa0pVxwaIXxU26d3/EWg7v2r7XbwmH51dgSfPstDU0hIOuIIYTReDl
         qcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUWTQrpnr3ofnuYRMoFQ70S/yjLY9Y8vBL8YKw/kQsc=;
        b=Vk1Or+1IGubcl5ITA/5LTaKutSzzX+CnLwM/Cjc50W/AZIG6PzZwSYMwnfH8WUlXs2
         7w+zD2Dm4mYe5UipiNLlQFpj7oyWZ5cZ6soCm+MKXSbvsUntxU+K2hBNJ1wj9Z3lLHtv
         BA/bj/ei5Z1l70zjeZBcvUs7zaS7GWmFGfFDBlq2vAd/nHPTgYC4hFGf3JFmesUMISih
         9cI3T9Dsy52DmWgeStAnSN69B1NhST9TKZspzwAxTzA3RK0bo+iYlp8ZXt16pzIZ95nV
         yqpLeJQ0bqJdc3pysGsNvaI5UITQGYaNhE+mBNPG1kgIjC3ee2nrClckrLnbEDbzFiK0
         C7BQ==
X-Gm-Message-State: AOAM530HlNVnxHr+kw78ggvB/9nuA/7GAp5NeJsZKdH9l9M1l1Tt7eRX
        TUQfWu3anZs3fxdnt0q7o4R9BNlWan36/7QljSb/+9gCIw==
X-Google-Smtp-Source: ABdhPJx9ymsemc0+5i916kEfjLB7rgHgcyATd9Hcd0pBUKaMwBl+oWiTuphe0h+MoenK9bSrca1ddvBWbjtfIsBblCw=
X-Received: by 2002:a63:6bc6:0:b0:39d:966d:2791 with SMTP id
 g189-20020a636bc6000000b0039d966d2791mr3875379pgc.407.1649973203853; Thu, 14
 Apr 2022 14:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
In-Reply-To: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 14 Apr 2022 14:53:12 -0700
Message-ID: <CAGG=3QUF8am44D-jy_pSTirV4-Kfr5QTavRc8tntytxt2iqj1Q@mail.gmail.com>
Subject: Re: toolchain mitigations plumbers session
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qing Zhao <qing.zhao@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
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

On Thu, Apr 14, 2022 at 2:30 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Qing, Kees, and Bill,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
>
> Would you all be interested in leading another session on
> kernel+toolchain collaboration for mitigations? Do you plan to attend
> plumbers this year which will be in person?

I'll be in Dublin during that time, so yes to both questions.

-bw
