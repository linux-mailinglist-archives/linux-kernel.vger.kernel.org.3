Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405354D042F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbiCGQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiCGQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:33:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3793999
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:32:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g20so20743802edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKIMSKOmQczp0e6D3JRJ9osYjA5YlKV5jswL6vSd9pk=;
        b=ZQi7BcyODgCaLpWI/kNli2EcnYEqbd8pRZdohi1haz2FUjxyyCk5U6OMre3VnDW9Tq
         7xpDQtt0UZSpQk19GGPy3pCdMF03L+Ji9FQDHjooCGnS2K3CC5Le3RDjEPFLtrg6dKMq
         6cuqAz5dhEHDcD5jBN/XA+0liSXvF1o80wpOfgsyUsAGY0OvPdXkXFFpa3dZacbCt3cb
         t4PnPCzfbq/hl5mkMe70tQY8rvTa1gVp3sO8ENYO28Z8o2Oy0H2hfAPyj+8ZvTn2UZqB
         iQV9VReyIv3jOXGc597NGm7+nlUi4d/TJGU5DDyVfLfKYao+oD6Vyj0ZYuwK8F3SqSI9
         Zxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKIMSKOmQczp0e6D3JRJ9osYjA5YlKV5jswL6vSd9pk=;
        b=TSk4DNdvBTT8l0nBWYLfBJ1kt3fwXlMAmvLOgT9hS4KSlG657LBvWwhT5YhFue2dcg
         T4by0XlVb/452dXttu4vTNBsEq3O3ezPJkuKURvZt6XUNmpiGDJhPlMpTITRlyx3Oj64
         nZQv5B/8SVQl3loKwvUo0qUT2dpH+C/+ugCNy0gp0d/69oQe4UxWPYiFOJ9IP3wTb0va
         WMk3YaIqIYPHQ1SV82O30+PAQy+dfF/nX6Tv9V+o4zhm4y5cDLqtany6o4lqGnZAhaX5
         RBloKwKi/Mr15kNmEVYQnuhbEpk37A1oAOqGm3+wFFYKIO/6zP9wOY3J+dx/3+wGuDUt
         /y0g==
X-Gm-Message-State: AOAM532HiLqYMAHZnTY2p/VGf98Hivj4G5o/wqW7X9uTAUKo5b2DDqJ2
        Vr6e50D9NXhBIW//Pe8Vltk97Af1zq0jGdKkW2A=
X-Google-Smtp-Source: ABdhPJzgCSDInhVXluBgTVXooS+lwRYvYEcgpdwDZqc0IWXtJwfUM3gUJ9qS5If1hgV2rmpSaUg39zZD0Hy+sugIK9k=
X-Received: by 2002:a05:6402:268a:b0:410:cc67:e792 with SMTP id
 w10-20020a056402268a00b00410cc67e792mr11879020edd.218.1646670731100; Mon, 07
 Mar 2022 08:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com>
 <CAMZ6RqKaq8GiPYMyL4D1ksUtgketAF905oBgwKuGLtk7BmobZw@mail.gmail.com> <20220307150750.1762040-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220307150750.1762040-1-alexandr.lobakin@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 18:30:53 +0200
Message-ID: <CAHp75VfXeo0rrKB74t7gJOcv4CEnkByucE+Sa1hT2GTap=oQNA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
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

On Mon, Mar 7, 2022 at 5:10 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
> Date: Mon, 7 Mar 2022 22:50:56 +0900

...

> For example, people tend to make the following mistake:
>
>         unsigned int i;
>
>         for (i = 0; i ...) {
>                 ret = setup_something(array[i]);
>                 if (ret)
>                         goto unroll;
>         }
>
> unroll:
>         while (--i)
>                 unroll_something(array[i]);
>
> The loop will never end as `i` was declared as unsigned.
> -Wtype-limits catches this.

This looks like a wrapping value issue, not sure if the type limits
makes logical sense. What I'm saying is that the waning is
controversial. It may help or it may make noise.

> Not speaking of checking unsigned variables on < 0:
>
>         unsigned int num;
>
>         /* calculate_something() returns the number of something
>          * or -ERRNO in case of an error
>          */
>         num = calculate_something();
>         if (num < 0)
>                 ...

Depends on the context. Here is a mistake, but there are plenty of
cases when it's okay to do so. And in the above the variable name is
misleading with its semantics, The proper code should be

  unsigned int num;
  int ret;

  ret = ...
  if (ret < 0)
    ...
  num = ret;

Again, the warning is controversial in my opinion.

-- 
With Best Regards,
Andy Shevchenko
