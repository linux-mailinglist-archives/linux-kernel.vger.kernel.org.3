Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1948981C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiAJLzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:55:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42342 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiAJLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:55:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A038DB81616
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13C0C36AE5;
        Mon, 10 Jan 2022 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641815740;
        bh=rRcag0Wru4htyDyypLq1Ra7PS+1wh1Z6ri+Ua7S+Ajk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rqcXmrS1sNkJWXHdZ7Nh7IEM1sObBhjx+voP2/KOdLGQEbgOOl9dVe3WnvkSr0cs+
         99w5d5WY81sXY4/vC1wzSp3lSbJPGhzaWix+CCmUFrwugg4Jg37bvUI5UAzy2qlimU
         1HZMKAtKv5wz4DorSePFk1n9nCd2dRps1F/tqthZZTQrTyQqRVEzPD17TXlVJqk4dq
         v3nAA/bImB1NU8D0AndgM4gCAzsogVSdX44NOQVp6gtyRGf1Gz79OhPUhrfVB7PIpR
         hbAN9LLxceZOD6MOBU0fpSggszEyxkqtQuSxXLmAn8o5QBqLIMhfkbfTQmtmZCn2wr
         TTZuaYLoWGqXw==
Message-ID: <e0f8de9e-02f5-acf3-6226-f253c423f57d@kernel.org>
Date:   Mon, 10 Jan 2022 19:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not allow partial truncation on
 pinned file
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220108164552.3130085-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220108164552.3130085-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/9 0:45, Jaegeuk Kim wrote:
> If the pinned file has a hole by partial truncation, application that has
> the block map will be broken.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks

