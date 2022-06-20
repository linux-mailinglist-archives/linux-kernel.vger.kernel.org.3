Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEDA551626
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiFTKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbiFTKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:44:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA29913F33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:44:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ej4so10565350edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ayyFIPOEX7mmFlL3xX1k+HqUb9PAPVzELewnOWAtkE=;
        b=YHDSC+bwoq5f1H4yX7964QUWsTVMA47TLsvBrzfEyMTkXapaxSZP0TWbgnxWBeYAk0
         F+JVvZ0baWWoqZRyI7yF7jntpBwrjAOfx09c7ZxgIfdf35x65ITdjO7PB8B0mpqm7nJ/
         z7Di2wgFdKY0W1UcI0ROZ1G+dYfI+t3mm669GOyCLRHwkpxWq0y8mGBVbZZE8PHWu4UI
         dXPMLTIywRWkGq/4dSx1UWKMU6fUU6UhIsIh3n/5I8TT84dVsUBilTmtAiHGUg/ot26v
         5vg5RUbRG/2WbxV9Tx3o//Uym3CCOoZNYU1OMbunmYImB7mYo7IVfmlc+rTvTmNWD1Sl
         4Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ayyFIPOEX7mmFlL3xX1k+HqUb9PAPVzELewnOWAtkE=;
        b=EvjrcxRBFuwVoGeW+No5ahN1rdXR+AXlKee1JfBeXjk8QJCBStrzCZkVjCotjQpQZt
         W+LlKltpK1z230tum+iEG/WhX0VE9OSeGJBWYTshxV16nO4iV8j2RgZZYf/vpZXANUGa
         ijDfEZvxRs4w+UYFXYRwQcSCc01di4bxllPRbh9nEkS6m3NHaiNapnY3YPiYw0qLRP3g
         6R1k0OnWKr3Bee4z9Byvi+kJxS/83PfDHavzXmGLBm2TXN6IOxVRbdO69lyScoD4THS1
         S8fwUcCdP6aqI1omj9gg0wmNXw4bDVDsoZals8JG7SRPPneb2wh/xuiPqy0Xmdo1wM2z
         R4/A==
X-Gm-Message-State: AJIora+Hc62o/BxWFUVy060bRNqaJ8UCbuDPIEf5/4E2TJY6g+2HwVFH
        EEw3iY7bQHg9i9nx9COq2XwyINwqN2K4kadFfDkBjAw7P3ZBFlRE
X-Google-Smtp-Source: AGRyM1tRfiJVwErHKbnkWcDg2CzV3HdMX8kafR/tTByxj0eJ9JVyeM3W+qyR4A+SD4KT4KjWSui1kzD1A/aStDHwxXA=
X-Received: by 2002:a05:6402:26ca:b0:435:7f6e:f3a4 with SMTP id
 x10-20020a05640226ca00b004357f6ef3a4mr7230293edd.61.1655721851333; Mon, 20
 Jun 2022 03:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
 <Yq+PMWlARgDhv8uL@pc638.lan> <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
In-Reply-To: <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 20 Jun 2022 12:43:59 +0200
Message-ID: <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
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

> > >
> > Is it easy to reproduce? If so could you please describe the steps? As i see
> > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > glance i do not see how it can accessed twice. Hm..
> It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> failed. IMO, vb->va which out of vmap_purge_lock protection could race
> with a concurrent ra freeing within __purge_vmap_area_lazy.
>
Do you have exact steps how you run "monkey" test?

-- 
Uladzislau Rezki
