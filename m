Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD347B194
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhLTQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbhLTQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:47:21 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:47:21 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 7so16605990oip.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0gnlaxeyQCadoEVMeSPUHUzvKRb7RQN7LbRSbZFfatM=;
        b=IRUvy0sq2WOTrv8jDUNtNJ7B2na2N+ZG8NYZCS/0jSMFnueLEV9VTK2tF68J6+y1yV
         d/qsk/tRw7PJRkAnOM65R2Se+gvKI9YoSyVZ0h+eMfqdVhFufS0UCXWelkjVp51nKzr5
         90RZO8la0DZdYQhKeqFVHAZkWNjSzGJsLLS21yDrJ05HnoapH5oICEbiwF+CI/DYuhsE
         1Lb+L8NZeiCUpBa3AMxBQTz7r0YIcPjn2EhhUHdw+zUKg0A/tXu7fybIPZQRMw1saL0Q
         G089EwjVrAeQqAWnm6SY9OMhoS5v+KSsI2OJ3td6G+9vsM/RAE4Lo3OnvNZCtOGdQV+9
         iTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0gnlaxeyQCadoEVMeSPUHUzvKRb7RQN7LbRSbZFfatM=;
        b=6LRqvRtTItnGYFV8/nBEffZKarpF9qSKqxhY7DlIpBMdiANR5u7nI4fggKR4HzwLOo
         hKXOC6V0jQxMliYAAO32ZdWUlgLw/bh89n5FIvt+wgsncyoVaDB13mxWy+JwBIiXWq1a
         7WeDFuOKShyWU/d8MA+FDFuM7EEK0otK6kAOzvL4uE+rwlvOOHTJLQgaQ9bZ4m7pthW/
         MZvM0pJP5d85ZYUTGRAHhbzviv1Q9MKD01NfE71G6BYFkcend7hYkcof1F07HYE5ngn4
         e3zwrPYwVl/NFEyDKIpuUT8Jt7euzm5OyM1QnX1B/UjKos2E38IS/CB78LtgFGCZSvwM
         Qt+g==
X-Gm-Message-State: AOAM531gkAf90WmTi0Bp8LiD404mirrcV2iC1VOPla6lnb+N+qOu6Xvq
        QwYxoPLc7cYHUSH51VKv/374G2J+Lwo=
X-Google-Smtp-Source: ABdhPJybXwLFr6ZI/n+3GF0+Nirw+wOCE29j1RW8vhLJJiWUKHNaP+kExUwBvX02S8PhqzYba6HYtQ==
X-Received: by 2002:a05:6808:2016:: with SMTP id q22mr12445827oiw.81.1640018840485;
        Mon, 20 Dec 2021 08:47:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 184sm3498343oih.58.2021.12.20.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 08:47:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Dec 2021 08:47:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc6
Message-ID: <20211220164718.GA2284495@roeck-us.net>
References: <CAHk-=wgWuZPhK6dgXsS42iMz4o610Uw4QXeUsTSOQheNo1tf5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgWuZPhK6dgXsS42iMz4o610Uw4QXeUsTSOQheNo1tf5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 02:39:17PM -0800, Linus Torvalds wrote:
> Things are calming down, and rc6 is fairly small. That's normal for
> this time in the release schedule, but it's also normal for this time
> of year.
> 
[ ... ]

> I know most of us are preparing for Christmas, but give it a whirl,
> ok? How important are those presents (and that family) anyway?
> 

Fortunately, robots don't get holidays off (yet).

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 480 pass: 480 fail: 0

Guenter
