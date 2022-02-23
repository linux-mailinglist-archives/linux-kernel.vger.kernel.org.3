Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3794C1B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiBWS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbiBWS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:57:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E02DABC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:56:44 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h13so9947146qvk.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3Lu5wb8EhpAgZDSk61zW+lqHYQM4+j9HTgU1DVV1Sw=;
        b=l1InJ+X31LDWy2jTVnSPnQDi+B49kLksRpH4cPiS6MLy41mkrhC68E0V2/4z3oezcb
         63eEmZS13IQSySaYk3+lzAZEGeJp27DvdSeDfSedL++SVmCPcLn9dPcXj1vfri3WfV0F
         2J005jcW/xELjO3UEXFIK2EDjOyeV400zYDDrNmKkcXvj02/tydEuCYNFcAoq7Uet+sR
         602UokOf4rOVUOJRS5/S+28PpA9pCvv6sQa0SUL4vZUKzhv55iJzCxyUIncBfgEwhfk5
         bAM1DdbeHuOj1/BHIuzcK+sVkHmk/2EKFmasXWBZImFrucmFvOQMJ58uPe07fxioFYOG
         lwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3Lu5wb8EhpAgZDSk61zW+lqHYQM4+j9HTgU1DVV1Sw=;
        b=RC01JvfK6xymlY0YD87iyR/RaIz4Xmpdpd/VjaTM6nwtPakgZQDj04nIXjo6+BYkzl
         Y4Axi+PMbDyJH6LeQwwurDr/UpvvYJCOfinJySWjBkk5WJM4M2NV9sfwHE8hU+CujbZh
         iQjGELx3yUFZa5/FjQbtAV+d/uOa6oE2HuQI4DkGs4vpLSmTGu+qP10FkxNsxpnmzw3D
         xsq85A8UswiBvxJY1xUyFdI8FwuDroY3cYv5mlSDlnUxMThwcUjEHUonIyG6hTECwxPt
         6pp4gyEOhlk+f6OKavjKs0NTAViiAh1b+/fYfd/Jr0qUv19p4skXnT2TRuoDeE1mTekE
         f1ZQ==
X-Gm-Message-State: AOAM531sU1mEiLx0OcmXch8fMuQQOrI9arBBRnrz8DbDRSzXfW1b+cp2
        zxhzWN01Pz+YnXhyaTuRBMlZa7xIxI4NYw==
X-Google-Smtp-Source: ABdhPJz5HctQWHrpQKBVleNNu+26U1JjeMO0f43E8EYK8hE+TjsP+jdzljicZPNAaEmTkczGytDXGQ==
X-Received: by 2002:a05:6214:1d05:b0:42c:a98e:6201 with SMTP id e5-20020a0562141d0500b0042ca98e6201mr663380qvd.122.1645642604107;
        Wed, 23 Feb 2022 10:56:44 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 5sm305559qtp.81.2022.02.23.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:56:43 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:56:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer
Message-ID: <YhaDa1CfPyQ/laup@cmpxchg.org>
References: <20220221233951.659048-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221233951.659048-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:39:51PM -0800, Roman Gushchin wrote:
> Add myself as a memcg co-maintainer. My primary focus over last few
> years was the kernel memory accounting stack, but I do work on some
> other parts of the memory controller as well.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
