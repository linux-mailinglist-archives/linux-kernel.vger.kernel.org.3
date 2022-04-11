Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC624FC2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbiDKQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiDKQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:58:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90A18B30
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:56:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j83so16467518oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWmf6CDqr26YDLjUPI/Ua6LDwENvM3MIxEgVyjhCpgg=;
        b=k2DlkRXJYG4p4wihUGI4UKqqXqfv8i44QXBjh7hHRtj2/dZJUFDSTJAclth5skGEHi
         RZPGo0ownYQOeEaBRXxJiVY/387Xae3rKE0RO9W/4OGC/lDiYh7bfY0l8Ki3F6Ziz9Yc
         06cdxYCtMBUvruBXHRJBvHihulEayextGjMFywVrurCxbtkZQyWCRENCWH05CkdY/p9v
         2BP5LZrqZe74Y17GCaCZWeYnMtzhQ4v2jMlVuvbuaPg0dXTqCKLUkZwDs29VOoDVf1NF
         LsLbyuFGvRsJRA9HwoL9787H/0KL8+9TP7jvH+dxO/AyGP/WhT2Skho9QXd1WKOKz3lM
         ji0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWmf6CDqr26YDLjUPI/Ua6LDwENvM3MIxEgVyjhCpgg=;
        b=umBRx4d3FQ25UzEh1QTcGeqfHzgtUzjHClQLsSs02ngd+1NnGcL+qypM80AUjVF9KF
         96i9LeteoUcOWFeYxtzGkfbqhlmg3CQmRHpSu3shZbuLztlvjxhM+vOYWkrUwnV6UsYD
         T460NmWUXXjDouVmwbDdQZUU4axRIm9CPYaaPKyACLKRNVJ6hUSFPtamfKRodyXlPJOI
         +iiXzAMQmN3/JwYktQueB47OKvhAPD5obQzqp7syBVaa1d6EUhgKSXQyPwla5j2PSPvO
         2u3yu7OxyAWa3T46TXkQ09adob7YMsyEOgTHfmx0pFpadg050+2n7asiwYbf8TvL/p4a
         //MA==
X-Gm-Message-State: AOAM532gXRDilkC03PKm0iyCuauNTcuVdf7tepcJlgeg0ONszYboIue9
        VpvGJsGBJZqjH11bslKofa14zkWixKIoBAaRmzs=
X-Google-Smtp-Source: ABdhPJxHLJyJe1kCKnbIFAfGbINbnNZD0RT30rGO9AHKmB1Pau2Fk/vb5qUoMn7E4BXK78/nQ1fkO2pbKw2n4xWtxWk=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr27378oiw.253.1649696176476; Mon, 11 Apr
 2022 09:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220409171131.1599090-1-trix@redhat.com>
In-Reply-To: <20220409171131.1599090-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Apr 2022 12:56:05 -0400
Message-ID: <CADnq5_MqU8tinywKJ5_G-HwNNF2k=Q4k7C6Gh5hdtnpve08RJA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove r600_blit_shaders.[c|h]
To:     Tom Rix <trix@redhat.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 1:11 PM Tom Rix <trix@redhat.com> wrote:
>
> The only use of the global variables in r600_blit_shaders.c
> were in the old drivers/gpu/drm/radeon/r600_blit.c
> This file was removed in
> commit 8333f607a631 ("drm/radeon: remove UMS support")
>
> So remove the r600_blit_shaders.[c|h] files
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied.  Thanks!

Alex
