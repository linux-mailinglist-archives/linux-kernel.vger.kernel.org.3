Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2632F5B21DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiIHPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIHPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13405F3BF6;
        Thu,  8 Sep 2022 08:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46A161D56;
        Thu,  8 Sep 2022 15:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABF3C433D6;
        Thu,  8 Sep 2022 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662650307;
        bh=Zi2AYs3hspJ01ETB39xKF96aCDXF/4NVThJlfyqh6A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+RMQO19CtfeCyO/7vbpKMXIueWkcjv5KqcSoHrjJuiHMSqsdr4FSFieE/loamTbN
         CWvsDV8ZGDj+xDZeuI6lWYcE5f+IHUzUhNVPTlUCaSZMi9WqUVIDqewCtxP/VSUsgD
         /YT024G91MwWXBiO+pTroNlqMe1OR1AUOR5rE5FFwMZ2SwNJ/dnbGg4bBA9mIwltND
         QTqR8GdYLkOsEgchlHLbtEmk+l9jX/vp9cQrPpSMDQdh89H+EasOzSujWA8PPGEtLb
         UOkPlDffyM7LNBPEBRd69WJhZ3HZj1NGcAW8YVJR9nMcD0iDdjKwX1lazghkXdniQI
         AuY3ef/fEfdlw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 43CDF404A1; Thu,  8 Sep 2022 12:18:24 -0300 (-03)
Date:   Thu, 8 Sep 2022 12:18:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Message-ID: <YxoHwE6gL7WLmZqk@kernel.org>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
 <Yxioy/TXc/KDLoDL@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxioy/TXc/KDLoDL@krava>
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

Em Wed, Sep 07, 2022 at 04:20:59PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter wrote:
> > Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, added,

- Arnaldo
