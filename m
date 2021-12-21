Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838AC47BB82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhLUILk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:11:40 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:45027 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbhLUILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:11:36 -0500
Received: by mail-vk1-f181.google.com with SMTP id b77so2281683vka.11;
        Tue, 21 Dec 2021 00:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TB3EgKnQ6cDDwbUNjEM7H+wsTNMcb9wXt6YvS3W4ql8=;
        b=jXYRKzSpCEHYENaxvdriLAWEEGUkR6NkkpovRU9Ehwl/l+QvWlHQGhTj1iyHgMopiE
         IyDHyBYl5pHroyYRjeCv539l4B4IMjm5hcyr0Lt2YVpcgtMpvKkTcpRJCusFcNSRcy9K
         kGgQoBlrH5ofcnyWQ2CccX3lGhBltYFPGVlK5TCY3smdRQmqvDJ2u/xDZ5X1n0vMbY+w
         t0oBnk/Rg6C45B2fW7Uhas5HspN83dLQqyh8jQFyMTeVv0dDxBK+Lfqw49U0oc6BDilL
         vSIYvwmTXK3nZBW39kvNYZEz3n/82hhE3xDDgcWh8hZoN5aF8eyin12wDCHoYMGVBIBC
         5qdQ==
X-Gm-Message-State: AOAM53284x8AjwrVqi4MN22CVj4cAjJDCJfjhUcSKCDIhg0qaCbnhYoJ
        MkDKlB7b5JLM1iG+oaFtjw5kzWSPY6Xh5A==
X-Google-Smtp-Source: ABdhPJxzRKHJi0hSv0lLc7UvBTg+bgTAuGdijAPJbPY9Q7lRnU7vwgvJ++BY/aHXe27BY4POTqz/YQ==
X-Received: by 2002:a05:6122:d0f:: with SMTP id az15mr385543vkb.28.1640074295784;
        Tue, 21 Dec 2021 00:11:35 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id q8sm821317vkq.4.2021.12.21.00.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 00:11:35 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id o1so22311104uap.4;
        Tue, 21 Dec 2021 00:11:35 -0800 (PST)
X-Received: by 2002:a67:2e09:: with SMTP id u9mr653700vsu.77.1640074295303;
 Tue, 21 Dec 2021 00:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20211221004246.213203-1-colin.i.king@gmail.com>
In-Reply-To: <20211221004246.213203-1-colin.i.king@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Dec 2021 09:11:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXN=jjgirX4mTghvYo1TQtW4F+5uMLxHoOFKSXbqk5qPg@mail.gmail.com>
Message-ID: <CAMuHMdXN=jjgirX4mTghvYo1TQtW4F+5uMLxHoOFKSXbqk5qPg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: mb862xx: remove redundant assignment to
 pointer ptr
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 3:01 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> The pointer ptr is being assigned a value that is never read. The
> pointer is being re-assigned later in a loop. The assignment is
> redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
