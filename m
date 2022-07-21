Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF457C61F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiGUIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiGUIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:21:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950C7E002;
        Thu, 21 Jul 2022 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658391697;
        bh=yNyaWxGVWAkT4VwBbvTqloaCzcp93id9lrdVRLcIzxE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BTWN8TzHtxoRGp72P8nurA+lrMmWQUH2h+S2ptppi5YULal1rCWKbG4uE3z2gznC1
         Zvy7xWuAg3//NAzYeDQVoZQ8g41z/5BJ0wI07dSR3nA2TXjHNgqR2s6cB72EAd1/TR
         rdHelyOnGumv0SBr6Ddw61qCKXvoMeY/vvaPYLE0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.130.88]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1oFocI3XN9-0022ti; Thu, 21
 Jul 2022 10:21:37 +0200
Message-ID: <e63cfffa-126c-d6da-207d-43db651d2d92@gmx.de>
Date:   Thu, 21 Jul 2022 10:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma-mapping:do not initialise statics to 0.
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720193941.8261-1-gaoxin@cdjrlc.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220720193941.8261-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gYTUu6tG0sdhEE85vOo6dYW4wCykQ9sH4QkWJdu7L5837A3aG2D
 tjytWJg7xk/VJNutSNaAfb5mmapZQ1fLxdmwPXTCD3XGNnI6bTv8MY1arq0dKXzXYzivFod
 zRfaiZnm+3l4lGLe6o+4u4xmF0Q1FVt07rIM9AQnwfWw2CtABUkP+GtWKc+0FlxnGh9YWX7
 kfq1nXlkRqcG5EwlF70Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6XwlE23K330=:CiVxwWkTZSFSbTvpYLnU2E
 U49XW4EdBsn2F+DD1ifHsobWC/8PfpMlvN7QhSbstucrGY0xHN5cSJ2z6dBqBEKf+Ak9gqzA5
 crVpgOdRHFyMIPy7lcPC63HsdjWk9prVh6bXPBFivGQSnTKdUEUV5PCg0shm+pQpw/xax9iwS
 gDgDLu7rj2+C+b1uVh4Sbg1uFtfU56cFbei03pWe150Ll2zDLxwL0f2lU2Gj2VR6tDduyUFGI
 RezxdflJguemvq8rDzvusWxPgOz+XlAdzdLc6ksvjqunYF6+Y2uwQAyX+4U4/ZULyUxGaQIOH
 i4yuSxN63RQVbpol/YhCsJNe/Ek/3Ata/EVeztW3XV7D+OV14SlcxJwlg9PYovgSUU5nTmQkX
 WTCWJHgWwp1erZDqI4W93KsDQoHGws77LmrBH7ci3sKzrJ1EytOReuhiBzgllKSdE5rVupK2P
 0UKSjGTFE4u4nhVqc9ur1xmswhiVmNTKgju/jD99V5CWURjpVu5Xk32s+piWM35wOCC7jP3ZE
 RDdpUFd1nvn7UuPAEl0UEhLIUvFq8B0IJrYbF6MgDi0W9+2/p5aHD9teE84Xv1Z7+3zIQVcPX
 gpOsqn8GGuPTXC9bDZU7IxMav4AmI4zT1SvK4sJ7/RUFTcFvBiRMhZy5i1BVJfwTPu+BnVAKM
 fNebeMuoKH/es7daJ4l6lyu2PLEzB1poZa9xhLSeyIC4U6JsNefI3+gOuh2bFmZxyKJt8Opcf
 Fa9GGxFZHX77kbzOAm+2gLv1MlEuPQKnMqIxoHwNKoFj9wB09vbjlyeHCgIdeK+oauKJBokFz
 sc8uYszk57R3U0weUwE96mlc77+yHDQGoU7RcyFXHYLCIcxQMeObI3LRpGRFUr+PNUEjvMgmM
 laLUxNVkwt4SrFmwch4j8OjrpC7z07++sXSKZN3N2rOV4S5825EUBtdj3NafgtR9y8LoUL2AE
 fnC15VZPqF7NoQ3r0XVTb0n+qLvn+O42F7NcK2F83SSIEO3XJvxaxCBf1titwzBvvlvrRIZQw
 iZgJNzmoHuqQGRERHaY1vozmpDM+ErutO0M8ULGTHJxWpDmpxHegJGhABFeJzouH/BoDq/gWR
 Jcyde800r8JmRkvqqOESfmOUaVGi4qo0fCn
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 21:39, Xin Gao wrote:
> do not initialise statics to 0.
>
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  arch/parisc/kernel/pci-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
> index 160996f2198e..ba87f791323b 100644
> --- a/arch/parisc/kernel/pci-dma.c
> +++ b/arch/parisc/kernel/pci-dma.c
> @@ -36,8 +36,8 @@
>  #include <asm/tlbflush.h>	/* for purge_tlb_*() macros */
>
>  static struct proc_dir_entry * proc_gsc_root __read_mostly =3D NULL;

While at it, you could remove the "=3D NULL" as well.

Helge

> -static unsigned long pcxl_used_bytes __read_mostly =3D 0;
> -static unsigned long pcxl_used_pages __read_mostly =3D 0;
> +static unsigned long pcxl_used_bytes __read_mostly;
> +static unsigned long pcxl_used_pages __read_mostly;
>
>  extern unsigned long pcxl_dma_start; /* Start of pcxl dma mapping area =
*/
>  static DEFINE_SPINLOCK(pcxl_res_lock);

