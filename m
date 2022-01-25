Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346249B64D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiAYOb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579375AbiAYO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:27:13 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:25:33 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so62194983ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFnSDupuYaQ1MQejso8mT1I5AQneR3nub9bSmJN8qsM=;
        b=Byf4Ud2Ux5oawS5IIueddrkK9fhvRtMk6ntgz9b7jSl2gVLjeV49ZS86Xo68ZceTKe
         SxwfCzE9AnTtQ0NmdpOZqlPTAn4Rg//G+lBk2mNOuiXFfQ7aRbKlDHvEh+T9ACDBfyqF
         wJkjNzSFW6XITY8jPHGjE1StTuJ5RzjK5tUbDk2GKM3wBeWmEmVCeA+jNFl5XG0UhTZv
         t5DJApD5A4i6vUJP03oprjbWgg7SfijRUskCiqgvAehg1q7dVv+t5hEtfxWCsoxrGsLc
         p4+/hUIYLmlp0BZRC/tn0/J99/s8EMDIOu53U+xHGOwirlbSQgD3RJkHvspmMza6m7DC
         6J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFnSDupuYaQ1MQejso8mT1I5AQneR3nub9bSmJN8qsM=;
        b=NmGpXufddsf20jwh79Yr0RmYAiyJs1QQBz/ICQCtn6+efikALR+qO5VIh4RCz4lWHk
         iLfJoSkZ/cYxYydVZB3asGwU1d5EyPgbCgfZy0dnTmr1ZcBIVWhS2H4VD4xo5XwAHWbP
         FxLoUZH5qugWxBuNhyahGAnAOQYd84U/SZaElkVMMfHKL/0ZYnG2CHqlTFr82Js7P55j
         IYdWpQGNfa1MwHXENtFPa+fBvwFYJFbAjGhezza8kV5/wdKk0+ecd1cJmWgarsUHHu2G
         xipif9kUAAzAU99XbByUVL3lXRB5o4vKswTC7PuyvaIUJaf5x5Wxi3W1GsWfH3A4ZEm0
         yu1A==
X-Gm-Message-State: AOAM533MQE+PjWbYFeCVvXJdwahnofah51uRo27XvUrK6279zWdXHkud
        dNz5c67kbIf/hdYCG/6l2sumv7VR5kUXtvJ1k0Otjw==
X-Google-Smtp-Source: ABdhPJxELYtJvtY502AMwplDdVTZkQ1wElvFurJ537bcOYFxpfhh9Q1yIm5DMfTGoFH7if2ZoPOMjTmFVcQbHOiaZVY=
X-Received: by 2002:a25:ab6b:: with SMTP id u98mr28752508ybi.523.1643120732730;
 Tue, 25 Jan 2022 06:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20220125124833.39718-1-linmiaohe@huawei.com>
In-Reply-To: <20220125124833.39718-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 25 Jan 2022 22:24:56 +0800
Message-ID: <CAMZfGtUjFOayWco-5yF=BvTpQ5-Bv3qUq3N5_b8dBU6vo8ZFHw@mail.gmail.com>
Subject: Re: [PATCH] mm/hmm.c: remove unneeded local variable ret
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jglisse@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 8:52 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The local variable ret is always 0. Remove it to make code more tight.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
