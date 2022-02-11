Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97054B2A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbiBKQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351473AbiBKQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:25:36 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09AD38C;
        Fri, 11 Feb 2022 08:25:34 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 4so10049507oil.11;
        Fri, 11 Feb 2022 08:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyIkGH+i+hA9lPPeVfs99/FEP7xdwJEwC+hY7kMKZgw=;
        b=P24+C37Xq0iumMpDIb3A0chDBh3cPgNCZM7xbLzBvpF1sTSfw00LGvv5fGz6BlDqhK
         k/dA6W9yccLOmZwpQD/FatTKifjUw0CsLaWxuacW9cUX8QrnkSCZfN2sK+0uL5zw7qgy
         7n7CWyfMtRt8WeF4mWCzyXCIj2GgBH4i/XZ5SbeQJhhtw08B2w9mH0U0UqgETTSk3p2I
         cVJrx2bwqs1+qNcVwW0KtP+0WN/C862+Jp7QtDBdSL2CMYx/2hWF5WvU05BsuHP1tEa9
         dARhmNo9FRy5/B84yb53LNc8X54bi14rMItm8dzudpxoeWF0UUiEsmhmhuOnSIc/Jtuv
         odBg==
X-Gm-Message-State: AOAM530ARwInzLOok/DguD+flkYVjH1CeEeUH1EqDvkLv+mofBgdB9T8
        ofF435YIhTmv+3B7NwZyCg==
X-Google-Smtp-Source: ABdhPJwIS3cLhs0Ugl2Q/THWn5KyvDyZbUsJAm3LnsCtXXjs1D0Hv+qcDll4B534DYp3YV2BwD8obg==
X-Received: by 2002:a05:6808:bd3:: with SMTP id o19mr540564oik.331.1644596734020;
        Fri, 11 Feb 2022 08:25:34 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id h2sm9278124ots.51.2022.02.11.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:25:33 -0800 (PST)
Received: (nullmailer pid 466919 invoked by uid 1000);
        Fri, 11 Feb 2022 16:25:31 -0000
Date:   Fri, 11 Feb 2022 10:25:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: clock: Add s32g2 clock binding
Message-ID: <YgaN+0KJTi0be++F@robh.at.kernel.org>
References: <20220207132444.3653-1-clin@suse.com>
 <20220207132444.3653-2-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207132444.3653-2-clin@suse.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:24:42PM +0800, Chester Lin wrote:
> Add clock binding for S32G based on SCMI Clock Management Protocol (0x14)
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  include/dt-bindings/clock/s32g2-clock.h | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/clock/s32g2-clock.h
> 
> diff --git a/include/dt-bindings/clock/s32g2-clock.h b/include/dt-bindings/clock/s32g2-clock.h
> new file mode 100644
> index 000000000000..6d8606293865
> --- /dev/null
> +++ b/include/dt-bindings/clock/s32g2-clock.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */

Dual license please.

> +/*
> + * Copyright 2020-2022 NXP
> + */
> +#ifndef __DT_BINDINGS_SCMI_CLOCK_S32G2_H
> +#define __DT_BINDINGS_SCMI_CLOCK_S32G2_H
> +
> +#define S32G2_SCMI_CLK_BASE_ID		0U
> +#define S32G2_SCMI_CLK(N)		((N) + S32G2_SCMI_CLK_BASE_ID)
> +
> +/* GMAC0 - SGMII */
> +#define S32G2_SCMI_CLK_GMAC0_RX_SGMII	S32G2_SCMI_CLK(16)
> +#define S32G2_SCMI_CLK_GMAC0_TX_SGMII	S32G2_SCMI_CLK(17)
> +/* GMAC0 - RGMII */
> +#define S32G2_SCMI_CLK_GMAC0_RX_RGMII	S32G2_SCMI_CLK(19)
> +#define S32G2_SCMI_CLK_GMAC0_TX_RGMII	S32G2_SCMI_CLK(20)
> +/* GMAC0 - RMII */
> +#define S32G2_SCMI_CLK_GMAC0_RX_RMII	S32G2_SCMI_CLK(22)
> +#define S32G2_SCMI_CLK_GMAC0_TX_RMII	S32G2_SCMI_CLK(23)
> +/* GMAC0 - MII */
> +#define S32G2_SCMI_CLK_GMAC0_RX_MII	S32G2_SCMI_CLK(25)
> +#define S32G2_SCMI_CLK_GMAC0_TX_MII	S32G2_SCMI_CLK(26)
> +#define S32G2_SCMI_CLK_GMAC0_AXI	S32G2_SCMI_CLK(28)
> +/* uSDHC */
> +#define S32G2_SCMI_CLK_USDHC_AHB	S32G2_SCMI_CLK(35)
> +#define S32G2_SCMI_CLK_USDHC_MODULE	S32G2_SCMI_CLK(36)
> +#define S32G2_SCMI_CLK_USDHC_CORE	S32G2_SCMI_CLK(37)
> +#endif
> -- 
> 2.33.1
> 
> 
