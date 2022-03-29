Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E155F4EAF28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiC2OZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiC2OZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEE01CB2E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD0C61607
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D380C340ED;
        Tue, 29 Mar 2022 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648563817;
        bh=sRzUpzrKTVT4tz5RtCx6TS2/CwuHsCPOf9pnrP091pA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=azcFwgoJgYfcB6jgfZ6tfxNO+NzwVTMh2y2es/YfKA6u6n9KDtvcmLYM/3Pj+U8gc
         ybDnLTG9qf1xm8kTsodLjCNRFHy/di039JzeI5eA8wzQmPmbelqglDUl4GPWbxj4l4
         S6eN8IHNnYB+SPR4qSbO54HeHJAeKENIaz5RJtBQoYG4r6uLyL5o5BXytXQBWjNCUK
         A3DyOU1bHmcE7S0yxJFwcR/ZX9gus1XVsVf54A10Tjxod5zkstRfBIEPKaHARlqKUQ
         oirwaCWsFZ8VzSAlnN+BTpa7vEtbi8P1DKcxEb1Jp6jzZaOj+hohTs+wOlpAScOtd5
         WJ8fGzAEWwAnA==
Message-ID: <101f4cb6-37bf-0ac3-3838-7aab7e648352@kernel.org>
Date:   Tue, 29 Mar 2022 22:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce data read/write showing
 path info
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
 <YjkUvRKhyX8AUoTm@google.com> <YkJ5anzBIyQkiHfU@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YkJ5anzBIyQkiHfU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2022/3/29 11:13, Jaegeuk Kim wrote:
> This was used in Android for a long time. Let's upstream it.

Could you please explain more about its usage?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

The code part looks clean.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
