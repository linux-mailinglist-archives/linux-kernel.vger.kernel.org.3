Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A1598819
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiHRPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344298AbiHRPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:50:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C974CD3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:49:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v4so1581503pgi.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4hJQQZBYGXrhIgpi2e18PbmhqiurRkQ4r1UmXxi4v9Y=;
        b=omdwsKen7qjiAj2w6T54A9EShiBsMl0XHFGTV/2iYIdlnPgbT1dUelOPiqOewvtyNZ
         n/IWkoVWt14Qom7377M2wRa5xGhNMgrx8VKYNExR1lDv/nlTrpOOcbUYZHwEPXarTUSo
         XLHLIJqWaZztG1JWeUrV6t3+WTpwx/IPfqnxtEMTZCMYo+krL6GFwhYZJKAY0trxNsEh
         DTlV8ahHWOPP3n5CzqdcM7s9g9FOGbY2VKtHrC+79f9OFIPH5FJ05ONmBD5JORXbswBp
         veQH/ZP5yu1PQRtFcDQWoSJPMmJ+g9DzQ1Q89pbRU7f7utFQVJH3Ox7iIhFr8SxIIY1Z
         UJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4hJQQZBYGXrhIgpi2e18PbmhqiurRkQ4r1UmXxi4v9Y=;
        b=Tv9Xy/VNNFf9+1iPjr2A124XRSAbSvS072rLntVaUvyMgwXsYhEzxEODr3CCLqVf96
         1trQh8FsQDjAcY/fpHT1qGgrxbg8n7XDY0agHXHTW8LJRBS1FoNVnRyEVQlzOSxGAIYp
         2AAvinmC+czTcfp2cj8bn6k7B0ZDZT76DYJXmdTaepG+H7OsmgtnyVSHZSYUv418hKCR
         v87g3zHo8KU9DU4qVNs19hGtscdIRKNfYj7OhdTgxs8BkzbrMWtnA6md1ja9qjWu3/P+
         XMn7q5BAvTg7yOUs7I6QPNJee9MHHr4B5Rj1ytXjCOsBS/1dbNXSldgTOU2e6pJUtIQR
         qbsA==
X-Gm-Message-State: ACgBeo15KECQia5LhAx058g2QUsEJKEUZH6poye5v+IDMSGY73ux6JNd
        OU3i7f1ok4BlA5tfOS/dVrj9bPLBANp/wXnG3/g=
X-Google-Smtp-Source: AA6agR7eUaYgWQuelRzntI8mW0P8+zA+gyP/1ew26716fygF/egM243ysWN2vXmkbINa6nfd+a0atJyRixtnRT5w0Qw=
X-Received: by 2002:a63:87c3:0:b0:429:fa0d:c954 with SMTP id
 i186-20020a6387c3000000b00429fa0dc954mr2997122pge.96.1660837790858; Thu, 18
 Aug 2022 08:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628145552.349839-1-xiehuan09@gmail.com> <CAEr6+EDVhMwF1cok1StkYPSd_AMdMsn9Kw9U+Bt5p9i7CYZG4A@mail.gmail.com>
 <20220705134946.01cff121@rorschach.local.home> <CAEr6+ECutZuYZNYzv-oD7Ss5nfg8eFAdwDG75E5NhM3UtkmH1A@mail.gmail.com>
 <20220818112644.40da65bf@gandalf.local.home>
In-Reply-To: <20220818112644.40da65bf@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Thu, 18 Aug 2022 23:49:38 +0800
Message-ID: <CAEr6+ECGx+3L82WWtKkm6eV8_GLCwH_9YNia+rO3LM7ZynQzYQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 18 Aug 2022 23:05:19 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Hi steve,
> >
> > I would like to ask whether this patch set may be merged into v6.1  ;-)
> > The kernel development is indeed very different from what I originally imagined.
> > I originally thought that objtrace would soon enter the kernel
> > community, but I know
> > it may take one to two years, or longer or discarded, I have slowly
> > come to accept this reality ;-)
>
> As, sorry for the late reviews (trying to get through all the other patches
> too). I'll see if I can look at it this week.

Thanks so much.

-- 
Thanks,
JeffXie
