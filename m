Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653F4473CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhLNFe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhLNFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:34:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9BC061748;
        Mon, 13 Dec 2021 21:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75342B817E3;
        Tue, 14 Dec 2021 05:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DD7C34604;
        Tue, 14 Dec 2021 05:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460095;
        bh=uifXN9knAPqcj8AIdmY81gvwtHrEyoIN0iv6l/5tB5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aloQNyOyWbcWHQoTNgGgcTu3/FtPbTi4ej1487uIBJkg3cbq3VEHIu4a7PlDKUeXM
         eJNsRv+mPW/Nn6XL9oz0Ztff3d66aJE2y2pSS+g+4FbaUu0f68p8PriYZzLDZam4zc
         hSeCkMbP57MU1wcC/vu9JVY4Q9Stvs7xpXCv7nwt5ntqZyurolHKTcQydJr0V/sgRR
         B26RxyWCjMO2PxAFnkZP2+FwsBJZ6DZiS5sGCHF0GxB6xLupDh/QyqJ6n5gTvEdK3X
         7uUmpAH5bb1d3segDDBqCY79JfFkRdoDi/666mKnUB5GpNEq8A0LGDov6qNwBywgjG
         ajkXo2CP1S4YA==
Date:   Tue, 14 Dec 2021 11:04:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: qcom: Add clock driver for SM8450
Message-ID: <Ybgs+zet4EVGMa2a@matsya>
References: <20211207114003.100693-1-vkoul@kernel.org>
 <20211207114003.100693-3-vkoul@kernel.org>
 <20211209082607.06929C004DD@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209082607.06929C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-21, 00:26, Stephen Boyd wrote:
> Quoting Vinod Koul (2021-12-07 03:40:03)
> > diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
> > new file mode 100644
> > index 000000000000..82ac419718d7
> > --- /dev/null
> > +++ b/drivers/clk/qcom/gcc-sm8450.c
> > @@ -0,0 +1,3303 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2021, Linaro Limited
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> 
> BTW, clk providers need to include clk-provider.h

It is included but indirectly thru clk-alpha-pll.h.. I think this should
be fine.

Thanks
-- 
~Vinod
