Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747F5465C56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355017AbhLBDCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhLBDCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:02:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0CBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39AAACE2152
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B63C00446;
        Thu,  2 Dec 2021 02:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638413952;
        bh=o0NFyjVR2qKGQkr94mZhlpfOuhwPuvNP637P3gi6/8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AkzX99sR2ycBPpq7wWlIq9cDgb+id32l/orV1UQ9u0VYVAblCC7iq6oBxGBUZOHFC
         RXjVvOlysLlZMSZxThtoAKtJSufGY08tqC9CUCaY3nRdddGP7gedC9FN1Y0WYsCMPs
         DMeoYFyhKoM0p6rvNhIEBdG54s7nbJwu6wMbuU3sIKG/x4OYn7Un9X6PHiOn/goBql
         KPsa99t3/8XT5k44jycEiF9nnbNd2YJ3CHxGST0hHSrkg+3PZ7Oy4N58PCaR6ipoR7
         9a36ELos2HfNh7dorqVR5TJ0Oz4/JaCHBldJHFElLLOCxl8YutISculzg/C5gDXGzY
         AG4AYboRhqz0g==
Message-ID: <f1c6e1f5-e2c7-a704-9a3d-5012ba3e9be2@kernel.org>
Date:   Thu, 2 Dec 2021 10:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [f2fs-dev] [PATCH 4/6] f2fs: fix the f2fs_file_write_iter
 tracepoint
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-4-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211116214510.2934905-4-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/17 5:45, Jaegeuk Kim wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Pass in the original position and count rather than the position and
> count that were updated by the write.  Also use the correct types for
> all arguments, in particular the file offset which was being truncated
> to 32 bits on 32-bit platforms.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
