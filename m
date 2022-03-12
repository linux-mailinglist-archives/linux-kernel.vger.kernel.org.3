Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990F34D6F4B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiCLNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiCLNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:50:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917F48394;
        Sat, 12 Mar 2022 05:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB6CB80184;
        Sat, 12 Mar 2022 13:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693DDC340EB;
        Sat, 12 Mar 2022 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647092985;
        bh=we1aIunEDsjXxW0Qgwn33PjFma16QfeEFYVdjto1NqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZGo5wPTvbpTwixKteGf5n4Ycql+6s49ePuJLqcQHU+JZVRNJX8Az7esa+Tgcrpkp
         hXHb+kezsfdTiF/B1bC/2tvo3rXDXPuvNp5tHUEIY5iIiGdI/MtAyL3zogbt3nOKGl
         yB3byrO20MM1qoiH0JmIei5d3JZGyR1MnQVohNx1TvXiy9O2Gv4bdO4kkfzFeAgDWa
         Os435JhnbjA3TKDrQgRSRHnJ8XX1jyS0Unz0sHGb921+FcXYWI/pD8faHwirNtkTgI
         kC5wR5teP1OgQsHXeynQG/ljfhKkAQ+p7ZeMZylxPn4P60lDa229vJXcdEv5ss0hqj
         UVymfkl/Iav/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48740403C8; Sat, 12 Mar 2022 10:49:43 -0300 (-03)
Date:   Sat, 12 Mar 2022 10:49:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Weiguo Li <liwg06@foxmail.com>, dbueso@suse.de,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: Fix null check
Message-ID: <Yiyk9xbhBoHTcJFG@kernel.org>
References: <tencent_B5D64530EB9C7DBB8D2C88A0C790F1489D0A@qq.com>
 <20220311190856.iv6tz3e3do2cc7tl@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311190856.iv6tz3e3do2cc7tl@offworld>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 11, 2022 at 11:08:56AM -0800, Davidlohr Bueso escreveu:
> On Fri, 11 Mar 2022, Weiguo Li wrote:
> 
> > We did a null check after "epollfdp = calloc(...)", but we checked
> > "epollfd" instead of "epollfdp".
> > 
> > Signed-off-by: Weiguo Li <liwg06@foxmail.com>
> 
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>


Thanks, applied.

- Arnaldo

