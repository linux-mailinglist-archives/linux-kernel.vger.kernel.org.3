Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1D59F39D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiHXGdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiHXGdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:33:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29D7F0B4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F759B82365
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0300C43470;
        Wed, 24 Aug 2022 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661322810;
        bh=8kwtJX3bSOriP9VPSA40UiAk54/reUPTo+73q/qPh/I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EduN1P9tPAYeIwUR4X+tbVZQ2CjasVsIgE3+8ybkq4S6/qzf3GsqI+3KIdblKUctX
         HVUqSbPekR0PQq3rV2oLcGjHgVwq1+fdljXSO+nyKyBEU/H+rKTsOTUwdIgVDwc2ZX
         s1htuFgNK11ngX+eJrwrQkwd+lfX4vIdKouv1U39RV3mJ55shs36Pt2VMWpV5UfcwT
         PNaP4yU5HUCD2z4Vfbo4xsEarMb1+Afl8UuKge9AT14EWVxX87EnEtwQ7SunKLxBlP
         4LakKRT8GATWy0CXdoc5QYEzJGnsk2w8AWeNYi61VSH/kce0khejRTvgo4qzJYkvz7
         JYsKlhHzIMonQ==
Message-ID: <5688e47a-fc2c-457c-fa78-071733bf06f3@kernel.org>
Date:   Wed, 24 Aug 2022 08:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 1/2] rv/monitors: add 'static' qualifier for local
 symbols
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>, mingo@redhat.com,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
References: <20220824034357.2014202-1-zengheng4@huawei.com>
 <20220824034357.2014202-2-zengheng4@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220824034357.2014202-2-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 05:43, Zeng Heng wrote:
> The sparse tool complains as follows:
> 
> kernel/trace/rv/monitors/wwnr/wwnr.c:18:19:
> warning: symbol 'rv_wwnr' was not declared. Should it be static?
> 
> The `rv_wwnr` symbol is not dereferenced by other extern files,
> so add static qualifier for it.
> 
> So does wip module.
> 
> Fixes:	ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
> Fixes:	8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
