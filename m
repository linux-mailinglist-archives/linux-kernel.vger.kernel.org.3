Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E0478460
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 06:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhLQFJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 00:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhLQFJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 00:09:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:09:40 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so856376plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5W/bzSegDtUSc7k5vwSKDN1FXvdIqhDrrjznRYisGn4=;
        b=fZLDIXhJVef2Z1hy/ndF0dlu4HSaUi1iW5nk2bY9o8ImRzFTrPTpamqbr5GIm0q8Q9
         tUcD62tef/aGPGby7voFS2Q4O9znqtZC/dlM9iaxGmwtb/R2eP6YWbyrzMEgN/pn8tNb
         cZSUxTfTx49X31uuAc32d+RaZnez/sRMNgZWw3Hx/a9cWjIC7ZWpTak9H2I/+MNAeT8Z
         mFhMwoQgcS3zY8AQ/hEQNiqsm+9yVFEzT5aNz8vL0Lp9LbV2k9I4/ifJbb0nFQPSnB8L
         t4hsDHVqv9nYsL0s9rLLzFmjoOHmTTB41YmATNlKZKfTH2JYujVG8vbJqo3etSTBgXb+
         qA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5W/bzSegDtUSc7k5vwSKDN1FXvdIqhDrrjznRYisGn4=;
        b=F9+nFGb3XGN2qqVpvzZfkOv5EAhrsGCqIvk6lec51dfqtxWXvcduC4ngNqFdmtfUr/
         Cd/y6XJXmceHSPPheNJ/tEHwHc1M5hg/brF2C/k0QBPGMFoKYZvG8nZBawrJ84cYUQ5w
         aiBQbUXnNN8fI7P1wM1OmtusKe1BRkwkyJaoYg6SZwGNAUxu4yG1h3/itFvO4k8lUHga
         b/hQTQhQf2lqPaJ7RxSVyvPSI0vf0Xx5L8vLIjLjKJ6bi1AsJXmQyjS4xhRm8xZ8yH0G
         F4rpJMZPrjxLkNqPf1lk5RJ6cxy0oPkPX2pOKT/DxlspYPLOcJAwcJZPZ1mUtwnXW/aF
         3wOw==
X-Gm-Message-State: AOAM531HeeJqbT4j/bQVL2JatV9qaRB1DBdfoWIOYiYjHdpOdTYncm98
        8rAkp4wzD8WmPNz6bIrBghZNW6fNdEz4jwVA3VPMnQ==
X-Google-Smtp-Source: ABdhPJyqJJLzM+AwEpjT5+YuXTNw45sYnJ1rOAs2JyCLtKmVCOv6nZdUpQdI0UOsjb5oyYBeB3Y59xD1nuBqwDvddq4=
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr10274235pjb.198.1639717779421;
 Thu, 16 Dec 2021 21:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20211217044911.798817-1-sharinder@google.com>
In-Reply-To: <20211217044911.798817-1-sharinder@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 17 Dec 2021 00:09:28 -0500
Message-ID: <CAFd5g45qZjD33dBQtpqD3btNBNL6gL38=8YBBUGCAr9-ohgdpg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Documentation: KUnit: Rework KUnit documentation
To:     Harinder Singh <sharinder@google.com>
Cc:     davidgow@google.com, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim.Bird@sony.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:49 PM Harinder Singh <sharinder@google.com> wrote:
>
> The KUnit documentation was not very organized. There was little
> information related to KUnit architecture and the importance of unit
> testing.
>
> Add some new pages, expand and reorganize the existing documentation.
> Reword pages to make information and style more consistent.

Thanks for all your hard work on this Harinder!

And thanks to everyone else (Tim, Marco, and David) for all of your
help on this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
