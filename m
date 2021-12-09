Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599C246E20B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhLIFmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhLIFmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:42:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD0C061746;
        Wed,  8 Dec 2021 21:38:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4657EB823B9;
        Thu,  9 Dec 2021 05:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52599C004DD;
        Thu,  9 Dec 2021 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639028321;
        bh=fFBTSFrdXZUGePWij4vE30xl2P8jGIIrCn1ZphEI7W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxwq4wi4NaCliBKROCCVXEOSYoXi5UyE/VLuQaW4kZD7GD6t3X1xCsBZF9LRV1qRd
         B8iToP3hmS2T1SIQRt2RaOFGaosD/sjxOIN1ubSr91AWGs3n3riEFUKdCj8cQqmG1X
         Aopbq+XLFRnajLzmssvFZVheLFuklGvxvbK6JzjgRPmmVOhItwoxp9ePCThk8OuLmT
         RTGo6NnE7IYQklDRNxXHjAgvFjTB2i/grKbqnSlXewnaawEEYYPzPK5SOMuzpv6eht
         jf8PRA0JQ3bOOddTbcR3fkeOtY06TfD5XdbEnUsUOajfeZLFRVUKP5ZTvh7mbK788W
         D0L/21ffqKoPA==
Date:   Thu, 9 Dec 2021 11:08:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Katherine Perez <kaperez@linux.microsoft.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v3 1/1] arm64: dts: add minimal DTS for Microsoft Surface
 Duo 2
Message-ID: <YbGWXbA6jEJEZB3U@matsya>
References: <20211208235137.2751003-1-kaperez@linux.microsoft.com>
 <20211208235137.2751003-2-kaperez@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208235137.2751003-2-kaperez@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-21, 15:51, Katherine Perez wrote:
> This is a minimal devicetree for Microsoft Surface Duo 2 with SM8350
> Chipset

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
