Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9027458C67A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbiHHKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiHHKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:33:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC050FFB;
        Mon,  8 Aug 2022 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659954809; x=1691490809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TkDQQIVn5gXSOl294qqKK8buwtM+qJn9ROJ7wvLLwAE=;
  b=cIlwE8fAO7GkrdE3TJWiUXWyOnY8Wq6QmFj9jmBFZaW4aTYC9/A/p8fH
   b5GdP2OogqNvTcEgNfbt+jh+yGD8Hmk7QPrx7Vwh9yfFdVm3JHIkKzWJ4
   CVV2CAnrtnKjAcd0iiMWVz/3cpoBzreU96vI+zBuL9GJ2ayYY3TbJIvZl
   6WH6g+LX7C+g+LWb5NWx7/q6hOZH+fg47hLjZmZRhsDk2AR6K3j5vKVFE
   OGJYiOxkdEqIqglDaV77NP9poKbDqxpPs3rIQHU/fh4egG7mBz+o05YJe
   pOBsfjmoDRIrIsBtmJkpIgrElXGdp6xR1VCfZHU05rCF7+IJ2WgWKTM67
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="291337267"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291337267"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 03:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746583385"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2022 03:33:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Aug 2022 13:33:23 +0300
Date:   Mon, 8 Aug 2022 13:33:23 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: typec: ucsi: stm32g0: Fix spelling mistake
 "booloader" -> "bootloader"
Message-ID: <YvDmc2RXuvCE8rGt@kuha.fi.intel.com>
References: <20220803123018.913710-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803123018.913710-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:30:18PM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err_probe message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 061551d464f1..6ced49e4d208 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -599,7 +599,7 @@ static int ucsi_stm32g0_probe_bootloader(struct ucsi *ucsi)
>  		g0->i2c_bl = i2c_new_dummy_device(g0->client->adapter, STM32G0_I2C_BL_ADDR);
>  		if (IS_ERR(g0->i2c_bl)) {
>  			ret = dev_err_probe(g0->dev, PTR_ERR(g0->i2c_bl),
> -					    "Failed to register booloader I2C address\n");
> +					    "Failed to register bootloader I2C address\n");
>  			return ret;
>  		}
>  	}
> -- 
> 2.35.3

-- 
heikki
