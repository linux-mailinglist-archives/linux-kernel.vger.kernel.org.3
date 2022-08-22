Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB61259C915
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiHVThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiHVThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F6120AC;
        Mon, 22 Aug 2022 12:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7A56122C;
        Mon, 22 Aug 2022 19:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22144C433D6;
        Mon, 22 Aug 2022 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661197033;
        bh=FeYGsxzCyb1NGsi9TcyMiumm/NVyPesnRttU2pCPJgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnf6EkL3sfDIT3ITEXiWFCXln4ziGtCF2o2/BqUTY71/UMaydkmuvKO76lhNgYKKB
         bWTAlDskcB/BFea2awpx3Aai+LCz6g7PYiDvyGzCFLoL4EChiEpm8CStD49JyT9pDk
         qUWv/J/26byy6dySt5Zq9Rqsr4viEH1S0jPhuY/a8HLWGKxFmFlDLbjtnAWP8N3wHU
         N7lhWIGA6WNGKEIMHV3UCU9LOUq0aYwNFKhsuVL7TbPOdW9FuYNiqdoxaKPtzH1Dn6
         aELdfX9urW1ACCvLBcgWNPSwk63V5Q+c2XykhuyjQ2QNmlu1F6z8gsuCRmyoxrNXK4
         NcN82MV38URIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14137404A1; Mon, 22 Aug 2022 16:37:10 -0300 (-03)
Date:   Mon, 22 Aug 2022 16:37:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>, bp@suse.de,
        ndesaulniers@google.com, nathan@kernel.org,
        alexandre.belloni@bootlin.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix compile error for x86
Message-ID: <YwPa5gZ0gVTM4Sli@kernel.org>
References: <20220822092557.210209-1-yangjihong1@huawei.com>
 <YwNcgdk/p18Cr+uv@gmail.com>
 <YwOBKwPmW/FX6hSS@kernel.org>
 <CAHk-=wjRLxmiTWiy4f1wa4S3NRK1kdZoAind_AtBGvNx=CdhYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRLxmiTWiy4f1wa4S3NRK1kdZoAind_AtBGvNx=CdhYg@mail.gmail.com>
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

Em Mon, Aug 22, 2022 at 09:45:02AM -0700, Linus Torvalds escreveu:
> On Mon, Aug 22, 2022 at 6:14 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Linus, I'll prep a pull req later today or you can apply this so that we
> > can reduce the window where tools/perf/ isn't building.
> 
> Ok, I took that patch directly. Thanks,

Great, thanks, rebased my local branch, re-tested, all is ok.

- Arnaldo
