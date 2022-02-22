Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0BD4C0218
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiBVThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiBVThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:37:21 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3415F59
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:36:54 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:36:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645558612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YxvjL6zVV0x9zwaZkpyF0XEqaCMc0aVeOtGngtzjUQE=;
        b=LPJcnJ4bL0l64rO7BBgmQyUUZILiVCpPykl4LBwMiCePV8u70mOppcN4WUE0umyPcstyT0
        FposOM+6KNhtvmnt/57fphlE6MwB3Z7tZZeZz3O1DKrPh3c2EaFsk42sGZsGYVKU9YGM0P
        pgqnKGch6rFwsmEnAy1vt5UdZ5dXOZ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS, SLAB: Add Roman as reviewer, git tree
Message-ID: <YhU7T//RK6E+1Nig@carbon.DHCP.thefacebook.com>
References: <20220222103104.13241-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222103104.13241-1-vbabka@suse.cz>
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

On Tue, Feb 22, 2022 at 11:31:04AM +0100, Vlastimil Babka wrote:
> The slab code has an overlap with kmem accounting, where Roman has done
> a lot of work recently and it would be useful to make sure he's CC'd on
> patches that potentially affect it. Thus add him as a reviewer for the
> SLAB subsystem.
> 
> Also while at it, add the link to slab git tree.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Sorry, used the old e-mail. Here is the correct one:

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
