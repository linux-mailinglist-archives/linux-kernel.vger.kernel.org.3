Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93DF49C6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiAZKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiAZKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:00:09 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32BCC061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:00:08 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i62so23372438ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gK7bszl+FUXRrhnEheiDpnk/jqDd/Le7Dxn0utoVoj8=;
        b=GhCTQRyPY7E3qzL0iF+8nQ5xk2TXL0XJ43s8X7lqCalrWDuHw7QbggUmvVmy5LBmkh
         bnb4pRCOhq+iuJdPddnsqzmxKTODiHBjn7O3mPKyalPKi8d/YG6zQJpuyJpgaFOeMBGq
         GfP+9AnmoUAtmS/F+g5ql9bRikmtbuwWHnSQsJI9wsGvlqWMo6VdFkNpopqonMsdIQVb
         jz4u8yEiqJ1gcEbpNASsdqbSZWxYHBCUdkcbHu5k+oIDFuPfyjuzqg3LsJurZUGUUIzI
         62PWxNzYHXMLKXaVge4nkC6hPlXtSFyfvIUBLENwR6caYw5cu9207LtotFw2r0SUmZlj
         V0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gK7bszl+FUXRrhnEheiDpnk/jqDd/Le7Dxn0utoVoj8=;
        b=bJwmzdW4BEZhh95aXE0BAQXDr/CKy6SlGM1/NbPfNh2LPJLYDWQTaa3j/NpX6Xpitd
         Mn/JkyWKpd/yaothRJTu/hahA6QdtuQSTlVmi49DNHsc8pSYMYYqPVLhKTGqMyy+ygVi
         T657oKdCuFC+UAJOL3/iXm1B/Bi0RVETwknScqVtu6fUbAIBiSCrBvgeW7+blkNJu6+E
         jjZVBqax/EnN3PQXEnYcCbzRTvLvzkf19qil1ShwuY2PqPfr+DQaWVWelt0J3CrUM7me
         DwIuhT/1DOkK8RI0IIUrv48pEgteGtVHB5pOeRoFni/AAqlwYOxZa86/MPFQsVKG4tzF
         lpGA==
X-Gm-Message-State: AOAM5308XrBlYqMydPJKZAhHmDRjaRlyPft+8s38WrATBok9gaYyh+6c
        kBBFv7l2OD6S/4u50ENz4pMD6dmoOIhWXOTNWfZM9w==
X-Google-Smtp-Source: ABdhPJy8rw1zn0vMv+DMB8N+z1pB8uO0eqAMBVWVctba0N642+H7wxAZyEfghR/ChCdkI5wnC9IBc8lzEsiRxGHWuBg=
X-Received: by 2002:a25:d107:: with SMTP id i7mr34234702ybg.495.1643191208184;
 Wed, 26 Jan 2022 02:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20220126092542.64659-1-linmiaohe@huawei.com>
In-Reply-To: <20220126092542.64659-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 Jan 2022 17:59:32 +0800
Message-ID: <CAMZfGtWYkA_vs1_p5ok0T3J4WWamPE5ZNd00wsOOUiUCPnkP8g@mail.gmail.com>
Subject: Re: [PATCH] mm/highmem: remove unnecessary done label
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 5:26 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Remove unnecessary done label to simplify the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
