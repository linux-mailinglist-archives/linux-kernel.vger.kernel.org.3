Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B257AAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiGTAVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGTAVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:21:37 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC994D16E;
        Tue, 19 Jul 2022 17:21:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8DEE43200684;
        Tue, 19 Jul 2022 20:21:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Jul 2022 20:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658276491; x=
        1658362891; bh=BbAJYPKoQCnVnDq1KjWsIixQjPTWuVjYkUPDVJEm99A=; b=R
        AhsGuoXQLRC6Kzw56gvpnlmnDceKyRc2nSDLmRfsnme2vKufI81QG2DLmo9ZlTR7
        bpvzaWHGWS0NezXmNU9dW7v/XmQqwXOXQFa3Q5nVD6Z8/nRAnPeUngrjn5nnlowI
        8JPIMwolQsL6ya9bFUDj1t4Q7x3/58yYGHjRNduZOPkd2JXF1Lm4FmPdZCMq3sCb
        ros4MCnk0dqHPdbM6YNuspJhVLGugInosEfVEpGGryFEqjYKaLNZ6fj8BANFPcNx
        8liCcqiJtClM2pC7+PurS40JZj/KTwSErMcqZw/yolk49Ufz3thob9Fi7lnUjPoS
        agzowQ3wdSYlIhhYCIhWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658276491; x=
        1658362891; bh=BbAJYPKoQCnVnDq1KjWsIixQjPTWuVjYkUPDVJEm99A=; b=W
        trF68sDLIA5z28rks3W9SdvA8KIi1ammSqjjWkzdVWqC4z3rHJYUiMx2qlNIYhw4
        pa1p9iO6ygTatTc+T0R+M2SjCnvbKXiWgOa2pY93G5QaM2JVo4Xj2hcF6f0345dq
        m4Wkv+QUo/D2ioS1iYjzjtm34JQNLCKh+1ajEB9kYhwmSvB1oSiMtzZ76wI7jeBc
        uqWmnmMFXyILti3sMHU+5RVS8nq8d7em7zQGqSxD++8/B/vdCwVfLGtwFJQ8pGw3
        6wXLFCw3pMg6BOeSnxABsa1xgBVS+em5BOTZrWZJWbNzIqHfkGrOIkNdYIe5UDNw
        9Euc0g4dvdK8SRRtL6hWg==
X-ME-Sender: <xms:ikrXYuxhGqeMSa3dy2fsQ3uhvJq1gSbQwWWK5RP20vdul_QUV2nsWg>
    <xme:ikrXYqTVuw8rvK49riz6OJi5LYi-rv4_yH8gsvzkSqLl7T1MSzhG7aMAXtb8dujm8
    39ajCEtrHcFeyFlzg>
X-ME-Received: <xmr:ikrXYgWne5fA-sZKsRJQLx6h76f-7Kkzg-QNR2BxcbkvxikxxlcP2UEq6-lcKwb6WQK54diOuV-Dms6bVNIvx9YiWlGvVpd3La80y9aZjvsj7wkLezIewmfabA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeluddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ikrXYkgHNCuPFa5z0cll4yGH6KHe2zzVsnDurC4Ah7LcfeLHD1_OPA>
    <xmx:ikrXYgCOVYb1YbzVioHy-2Imti6T_ZPCn8cjdzj0mwxaPgYylTlK6Q>
    <xmx:ikrXYlIS6HgmyVQl2NZpKSJdYalQDd5cYUIXBHJsZ40sPjJjJbCgZQ>
    <xmx:i0rXYuAQFrfPsWWkka5_1DZ_uOBuS1CuiH3MBWW9efzXZJhgQk2Rhg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 20:21:29 -0400 (EDT)
Subject: Re: [PATCH] clk: sunxi-ng: Fix H6 RTC clock definition
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, andre.przywara@arm.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220719183725.2605141-1-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a7a253a0-1cc3-61e4-ae59-fc299057974a@sholland.org>
Date:   Tue, 19 Jul 2022 19:21:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220719183725.2605141-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 1:37 PM, Jernej Skrabec wrote:
> While RTC clock was added in H616 ccu_common list, it was not in H6
> list. That caused invalid pointer dereference like this:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000000000000020c
> Mem abort info:
>   ESR = 0x96000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000004d574000
> [000000000000020c] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> CPU: 3 PID: 339 Comm: cat Tainted: G    B             5.18.0-rc1+ #1352
> Hardware name: Tanix TX6 (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ccu_gate_is_enabled+0x48/0x74
> lr : ccu_gate_is_enabled+0x40/0x74
> sp : ffff80000c0b76d0
> x29: ffff80000c0b76d0 x28: 00000000016e3600 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000002 x24: ffff00000952fe08
> x23: ffff800009611400 x22: ffff00000952fe79 x21: 0000000000000000
> x20: 0000000000000001 x19: ffff80000aad6f08 x18: 0000000000000000
> x17: 2d2d2d2d2d2d2d2d x16: 2d2d2d2d2d2d2d2d x15: 2d2d2d2d2d2d2d2d
> x14: 0000000000000000 x13: 00000000f2f2f2f2 x12: ffff700001816e89
> x11: 1ffff00001816e88 x10: ffff700001816e88 x9 : dfff800000000000
> x8 : ffff80000c0b7447 x7 : 0000000000000001 x6 : ffff700001816e88
> x5 : ffff80000c0b7440 x4 : 0000000000000001 x3 : ffff800008935c50
> x2 : dfff800000000000 x1 : 0000000000000000 x0 : 000000000000020c
> Call trace:
>  ccu_gate_is_enabled+0x48/0x74
>  clk_core_is_enabled+0x7c/0x1c0
>  clk_summary_show_subtree+0x1dc/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show_subtree+0x250/0x334
>  clk_summary_show+0x90/0xdc
>  seq_read_iter+0x248/0x6d4
>  seq_read+0x17c/0x1fc
>  full_proxy_read+0x90/0xf0
>  vfs_read+0xdc/0x28c
>  ksys_read+0xc8/0x174
>  __arm64_sys_read+0x44/0x5c
>  invoke_syscall+0x60/0x190
>  el0_svc_common.constprop.0+0x7c/0x160
>  do_el0_svc+0x38/0xa0
>  el0_svc+0x68/0x160
>  el0t_64_sync_handler+0x10c/0x140
>  el0t_64_sync+0x18c/0x190
> Code: d1006260 97e5c981 785e8260 8b0002a0 (b9400000)
> ---[ end trace 0000000000000000 ]---
> 
> Fix that by adding rtc clock to H6 ccu_common list too.
> 
> Fixes: 38d321b61bda ("clk: sunxi-ng: h6-r: Add RTC gate clock")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>

This bug also got fixed in passing by e1c51d31befc ("clk: sunxi-ng: Deduplicate
ccu_clks arrays"), but that won't land until 5.20.

Regards,
Samuel

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> index 29a8c710ae06..b7962e5149a5 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -138,6 +138,7 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
>  	&r_apb2_rsb_clk.common,
>  	&r_apb1_ir_clk.common,
>  	&r_apb1_w1_clk.common,
> +	&r_apb1_rtc_clk.common,
>  	&ir_clk.common,
>  	&w1_clk.common,
>  };
> 

