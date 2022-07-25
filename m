Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B650C58055B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiGYURJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiGYUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:16:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AE237E4;
        Mon, 25 Jul 2022 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Vam91HtFgm/m4TjFIqmlBnedpAiTbay3DqOChZgZtO4=; b=cfeHSMVcbO9fMhs5zdOdj2LtWP
        MkNrQ/NYRJNFSCDkVsDFs+QkFonh1JTK+W9zQOhmsLtKRER5uM8A2ianh9Sasff4yT1IBpVCpKGzT
        T/f7gf2WPfVO6dn+IsMclT0f+lpGaHNwxAXzfSddPNfa9CpOdDGL52YuiYdiQwxvoemIto4LNulG0
        mKbA7iVs+lyG0qhGifjXZAf8QEd1+u3W4LgALtjLL8jR7MhfyGLHHWI11RwZlVcWLHvo6HYEgg698
        LNnYBLaDllK1CF8URqhgk/mjNgj03fpXVZq4IKjYJ/2LwMoLVqHzaQgE7nsNdaPD5OWR9GZ5Iw/4b
        xNA7npbg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oG4Uc-001nJU-Qg; Mon, 25 Jul 2022 20:15:54 +0000
Message-ID: <7edae5b4-3561-f1d2-5b7c-c8a69f0f1ef3@infradead.org>
Date:   Mon, 25 Jul 2022 13:15:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/5] spi: spi-gxp: Add support for HPE GXP SoCs
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220725201322.41810-1-nick.hawkins@hpe.com>
 <20220725201322.41810-2-nick.hawkins@hpe.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220725201322.41810-2-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/25/22 13:13, nick.hawkins@hpe.com wrote:
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3b1044ebc400..543e4a5b5ffa 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -371,6 +371,13 @@ config SPI_FSL_QUADSPI
>  	  This controller does not support generic SPI messages. It only
>  	  supports the high-level SPI memory interface.
>  
> +config SPI_GXP
> +	tristate "GXP SPI driver"
> +	depends on ARCH_HPE || COMPILE_TEST
> +	help
> +	 This enables support for the driver for GXP bus attached SPI
> +	 controllers.

Documentation/process/coding-style.rst says:

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

thanks.
-- 
~Randy
