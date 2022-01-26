Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9349C34F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiAZFfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:35:09 -0500
Received: from mx.msync.work ([95.217.65.204]:49842 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233609AbiAZFfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:35:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11BDE282CAF;
        Wed, 26 Jan 2022 05:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643175304; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=NAfBCWgItakVlmgvOLevvnbl8A251km2XBgrPyvmaoo=;
        b=IzKgGGegy8oHHSLfLehfYpxDbseHD1HFTsIxaHd3pkLMi2ouayV+kV6Te8WmLxWw5FbukC
        JlMQluF9rg+x2GtkXCbane3cP71dr2NjNP/ISfGHRKfr8G82BFl2H7/t1qy5zyR1l5GBSN
        AVEsy7PC83B0OEhKbTTxeRtdsxTsrn1zDLh+25EIak975kYT/uMw9u8C+YXuh9lsQs7lJ+
        vw3Z9BaBuD7NySEkmAQxSC8bxDxkkm7WDS27EixglgpHG1S1EpgccmCMhFJe/b1R9LSjbj
        hjbMGF9NwFADcjk30Kyz0wub6Q7boKYmFU5ep1ffeyrYo01HESw4toyzETFBjw==
Subject: Re: [PATCH 1/3] arm64: dts: meson-gx: add ATF BL32 reserved-memory
 region
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126044954.19069-1-christianshewitt@gmail.com>
 <20220126044954.19069-2-christianshewitt@gmail.com>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <a279c365-0615-1c7f-5596-dec9ad1c8229@lexina.in>
Date:   Wed, 26 Jan 2022 08:35:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220126044954.19069-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

26.01.2022 07:49, Christian Hewitt wrote:
> Add an additional reserved memory region for the BL32 trusted firmware
> present in many devices that boot from Amlogic vendor u-boot.
> 
> Suggested-by: Mateusz Krzak <kszaquitto@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 6b457b2c30a4..aa14ea017a61 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -49,6 +49,12 @@
>   			no-map;
>   		};
>   
> +		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> +		secmon_reserved_bl32: secmon@5300000 {
> +			reg = <0x0 0x05300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +
How do I check if we need a similar patch for axg boards?


>   		linux,cma {
>   			compatible = "shared-dma-pool";
>   			reusable;
> 

