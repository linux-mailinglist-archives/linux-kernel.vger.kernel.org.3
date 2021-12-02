Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4A465C55
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbhLBDCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhLBDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:01:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE42C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6A3CB82148
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC45C00446;
        Thu,  2 Dec 2021 02:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638413909;
        bh=LraxeI1/dxSjuRHUMtK9daJ6qzZS2pK9w3OIW9Mp8XI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X16/N+w8CZnooamPDrNtzDzBPN/4SdJJFE9IEM5hB8qzbLGDAO95zNDlU//s7/zR9
         jjd3mk19oP9xXXxNty6Hgowzq5H6mAtw0CFWvUUEXa3oNnP1ECkTg7a3uSnC+IAQny
         YaKA/AVTPUfgVtoSr1QDZOXD2YleCxBhS5+NzDPsSiNGmMB1wbPEdX6SQHlsGj6cuc
         b25m2QXRFT68qjzSx3zyX7B97L0uL5+JcNxFLCMsqgpicvA396Vc3ThE4BsDNoxabd
         J6wRGzGZKqkL+08pdcM5AlW7oZGnbMukuqmyarr51p0Aojd6bpTGLzel1BxIPFD0AJ
         Tux1aky90NZLg==
Message-ID: <9a0d8831-7544-7778-5f98-48fba55cf9b8@kernel.org>
Date:   Thu, 2 Dec 2021 10:58:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [f2fs-dev] [PATCH 3/6] f2fs: reduce indentation in
 f2fs_file_write_iter()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211116214510.2934905-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/17 5:45, Jaegeuk Kim wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Replace 'if (ret > 0)' with 'if (ret <= 0) goto out_unlock;'.
> No change in behavior.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
