Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27799462CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhK3Gfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhK3Gfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:35:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:32:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o29so16478056wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V13RyYqv2WhtbyDuqbbRKKzuJ+76Oi0/zKY/2heW9G4=;
        b=LkjwFV5iWha9Gasa8L4fcbsdbHOEQq50NM0gWcGHIXvQo4TVuepOq1ElZymiHH0vkd
         k2BQ8wziM8xKjcoHumgblrfeFGHmuiY1xG3sVJItv1WUBuaR6D2T36tr3SCyrpkRevh+
         feBUSBwZELG7rLcuGYeKitiWiwypuu/kfG/bCsSgM/4mvlYjFIxY/FGmXspudHj1dkcq
         pWgbyQOAnxQRmxRQlNxyt/CDKrJVYmo5OX7+PfQZdUl8qBViLDl+ZAYlAXMANlyC3HGg
         Dy+I0OlyXdJYd738VRIOpnAE9oEGQ0amltOnigSlLtAiMKRJ2lf5YHQewxLKm1yi3eUe
         pK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V13RyYqv2WhtbyDuqbbRKKzuJ+76Oi0/zKY/2heW9G4=;
        b=f/1FhGCuTryXsMh2d6PTNCvc1kdP4JYq2NnipBFZCydAMybwNhZ77LQpqe0jugFLGx
         6jene6H41soCV4sZmxft6SrPn2BrL4DfUordhoTfPVnmEZWHTm0eO3g9qlNTlh5Vjhc0
         TqWTgkj+DYljKH9jC6uyXysaRZYR5QldWSet3Af+UxS4ZW/T9BqW+oDKemL2ccNmtOzA
         BxzJ89OHocZE8GbB8+vU4J+ToN4sHepM6aNrz2sjBpAoiaVwZbjaXR+cZpPZCr0zHiV4
         fsUUKul5hLe1yFDAykl2YrcoIQZ65Ds4AVpOjUq6XNw5VKFkUYGFfw91Jx7t1jy3SVu2
         uOqw==
X-Gm-Message-State: AOAM533w/YWtf0mZacjlpteK3QoAvufbItmvXvCxzLzZ+yBWr0Yyzcw/
        SFoLVeaW6cc24+LVzc+WzWVmiCQtfxibiDzPRQzkTdkd8C6LUw==
X-Google-Smtp-Source: ABdhPJxh9enzmH0O96r70utD0MOPBkwb5IeIYk8bbB3QFlhjfWECIwQbjlFnezpnz7UQh5ZYrZwgnaA34q0AOQ+D/LQ=
X-Received: by 2002:a05:600c:2117:: with SMTP id u23mr2802655wml.19.1638253935857;
 Mon, 29 Nov 2021 22:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20211130073940.7eb0f2c1@canb.auug.org.au>
In-Reply-To: <20211130073940.7eb0f2c1@canb.auug.org.au>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 30 Nov 2021 07:32:04 +0100
Message-ID: <CAHUa44G4ZBXZFN-06zuCKoU2DCPHg+j3eDWBCuhUU8ijLZMQrA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the tee tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 9:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   9fcd8dc5d651 ("optee: Fix NULL but dereferenced coccicheck error")
>
> Fixes tag
>
>   Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
>
> has these problem(s):
>
>   - No SHA1 recognised
>
>
> Please just use
>
>         git log -1 --format='Fixes: %h ("%s")' <commit>

I'm sorry. I'll fix up the commit.

Thanks,
Jens
