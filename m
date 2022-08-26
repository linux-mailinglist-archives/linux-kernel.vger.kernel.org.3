Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC605A3253
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbiHZXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiHZXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:05:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EAC501A6;
        Fri, 26 Aug 2022 16:05:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q16so2879884ljp.8;
        Fri, 26 Aug 2022 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Pbp0J2KuJMWy/u1hdZ0Pq6byLOIKeqHx1m75MM9TMnY=;
        b=agVDPtMpjVei8gZLNupdAnyj4NOMcKA3RGy01rRHq34z6Tta1vZCI9ij2uS5xDHJ4w
         tFbjhZGUo6ailScXlj/gVE/giWWkmnr7ciA6reFopm0QxirGx5DWLCfdPKFVa7HcUoPA
         ifZPiE70b3m+Xf6L9ZG6KrX7FaArbVNm/MdwZU7S/r3czkcM0oGr38i4Ly9wY21mC1zO
         3dFjXOB4/eGCMGLuVz/P3Kf+HInkqxlt/84t4Jc2y57iUmVeTR64RSNr97uOUUaSU8Ux
         VbP/assIubl4TL3gAcPNFuabmbORJcoqOZr6QFqGmh2JIdoMyjyp9Tu/qB7i5GKXdlDe
         ZqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Pbp0J2KuJMWy/u1hdZ0Pq6byLOIKeqHx1m75MM9TMnY=;
        b=y24zNLH8Fy1LrJV7UM4Tp2iIIHJ+w5p2LsjWE6101wR6KttD9tHyMORaAozn4y2FMq
         qcZ+D9dVfAoQKyMYpL57YThRROu+bBBBUSVwBneG2R2O9N7rJV846+TykuIbz8eLgaUt
         cHTJYW/VFP3FOWryEOTsidA6qHvBCJZrdXE51DWtRo+mjST0j2gwP0N+ZHsZOolQeCzZ
         ZXJLten8YIeowxKECajzXWWDt1CxHcqKfcHo2uPhkiDkIAqM0o1IAsT1wv8N9kBCNrFb
         0kal5Xu2cSOpOoRxt8L/Di0/NC4ZnXOKN/8HSnnl8l1sEUvgRP3ayGM/oq4ywWCH6Sln
         YubA==
X-Gm-Message-State: ACgBeo0LD3sLMOb/mHrigsMpns7z2MO5bNl4iBTl2jAB+QTYnegBJ0ON
        Dz7kXxNrBSdmXPFnQwiL/HhZ4tzGDElopQ==
X-Google-Smtp-Source: AA6agR6RFTDBSQKZOPqJ+Og5AgBQ6K6ZM4s8q5inPgur4mI/jp1CTpeNwgPFANbVvHmJ5G7g/tdfTA==
X-Received: by 2002:a2e:978e:0:b0:261:e36c:b2ca with SMTP id y14-20020a2e978e000000b00261e36cb2camr3043356lji.489.1661555110815;
        Fri, 26 Aug 2022 16:05:10 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v4-20020ac25b04000000b00492c4852f22sm484639lfn.307.2022.08.26.16.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:05:09 -0700 (PDT)
Date:   Sat, 27 Aug 2022 02:05:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 08/11] spi: dw: update buffer for enhanced spi mode
Message-ID: <20220826230507.bf6xxcphicg4gck7@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-9-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-9-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:52PM +0100, Sudip Mukherjee wrote:
> In enhanced spi mode we will be writing the address to a single FIFO
> location instead of writing to multiple FIFOs in the standard SPI mode.
> Save the cmd and address bytes in the buffer accordingly.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 55 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 8cb30540ad5b..2564a2276572 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -520,7 +520,8 @@ static bool dw_spi_supports_mem_op(struct spi_mem *mem,
>  	return spi_mem_default_supports_op(mem, op);
>  }
> 
 
> -static int dw_spi_init_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
> +static int dw_spi_init_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op,
> +			       bool enhanced_spi)

There is no point in modifying this method. Since clock stretching is
available you won't need to collect all the data in a single buffer.
So just create a new method dw_spi_init_enh_mem_buf() which would set
dws->tx/rx pointers and tx_len/rx_len fields with the
spi_mem_op.data.buf.{in,out} and the corresponding lengths. The command
and address data shall be written to the Tx FIFO to initiate the SPI MEM
transfers, since in accordance with the HW manual the SPI-bus transfers
won't start before it is done.

-Sergey

>  {
>  	unsigned int i, j, len;
>  	u8 *out;
> @@ -548,17 +549,57 @@ static int dw_spi_init_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
>  	 */
>  	for (i = 0; i < op->cmd.nbytes; ++i)
>  		out[i] = DW_SPI_GET_BYTE(op->cmd.opcode, op->cmd.nbytes - i - 1);
> -	for (j = 0; j < op->addr.nbytes; ++i, ++j)
> -		out[i] = DW_SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j - 1);
> -	for (j = 0; j < op->dummy.nbytes; ++i, ++j)
> -		out[i] = 0x0;
> +
> +	if (enhanced_spi) {
> +		/*
> +		 * Fill the remaining spaces of dws->reg_io_width bytes
> +		 * size register with zero for cmd.
> +		 */
> +		for (; i < dws->reg_io_width; ++i)
> +			out[i] = 0;
> +		/*
> +		 * Copy the address bytes in dws->reg_io_width bytes size
> +		 * register and fill remaining spaces with zero.
> +		 */
> +		for (j = op->addr.nbytes; j > 0; ++i, --j)
> +			out[i] = DW_SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j);
> +		for (j = op->addr.nbytes; j < dws->reg_io_width; ++i, ++j)
> +			out[i] = 0;
> +	} else {
> +		for (j = 0; j < op->addr.nbytes; ++i, ++j)
> +			out[i] = DW_SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j - 1);
> +	}
> +
> +	if (!enhanced_spi) {
> +		/*
> +		 * dummy bytes are not needed in enhanced mode as
> +		 * wait_cycles specified as number of SPI clock cycles
> +		 * between control frames transmit and data reception
> +		 * will be mentioned in enhanced spi mode.
> +		 */
> +		for (j = 0; j < op->dummy.nbytes; ++i, ++j)
> +			out[i] = 0x0;
> +	}
>  
>  	if (op->data.dir == SPI_MEM_DATA_OUT)
>  		memcpy(&out[i], op->data.buf.out, op->data.nbytes);
>  
>  	dws->n_bytes = 1;
>  	dws->tx = out;
> -	dws->tx_len = len;
> +
> +	if (enhanced_spi) {
> +		/*
> +		 * In enhanced mode cmd will be one FIFO and address
> +		 * will be one more FIFO.
> +		 */
> +		dws->tx_len = 1;
> +		if (op->addr.nbytes)
> +			dws->tx_len += 1;
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			dws->tx_len += op->data.nbytes;
> +	} else {
> +		dws->tx_len = len;
> +	}
>  	if (op->data.dir == SPI_MEM_DATA_IN) {
>  		dws->rx = op->data.buf.in;
>  		dws->rx_len = op->data.nbytes;
> @@ -744,7 +785,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	 * Collect the outbound data into a single buffer to speed the
>  	 * transmission up at least on the initial stage.
>  	 */
> -	ret = dw_spi_init_mem_buf(dws, op);
> +	ret = dw_spi_init_mem_buf(dws, op, enhanced_spi);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.30.2
> 
