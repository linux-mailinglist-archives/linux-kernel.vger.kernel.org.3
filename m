Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF484BF54C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiBVKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBVKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:02:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF24D9E1;
        Tue, 22 Feb 2022 02:01:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n18-20020a05600c4f9200b003806ce86c6dso1338886wmq.5;
        Tue, 22 Feb 2022 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/VLSitTrd+JFCZXSR5n/Er4w4lGem+eUtBiugHGU/Z4=;
        b=S9lree33k8RehQXpjQz9yt2eOLH+BgQjoILefmlddLKENH/YAeRS1XXUi5ZjDy/7ir
         2bP68rDyqkGKrMP9/ewP1d8xfe65AFSLRC3QEybfEBH90Ek95qK9fmLlVV1t33S3zj5v
         zVah9SqBTF0EdXFT3490N+hVybH6DYDgtNrXPXteXJ4O8OskRB4Q8CFG5dOszF5XwzB4
         UZoAOr0A/6H2hr7mYk1q5mCnfju37Y8jXcilJ8BryFGl46XsTzWierY4lwx1xQJZYyXB
         PTHs0fbpIcqBNHntcSxgPJ5T8Whl1tYjEagk3oQMkJ9/KfRGHkry/jDYwdOFlOz5MLMF
         mNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/VLSitTrd+JFCZXSR5n/Er4w4lGem+eUtBiugHGU/Z4=;
        b=7P/HzeOaB6Htsdg6EbmDpYg6TzZHZ0ZWaFE2wT3q54UBiNNkPWJguDecYnbPgOJJub
         Iijsd8KGZAfjSGhgyNyQsS1tPqKu8XFtaFsOhE3gbVEcLDlZa1YIOPsPGdN8tO1pJkGV
         c8B6gLhZ6L+5RJ+kBZw+sB6kjBsW0CqYZPjSGSXz2L+NfDoZjIv2iq/+uwXirL4kKFP4
         /5uDrCgg+HoU+cxn+FQSO3EUFmmhJVWVr8hVuk/kNSHI2mNG1ZgItGdJ9bg6+4UGMJa0
         HxwyP/aCYyl90Fk4arRdg3mTXnH2kXeoCqEoZ4X718OcT3cUli7bAXv7HE1LvyMfmkop
         dn3Q==
X-Gm-Message-State: AOAM530Z8KI3Hac7haWQBpWXxuQbAey+snBEli9JnyMc0MW3nDB556To
        wkbYZmsvfQmCmpiJQ1AitaU=
X-Google-Smtp-Source: ABdhPJzplDMVPJgQYu3DGBs1qKf+QnItZBegvj3CIeFpq1qWqdVwvcNeSzqPXGJpAT0rRfAYKBOIoQ==
X-Received: by 2002:a1c:a483:0:b0:380:c27c:225b with SMTP id n125-20020a1ca483000000b00380c27c225bmr2443819wme.121.1645524104267;
        Tue, 22 Feb 2022 02:01:44 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm2297026wmj.18.2022.02.22.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:01:44 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:01:41 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Harsha <harsha.harsha@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, michals@xilinx.com,
        saratcha@xilinx.com, harshj@xilinx.com, git@xilinx.com
Subject: Re: [PATCH V2 3/4] crypto: xilinx: Add Xilinx SHA3 driver
Message-ID: <YhS0hY4c0p4rL8K/@Red>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
 <1645125264-11033-4-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1645125264-11033-4-git-send-email-harsha.harsha@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Feb 18, 2022 at 12:44:23AM +0530, Harsha a écrit :
