Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6BC5370EE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiE2M0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiE2M0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 08:26:35 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4629FC7
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 05:26:33 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n145so8969965iod.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xK/bSJWWO57y/psK8zSSr6zBXFAfYJUDBYthsrv52G4=;
        b=M93PIG9ayKy+6Azc6L8CI6zsYP+MRzLY9KFbbGJrUMpuQeiQuJn/28XWqfHiGINthA
         we1Ucd3Jp7QPsRrh33PjTkXbJ1wHwGVjNI0DCRKas+Qcy39+dA5Bdx8GMphLnUpOgt91
         N4Im38BlPoa4gVygoGGRcRs/iI6RcKlkpq+S8RtFP0xumW1HWvE4/eviff9dJTSpl6/7
         5TFJmY3cI0qGxupujKfCVhilDSLXHx4QoEd2cckK5IiRD6FQTJ7eIuhU021RtFxA+1FJ
         W6EIQWzoX73oPP5claIaF7X6fAOaD8eAC0/cRyMvcvBogxtO7V37uG1Iyu9WVf/XmIjM
         zNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xK/bSJWWO57y/psK8zSSr6zBXFAfYJUDBYthsrv52G4=;
        b=In7jqbSo8qIXLSGp1O3U+rjSW2Plo5RUQmGDZwVODXqGrYZx3d9aFpPMIMOnG812J5
         dcSm8JsJSGPHuppHAFmrv2MWAalIExFz8/W0hCzxcFz6Cu+ESuo9742WfcbCXi3Ph5Ct
         TpSsxROd0kbkGWUQTJ/vUwOsAofSh6YQM2t5I4lcm2rBWflOCSAWdS4G/A9EYovBePwq
         WpE+AOH0tW/d5p9CxPMTYHeuqunnTvR9UckzQzs7WBfLsLnjIdRD6aAGRwzBiQJqWiOB
         IYqLyroKB/QKC4wFqenOMchTTiJTCmHB3eyxBRQktlF4oAamILvHsbLacbPjEg5nProA
         QnDw==
X-Gm-Message-State: AOAM532OP8p2Wn3EC3xtQXm2BrkgvUSp42MddTJvIfIjhPHjryp5vpaG
        /NN650dPwFyAPopv5r4HPnA=
X-Google-Smtp-Source: ABdhPJwS+WcNE9pbiOQSHZkVimE1O6GXPuUjlvKerJFqa4n34PQkSGx/DvTc1/2cTz2lidEh/SkA3w==
X-Received: by 2002:a5d:9854:0:b0:65a:fb17:76c9 with SMTP id p20-20020a5d9854000000b0065afb1776c9mr22459984ios.37.1653827193103;
        Sun, 29 May 2022 05:26:33 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id z7-20020a6be007000000b0065dc93eae5dsm2594517iog.7.2022.05.29.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 05:26:32 -0700 (PDT)
Date:   Sun, 29 May 2022 12:26:30 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/slub: improve consistency of nr_slabs count
Message-ID: <YpNmdkAbE/gyaN12@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <20220529081535.69275-2-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529081535.69275-2-rongwei.wang@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 04:15:34PM +0800, Rongwei Wang wrote:
> Currently, discard_slab() can change nr_slabs count
> without holding node's list_lock. This will lead some
> error messages print when scanning node's partial or
> full list, e.g. validate all slabs. Literally, it
> affects the consistency of nr_slabs count.

validate attribute is for debugging purpose.

I did not take much time for this series but
My quick impression is that it would be better to deprecate
the attribute than making it work by affecting allocation/free path.

Thanks,
Hyeonggon.
