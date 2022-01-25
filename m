Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BD49A86C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318681AbiAYDGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3416067AbiAYBy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:54:29 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C0C02B86A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:12:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p37so17792912pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juHcihMU504MExcTZ9GLv7lBDDM16Zik+9Orkm7/GTI=;
        b=KLwkpP+q4x5XMX/jnXWG3fY+/0wY1bYlCFIKbH4s9Ms/2M408GBXQ2AcIrtmLJIexK
         gy8nus3KU7jtyyF/v6Deesi8D9c04gizslrKQjDEX7dQ8djYZiggvQTzTnnY9KXar2Uq
         FQeNgv19sV7EDKZOY1bib1xVAp/EzNza19DPpCIA7sfPZV4LqmFC472e9s9KhNnKCeQ4
         RazQQK+ObmTTJbYg9ZR/nq01NuaQ80znKxvBwJOZRNz9qaL4EalZK88mQeS7yyZqKXlO
         ohA/9RoRh6+5yU9Sen01iwVfvzw1wzie3LXuBfdXmiX62jhYsk5u30YFdd3kZtV/sQvU
         FVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juHcihMU504MExcTZ9GLv7lBDDM16Zik+9Orkm7/GTI=;
        b=4gidiXZCaHNuayRaNHl8ff6pKL6Y+wzamqBvL2tsr5JJeOhXj8cVwEI5PtVcNW5xq6
         ma6csdVIj+Wc/EdlIwhWT6uXmq0tLH5Jofwh7cQAGKdIidmhPI7Jyk5L2tTzHiYmVyJ+
         6nOA6TEhwSVLo4kNi3TtG25cbKLU+5q0jgMneDp9lpF+STgBFibi/vsz1LKjJZfUexxH
         on0kJixIdyq3wakavK1VkJOx25SmzIUxSpGqhQ6YrcFsnEUHCTe+eSkWrxKHK/AjGLP+
         2aBLUnfAp11ltpBsGOo8ysJd+WiaXJPjCpc2ZE66AR464aGk3vhCup1I4In+B1Poyw3Z
         HhqA==
X-Gm-Message-State: AOAM5322Mx6D8RcIFrJnLF2/mjgfsx8EtdyUcDVUiocuXzC3Oii0PAns
        wb0s9ov6dGR5ZD5lxhpFXNtFj9vj+ej9RXqFAaX3RXPWQNk=
X-Google-Smtp-Source: ABdhPJy6/hRB7xHzNbOoBC98EAuozrsI80oV9sSX1lfyCFZZVO0quV4pwoKzg8R+7D+Iw/5WcQm0rBLgCkuROG0JD7o=
X-Received: by 2002:a63:6b44:: with SMTP id g65mr13597344pgc.175.1643073177245;
 Mon, 24 Jan 2022 17:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20220105031242.287751-1-dustin@howett.net> <Ye8RaQcIuR6kpaYj@google.com>
In-Reply-To: <Ye8RaQcIuR6kpaYj@google.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 25 Jan 2022 09:12:46 +0800
Message-ID: <CA+Px+wV8Ygz3n=4TtX1F6YB3Gcz8amNmotru09ftn9w776nDuA@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/chrome: Add support for the Framework Laptop
To:     Benson Leung <bleung@google.com>
Cc:     "Dustin L. Howett" <dustin@howett.net>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On Tue, Jan 25, 2022 at 4:52 AM Benson Leung <bleung@google.com> wrote:
> Tzung-Bi, could you help take a look at Dustin's series?

Pardon me, I didn't subscribe LKML due to it is too noisy.  Could you
also forward the 2 patches?

I will try some magic
(https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development.md#Downloading-a-patch-from-patchwork-into-IMAP)
to get the mail thread.  And subscribe LKML to get further patch
series.
