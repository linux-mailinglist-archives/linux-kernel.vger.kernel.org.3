Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358404D3EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiCJBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiCJBuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:50:39 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332441275EB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:49:40 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:49:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646876978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWBNdn64wpDGZBAntprlV8MUAyPFqkJHbbFkUKlSd/0=;
        b=hG3q0xyluhiPWTbMKaV4+3rkV3TUXrhYSLAjdNS9MoSjY7sYVFMw8x/hDpBq9CfM6uZcz5
        +yyv7sZmOguyaVnPp1jvsNO8I/bySHhC3ttEhxU+Aqn04zvskZjjLDq3ymIXFv2ZtObHfF
        gnDAISN0KYG8IfFTQ/o6KIumI0fRuN8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
Message-ID: <YilZK/SUs9cnZTrt@carbon.dhcp.thefacebook.com>
References: <20220309145052.219138-1-sxwjean@me.com>
 <20220309145052.219138-2-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309145052.219138-2-sxwjean@me.com>
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

On Wed, Mar 09, 2022 at 10:50:51PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Since commit 9855609bde03 ("mm: memcg/slab: use a single set of
> kmem_caches for all accounted allocations") deletes all SLAB_DEACTIVATED
> users, therefore this flag is not needed any more, let's delete it.

Indeed! Thank!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
