Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7E462C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhK3FeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhK3FeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:34:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 21:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABFD9B81205
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45E3C53FC1;
        Tue, 30 Nov 2021 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638250253;
        bh=AH6JqNovGdIYiLtfyeEAto+S+Fvppbt0BQGlgcV8FDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr07doPAG7FW/LV/59KN1a8UYnlS8lYnYIxMCyUHTOljMoUSF7RstmCh6pY3UGPap
         T4r1xM7Q5qyv5I3blH1vn2Q39XOLYP1jKuO1c8iF/rS4fLCNHF7r89VuVqURQawCXl
         d3KsGymVDWN3bTk8+lA4CbtHKVeUO0giETAdlAsGHvNAf581h05re/NseXmJgEQlkZ
         A7BbedP5VSLGniDCGqX9LTQ+dFiu52CJggIcrdDvQTaKfiyOklhs0qxet+p9UXm3im
         UuAjBAEDWyyjEfRup5QopmlXeSqOgHnyu+eMaIFX2k+3jIBNT+TwvPAmRRdyVL43Eh
         n5As2JJiLmiRg==
Date:   Tue, 30 Nov 2021 11:00:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lontium-lt9611: check a different register bit for HDMI
 sensing
Message-ID: <YaW3Cff+AJqT8tS/@matsya>
References: <20211117020724.2647769-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117020724.2647769-1-pcc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 18:07, Peter Collingbourne wrote:
> It has been observed that with certain monitors such as the HP Z27n,
> the register 0x825e reads a value of 0x79 when the HDMI cable is
> connected and 0x78 when it is disconnected, i.e. bit 0 appears
> to correspond to the HDMI connection status and bit 2 is never
> set. Therefore, change the driver to check bit 0 instead of bit 2.

So we have got limited information on this but BIT-2 seems to be related
to HPD and empirical data from various monitors supports this, so this
seems the right thing to do.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
