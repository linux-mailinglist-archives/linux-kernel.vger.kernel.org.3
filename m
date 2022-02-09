Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB94AF218
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiBIMuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiBIMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F25C0613CA;
        Wed,  9 Feb 2022 04:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236B061909;
        Wed,  9 Feb 2022 12:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6710AC340E7;
        Wed,  9 Feb 2022 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644411020;
        bh=e0spYyopUTJEcbTeOrH8NAGq+fUdLvm5AdAAhdd09Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ag1NfRBP844izHjhn428z33WAj1ZxvxL6Ae2imjd+A91Dg0+CxXTNYNXewjyhhFBk
         maHPqR/zr9ICAGBXzT1w/sHwtzShS/EO2DNcqZkzVhXh/JxUJ1PySv4C+M9TMcwjYW
         +dDiDMk9C0Np/114sA6EeUT0Vfagx7hS3D0YIzaz6LTb1aliarFs/DdsZGrRpd+dSo
         vMHssD/9ECBel+zg8cEnCeEPjmLn5T4o+pAg0FJSVSBTjSMbY0sPg7gDSm1AgE5Cv5
         JJ9zmMCHohdmoIpIMBy06lCxrtaL6py7mg8WYCUE5W5arTn+b1QjoZuL/psVJI9KH6
         55i4NV02j1EMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DDF7400FE; Wed,  9 Feb 2022 09:50:17 -0300 (-03)
Date:   Wed, 9 Feb 2022 09:50:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Jiri's email address
Message-ID: <YgO4iYUj2SXAtkGG@kernel.org>
References: <20220208221117.710405-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208221117.710405-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 08, 2022 at 11:11:17PM +0100, Jiri Olsa escreveu:
> Using my kernel.org email.

Thanks, applied!

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..d4248b02515b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15123,7 +15123,7 @@ M:	Ingo Molnar <mingo@redhat.com>
>  M:	Arnaldo Carvalho de Melo <acme@kernel.org>
>  R:	Mark Rutland <mark.rutland@arm.com>
>  R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
> -R:	Jiri Olsa <jolsa@redhat.com>
> +R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Namhyung Kim <namhyung@kernel.org>
>  L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.34.1

-- 

- Arnaldo
