Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CA59114D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiHLNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiHLNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A390C6A;
        Fri, 12 Aug 2022 06:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB610617C0;
        Fri, 12 Aug 2022 13:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3215BC433D7;
        Fri, 12 Aug 2022 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660310609;
        bh=/lv88xp2oA1PzTLyJc6dBD17FKmwoXzEzmWpFb15WwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCM2NIjtRzkX8nwXyl1wy6yZCBtMTB5loKmfwDCQFawv7062SOm2uWBZlgwMiag7N
         sNk2TOs+Z6O4IBSKD69xlcYbTX1yOnlELS/uEv+TPQcWiJCwVoCJM0pMeR6DwfNUb1
         cDR4xvgiuLS4lQF7bQXSpAfkRGeG9KR59bxDBe7F8apJIlK9RgnJjuRWF3HdJK2p3U
         ABez2PcWTUE07lKz4bnYvY0fegMGmRcHYqWfHNAk4G6F85PY/EM3ee7ZmsaMyAPT40
         UqfLoVeLG3k9p1iD0Wjn+kfyHWHc71V/OcC3pIHhthTGUx4PDNBs9wycJjlW7k4/kY
         3hhKXMhjD3eCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CBF64035A; Fri, 12 Aug 2022 10:23:26 -0300 (-03)
Date:   Fri, 12 Aug 2022 10:23:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: fix coding style in build-id.c
Message-ID: <YvZUTbEjvSLbUJQQ@kernel.org>
References: <2983e2e0-6850-ad59-79d8-efe83b22cffe@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2983e2e0-6850-ad59-79d8-efe83b22cffe@suse.cz>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 12, 2022 at 01:42:56PM +0200, Martin Liška escreveu:
> Use tabs instead of 8 spaces for the indentation.

Thanks, applied.

- Arnaldo


> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  tools/perf/util/build-id.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 9e176146eb10..0cc68cdd84c8 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -652,17 +652,17 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
>  	nsinfo__mountns_exit(&nsc);
>  
>  #ifdef HAVE_DEBUGINFOD_SUPPORT
> -        if (realname == NULL) {
> -                debuginfod_client* c = debuginfod_begin();
> -                if (c != NULL) {
> -                        int fd = debuginfod_find_debuginfo(c,
> -                                                           (const unsigned char*)sbuild_id, 0,
> -                                                           &realname);
> -                        if (fd >= 0)
> -                                close(fd); /* retaining reference by realname */
> -                        debuginfod_end(c);
> -                }
> -        }
> +	if (realname == NULL) {
> +		debuginfod_client* c = debuginfod_begin();
> +		if (c != NULL) {
> +			int fd = debuginfod_find_debuginfo(c,
> +					(const unsigned char*)sbuild_id, 0,
> +					&realname);
> +			if (fd >= 0)
> +				close(fd); /* retaining reference by realname */
> +			debuginfod_end(c);
> +		}
> +	}
>  #endif
>  
>  out:
> -- 
> 2.37.1

-- 

- Arnaldo
