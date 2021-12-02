Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3B466041
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356340AbhLBJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:24:31 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:50964 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237129AbhLBJYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638436855; x=1669972855;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Hf1Sz4lNz/yJTkW9Vuqpwjleh8HbZdbQpO5u4O3YGU=;
  b=bAwCSUPRh9Zbd85vlXDo0GxQHJ3ch2sirdj3ACc6XmDdTldOUmuvryir
   AC/L5no3wi1OoA6Rl0BidPqGwz8rOMBy6wNNd/LDPb+456P07/2AnP9Lx
   8su0CvDF1TScx2Z8mNzM61Oh/ejX2jZSDpHQx5F05EZDcmZzfsfjcKCNT
   Hp46k9mjzkQGM4MhUdos+lAZUa5WJJ0Kl12GaiP6gNCCnimu51RW22PU0
   62SVChlZdWiUH8O/hrejoK+/7BGYk9MseHi1VTUZQ8uGQ7Dx0yjBBj7Qq
   Yl8rh7ZMoCI3VfigpBaOpMHiYBb2PZ+xS/3eudaZZ7fq2G86rpdSWmtQp
   g==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631570400"; 
   d="scan'208";a="20805231"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Dec 2021 10:20:54 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 02 Dec 2021 10:20:54 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 02 Dec 2021 10:20:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638436854; x=1669972854;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Hf1Sz4lNz/yJTkW9Vuqpwjleh8HbZdbQpO5u4O3YGU=;
  b=Y1z0vd0IeB/Se3Pisi3qXyF3tTzpacxGq/m0b1WGStRhEmeZMufV6nRi
   AqYmtQAwxQhckKgG2V6h4AlMZVOdEZQBEtjfP+1sCBvBAaKlo5LqqzfJJ
   Uhj0Egu5NowxnQ03PsiTE+zUJAKstIrh8bjzzYFg/XKxnBzMxZDaTua2m
   5HSWVHEUFc8XbaWBdUW2i3piukeAdJPGy3zyGTSA/R3XIBhRuQeUBlcN7
   1IRZmGzZ9BkS+CVDLTz9/KuEIWi7CdWmZRMis7+IJAqlucKoRwW1Uhxas
   g0WkkMNryC2jSoRV8dWNwm5ZeCSlit07PTueAb1WniFL0FEtIK4UiYNbo
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631570400"; 
   d="scan'208";a="20805230"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Dec 2021 10:20:54 +0100
Received: from schifferm-ubuntu (unknown [192.168.66.22])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 70D1D280065;
        Thu,  2 Dec 2021 10:20:54 +0100 (CET)
X-CheckPoint: {61A88FF6-3-3C7FD1AA-EED18422}
X-MAIL-CPID: 45077FE7A9563F0EC435383A3A30E219_4
X-Control-Analysis: str=0001.0A782F29.61A88FF6.00C9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Message-ID: <7f627adcaf0c8a8d0ffc8696658d3e400a750e62.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: micron-st: make
 mt25ql02g/mt25qu02g match more specific, add 4B opcodes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Dec 2021 10:20:54 +0100
In-Reply-To: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
References: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-07 at 14:08 +0200, Matthias Schiffer wrote:
> Change the mt25ql02g/mt25qu02g entries to include SPI_NOR_4B_OPCODES.
> In
> addition, the SPI_NOR_DUAL_READ flag is added to mt25ql02g; this
> seems
> to have been an accidental omission, as mt25ql02g and mt25qu02g
> should
> support the same features.
> 
> In addition, the entries are made more specific by matching on the
> mt25q
> extended ID, like it is already done for the smaller n25q
> derivatives.
> It is unclear whether n25q derivatives with 2Gbit exist that do not
> support 4B opcodes (like it is the case for sizes up to 512MBit), so
> we
> do not have a match for such variants anymore (as we wouldn't even
> know
> how to name such hypothetical models).
> 
> The changes were tested with a mt25qu01g, which should support the
> same
> features as the mt25ql02g/mt25qu02g.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

ping


> 
> v2:
> - add extended ID match
> - add back NO_CHIP_ERASE
> 
>  drivers/mtd/spi-nor/micron-st.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-
> nor/micron-st.c
> index c224e59820a1..a000a0790ecd 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -180,12 +180,14 @@ static const struct flash_info st_parts[] = {
>  	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048,
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      NO_CHIP_ERASE) },
> -	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
> -			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
> -			      NO_CHIP_ERASE) },
> -	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096,
> -			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
> +	{ "mt25ql02g",   INFO6(0x20ba22, 0x104400, 64 * 1024, 4096,
> +			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
> +			       NO_CHIP_ERASE) },
> +	{ "mt25qu02g",   INFO6(0x20bb22, 0x104400, 64 * 1024, 4096,
> +			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
> +			       NO_CHIP_ERASE) },
>  
>  	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
>  	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },

