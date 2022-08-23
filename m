Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B740959E3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiHWMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357987AbiHWMVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:21:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866F5F13B;
        Tue, 23 Aug 2022 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661247811; x=1692783811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b83HGrHfDYMEIJaAe/yrY5VTWl4kD8DWJHvic1O+l7Q=;
  b=mHcOuj/ddSIGG2kfj8JkqjxoOVEEHJ8Iyl91OGnooPps4qwBJsz3/g6G
   AUKU+nUT69D2CCPzVfNyjKLo+UhDJeg+/3jcl3yBRfP8f+RahkoWo6u/2
   SRddqyjDlfU6lI2NbT6Nb7jucg5Sy4cgZZsF9zK+HrLnBc6cETwtlG6FP
   OhEU8NE/bYC7T2qDUgvWo+e90rp8khwE1X4uQZH9einaLXlP1way4CZrw
   Df7tuwbAYbwMGcU21kuEUpzlXnCnTRXqe2IX/7u2I4cocojWEZFtZZkBY
   1SzP/P3QZ7yIuO/PjgJNCaIia4O7yjLdJZebvys95ZWKSEBMN7fMWoQyk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294431311"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294431311"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 02:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638585425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2022 02:42:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DAFF4AD; Tue, 23 Aug 2022 12:42:38 +0300 (EEST)
Date:   Tue, 23 Aug 2022 12:42:38 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH 1/2] thunderbolt: thunderbolt: Add vendor's specific
 operations of NVM
Message-ID: <YwShDiVI4eAVUNcS@black.fi.intel.com>
References: <20220823075921.18366-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823075921.18366-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 03:59:21PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_switch_nvm_alloc() contain an array that has functions
> pointers to vendor_ops that vendor to define.
> And moved vendor:intel part of the code to make all the vendors
> (includes Intel) support it in nvm.c.

You still did not fix the $subject as I commented previously and please
check the threading since I got two separate emails that are not related
to each other. If you use git send-email it handles this but send the
series first just to yourself and check that everything is fine before
you go outside.

Also don't send new versions like every single day. Let people time to
review them.

And last, you should add cover letter too (--cover-letter option to git
format-patch) that also has the version history.

> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  drivers/thunderbolt/nvm.c    | 162 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  97 ++++-----------------
>  drivers/thunderbolt/tb.h     |  17 +++-
>  3 files changed, 195 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..5c7c2a284497 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -12,8 +12,170 @@
> 
>  #include "tb.h"
> 
> +/* Switch NVM support */
> +#define NVM_CSS		0x10
> +
>  static DEFINE_IDA(nvm_ida);
> 
> +static inline int nvm_read(struct tb_switch *sw, unsigned int address,
> +			   void *buf, size_t size)
> +{
> +	if (tb_switch_is_usb4(sw))
> +		return usb4_switch_nvm_read(sw, address, buf, size);
> +	return dma_port_flash_read(sw->dma_port, address, buf, size);
> +}
> +
> +static int intel_nvm_version(struct tb_switch *sw)
> +{
> +	struct tb_nvm *nvm = sw->nvm;
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * If the switch is in safe-mode the only accessible portion of
> +	 * the NVM is the non-active one where userspace is expected to
> +	 * write new functional NVM.
> +	 */
> +	if (!sw->safe_mode) {
> +		u32 nvm_size, hdr_size;
> +
> +		ret = nvm_read(sw, NVM_FLASH_SIZE, &val, sizeof(val));
> +		if (ret)
> +			return ret;
> +
> +		hdr_size = sw->generation < 3 ? SZ_8K : SZ_16K;
> +		nvm_size = (SZ_1M << (val & 7)) / 8;
> +		nvm_size = (nvm_size - hdr_size) / 2;
> +
> +		ret = nvm_read(sw, NVM_VERSION, &val, sizeof(val));
> +		if (ret)
> +			return ret;
> +
> +		nvm->major = val >> 16;
> +		nvm->minor = val >> 8;
> +		nvm->nvm_size = nvm_size;
> +	}

Blank line here.

> +	return 0;
> +}
> +
> +static int intel_nvm_validate(struct tb_switch *sw)
> +{
> +	unsigned int image_size, hdr_size;
> +	const u8 *buf = sw->nvm->buf;
> +	u16 ds_size;
> +	int ret;
> +
> +	image_size = sw->nvm->buf_data_size;
> +	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * FARB pointer must point inside the image and must at least
> +	 * contain parts of the digital section we will be reading here.
> +	 */
> +	hdr_size = (*(u32 *)buf) & 0xffffff;
> +	if (hdr_size + NVM_DEVID + 2 >= image_size)
> +		return -EINVAL;
> +
> +	/* Digital section start should be aligned to 4k page */
> +	if (!IS_ALIGNED(hdr_size, SZ_4K))
> +		return -EINVAL;
> +
> +	/*
> +	 * Read digital section size and check that it also fits inside
> +	 * the image.
> +	 */
> +	ds_size = *(u16 *)(buf + hdr_size);
> +	if (ds_size >= image_size)
> +		return -EINVAL;
> +
> +	if (!sw->safe_mode) {
> +		u16 device_id;
> +
> +		/*
> +		 * Make sure the device ID in the image matches the one
> +		 * we read from the switch config space.
> +		 */
> +		device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
> +		if (device_id != sw->config.device_id)
> +			return -EINVAL;
> +
> +		if (sw->generation < 3) {
> +			/* Write CSS headers first */
> +			ret = dma_port_flash_write(sw->dma_port,
> +				DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
> +				DMA_PORT_CSS_MAX_SIZE);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* Skip headers in the image */
> +		buf += hdr_size;
> +		image_size -= hdr_size;
> +	}

Blank line here.

> +	return image_size;
> +}
> +
> +struct tb_nvm_vendor_ops intel_switch_nvm_ops = {

const

> +	.version = intel_nvm_version,
> +	.validate = intel_nvm_validate,
> +};
> +
> +struct switch_nvm_vendor {
> +	u16 vendor;
> +	const struct tb_nvm_vendor_ops *vops;
> +};
> +
> +static const struct switch_nvm_vendor switch_nvm_vendors[] = {
> +	{ 0x8086, &intel_switch_nvm_ops },
> +	{ 0x8087, &intel_switch_nvm_ops },
> +};
> +
> +/**
> + * tb_switch_nvm_alloc() - alloc nvm and set nvm->vops to point
> + * the vendor specific operations.

This is not correct kernel-doc format.

> + * @sw: thunderbolt switch

What it returns? 

> + */
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw)
> +{
> +	const struct tb_nvm_vendor_ops *vops = NULL;
> +	struct tb_nvm *nvm;
> +	int i;
> +	int ret;
> +
> +	/*
> +	 * If the vendor matches on the array then set nvm->vops to
> +	 * point the vendor specific operations.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(switch_nvm_vendors); i++) {
> +		const struct switch_nvm_vendor *v = &switch_nvm_vendors[i];
> +
> +		if (v->vendor == sw->config.vendor_id) {
> +			vops = v->vops;
> +			break;
> +		}
> +	}
> +
> +	if (!vops)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	nvm = tb_nvm_alloc(&sw->dev);
> +	if (IS_ERR(nvm))
> +		return nvm;
> +
> +	nvm->vops = vops;
> +	sw->nvm = nvm;
> +	ret = vops->version(sw);

Probably ->read_version() is better.

> +	if (ret)
> +		goto err_nvm;
> +
> +	return nvm;
> +
> +err_nvm:
> +	tb_nvm_free(nvm);
> +	return ERR_PTR(ret);
> +}
> +
>  /**
>   * tb_nvm_alloc() - Allocate new NVM structure
>   * @dev: Device owning the NVM
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 244f8cd38b25..d257219cb66e 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -102,10 +102,10 @@ static void nvm_clear_auth_status(const struct tb_switch *sw)
> 
>  static int nvm_validate_and_write(struct tb_switch *sw)
>  {
> -	unsigned int image_size, hdr_size;
> +	unsigned int image_size;
>  	const u8 *buf = sw->nvm->buf;
> -	u16 ds_size;
>  	int ret;
> +	const struct tb_nvm_vendor_ops *vops = sw->nvm->vops;

Reverse "christmas-tree" format here for the declarations and everywhere
else too, so

 	const struct tb_nvm_vendor_ops *vops = sw->nvm->vops;
  	const u8 *buf = sw->nvm->buf;
 	unsigned int image_size;
  	int ret;

> 
>  	if (!buf)
>  		return -EINVAL;
> @@ -114,49 +114,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>  	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>  		return -EINVAL;
> 
> -	/*
> -	 * FARB pointer must point inside the image and must at least
> -	 * contain parts of the digital section we will be reading here.
> -	 */
> -	hdr_size = (*(u32 *)buf) & 0xffffff;
> -	if (hdr_size + NVM_DEVID + 2 >= image_size)
> -		return -EINVAL;
> -
> -	/* Digital section start should be aligned to 4k page */
> -	if (!IS_ALIGNED(hdr_size, SZ_4K))
> -		return -EINVAL;
> -
> -	/*
> -	 * Read digital section size and check that it also fits inside
> -	 * the image.
> -	 */
> -	ds_size = *(u16 *)(buf + hdr_size);
> -	if (ds_size >= image_size)
> -		return -EINVAL;
> -
> -	if (!sw->safe_mode) {
> -		u16 device_id;
> -
> -		/*
> -		 * Make sure the device ID in the image matches the one
> -		 * we read from the switch config space.
> -		 */
> -		device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
> -		if (device_id != sw->config.device_id)
> -			return -EINVAL;
> -
> -		if (sw->generation < 3) {
> -			/* Write CSS headers first */
> -			ret = dma_port_flash_write(sw->dma_port,
> -				DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
> -				DMA_PORT_CSS_MAX_SIZE);
> -			if (ret)
> -				return ret;
> -		}
> -
> -		/* Skip headers in the image */
> -		buf += hdr_size;
> -		image_size -= hdr_size;
> +	/* Vendors to validate before write to router NVM */
> +	if (vops->validate) {

Should you check for !vops too? By default we don't assign them.

> +		ret = vops->validate(sw);
> +		if (ret < 0)
> +			return ret;
> +		image_size = ret;
>  	}
> 
>  	if (tb_switch_is_usb4(sw))
> @@ -384,28 +347,21 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
>  static int tb_switch_nvm_add(struct tb_switch *sw)
>  {
>  	struct tb_nvm *nvm;
> -	u32 val;
>  	int ret;
> 
>  	if (!nvm_readable(sw))
>  		return 0;
> 
> -	/*
> -	 * The NVM format of non-Intel hardware is not known so
> -	 * currently restrict NVM upgrade for Intel hardware. We may
> -	 * relax this in the future when we learn other NVM formats.
> -	 */
> -	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL &&
> -	    sw->config.vendor_id != 0x8087) {
> -		dev_info(&sw->dev,
> -			 "NVM format of vendor %#x is not known, disabling NVM upgrade\n",
> -			 sw->config.vendor_id);
> -		return 0;
> -	}
> -
> -	nvm = tb_nvm_alloc(&sw->dev);
> -	if (IS_ERR(nvm))
> +	nvm = tb_switch_nvm_alloc(sw);
> +	if (IS_ERR(nvm)) {
> +		if (PTR_ERR(nvm) == -EOPNOTSUPP) {
> +			dev_info(&sw->dev,
> +				"NVM format of vendor %#x is not known, disabling NVM upgrade\n",
> +				sw->config.vendor_id);
> +			return 0;
> +		}
>  		return PTR_ERR(nvm);
> +	}
> 
>  	/*
>  	 * If the switch is in safe-mode the only accessible portion of
> @@ -413,24 +369,7 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  	 * write new functional NVM.
>  	 */
>  	if (!sw->safe_mode) {
> -		u32 nvm_size, hdr_size;
> -
> -		ret = nvm_read(sw, NVM_FLASH_SIZE, &val, sizeof(val));
> -		if (ret)
> -			goto err_nvm;
> -
> -		hdr_size = sw->generation < 3 ? SZ_8K : SZ_16K;
> -		nvm_size = (SZ_1M << (val & 7)) / 8;
> -		nvm_size = (nvm_size - hdr_size) / 2;
> -
> -		ret = nvm_read(sw, NVM_VERSION, &val, sizeof(val));
> -		if (ret)
> -			goto err_nvm;
> -
> -		nvm->major = val >> 16;
> -		nvm->minor = val >> 8;
> -
> -		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
> +		ret = tb_nvm_add_active(nvm, nvm->nvm_size, tb_switch_nvm_read);
>  		if (ret)
>  			goto err_nvm;
>  	}
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 5db76de40cc1..73ae2e093a92 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -48,8 +48,8 @@
>   */
>  struct tb_nvm {
>  	struct device *dev;
> -	u8 major;
> -	u8 minor;
> +	u32 major;
> +	u32 minor;

This should be a separate patch, I think.

>  	int id;
>  	struct nvmem_device *active;
>  	struct nvmem_device *non_active;
> @@ -57,6 +57,8 @@ struct tb_nvm {
>  	size_t buf_data_size;
>  	bool authenticating;
>  	bool flushed;
> +	u32 nvm_size;

Kernel-doc

> +	const struct tb_nvm_vendor_ops *vops;

Ditto.

>  };
> 
>  enum tb_nvm_write_ops {
> @@ -65,6 +67,16 @@ enum tb_nvm_write_ops {
>  	AUTHENTICATE_ONLY = 3,
>  };
> 
> +/**
> + * struct tb_nvm_vendor_ops - vendor NVM specific operations
> + * @version: Used NVM read get Firmware version.
> + * @validate: Vendors have their validate method before NVM write.
> + */
> +struct tb_nvm_vendor_ops {
> +	int (*version)(struct tb_switch *sw);
> +	int (*validate)(struct tb_switch *sw);
> +};

This can be private in nvm.c.

> +
>  #define TB_SWITCH_KEY_SIZE		32
>  #define TB_SWITCH_MAX_DEPTH		6
>  #define USB4_SWITCH_MAX_DEPTH		5
> @@ -736,6 +748,7 @@ static inline void tb_domain_put(struct tb *tb)
>  	put_device(&tb->dev);
>  }
> 
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);

And this should be moved close to the tb_switch_ routines.

>  struct tb_nvm *tb_nvm_alloc(struct device *dev);
>  int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
>  int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
> --
> 2.34.1
