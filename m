Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6652FC4A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352170AbiEUMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350093AbiEUMGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:06:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585D1CB10
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:06:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h13so3505812pfq.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=173FUsw6tLIJBxwMxWbaXPAVuBn6Pqyry82161LO+5o=;
        b=t7th7/O7T+GQeFuDwYpInw+m79Nf9NcWcLo49bsR0eUYI8sBkzCFs80bwuythG6L+m
         hQTVY4+XcWPk7VQFLj7yw0tVrwwWpMqrYKZkR+THOIt2o7DKmHxJc/7v0FFYKhr5IK6Z
         HpVMl4PKViTGMhoMGXsfsFuz5U4HH8WsRPpuMmZwJz6xBB+OJNWEsIv8YDwSoo7corb5
         kb5iMIwEjtsTUxWvkd7pEmZUB7R48721v+yddyIbXui2D/s6jsKSDXyOtt/1zYBqgMxX
         5brk/nFW9snvzOfQQ++A8s/7bvmweeB101z1qlPM4mpddYGwKeMNu5tV4Jxn4LWWsR1p
         Y3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=173FUsw6tLIJBxwMxWbaXPAVuBn6Pqyry82161LO+5o=;
        b=Ay8KlB/S4zqUsnKDzTo9FUmZx4gLTPIeB1pE1YYh40naCKY9awZ2SKNGSTpmDVVKJh
         yT/71mNMkYTuAlITBmQYyFYqtBPKBUqMLqdDfZ9yh871+mmrThFVzSTcGlnQUnWiqUmz
         7+DXe0rHep3siS57DAW6r69fQ18X0FfKF0qfXqwR01FHJSp/ghH7DIXPYIuULJAvIxuu
         8B0/e3U1hCSBC+TKbC71y24+2ePygclzlU8jfDvceMRn8NNtU5sIxirZEHj4VR9vXpAo
         QdnTwWONXMb1Y0yxAS2SZzYvXwXdWBG7ntywzGAWoPcAdfZvQ2K9q+NlzFYB7fFSABqL
         NrXA==
X-Gm-Message-State: AOAM5302AuVZksJtGePVUpO2WgOnQiCSPJEZ7OKqK4gSWRy1C1i3NRN4
        l1IoAm5saxCHeWK/Z+kVZMoYWqz0SttnwA==
X-Google-Smtp-Source: ABdhPJxKSfGRT8m0D3bvpo8J9qYc7ZkBmclnsMk5PYLCp1cn0OI4MWpkCsZWpL6K+oJOckoMolhItg==
X-Received: by 2002:a63:202:0:b0:3f2:75a7:cd28 with SMTP id 2-20020a630202000000b003f275a7cd28mr12480723pgc.537.1653134776979;
        Sat, 21 May 2022 05:06:16 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id m4-20020a655304000000b003f9eacd0684sm1264323pgq.3.2022.05.21.05.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:06:16 -0700 (PDT)
Date:   Sat, 21 May 2022 20:06:13 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ksm: fix typo in comment
Message-ID: <YojVtbCiQ47+Aoq1@FVFYT0MHHV2J.usts.net>
References: <20220521111145.81697-94-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-94-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:11:44PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
 
