Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76103472096
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhLMFhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhLMFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:37:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB2C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 21:37:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A2351CE0BA2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01910C00446;
        Mon, 13 Dec 2021 05:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639373868;
        bh=2QC3Kl/2MMKihnjaBJT0x2ghCpA67B2jmis0nr50n+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzFmotQoKgkzgXWtSPGLEHVSEFWeAkJl6DJq4KMskOP6T2IjL+3K7ZzgutowB+vVA
         Yzu9cPpdB8sDefllTcSutV3wjJNU8zCSJqEQ5iHre389wtvzucMg/hylTxrIKA2fWC
         h6T5E1JjkReo4AdXYOB4VD2Z5O80TFSWKwa87TgMuc6HD5vpiwjec/DE/bKI4zMM4b
         gpnLU5X5/bGxVA9X+ODhYuGkmwl5XB6DcptsyrfDGq8QVCvbUDBkMv9CYkFka8b6aQ
         Xa9p8i8eF2rQrSDPoeAVPddDzjc1QbqKVJmb0GC8/p8V8cOsdpbmYdOjUwgOGyYFRZ
         0ip/JKNKluvKg==
Date:   Mon, 13 Dec 2021 11:07:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] amba: Cleanup amba pclk operation
Message-ID: <YbbcKabNS0plDpcK@matsya>
References: <20211210083130.141784-1-wangkefeng.wang@huawei.com>
 <20211210083130.141784-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210083130.141784-2-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-21, 16:31, Kefeng Wang wrote:
> There is no user about amba_pclk_[un]prepare() besides pl330.c,
> directly use clk_[un]prepare(). After this, all the function about
> amba pclk operation, enable, disable, [un]prepare could be killed.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
