Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED78465BFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbhLBCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350573AbhLBCFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:05:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB56C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4A7CB82192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE8AC00446;
        Thu,  2 Dec 2021 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638410530;
        bh=16Aj4t3kzRV9C2YxN9lR+dV2tB6ndt6yB0ZioM2yKK0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hrYsu56wozRMQDybk2aWcTV2X6e+0GmLw10jkVoF1KjJXtvEqujFXl6xEiDhwzaZd
         zv+Fy0xx230uJxO6LsrdX3mmGCi0rcHbiwHVLL12DNOBowE49lN6Gh/HygbDAzqsKs
         tC2FPZRIMTJ3WgnW9+fELKbG89K7Bla6W3trGQzgxjh6WlMCnbYq155mNLV3gXEn/s
         vQp4S89kXYzJg0cntfN2uYK8ukP1vrS7ZanfCJ5LVCVPCmEzfzWOY7itkWGhitDO+t
         qNF0EaWL7nxCxxFSuf5I41YXQm8AJP7wZIreK0BNdUu95BRgFPhbNsB5TZplaoYwDE
         ZCqj2yR/5trTQ==
Message-ID: <17aae2df-f9d8-c039-e3b0-551ad897a134@kernel.org>
Date:   Thu, 2 Dec 2021 10:02:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: show more DIO information in tracepoint
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211119211222.3114368-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211119211222.3114368-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/20 5:12, Jaegeuk Kim wrote:
> This prints more information of DIO in tracepoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
