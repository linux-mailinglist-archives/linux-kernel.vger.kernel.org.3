Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1B474C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhLNUIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLNUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:08:20 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B4C061574;
        Tue, 14 Dec 2021 12:08:20 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x6so26091811iol.13;
        Tue, 14 Dec 2021 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcClwwT0aibOVAXpgyfdacR5s8e062LtxNDnwr5pduI=;
        b=jke2JviKVZYjqK3eDLqLuKr7zq2BANQ3c669+t6D3UzrxQFTQCjOTEnpwru8woCWpe
         ZAetlNiP6qIk6q67QT1hjfTaIOVWY5WZSm9NmukSEdIxW3w4AqQLFFgkbDTExkkLv+Jh
         1URyOc8ha0g82Xx2XEuwsOziVKlBPCQS+3UFf2wvrBuZmFGySJFrtEx1aXzfQIwlsAab
         iC1uvL/iJmv7vMzIhSNRHJrnJuI1ckqCG0NX7KtbTGBzbg5uMMZrpDB4Yf7kGjKvwnP1
         HSEgXkjWdWUwxDy+BAYSKY5YnFJ6PaEj76LsEPOsxC6nHJOijLsyjxkf1AusoKb9xYEX
         zkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcClwwT0aibOVAXpgyfdacR5s8e062LtxNDnwr5pduI=;
        b=jyenBk6Q++w2y/rUYzDf6C9LR6QSgU7zDBruz74SYAYkRJuSGhT2cl9SIRLS+3Tvl+
         VqA/+H9twn9Qk0PP7GdP/egn4Li3ahBy5PelU6jC7+fY7e5N/uvSpTMcv81s1Y8G0x1H
         swkYtk2WfElkybrDcsDEpt/JMzCfJTA83jBzm90Q5IMrFWA7i6D6eEvvzgriMqeOBFZx
         dobQUydQkXDOOW51FxneknziN0OxHr7WFV5tNQ6v9cOE3fWunpMuggV/h2GZt2fsptV+
         P+b/sl75Gwb1sCYIyAIsGL56FUuZ0KwvfVdgxISxPQYZR9x7eOwUNGYFEKwu0tYHiCId
         qFsg==
X-Gm-Message-State: AOAM530naGaMyCfRcct8C5lNrKN+EZkZ11/yEP/9XrZ38M2cIor8BQ7b
        VWxJIRNtTKKkynI0lV8T6ct+lgmPIDeaDXnvYbFYJIELn/0=
X-Google-Smtp-Source: ABdhPJzcxR8nevWNaJ1bvUP6+E7XxRI4o7E1CfcZmkHT7HbVsnBz+ZfyN2MFDde5aXpjC9kTrzPOquf6pPHJL+jKJSU=
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr4364530jav.185.1639512498688;
 Tue, 14 Dec 2021 12:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20211214191415.GA19070@kernel.org> <0f74ba31-aba2-0608-b383-9ab46766485b@infradead.org>
In-Reply-To: <0f74ba31-aba2-0608-b383-9ab46766485b@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 14 Dec 2021 21:08:06 +0100
Message-ID: <CANiq72=fHrp=9cbQizyhp1hgiyBYTTunX4odaXpTjxgr+aGqKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Remove mentions of the Trivial Patch Monkey
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 8:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy -- I didn't add your Ack from a couple months ago since I
added the Doc/ changes.

Cheers,
Miguel
