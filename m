Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4334D49DA34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiA0Fap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiA0Fal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:30:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B824C06161C;
        Wed, 26 Jan 2022 21:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8F46185F;
        Thu, 27 Jan 2022 05:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682C3C340E4;
        Thu, 27 Jan 2022 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643261440;
        bh=RFru6zDdDC7kdd3Z8nnB6b47NEgyHbEaUrldn5b6FWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oY99M0U+kI71Y9CyWwWre5mqwgNm2/qxzL8QfqnbF6aCuE1sXUhgLvNzAWjvtZiF/
         mbKJYek6PIAa2p6r8rgtQDPPoyjAn4/3dBYGt5mrKiIRnYPASvjylnNhg3RQNwk/5I
         D3VjYzX5jjWUIka/5lmugGhLk+IgA+1ruSeV91Ag+LafHF3wDspUBw3/EKrdEXC0tS
         ABwiowfNT52hrgjWjCqJFS1eC5A1ApPpQ8rBwomTmQvyVWj3GCYw3/Y30TjC0nAgxD
         u6k2yc6P3FypxpJjqgn1zYs/JfAl/bNVopr8RWuFoOZ85S88S3p9p4NIwjX00GZJNM
         L0r7crK7k0xEA==
Date:   Thu, 27 Jan 2022 11:00:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dt-bindings: phy: qcom,qusb2: Document msm8953
 compatible
Message-ID: <YfIt/Lej93IcH0lo@matsya>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-2-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-01-22, 20:40, Luca Weiss wrote:
> Document the compatible string used for the qusb2 phy in msm8953.

Applied, thanks

-- 
~Vinod
