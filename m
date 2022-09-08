Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D45B26A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiIHTSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHTR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D0FE4B3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAFDD61D67
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 19:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CCC433D6;
        Thu,  8 Sep 2022 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662664678;
        bh=4y/gYFIK8fZNCZXf2/aoBtlgEBW3r/vu7ufnJ6SLnj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baZEsFfCF/BU3dYZ6PyVV/s/KTWUWw9Yx1eFiCutXR0stYn8JUfS644nK7an179BM
         UVXKuB/sNJyxrT2zgwrClPMQpj9NpT6J/whh/LZ1yQ+0EgGbDSrbAgHj0/1+QlKsmo
         LtDhyRFXWgZL/PSsuNNBVdbi+vU3FahBiOV+qeG1OVFIJHMDnA241WWOMNHrZPo8id
         o0EqpZoU26bRBKsNxH1WGeEQOn9Jm+mBps80/CL9Ben6hxyHYgAanl9w8s1iLYAEmx
         vQyc6YwndIYvXvrcul0RuZqhm3x795oaKEdj02zF5KIjsPsAY7Ww3KHJ+RjMHNRIXc
         dF8kQif0Rj3RA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: introduce struct damos_access_pattern
Date:   Thu,  8 Sep 2022 19:17:56 +0000
Message-Id: <20220908191756.129602-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908184356.103133-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 18:43:56 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Yajun,
> 
> On Thu, 8 Sep 2022 11:26:11 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:
> 
> > The damon_new_scheme() has too many parameters, we can introduce struct
> > damos_access_pattern to simplify it.

Because my previous comments are only for trivial cosmetic nits and the size of
the patch is not tiny, I fixed those on my own and posted it:
https://lore.kernel.org/damon/20220908191443.129534-1-sj@kernel.org/


Thanks,
SJ

[...]
