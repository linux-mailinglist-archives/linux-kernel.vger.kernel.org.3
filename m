Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE046AF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378704AbhLGAxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhLGAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:53:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5207C061746;
        Mon,  6 Dec 2021 16:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E2ABCE194C;
        Tue,  7 Dec 2021 00:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9F7C004DD;
        Tue,  7 Dec 2021 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638838171;
        bh=F1mtF1jfjqdNckBTErgcE7hdxiUi8P4REaffmakUG8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YerynAY+YIvVTSzJPJ9p++HqFApjJ2hF+soSXiBaVRp4EWpvUxRacFS619pTT0hxs
         E0iRj6uNMJIpYWR78fMG99Qapo43e9Ek6lTd04AUzgWdo6Iw6SopcdjIAWTzCdIpDf
         4V9mGWzS6XgyJdAm7qzpJVQW2xRAql4UZ/WA+ceXGye3oQ5J3Cg1dqjrjLj0/+uoK5
         K4KFWJwyTkwy8RH8S7z1PIdTPJgcffcIq6p3DKohMbHpeH2mlHe3agg7+vYQNR2q9Z
         TeckFnRzGIqwPiKDni4kSXWMtqB1xyW4H7ZypwkLIVYYVAa3ahNjPImzBZCRRR7mop
         nrHj7jiih8D6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BED7440002; Mon,  6 Dec 2021 21:49:26 -0300 (-03)
Date:   Mon, 6 Dec 2021 21:49:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <Ya6vlokMH2pCTTfd@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <YaobYKgrTV1Bthi0@kernel.org>
 <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com>
 <Ya4CxsyoyFQVFzoi@kernel.org>
 <90475C95-0E7E-4212-A390-2FB33E47EC04@fb.com>
 <Ya5r81oxLY1Lb/JN@kernel.org>
 <BEF5C312-4331-4A60-AEC0-AD7617CB2BC4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BEF5C312-4331-4A60-AEC0-AD7617CB2BC4@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 06, 2021 at 10:34:31PM +0000, Song Liu escreveu:
> >From e033fd36657288ece383ba528aaff7b56eebfee2 Mon Sep 17 00:00:00 2001
> From: Song Liu <songliubraving@fb.com>
> Date: Fri, 3 Dec 2021 15:14:41 -0800
> Subject: [PATCH] perf/bpf_skel: do not use typedef to avoid error on old clang
> 
> When building bpf_skel with clang-10, typedef causes confusions like:
> 
>   libbpf: map 'prev_readings': unexpected def kind var.
> 
> Fix this by removing the typedef.
> 
> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")

Please get a larger sha abbrev:

⬢[acme@toolbox perf]$ grep core -A1 ~/.gitconfig
[core]
	abbrev = 16
⬢[acme@toolbox perf]$



Thanks, applied.

- Arnaldo

