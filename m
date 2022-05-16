Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97298527D06
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiEPFTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiEPFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:19:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CBA35A8F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=j61Lk+lXHdyvFlw3E6J/i5mxpaw1t3F5zTGmgjpL47w=; b=VD+ckcEpO8NYFYuFn30rfGesR0
        JJH49HIYQsOkQIrZFjjlxFOqInZBw3D6jaRupFRdzai7XsMfyP4DUuK1tEviEhLKKSWqXz1ZlW7Gr
        x9+zgPnwoW+6M4FJdJmObJoT3zPD8di2EyapaQf4XNx0pU7G6eAkgIpIIvdTx4uVRWojqN2K8n1cr
        jSvOLrWkvfLUYopPshH/zR4zKjApUMCYlGg2r42JvI5KzEfLXmZLni2Bppb03kvP2C6nbkVVgcz+j
        3yZkUNpShniYB0h3KyYgE+YG5DLcdduOqLG0qFD74NQypOrK7xr9qdhmaknKdjtcekLUnpuaOhHU1
        9PaJ1ybA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqT8b-009aQ3-FL; Mon, 16 May 2022 05:19:21 +0000
Message-ID: <4aeee9a4-e8e1-bcac-1ebb-f2b8860ba363@infradead.org>
Date:   Sun, 15 May 2022 22:19:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] scripts:modify output format
Content-Language: en-US
To:     Dong Chuanjian <chuanjian@nfschina.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Kernel@nfschina.com
References: <20220516020442.GA4277@localhost.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220516020442.GA4277@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The change looks good to me, but there are a few other
"process" problems.

1. Was there a compiler warning that caused this patch?
If so, then tell us about it.

2. This is v2 of the patch. You should describe what changed
between v1 and v2 (below the first --- line).

Thanks.

On 5/15/22 19:04, Dong Chuanjian wrote:
> scripts:modify output format
> 
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8caabddf817c..ba50993785ec 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -498,7 +498,7 @@ static void write_src(void)
>  
>  	output_label("kallsyms_token_index");
>  	for (i = 0; i < 256; i++)
> -		printf("\t.short\t%d\n", best_idx[i]);
> +		printf("\t.short\t%u\n", best_idx[i]);
>  	printf("\n");
>  }
>  

-- 
~Randy
