Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8231759D474
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbiHWIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiHWIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:16:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21098FE9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661242285; x=1692778285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGZiRk5UFvIPLRGeEMdOMoJukJQ485whBLPB7y6qoMM=;
  b=gq6fGWT21otUrGez7+ShFgXHcDOBINr4VivS8OPyFT+lwZme9ZEVuk+G
   1y0xTcvXWhPvLwiRR+DLSU0h4pyYtf3xMQ83okSOHpYYIrz1utY/+x6/n
   4gqbWe9zn/DtuEmN2mXyc+sjt3HHcG+PaiCkIq+XNuWFzttE1+CtiUCZs
   aZnT7LRnMto5jD2yx7q/5zec9jBB1MwjPoINi7ApdTip7T9F7aGELw2Q5
   fkS95svGf9p+LAiEh/PB67uEY0kuA51Uvvwxakz7wgJurpLz5EphFjrTq
   K53PdOoKD84WgUeu/P6RlZtAmqxzz+xkFFJiHlZSUWqU2BIxOM5YCiRje
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294413383"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294413383"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 01:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751604341"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2022 01:11:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 23 Aug 2022 11:11:21 +0300
Date:   Tue, 23 Aug 2022 11:11:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/4] platform/chrome: cros_ec_typec: Add bit offset for
 DP VDO
Message-ID: <YwSLqfuP5u0Up8oS@kuha.fi.intel.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190807.1275937-2-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:08:02PM +0000, Prashant Malani wrote:
> Use the right macro while constructing the DP_PORT_VDO to ensure the Pin
> Assignment offsets are correct.
> 
> Fixes: 1ff5d97f070c ("platform/chrome: cros_ec_typec: Register port altmodes")
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index de6ee0f926a6..4d81d8d45b73 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -25,7 +25,8 @@
>  
>  #define DRV_NAME "cros-ec-typec"
>  
> -#define DP_PORT_VDO	(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) | DP_CAP_DFP_D)
> +#define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
> +				DP_CAP_DFP_D)
>  
>  /* Supported alt modes. */
>  enum {
> -- 
> 2.37.1.595.g718a3a8f04-goog

-- 
heikki
