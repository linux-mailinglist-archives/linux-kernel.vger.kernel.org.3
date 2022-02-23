Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277194C19C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbiBWRRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiBWRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:17:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3302DFD;
        Wed, 23 Feb 2022 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5q1kQq7kOHd8ZWgMJKMpOyWpguieS1gKC/28ABG7S5s=; b=ITqVZ6SBZNt7r5a0FtOu25UNTB
        TCIQtfwU2JUD+OdJibHE4wP8yyfUFXVm/ASinwWBG8y7WRCYQ9KJl9exV+C5B/Tlk/Su0RNsoOLrt
        hKDPBMP9o6rj+JcbMuD+7cl2JfZZWAVIqMpoJFFmL4wtayE+4iDgJ9jNKgADcfarPLnlkrdc6MlT/
        M3CW/d9AzcBtToAZqFIMR/d5vPscLDmjeEW9uVzXosBgJFtQ7o9CPzIzcyWBKAsu8eqj69btLdSOW
        uzflFPSc9IZX1En/80rj82wmfQz6jiq4t4IP6wntePJAb4REGYGC6EakuBs1lGOySwvMTYHUmOeHG
        cp8qBRXg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMvFl-00CKDV-G6; Wed, 23 Feb 2022 17:16:38 +0000
Message-ID: <1b6fe797-4d85-610e-7b7b-8c8295cc307d@infradead.org>
Date:   Wed, 23 Feb 2022 09:16:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: fix commends
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        hanshenghong2019@email.szu.edu.cn, weizhenliang@huawei.com,
        georgi.djakov@linaro.org, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220223134104.2663-1-caoyixuan2019@email.szu.edu.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220223134104.2663-1-caoyixuan2019@email.szu.edu.cn>
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

Hi,

On 2/23/22 05:41, Yixuan Cao wrote:
> There are some commends that need to be fixed.
> 
> Thanks for Shuah Khan's constructive suggestions.
> The commends have been fixed as follows.
> 
> a. So, if you'd like to use it, you need
> to add "page_owner=on" into your boot cmdline.
> 
> Here, "into" has been replaced with "to".
> 
> b. ...page owner is disabled in runtime due to no
> enabling, boot option, runtime overhead is marginal.
> 
> Here, "no" has been replaced with "not".
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>

The file changes look good.
The Subject and patch description should use "comments"
instead of "commends".

thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/vm/page_owner.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 2b54e82b9fe1..aec1906976f4 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -26,9 +26,9 @@ fragmentation statistics can be obtained through gfp flag information of
>  each page. It is already implemented and activated if page owner is
>  enabled. Other usages are more than welcome.
>  
> -page owner is disabled in default. So, if you'd like to use it, you need
> -to add "page_owner=on" into your boot cmdline. If the kernel is built
> -with page owner and page owner is disabled in runtime due to no enabling
> +page owner is disabled by default. So, if you'd like to use it, you need
> +to add "page_owner=on" to your boot cmdline. If the kernel is built
> +with page owner and page owner is disabled in runtime due to not enabling
>  boot option, runtime overhead is marginal. If disabled in runtime, it
>  doesn't require memory to store owner information, so there is no runtime
>  memory overhead. And, page owner inserts just two unlikely branches into

-- 
~Randy
