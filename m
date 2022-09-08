Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086895B2767
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIHUFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:05:02 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B63AB29
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:05:00 -0700 (PDT)
Date:   Thu, 8 Sep 2022 13:04:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662667499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCYR+bp1yumL+xeMTJSnVNXEiq4gtT5BoKEGNiTR/BU=;
        b=UNie+naMu/8ei3YoYW0dxhjpBhdS85jx2yoN8nLgTaMA4ZZTnSlFwpAIkC9CoFWJ3a1USj
        BQXZWTQguCdpdDiJQaem4CreJMMJnxqXdY04uPpwT2WQ+aR9wBBumuOfp9k+Dbg69eQEbv
        RO8uqFupTg9W4M4qwvJeaQhRD7GqzA8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com, hbh25y@gmail.com,
        legion@kernel.org, longman@redhat.com, songmuchun@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: mqueue: remove unnecessary conditionals
Message-ID: <YxpK2XxR8A+oESV5@P9FQF9L96D.corp.robot.car>
References: <20220908185452.76590-1-jingyuwang_vip@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908185452.76590-1-jingyuwang_vip@163.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:54:52AM +0800, Jingyu Wang wrote:
> iput() has already handled null and non-null parameter, so it is no
> need to use if().
> 
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