> This patch adds SHA3 driver support for the Xilinx ZynqMP SoC.
> Xilinx ZynqMP SoC has SHA3 engine used for secure hash calculation.
> The flow is
> SHA3 request from Userspace -> SHA3 driver-> ZynqMp driver-> Firmware ->
> SHA3 HW Engine
> 
> SHA3 HW engine in Xilinx ZynqMP SoC, does not support parallel processing
> of 2 hash requests.
> Therefore, software fallback is being used for init, update, final,
> export and import in the ZynqMP SHA driver
> For digest, the calculation of SHA3 hash is done by the hardened
> SHA3 accelerator in Xilinx ZynqMP SoC.
> 
> Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> ---
>  drivers/crypto/Kconfig             |  10 ++
>  drivers/crypto/xilinx/Makefile     |   1 +
>  drivers/crypto/xilinx/zynqmp-sha.c | 285 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 296 insertions(+)
>  create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 4f70567..bf4e55e 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -808,6 +808,16 @@ config CRYPTO_DEV_ZYNQMP_AES
>  	  accelerator. Select this if you want to use the ZynqMP module
>  	  for AES algorithms.
>  
> +config CRYPTO_DEV_ZYNQMP_SHA3
> +	bool "Support for Xilinx ZynqMP SHA3 hardware accelerator"
> +	depends on ARCH_ZYNQMP
> +	select CRYPTO_SHA3
> +	help
> +	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
> +	  This driver interfaces with SHA3 hardware engine.
> +	  Select this if you want to use the ZynqMP module
> +	  for SHA3 hash computation.
> +
>  source "drivers/crypto/chelsio/Kconfig"
>  
>  source "drivers/crypto/virtio/Kconfig"
> diff --git a/drivers/crypto/xilinx/Makefile b/drivers/crypto/xilinx/Makefile
> index 534e32d..730feff 100644
> --- a/drivers/crypto/xilinx/Makefile
> +++ b/drivers/crypto/xilinx/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += zynqmp-aes-gcm.o
> +obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_SHA3) += zynqmp-sha.o
> diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx/zynqmp-sha.c
> new file mode 100644
> index 0000000..1eaca97
> --- /dev/null
> +++ b/drivers/crypto/xilinx/zynqmp-sha.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ZynqMP SHA Driver.
> + * Copyright (c) 2022 Xilinx Inc.
> + */
> +#include <linux/cacheflush.h>
> +#include <crypto/hash.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/sha3.h>
> +#include <linux/crypto.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define ZYNQMP_DMA_BIT_MASK		32U
> +#define ZYNQMP_DMA_ALLOC_FIXED_SIZE	0x1000U
> +
> +enum zynqmp_sha_op {
> +	ZYNQMP_SHA3_INIT = 1,
> +	ZYNQMP_SHA3_UPDATE = 2,
> +	ZYNQMP_SHA3_FINAL = 4,
> +};
> +
> +struct zynqmp_sha_drv_ctx {
> +	struct shash_alg sha3_384;
> +	struct device *dev;
> +};
> +
> +struct zynqmp_sha_tfm_ctx {
> +	struct device *dev;
> +	struct crypto_shash *fbk_tfm;
> +};
> +
> +struct zynqmp_sha_desc_ctx {
> +	struct shash_desc fbk_req;
> +};
> +
> +static dma_addr_t update_dma_addr, final_dma_addr;
> +static char *ubuf, *fbuf;
> +
> +static int zynqmp_sha_init_tfm(struct crypto_shash *hash)
> +{
> +	const char *fallback_driver_name = crypto_shash_alg_name(hash);
> +	struct zynqmp_sha_tfm_ctx *tfm_ctx = crypto_shash_ctx(hash);
> +	struct shash_alg *alg = crypto_shash_alg(hash);
> +	struct crypto_shash *fallback_tfm;
> +	struct zynqmp_sha_drv_ctx *drv_ctx;
> +
> +	drv_ctx = container_of(alg, struct zynqmp_sha_drv_ctx, sha3_384);
> +	tfm_ctx->dev = drv_ctx->dev;
> +
> +	/* Allocate a fallback and abort if it failed. */
> +	fallback_tfm = crypto_alloc_shash(fallback_driver_name, 0,
> +					  CRYPTO_ALG_NEED_FALLBACK);
> +	if (IS_ERR(fallback_tfm))
> +		return PTR_ERR(fallback_tfm);
> +
> +	tfm_ctx->fbk_tfm = fallback_tfm;
> +	hash->descsize += crypto_shash_descsize(tfm_ctx->fbk_tfm);
> +
> +	return 0;
> +}
> +
> +static void zynqmp_sha_exit_tfm(struct crypto_shash *hash)
> +{
> +	struct zynqmp_sha_tfm_ctx *tfm_ctx = crypto_shash_ctx(hash);
> +
> +	if (tfm_ctx->fbk_tfm) {
> +		crypto_free_shash(tfm_ctx->fbk_tfm);
> +		tfm_ctx->fbk_tfm = NULL;
> +	}
> +
> +	memzero_explicit(tfm_ctx, sizeof(struct zynqmp_sha_tfm_ctx));
> +}
> +
> +static int zynqmp_sha_init(struct shash_desc *desc)
> +{
> +	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
> +	struct zynqmp_sha_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
> +
> +	dctx->fbk_req.tfm = tctx->fbk_tfm;
> +	return crypto_shash_init(&dctx->fbk_req);
> +}
> +
> +static int zynqmp_sha_update(struct shash_desc *desc, const u8 *data, unsigned int length)
> +{
> +	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
> +
> +	return crypto_shash_update(&dctx->fbk_req, data, length);
> +}
> +
> +static int zynqmp_sha_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
> +
> +	return crypto_shash_final(&dctx->fbk_req, out);
> +}
> +
> +static int zynqmp_sha_finup(struct shash_desc *desc, const u8 *data, unsigned int length, u8 *out)
> +{
> +	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
> +
> +	return crypto_shash_finup(&dctx->fbk_req, data, length, out);
> +}
> +
> +static int zynqmp_sha_import(struct shash_desc *desc, const void *in)
> +{
> +	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
> +	struct zynqmp_sha_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
> +
> +	dctx->fbk_req.tfm = tctx->fbk_tfm;
> +	return crypto_shash_import(&dctx->fbk_req, in);
> +}
> +
> +static int zynqmp_sha_export(struct shash_desc *desc, void *out)
> +{
> +	struct zynqmp_sha_desc_ctx *dctx = shash_desc_ctx(desc);
> +
> +	return crypto_shash_export(&dctx->fbk_req, out);
> +}
> +
> +static int zynqmp_sha_digest(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
> +{
> +	unsigned int remaining_len = len;
> +	int update_size;
> +	int ret;
> +
> +	ret = zynqmp_pm_sha_hash(0, 0, ZYNQMP_SHA3_INIT);
> +	if (ret)
> +		return ret;
> +
> +	while (remaining_len != 0) {
> +		memset(ubuf, 0, ZYNQMP_DMA_ALLOC_FIXED_SIZE);
> +		if (remaining_len >= ZYNQMP_DMA_ALLOC_FIXED_SIZE) {
> +			update_size = ZYNQMP_DMA_ALLOC_FIXED_SIZE;
> +			remaining_len -= ZYNQMP_DMA_ALLOC_FIXED_SIZE;
> +		} else {
> +			update_size = remaining_len;
> +			remaining_len = 0;
> +		}
> +		memcpy(ubuf, data, update_size);
> +		flush_icache_range((unsigned long)ubuf, (unsigned long)ubuf + update_size);

Hello

Why do you copy all data before processing and not use them in-place ?


> +		ret = zynqmp_pm_sha_hash(update_dma_addr, update_size, ZYNQMP_SHA3_UPDATE);
> +		if (ret)
> +			return ret;
> +
> +		data += update_size;
> +	}
> +
> +	ret = zynqmp_pm_sha_hash(final_dma_addr, SHA3_384_DIGEST_SIZE, ZYNQMP_SHA3_FINAL);
> +	memcpy(out, fbuf, SHA3_384_DIGEST_SIZE);
> +	memset(fbuf, 0, SHA3_384_DIGEST_SIZE);

You should use memzero_explicit()

Regards
