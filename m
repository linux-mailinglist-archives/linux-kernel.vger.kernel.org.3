Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58579544B22
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244893AbiFIL66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbiFIL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:58:54 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF813CE4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:58:50 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 0CDE7B00149; Thu,  9 Jun 2022 13:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1654775927; bh=NzmzzhGPGUY7xZcOQ+0OfmkAMUDNRFa2wttp68Yz7bk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mDV8x/vOv68VDjg22k4RMOhgEUyQVhp17be0H3abpHmpzRHLZ6eO0kdAts6i3K9nY
         /EiGmDVD0hGP/O4Pi+KdVjBAFkYec4qnTpSaNfOhGMLZRGtbGgwRwdqWQSGCP+UJ4s
         DXp63jvxADrXo3v/B15z140CcV7ptnfpj7f5q+cLQx7j9KPrJc0O06VLtRDDSTiSXs
         AXGOtstnavFqll3La/hP6p6Df1tSar0ioozucIOfyORzOOuStcR7kYuGcV9q7t+vZi
         OIAKhJHOuzd+Fe8hRfR2IMAOD+ZzafeFSvO9XR9dBgVI7twEF6uV/hT0Cko/PDQTGN
         uVtkXOkrMGKrQ==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 0B516B0012F;
        Thu,  9 Jun 2022 13:58:47 +0200 (CEST)
Date:   Thu, 9 Jun 2022 13:58:47 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Jann Horn <jannh@google.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
In-Reply-To: <20220608182205.2945720-1-jannh@google.com>
Message-ID: <alpine.DEB.2.22.394.2206091358040.566833@gentwo.de>
References: <20220608182205.2945720-1-jannh@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022, Jann Horn wrote:

> The fastpath in slab_alloc_node() assumes that c->slab is stable as long as
> the TID stays the same. However, two places in __slab_alloc() currently
> don't update the TID when deactivating the CPU slab.

Looks ok.

Acked-by: Christoph Lameter <cl@linux.com>
