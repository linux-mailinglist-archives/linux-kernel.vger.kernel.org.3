Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7546C426
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhLGUJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhLGUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:09:07 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F7C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:05:36 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x131so360844pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgYEUXbXJnnaXhuLas61v51X/GU1A03HhoOGNbWznls=;
        b=myJbxd20cJHzOhtFzksBCaz14XF0J+ZIoFTkJKwkBAQSsbKJKSnUDKGZpVCWcxgrUx
         nwknjq4sOXBawDYgFdZssPFZPiM1d5PNq+B0OVvWjsWoe+BP+GIMdxWlb5Os7EE28mlE
         QADptOhOeTmblUDKZo+wzpthShGAhxtqhnpPZwCfZ0tOU+q7ZP76PBhR4+5XWhR0vV08
         HnDJa7X4VFnGQ0VTvPdam4fSB3GQLowXFu8TVdc4FIFJEDxJzXf5r+7Hg/z3yhf9UOJ9
         0B8/Wc4YL/JJiFkJhwUEQtQWq3j3lW/hZ8gGylmYU+orUtAIQqt1JhzyvcU+PIYQJqwU
         DNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgYEUXbXJnnaXhuLas61v51X/GU1A03HhoOGNbWznls=;
        b=EQZNMvHtyVj/RPduKec/nfo8WLUNkTtDOwpgeTGozXXeGoyzl8ipIxtJwfrqXevpO9
         JT36Z2fP0ZAvBaMNZB00rUDzQqAPrSGYir2OQTnJ3KwNZbjIzuL4tO0WVhwseuRKSrWy
         kK6yAV6jKq5BqxDpiMZ6vXb0ZAijxqGjev2d+xA7IRz3pI/iT5Es1JjWVy9FUL1o6h2F
         w3F6i5iY/lPpRvpMrdlb1zNYBYvEizprBNA7JHqQW/GEsDZUpO63PySoGVFdlZ4gCDu1
         2ljj4rSvKxozK74SDGNBtKxCL3hS1Frf91D9A4uYISHtEDy7VJEpks4t451LzViBuhoG
         0Rkw==
X-Gm-Message-State: AOAM531Gxk53ORVG3Id01M1GMjP2NaK0Q4oZM0RnN4583380kFsBZlhj
        pbMRLFkRRCSi9qZSjSJaZoQcy4e3QQ5MDRGH+/zTUw==
X-Google-Smtp-Source: ABdhPJxwSkadnRD6LrIKmzZwTM9QAa4PDN+XAQfPHrmj3HkH9rSrr8S1Hsw8ZlLuS9gBam7VH5GhHZqA2fRlFPr9XXo=
X-Received: by 2002:a63:34f:: with SMTP id 76mr25135340pgd.609.1638907536157;
 Tue, 07 Dec 2021 12:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20211026153638.3857452-1-dlatypov@google.com>
In-Reply-To: <20211026153638.3857452-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:05:25 -0500
Message-ID: <CAFd5g44mWXs-cunWEtVUWgsA3rJe8P19-409SMQNjrYGW0E4iw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: remove claims that kunit is a
 mocking framework
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:36 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> KUnit does not have any first party support for "mocking".
>
> The original RFC had some, but the code got dropped.
> However, the documentation patches never got updated. This fixes that.
>
> https://kunit.dev/mocking.html has a current writeup on the status quo
> and will hopefully be eventually folded into the in-kernel
> Documentation.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
