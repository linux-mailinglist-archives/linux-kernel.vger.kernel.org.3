Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30117493D20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355627AbiASP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:29:55 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:48767 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348794AbiASP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:29:53 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 419E030057E65;
        Wed, 19 Jan 2022 16:29:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 27C5F3ABB52; Wed, 19 Jan 2022 16:29:50 +0100 (CET)
Date:   Wed, 19 Jan 2022 16:29:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     patrice.chotard@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v3] spi: stm32-qspi: Update spi registering
Message-ID: <20220119152950.GA4445@wunner.de>
References: <20220117121744.29729-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117121744.29729-1-patrice.chotard@foss.st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 01:17:44PM +0100, patrice.chotard@foss.st.com wrote:
> Some device driver need to communicate to qspi device during the remove
> process, qspi controller must be functional when spi_unregister_master()
> is called.
> 
> To ensure this, replace devm_spi_register_master() by spi_register_master()
> and spi_unregister_master() is called directly in .remove callback before
> stopping the qspi controller.
> 
> This issue was put in evidence using kernel v5.11 and later
> with a spi-nor which supports the software reset feature introduced
> by commit d73ee7534cc5 ("mtd: spi-nor: core: perform a Soft Reset on
> shutdown")
> 
> Fixes: c530cd1d9d5e ("spi: spi-mem: add stm32 qspi controller")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: <stable@vger.kernel.org> # 5.8.x

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks!

Lukas
