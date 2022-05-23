Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC65307F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353813AbiEWDHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353791AbiEWDHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:07:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6D275E0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:07:06 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f83983782fso133604237b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOZTNY/68HKe2L7iswjeWQupJ9xYHhn0FDV80b863lI=;
        b=RNsxv3x0oyT04rIIJEdH0PodMzS2vvL+Nhxk711tN1UP5KVeivD7RmjPH/FYZahtLy
         udBp6vVJkBiRy+DZGgPaiVBQ7Wge73DQrZ8ZxoF/YgI/3J4i43DZVaUeQKSZJCmL9g9V
         lcJyCAvQlvK9oP5gn/FLR8TnykxRS76fPuuAb7TjMVeJekt5Hf0bOrWKwSclE0gnO7lX
         hWCFLuailoQLy3kRQUQ9QbL0pEivNnu8ExmgUCiSpA3V2e0QDX6M/Da4rpNP/PI/ujln
         3KzM42qBoYCbw6in5JbsN8lNyuE0tvIKcjFBhZpiMJN2DZZaXjcRSgqWIQxkAm5prB7b
         eS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOZTNY/68HKe2L7iswjeWQupJ9xYHhn0FDV80b863lI=;
        b=dyKEbxHLHdXptel7C8FrOZIsXdeKkrLJ1HnT+6oISpUEJ8hsB8n1Jil+N81BNon5TA
         6Os3zaSCXlye2m/tn4T2dhgvKSL432TQrkUxsCKgz/YtMTPCoXxTU9vlsrI0xi45LwCY
         7JSOYWZ1fACvLWABWve+eB7u3sqOIefPORsdzz7OGgffz2aidkrBUt7VI6U8Jaw2QUh+
         QWWnUALlKBoKFCj+Figq+12xLZhdhh8jP5VCm/03gok2s5ESgjxe3pl3HZoSaPbeouhR
         THW8+Ipo+W9beizxsuTIkVxRihsiSBcdlgafolrGsaN176YmFKPADhykzzxgJqLrTOvv
         Cfzw==
X-Gm-Message-State: AOAM531NydBkus2U8Qew4oukqJMOnPuiDYOJLg9AznVfIbnlLhFITxAy
        mjSht6QoEKS9UpeeNOpqR/Pk3a4s/W4mYx4DWmTqew==
X-Google-Smtp-Source: ABdhPJx0l7z8HT36AxkFXHsReEAZQnh8wBb7IvuF6WBXBDhIZwxU14Wykp/tALYDcqcg2quvXSjptYd2YT+OiudNYbo=
X-Received: by 2002:a81:6a45:0:b0:2fe:de15:1387 with SMTP id
 f66-20020a816a45000000b002fede151387mr21041387ywc.418.1653275226013; Sun, 22
 May 2022 20:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220521074103.79468-1-songmuchun@bytedance.com> <e658cd60-0404-e055-f03d-a1866f77abd0@oracle.com>
In-Reply-To: <e658cd60-0404-e055-f03d-a1866f77abd0@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 May 2022 11:06:29 +0800
Message-ID: <CAMZfGtUh3s7HUif5fs2_UO=P3sVtrLfsLjzqRrYz4-Ki_hUB8A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Muchun as co-maintainer for HugeTLB
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:36 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/21/22 00:41, Muchun Song wrote:
> > I have been focusing on mm for the past two years. e.g. developing,
> > fixing bugs, reviewing related to HugeTLB system.  I would like to
> > help Mike and other people working on HugeTLB by reviewing their
> > work.
> >
> > When I fist introduced the vmemmmap reduction, I forgot to update
> > MAINTAINERS file.  Let's update it as well.  And rename "HUGETLB
> > FILESYSTEM" to "HUGETLB SUBSYSTEM" since some files are not only
> > related to filesystem but also memory management (the name of
> > FILESYSTEM cannot cover this area).
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Happy to have Muchun assist with this effort.
>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>

Thanks Mike.  Nice to cooperate with you.
