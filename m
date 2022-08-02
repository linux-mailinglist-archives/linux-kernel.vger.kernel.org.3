Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273045878E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiHBITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiHBITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:19:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B637D3CBFC;
        Tue,  2 Aug 2022 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659428359; x=1690964359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+vewyv6+8WMMh7FJKU7WpWGSmrkNzmBg1CxJQHgUEc=;
  b=VBMYxzC9CJyx4zALFWExBavfMKOFcj51Fn5Y3TmLYQ2bNGbWzU6gjyHW
   vobJ+4GB8TDgIFe6oy8gd9Awzlbf13sGm26IqG4eGDROA3fLC9sVw6/BV
   +HcXSFqJSmY5XBqEFCnRIo27RxIqIt3YRrqN2HuPHFC+Rc/rJIpeopWYb
   jDEW1wRy9k1jX7BBRON0fCcpwmmjt7VTufHpNMPocdW2nOyDNQ2bo97Em
   iQn1tEiOCr/DEJ+NaGTmuDQtCmDZCBqqJ9SL5nZtZl+Z2emi4wl/Bh0iI
   /cLYXgVuiJr5TUfHngg7iuv0vAMVGRQwm+C1+9JpmzjmFzPSYy0hoRoAn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="286913667"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="286913667"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744587113"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 01:19:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 11:19:15 +0300
Date:   Tue, 2 Aug 2022 11:19:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 4/7] usb: typec: tcpci_rt1711h: Add initial phy setting
Message-ID: <YujeA2pHG2WnZjaF@kuha.fi.intel.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-5-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801101447.86207-5-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

On Mon, Aug 01, 2022 at 06:14:44PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add initial phy setting about phy dicard retry,
> rx filter deglitech time and BMC-encoded wait time

I'm sorry, but what does "deglitech" mean? Is it just a typo?

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index df7bfe299987..33d8ea95b7c1 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -20,6 +20,9 @@
>  #define RT1711H_VID		0x29CF
>  #define RT1711H_PID		0x1711
>  
> +#define RT1711H_PHYCTRL1	0x80
> +#define RT1711H_PHYCTRL2	0x81
> +
>  #define RT1711H_RTCTRL8		0x9B
>  
>  /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
> @@ -107,8 +110,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  		return ret;
>  
>  	/* dcSRC.DRP : 33% */
> -	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable phy discard retry, retry count 7, rx filter deglitech 100 us */
> +	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
> +	if (ret < 0)
> +		return ret;
>  
> +	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
> +	/* wait time : (val * .4167) us */
> +	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
>  }
>  
>  static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> -- 
> 2.25.1

thanks,

-- 
heikki
