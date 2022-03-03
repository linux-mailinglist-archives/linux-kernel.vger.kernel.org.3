Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A44CB439
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiCCBUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:20:39 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91161688E2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:19:55 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id b5so187906ilj.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfdxHsJdjpHJMT5Bk6OrqDEOsR0qkATqti2d54wO7lo=;
        b=j9gOzaJxLQ29yG3yvnUU5jtZMlCzMw81UmGCof7z/ll/LSRBr6hl86GwqCJk/GPj2v
         GgDbwlTHOYsE5XBYqFm616+DrrJkKWTV32t9/+DWkx5g0nap6wVoRby2i9WmAjJjFu1e
         MSEt8NJXImj59mVGBg2ybShyeVr8JFmMk6zys79MORGZrOwOS8H8ReAxNgni9PhxeR0T
         8YNnBRK6kZQ/3dI5wQ+JZFLexE27mVoMpkv/2PfS+JgOCPReWNGJYWR9fwAENAz6k//h
         8x1zNUsdVpPyjXLuWItZ2R2WJhKYoLzcCJ4B4BrU95K0JxpLFrFKTDz+Do9IZNhhqwm6
         oCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfdxHsJdjpHJMT5Bk6OrqDEOsR0qkATqti2d54wO7lo=;
        b=u/IVCQDepkiWtF2xvTqSQOfv2k5DvoV3CgNg1xG5fE23lv3D3us6vgMq5IIgQKV50/
         Qk2g0RjUmcvjdsFqch3d8qGhkvIxm++n99q3yIFNPkhLbEkjB6aJD5KvQ9dIX4+qa49v
         zZ0joeEUcK6ntDWotG6uRNcp6Uz6e4qPF0UIdCEK5rZ+07d0HGFr4hI8m9bPTZXakV0a
         US6cgWxnJ0t73F002jSDX3WD6zDvxMq/liuA7CZLp+4Sy3aAESpnXsdP0/Sd9w6lzCdn
         1YiWCopaE5830Q0erV0+nTsVlLpxTUdkimyiL4X4RnSVVV+mAnmYwoZSv9U3GG5FZM2j
         l8xg==
X-Gm-Message-State: AOAM530s/k+eOrTPfpubeeAy2aT+GAN0qmzvsfXVv2olfbxa3bVM3Opt
        b17MrkpHH4qSocQHdc0BBCoPC8odtscpuQd1w95aPnOh18Y=
X-Google-Smtp-Source: ABdhPJxyx1WpMObbtDIfVBmDtK/+qLIkFnQyHTzYdT47kD/+mvGRqtvv3o7jKZdQe8VhuoUQUV/HN5CcBpvajIkXhJ8=
X-Received: by 2002:a05:6e02:198b:b0:2c2:c454:ea7 with SMTP id
 g11-20020a056e02198b00b002c2c4540ea7mr20629794ilf.151.1646270395383; Wed, 02
 Mar 2022 17:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com> <20220223154718.83500-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220223154718.83500-3-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Mar 2022 02:19:44 +0100
Message-ID: <CANiq72msgSQ2Tp3mKd+AtK5yK5Jqhr2Xws_rdOFxAbqzMpFN2g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] auxdisplay: lcd2s: Use proper API to free the
 instance of charlcd object
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
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

On Wed, Feb 23, 2022 at 4:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> While it might work, the current approach is fragile in a few ways:
> - whenever members in the structure are shuffled, the pointer will be wrong
> - the resource freeing may include more than covered by kfree()
>
> Fix this by using charlcd_free() call instead of kfree().
>
> Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
> Cc: Lars Poeschel <poeschel@lemonage.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy, queued.

Cheers,
Miguel
