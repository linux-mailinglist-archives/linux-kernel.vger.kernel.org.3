Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC044D368F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiCIQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiCIQVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:21:48 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60DC3A5;
        Wed,  9 Mar 2022 08:20:46 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru B5CC8209A0EF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] docs/kernel-parameters: update description of mem=
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-doc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220309122446.1118738-1-rppt@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d3679148-598e-4b58-96be-e3ab255ab8d9@omp.ru>
Date:   Wed, 9 Mar 2022 19:20:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220309122446.1118738-1-rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 3:24 PM, Mike Rapoport wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The existing description of mem= does not cover all the cases and
> differences between how architectures treat it.
> 
> Extend the description to match the code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> This is in a way a followup for the discussion of mem= usage on MIPS:
> 
> https://lore.kernel.org/all/1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn
> 
>  .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..f3597841a031 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2834,6 +2834,15 @@
>  			2 when the kernel is not able to see the whole system memory;
>  			3 memory that lies after 'mem=' boundary is excluded from
>  			 the hypervisor, then assigned to KVM guests.
> +			4 to limit the memory available for kdump kernel.
> +
> +			[ARC,MICROBLAZE] - the limit applies only to low memory,
> +			high memory is not affected.
> +
> +			[ARM64] - only limits memory covered by the linear
> +			mapping. The NOMAP regions are not affected.
> +
> +			[HEXAGON] - must be use

   Used?

> to set the memory size, there is

   What? :-)

[...]

MBR, Sergey
