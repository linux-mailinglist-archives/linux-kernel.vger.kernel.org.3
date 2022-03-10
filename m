Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67E4D3EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiCJBt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCJBt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:49:28 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154E107D87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:48:28 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:48:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646876903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3j8oVmnyXyAQOldnk6eZpZyZhPzFgUoRJ/18oHzhJk=;
        b=g4ugRQzwGUnXTcI1MYnEEloUTchzPmftqPNtiYCvy8B9nJ+hhBBiuIXKU/sPISdtxY5kZY
        cSbilvwFm+co7Gtr6eedOaZsmM+4Hi+P6vzr124CIW9wkI/7Fey9SwoThh1zAC4wfX5lis
        3jyyhOeAXRkqbXVjEfCrwJpPYeWq7+4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 2/2] mm: slub: Delete useless parameter of
 alloc_slab_page()
Message-ID: <YilY3zSquXNV/OxB@carbon.dhcp.thefacebook.com>
References: <20220309145052.219138-1-sxwjean@me.com>
 <20220309145052.219138-3-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309145052.219138-3-sxwjean@me.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:50:52PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The parameter @s is useless for alloc_slab_page(), let's delete it.
> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
