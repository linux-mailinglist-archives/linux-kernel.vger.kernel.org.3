Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E7512900
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiD1BpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiD1BpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:45:11 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAFB98F4B;
        Wed, 27 Apr 2022 18:41:56 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 Apr
 2022 09:41:50 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 28 Apr
 2022 09:41:48 +0800
Message-ID: <76bbc209-44df-ddbb-e5b1-42278644bc80@meizu.com>
Date:   Thu, 28 Apr 2022 09:41:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] docs: vm/page_owner: Use literal blocks for param
 description
To:     Akira Yokosawa <akiyks@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <seakeel@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cfd3bcc0-b51d-0c68-c065-ca1c4c202447@gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <cfd3bcc0-b51d-0c68-c065-ca1c4c202447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/27/22 8:58 PM, Akira Yokosawa 写道:
> Subject: [PATCH] docs: vm/page_owner: Use literal blocks for param description
>
> Sphinx generates hard-to-read lists of parameters at the bottom
> of the page.  Fix them by putting literal-block markers of "::"
> in front of them.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 57f2b54a9379 ("Documentation/vm/page_owner.rst: update the documentation")
> Cc: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Alex Shi <seakeel@gmail.com>
> ---
> Hello Andrew,
>
> This is the first time I send a patch in your way.
> So I'm not sure this works as I intend.
> If anything goes wrong, please let me know.
>
> This issue is in discussion in a linux-doc thread triggered by
> a post from Haowen Bai [1]. (Warning: The thread looks confused
> due to Haowen's unnecessary uses of In-Reply-To: headers.)
> Jon suggested the route via your tree, but he keeps posting
> to linux-doc.
>
> [1]: https://lore.kernel.org/all/1650424016-7225-3-git-send-email-baihaowen@meizu.com/
>
> Haowen's patch uses tables to improve the look of param lists.
> I suggested him using literal blocks instead, but I failed to
> hear any response. So I'm sending my version of the fix in your
> way.
Dear Akira Yokosawa
Sorry for missing reply your mail, since I am out of work at that time.
BTW, I'll try to work base on the newest Doc later.
Thank you for your suggestion and apply the typical format for  parameter description.
> I believe this fix is worth for 5.18-rcX.
>
> Side note 1: I see another patch queued for -next around here, which
> has broken indents by white spaces.  You might want to fix or drop it.
>
> Side note 2: page_owner.rst is not covered in MAINTAINERS.
> You might want to add an entry, maybe, under "PAGE TABLE CHECK".
>
> Again, if there is anything I can do better, please let me know.
>
> Best,
>
>         Akira
> --
>  Documentation/vm/page_owner.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 65204d7f004f..7e0c3f574e78 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -110,7 +110,7 @@ Usage
>     If you want to sort by the page nums of buf, use the ``-m`` parameter.
>     The detailed parameters are:
>  
> -   fundamental function:
> +   fundamental function::
>  
>  	Sort:
>  		-a		Sort by memory allocation time.
> @@ -122,7 +122,7 @@ Usage
>  		-s		Sort by stack trace.
>  		-t		Sort by times (default).
>  
> -   additional function:
> +   additional function::
>  
>  	Cull:
>  		--cull <rules>
> @@ -153,6 +153,7 @@ Usage
>  
>  STANDARD FORMAT SPECIFIERS
>  ==========================
> +::
>  
>  	KEY		LONG		DESCRIPTION
>  	p		pid		process ID
>
> base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b

-- 
Haowen Bai

