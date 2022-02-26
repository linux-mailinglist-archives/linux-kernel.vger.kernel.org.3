Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9B14C5393
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 04:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiBZDil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 22:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBZDii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 22:38:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4D190B74;
        Fri, 25 Feb 2022 19:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=08er3IcfPnj5kT98Dd2WZNuTMcBcFbsLNGNVuShvVqM=; b=F2YNPX+gmhOOZlQiXQMjDQYfea
        PmulQeG6uFsxUN4ajYPmnDoejveC/63RPzTavLD7oenwSKGC4S8pZYjHd6sg42fmYdM2U9zbmrnSH
        rhHBjfy5s/ExZ6FLv3AXwuz4JkDAbtiEUy6/cpaYJr3uk5BCDDNKlpcVlylrx10XgV5UdHWeouXA7
        Olcu4sv4tGUJ7g4IP+NXt0eCjx5CqC3/gxCsVPdBvKVrT9PD5i5F8KY9a+ltX5huH4PgN+P/xfAGC
        loFrMgb+Kk4sX3S8Z2TH1wWNWy6xq3ng5MogXM6XppVn4VVOLmjJdKt9eJE7LSedxE1MtMtbUktYI
        yvb6AErQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNntr-006Pbs-Bd; Sat, 26 Feb 2022 03:37:39 +0000
Message-ID: <e172056c-fe88-4c7e-376b-ce768d76ab5b@infradead.org>
Date:   Fri, 25 Feb 2022 19:37:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: fix function usage
 information for -f option
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        weizhenliang@huawei.com, georgi.djakov@linaro.org,
        skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, hanshenghong2019@email.szu.edu.cn
References: <20220226032641.2493-1-caoyixuan2019@email.szu.edu.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220226032641.2493-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 19:26, Yixuan Cao wrote:
> A previous linux-next based patch
> d7e9705bb715fc3deb16bfd5976d9d50f8d2aa67
> (tools/vm/page_owner_sort.c: fix the instructions for use)
> stated that the description for the "-f" option should be
> "Filter out the information of blocks whose memory
> has been released."
> 
> So I made the same changes in this document.
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  Documentation/vm/page_owner.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index aec1906976f4..32ca54757d3f 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -78,7 +78,7 @@ Usage
>  
>  2) Enable page owner: add "page_owner=on" to boot cmdline.
>  
> -3) Do the job what you want to debug
> +3) Do the job what you want to debug.

s/what/that/

>  
>  4) Analyze information from page owner::
>  
> @@ -126,4 +126,4 @@ Usage
>  		-c		Cull by comparing stacktrace instead of total block.
>  
>  	Filter:
> -		-f		Filter out the information of blocks whose memory has not been released.
> +		-f		Filter out the information of blocks whose memory has been released.

-- 
~Randy
