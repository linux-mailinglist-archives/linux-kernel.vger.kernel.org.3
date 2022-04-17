Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187A5046D5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiDQGfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiDQGfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:35:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A321E3F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C5C5B80A3B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB91C385A7;
        Sun, 17 Apr 2022 06:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650177176;
        bh=il3gPx/oYqYy8snasqd2G+n5oON9hLbfVENXrGUtHFU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kpa6ViPSZjyTyZf6S1pWEaQ43NI/C7+4nt82QA+TvgtS9NqlJPD/h+ucmR44L6I0S
         KQQPEblvkKG5Jo7ww+rc6GMFv6kjw3SjPS2Wx1/nUaIkQkQFotilelNpqLaf+gyRCW
         2vXF/t1JdMH9iduGyvIQoqxyyEdyJK7EyDMnvCp2feIATsnmup51iyMMRBlvYVm8vc
         O/oOfsN0y0NxAi/TEWVTilocw+8g1NT2zqEHCjiFABRe2ai2GFCewZIkqydu8ufeaw
         MxERqmvMZj17LYAMimEDuTYSs7Z5lrKIzAsKuaQNW1VDzuJ4yRSdapsqEypuGBlcvY
         MafznwVeCNKew==
Message-ID: <ad5aae57-42d6-e2f2-66ee-14178384cde3@kernel.org>
Date:   Sun, 17 Apr 2022 14:32:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove obsolete whint_mode
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220413154920.2024872-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220413154920.2024872-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/13 23:49, Jaegeuk Kim wrote:
> This patch removes obsolete whint_mode.
> 
> Fixes: commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
