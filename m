Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9654A2C23
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiA2GaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiA2GaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:30:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E0C061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 22:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB6160B87
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD284C340E5;
        Sat, 29 Jan 2022 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643437814;
        bh=O0Vb2Z47aKXoGYrt0vsVOneHYCWi7TwmdD7NQmLIbLE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z9mXvmN2zDZN233yVb0WPcheCr+3xRNokZOrPgIjzkQiSf0pj3skbNdyoQ/y35QPS
         5VC1R4u3GTonsBulJJXy3UlanxC5zFTYJDFQwlq1AWa9zCh35UNSJ+zmN4NWR4KHj9
         4MDk+s1TsAfKnzoH2Riw6JV1v4pWdZPNzMX1WHM3aB7KK5OtfX4pRbqZ+ViqcowUnN
         xixIjHPXtVWu59AHoGkmLjeNn9kvdupUp4yCw/TtdtlCx99SZLGpSPo0Hif1UMKWND
         aIqxo6XOauWoJE/PglpdVRfdtZmSoHL6UykybTNnMnRr/wgGZuI195CZx5RBdxM8Hk
         O6PMV21WZv1kg==
Message-ID: <31cc6a64-1962-d336-601f-70f3f8e7bf29@kernel.org>
Date:   Sat, 29 Jan 2022 14:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: expose discard related parameters in
 sysfs
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Konstantin Vyshetsky <vkon@google.com>
References: <20220125202254.3111474-1-jaegeuk@kernel.org>
 <20220125202254.3111474-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220125202254.3111474-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/26 4:22, Jaegeuk Kim wrote:
> From: Konstantin Vyshetsky <vkon@google.com>
> 
> This patch exposes max_discard_request, min_discard_issue_time,
> mid_discard_issue_time, and max_discard_issue_time in sysfs. This will
> allow the user to fine tune discard operations.
> 
> Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
