Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D74F1BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiDDVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380199AbiDDTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:12:06 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A233E9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:10:09 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:10:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649099407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aFvgM5NfOebxDDUuuHdtiZjWiL2k8D65MO0wbzsRCYg=;
        b=ql2tN95cfc7u+wPhC0kENNn24vZb3lVeqzCTUmJam3h9qW1fEQrbKa/dsQyjf9mgc0DmBX
        XpO2fOJD348nJ31+6gQRXCjl62yZRZyCKwDNrevZ9bt99DcrkWRxl8CwUMGoOowULtpaBn
        pvthJgRu34J/o/9TC57V07iwmxwGdvA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: remove some unused functions
Message-ID: <YktCirLdFJx7P/T/@carbon.dhcp.thefacebook.com>
References: <20220322091421.25285-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322091421.25285-1-linmiaohe@huawei.com>
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

On Tue, Mar 22, 2022 at 05:14:21PM +0800, Miaohe Lin wrote:
> alternate_node_alloc and ____cache_alloc_node are always called when
> CONFIG_NUMA. So we can remove the unused !CONFIG_NUMA variant. Also
> forward declaration for alternate_node_alloc is unnecessary. Remove
> it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
