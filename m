Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04D56A3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiGGNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiGGNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2A31912
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C5662019
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5937AC3411E;
        Thu,  7 Jul 2022 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657200767;
        bh=oRBMaGVn1cl239Cco0RUv0lBgGDfW5Ex3mNFdLKR7zo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hukO+DZS4phyRv+SQJDyrDwFokujShVXN4rDkd9bc/QuhjMbAwVAskiLPTE+/yNvN
         MyPe5oflLGCoMRZEihDt26qse/vl+X7w5czsnHUKwAguDbzNt/8JEmSs/iBA//KDQQ
         KRXIt6rN0aSV/VXbtu7V5iGqR8KU1p0CdA6zvsIhMHOr9qdRqNwFJcBZKQRF5/SR3S
         iD6vpAd4HpUKAnJeS3R1oZu8V4axoiOf5gcs/4xzdYYfNnKrDi8RdZ8fQRignQJrWB
         REL1E4GfsuSunKLzRhbcokxtiZfxxKlsL+R2eFWhPMkrbc4abCext1DTmLh5tRyZMM
         q20REdzUQ/OkA==
Message-ID: <e019a7c6-e112-786d-b431-49e355fcee8b@kernel.org>
Date:   Thu, 7 Jul 2022 21:32:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] f2fs: allow compression of files without blocks
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220707090924.4183376-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220707090924.4183376-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 17:09, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Files created by truncate(1) have a size but no blocks, so
> they can be allowed to enable compression.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
