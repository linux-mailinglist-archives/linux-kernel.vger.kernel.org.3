Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D4E51D3D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390302AbiEFI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390300AbiEFI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:59:51 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B7B5E770
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:56:08 -0700 (PDT)
Date:   Fri, 6 May 2022 17:55:59 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651827366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKpkW6bguymmdfZAvj/2y4sohq6tBesmgetgBnsnngs=;
        b=nT0zHF0rSVT3a6hZSHcVTH2Q8EAhfTpnKA2bc9bBdWF4wbipUG9Ss8qlXQZZXhnoz6xZWJ
        kx3g4jREQxB3DMZTuTLj5RJArCtu5mrcileFlixEupzSNSK0LxQknYd4v+x1+i0dK3h0g6
        a6t/ue/RGvZuIfkaicFSQg3JjZ/7mF4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/4] mm/memofy-failure.c:: simplify num_poisoned_pages_dec
Message-ID: <20220506085559.GB1356094@u2004>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429142206.294714-3-pizhenwei@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:22:04PM +0800, zhenwei pi wrote:
> Don't descrease the number of poisoned pages in page_alloc.c, let the
        ^^^^
        decrease?

> memory-failure.c do inc/dec poisoned pages only.
> 
> Also simplify unpoison_memory(), only descrease the number of
                                        ^^^^
                                        same typo

> poisoned pages when:
>  - TestClearPageHWPoison() succeed
>  - put_page_back_buddy succeed
> 
> After descreasing, print necessary log.
        ^^^^
        ditto

> 
> Finally, remove clear_page_hwpoison() and unpoison_taken_off_page().
> 
> Cc: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Otherwise, the changes look good to me.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
