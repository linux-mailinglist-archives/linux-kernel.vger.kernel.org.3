Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6753BAA3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiFBOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiFBOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:24:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFBE023
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:24:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so4627090pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxegqmluZfGum4dvqgOU0+mOd4/mzJT29RY5Mq2PSmo=;
        b=uuMOyjNlfwL7j6moDJgG7DcpONkUOrVwhM+DNWrYmg9aBd84kznKvan3AuRTwU+naM
         ddzHcbYCFjll4jQY/8xij8z5PH9TjyFteu10hVgP+97GbMTSRdC9F9wOnYl5myYVVqZ6
         BFnJaP5RM3r837wxhmP7YR1NxvitZSWxo6tKqCGanlMz9eEnVMcgCJ+kJPKJbOQlZYsG
         8omRmI7n5WHCyzEaI4Tq82z80958skwJPzvGAimZ/hHT/BSZZgzserZ3G9MCFdZkZxBF
         Y3qKuT5LzzTe4jsuv32TSpQFkC1mCLnzX3eOpto4VqKyd2VOl928uscBl+lSRwA6D6JS
         bHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxegqmluZfGum4dvqgOU0+mOd4/mzJT29RY5Mq2PSmo=;
        b=sbFzckUhE1625QCgRztpNOerZ6N3P/HEU0EhLMgiLht+5/swczEZxv4pm4SeRdMSZt
         oZWAowL+U0wDixA1I/Mu5jskV1LCxlLeCMDEaa+bNVw9s5d29xcdep+KwMchyJuv0WAx
         v/AEzRsKfKR/tvR65SQStjU5QrQB4Rw3DBuAwnpju7jw9jMXwjrjiSdnWyXK5JFoIBs/
         oGtQw5ow1C9FeV9OzjRq7iJRhrcib0pll31DNhV75xcXfEFach7iNe6iYhUg4Sf90Ph5
         //08n97Cc4v8k6NUPN/ynY7L5VUi1o2VFfE14DtBSptsroPxBlKwwQd9cqA186b0+SvH
         dzgA==
X-Gm-Message-State: AOAM531i7Nugb7jYRz/RK++HxS/1wKo6YtY1Y4y0YtzvlsSXjbq3AsNv
        Bm72jfWqfrCsCrM+7p4HnFJARMTbYeAxuci/ntQ0Jw==
X-Google-Smtp-Source: ABdhPJz4UU8XuKbPhBvUtYn+vGDCxPdlAiRGgoZq9L/JtvSNTSAsfHCO47SNz+0Rft+0oHk7biDkJsyU5kZLT2AqgY4=
X-Received: by 2002:a17:903:11c9:b0:154:be2d:eb9 with SMTP id
 q9-20020a17090311c900b00154be2d0eb9mr5088209plh.91.1654179865316; Thu, 02 Jun
 2022 07:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220521124745.8747-1-roger@norberthealth.com> <a728cf17-4866-1151-0740-56b06257c917@infradead.org>
In-Reply-To: <a728cf17-4866-1151-0740-56b06257c917@infradead.org>
From:   Roger Knecht <roger@norberthealth.com>
Date:   Thu, 2 Jun 2022 16:24:12 +0200
Message-ID: <CAO_iFwrHcSWJm17fL-Q83DZ5i1xr+_dkEjh5Yt3Hxso0VtnzZw@mail.gmail.com>
Subject: Re: [PATCH v5] crc-itu-t: Fix typo in CRC ITU-T polynom comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ivo van Doorn <IvDoorn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Kristian Hoegsberg <krh@redhat.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 5:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> I don't know which maintainer will merge this since no one is Cc:ed on it.
> You will probably need to choose some maintainer to send the patch to.
>
> But let's add the people who merged the header file in the first place
> for their comments/review. (done)

Thanks Randy.

The CRC implementation seems to be unmaintained (no entry in the
MAINTAINER file).
Any idea which maintainer I can send the patch to?

The kernel doc mentions Andrew Morton as last resort (added to CC):
> You should always copy the appropriate subsystem maintainer(s) on any patch to
> code that they maintain; look through the MAINTAINERS file and the source code
> revision history to see who those maintainers are. The script scripts/get_maintainer.pl
> can be very useful at this step. If you cannot find a maintainer for the subsystem you
> are working on, Andrew Morton (akpm@linux-foundation.org) serves as a maintainer
> of last resort.
source: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Roger
