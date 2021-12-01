Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B5464F62
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349740AbhLAOMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349603AbhLAOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:12:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED4C061574;
        Wed,  1 Dec 2021 06:09:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7118B81F54;
        Wed,  1 Dec 2021 14:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BDBC53FCC;
        Wed,  1 Dec 2021 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638367751;
        bh=nuUXKRE6eOnlBMrB9QF0r8JlMK0zxOIH+2kBllCxWyM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZaytimcU9aldqnICrRRmjMWo3koR6l2mqGVNbCK6jTS9m8A/qEcksX38weVya9egG
         jKZrJc8zHXAgMWHKcXAb+z+LjYL6NDhLHFxOcOyZuYQGWePk2k5SZvPqpVuhwYXx0M
         MSD1OCFhYn4n6SEmbKkHlQShGro/rRS7LFJMIMHt3d0+LUYnUytkhmsTD7d203ADku
         KyWhrfTDGmk14WGeckaE7r02dWfxp7ZYN4tUsx+BoB38Yi15WyM1sD5XHZqu/QS2Mw
         O/CMAbCdb0+KOf+rxBITfI0p7ktWeBoEqYqJGIIJ9A9Pc8VsZ4012ikQTDGoiQqyEZ
         QMeJJ5QJXl4tA==
Subject: Re: [PATCH] arm64: dts: Update NAND MTD partition for Agilex and
 Stratix 10
To:     sin.hui.kho@linux.intel.com, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yau Wai Gan <yau.wai.gan@intel.com>,
        Sin Hui Kho <sin.hui.kho@intel.com>
References: <20211201101353.51670-1-sin.hui.kho@linux.intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <b7a7cf43-fc22-e95e-0dca-f900d338e441@kernel.org>
Date:   Wed, 1 Dec 2021 08:09:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201101353.51670-1-sin.hui.kho@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/21 4:13 AM, sin.hui.kho@linux.intel.com wrote:
> From: Sin Hui Kho <sin.hui.kho@intel.com>
> 
> Change NAND flash MTD partition in device tree after implementation of
> UBI and UBIFS. "u-boot" partition remain for raw u-boot image, but "root"
> partition is use for UBI image containing all other components.
> 
> Signed-off-by: Sin Hui Kho <sin.hui.kho@intel.com>
> ---
>   .../dts/altera/socfpga_stratix10_socdk_nand.dts    | 24 ++--------------------
>   .../boot/dts/intel/socfpga_agilex_socdk_nand.dts   | 20 ++----------------
>   2 files changed, 4 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts


Applied!

Thanks,
Dinh
