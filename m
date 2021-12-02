Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B40B465C01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbhLBCIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhLBCIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:08:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91090C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:05:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DCF73CE2153
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D69C00446;
        Thu,  2 Dec 2021 02:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638410726;
        bh=Zqyn1HxcMbaKd/c5Q44hpfPvEint8HyN5m96Kf4PoIA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=mNsaV/nirFNJmCmm+sUO8fJfLBiQOku/BZ75Kvy9bTURrQvaxrA6uO6bI8rDr1eTu
         JBIfQ8d6Rv9A5DA+CwVRqtaWWAsazlTyN87wXH2r/SccpmTVG0emfz100zVRom2iWG
         xWMZqgGXphECIXEA/sXJ3F7fNATWSevSdIsiAgJz4DjzclTOhX7MUYyDOkGjpDWLIJ
         AAgBpSRA14ZP/YQLMilECADgqVTSKwTngp+CVtb+PUQzSQlh2g5HUeDz1MjmtM7pxB
         NxFgkXiA0uk/UI0d6OQQNtCymxdRToEeoILMlPov+VMeE/QTQfkbhL407mn3+Zcc6/
         0RtZGL0ts1iQQ==
Message-ID: <4e23a185-3c0d-37ce-1c56-18db8218120b@kernel.org>
Date:   Thu, 2 Dec 2021 10:05:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: show number of pending discard commands
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211129190039.598115-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211129190039.598115-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/30 3:00, Jaegeuk Kim wrote:
> This information can be used to check how much time we need to give to issue
> all the discard commands.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
