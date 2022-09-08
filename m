Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715855B16CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiIHIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiIHIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:22:14 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C1A4B31;
        Thu,  8 Sep 2022 01:22:09 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oWCn7-002MrZ-Cm; Thu, 08 Sep 2022 18:21:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Sep 2022 16:21:41 +0800
Date:   Thu, 8 Sep 2022 16:21:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     g00657492 <gaoxingwang1@huawei.com>
Cc:     davem@davemloft.net, catalin.marinas@arm.com, liaichun@huawei.com,
        yanan@huawei.com, caowangbao@huawei.com, chenzhen126@huawei.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert fpsimd change: run kernel mode NEON with softirqs
 disabled
Message-ID: <YxmmFem4pAPU2u7K@gondor.apana.org.au>
References: <20220829080515.314001-1-gaoxingwang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829080515.314001-1-gaoxingwang1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:05:15PM +0800, g00657492 wrote:
> From: gaoxingwang <gaoxingwang1@huawei.com>
> 
> After the call stack reaches the __local_bh_enable_ip function to start
> a soft interrupt, the system crashes.
> 
> Call trace:
> virtqueue_add_outbuf+0x3d0/0x7e0 [virtio_ring]

Where is the complete crash trace?

Did it crash because of an stack overrun?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
