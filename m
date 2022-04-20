Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D4508D65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380637AbiDTQgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380629AbiDTQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:35:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709045059;
        Wed, 20 Apr 2022 09:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B6461A15;
        Wed, 20 Apr 2022 16:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D66C385A0;
        Wed, 20 Apr 2022 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472389;
        bh=wr6KymuokZiq5D+EA0KfoyTNbKFzF4PNNrn62/cCrPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXbZZuE7srfXYXLTVeq34k2nN2rLZ277bSG+ipX5oi4lNxHIf9GlRETphFHHdF7Rz
         ut4E/hh+qS3eTqb2IW39fxbVo7LWJr7eUGVgTFn+AdK6W9PeBbyluLWVFvm2zwl4oG
         MjZVnZM7S4R+/xCHNDFESDAyYc56jx9gM8by4CNtArOWEbctFYDU8FkC9760MnOl1v
         UrOHvwChWyEQW/5wAss1SzzoYqpR4EqcVwffzWdNUINLYl9Wm1hQgMCUrs31K/Dgol
         HVx/wRBHbtWZCtKe69Xj3RbxDHpfInvawiImXdzwEcc6v6mPKkWKUg7P4hPgMl4bFe
         ipnf81Wu9kvxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A438400B1; Wed, 20 Apr 2022 13:33:06 -0300 (-03)
Date:   Wed, 20 Apr 2022 13:33:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     gcc-patches@gcc.gnu.org, linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add HAVE_DEBUGINFOD_SUPPORT to built-in features.
Message-ID: <YmA1wvsHjKyjK6Mg@kernel.org>
References: <0d1c5ace-88e8-7102-1565-7c143f01a966@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d1c5ace-88e8-7102-1565-7c143f01a966@suse.cz>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 20, 2022 at 01:30:09PM +0200, Martin Liška escreveu:
> The change adds debuginfod to ./perf -vv:
> 
> ...
> debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
> ...

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  tools/perf/builtin-version.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 9cd074a3d825..a71f491224da 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -65,6 +65,7 @@ static void library_status(void)
>  #endif
>  	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
>  	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
> +	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
>  	STATUS(HAVE_LIBELF_SUPPORT, libelf);
>  	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>  	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
> -- 
> 2.35.3

-- 

- Arnaldo
