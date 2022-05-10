Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B1520F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiEJINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiEJINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:13:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0F259FB9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:09:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5720121B90;
        Tue, 10 May 2022 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652170165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUo2NijTHuFF3fqQZweqeC6eRrpXTLI2waNhQol4fLE=;
        b=tnBOZgx8Weete7kwVruh9fCkhFo/VFPH11RwvAKG0tpgyp4+vymyi8UbQm7MiYOvM8i36T
        bwo2QexzY2VrgSXmnsuItEsAHrpmn0RMue327fhtMdp/+gCCeauytpZCc3KeAcYsOJrEPr
        aQ7cU8jQ7VumIGygnBkrqaGdbeUs6ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652170165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUo2NijTHuFF3fqQZweqeC6eRrpXTLI2waNhQol4fLE=;
        b=ESEqc2F9sUe+6URSVbHwaelV3jlA/FQwVxsyw5SWRbtH7QGx3rTx5oDaeQYVbunGEq4mPP
        o8Yckd5r9yWzmFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2990213AC1;
        Tue, 10 May 2022 08:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEglCbUdemIYCwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 May 2022 08:09:25 +0000
Message-ID: <42799bd1-2c5a-d2ae-65a4-76e7de4f68a3@suse.cz>
Date:   Tue, 10 May 2022 10:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for slab
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220507073506.241963-1-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220507073506.241963-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/22 09:35, Hyeonggon Yoo wrote:
> Recently I was involved in slab subsystem (reviewing struct slab,
> SLUB debugfs and etc). I would like to help maintainers and people
> working on slab allocators by reviewing and testing their work.
> 
> Let me be Cc'd on patches related to slab.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Added to slab tree, thanks for your efforts!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..c21e6221513f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18103,6 +18103,7 @@ M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Vlastimil Babka <vbabka@suse.cz>
>  R:	Roman Gushchin <roman.gushchin@linux.dev>
> +R:	Hyeonggon Yoo <42.hyeyoo@gmail.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git

