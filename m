Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90524C1127
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiBWLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiBWLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:20:01 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45B18F61C;
        Wed, 23 Feb 2022 03:19:33 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id cm8so34011764edb.3;
        Wed, 23 Feb 2022 03:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VTjlrwisBt8q5JD9OX/9RTT9JYvs+UWS5voo2Vw/wg0=;
        b=IKnprsKuwhjfDJm9ONbVDqisxurt6CfZHRsN9xjhBit4sZdcSDAwqPpvljK/hvIWne
         J17FElRMPY+i+j3TIQWoxZiOMTum2raSruuoJRr/X5SWG8XX8sz/hLZgg7Z3rDvRVXz3
         6hnCnqn6XReLJOpqoTBZHXTLXI6zGqkPCWjN7QGnhDSqre0V8nZEViT9JZTeZWH74Su3
         lA2vW2Zkw5BUCYnOtDoaw3jmF3wRR1RLgP6nVTl5Zkt4/VU3P+764WxV7MNfLjTMndfl
         e0X3RiNA8YYJC5X9D7U9x+aLo1lEMLVndInSo5i6VwCeWWY5u/7iHUwwzUjbOz6GsKxv
         6AvQ==
X-Gm-Message-State: AOAM531uqMh0rU5QZKKx7932Nin9qWsU9K9tAGu3j18k3Vs6P3ozu7H2
        tXbpPN2PMYpuuOZreomIwyI=
X-Google-Smtp-Source: ABdhPJw96ij8rMsamKI1B8NRWmlXjgIbJ1wB3U2OP3EfM8InzFoLRUrvOxJVQuAZoDzeaLCPxQsuvA==
X-Received: by 2002:a05:6402:3583:b0:410:a99b:59ee with SMTP id y3-20020a056402358300b00410a99b59eemr31056222edc.454.1645615172045;
        Wed, 23 Feb 2022 03:19:32 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id p17sm979916ejn.12.2022.02.23.03.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:19:30 -0800 (PST)
Message-ID: <9adc10ff-fa07-c84b-1602-2378bcbcf4d2@kernel.org>
Date:   Wed, 23 Feb 2022 12:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 2/5] dt-bindings: clock: add i.MX93 clock definition
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
 <20220223064358.4097307-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220223064358.4097307-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 07:43, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 clock definition
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/clock/imx93-clock.h | 200 ++++++++++++++++++++++++
>  1 file changed, 200 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imx93-clock.h
> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> new file mode 100644
> index 000000000000..416e6fd7856d
> --- /dev/null
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMX93_CLK_H
> +#define __DT_BINDINGS_CLOCK_IMX93_CLK_H
> +
> +#define IMX93_CLK_DUMMY			0
> +#define IMX93_CLK_24M			1
> +#define IMX93_CLK_EXT1			2
> +#define IMX93_CLK_SYS_PLL_PFD0		3
> +#define IMX93_CLK_SYS_PLL_PFD0_DIV2	4
> +#define IMX93_CLK_SYS_PLL_PFD1		5
> +#define IMX93_CLK_SYS_PLL_PFD1_DIV2	6
> +#define IMX93_CLK_SYS_PLL_PFD2		7
> +#define IMX93_CLK_SYS_PLL_PFD2_DIV2	8
> +#define IMX93_CLK_AUDIO_PLL		9
> +#define IMX93_CLK_VIDEO_PLL		10
> +#define IMX93_CLK_A55_PERIPH		11
> +#define IMX93_CLK_A55_MTR_BUS		12
> +#define IMX93_CLK_A55			13
> +#define IMX93_CLK_M33			14
> +#define IMX93_CLK_BUS_WAKEUP		15
> +#define IMX93_CLK_BUS_AON		16
> +#define IMX93_CLK_WAKEUP_AXI		17
> +#define IMX93_CLK_SWO_TRACE		18
> +#define IMX93_CLK_M33_SYSTICK		19
> +#define IMX93_CLK_FLEXIO1		20
> +#define IMX93_CLK_FLEXIO2		21
> +#define IMX93_CLK_LPIT1			22
> +#define IMX93_CLK_LPIT2			23
> +#define IMX93_CLK_LPTMR1		24
> +#define IMX93_CLK_LPTMR2		25
> +#define IMX93_CLK_TPM1			26
> +#define IMX93_CLK_TPM2			27
> +#define IMX93_CLK_TPM3			28
> +#define IMX93_CLK_TPM4			29
> +#define IMX93_CLK_TPM5			30
> +#define IMX93_CLK_TPM6			31
> +#define IMX93_CLK_FLEXSPI1		32
> +#define IMX93_CLK_CAN1			33
> +#define IMX93_CLK_CAN2			34
> +#define IMX93_CLK_LPUART1		35
> +#define IMX93_CLK_LPUART2		36
> +#define IMX93_CLK_LPUART3		37
> +#define IMX93_CLK_LPUART4		38
> +#define IMX93_CLK_LPUART5		39
> +#define IMX93_CLK_LPUART6		40
> +#define IMX93_CLK_LPUART7		41
> +#define IMX93_CLK_LPUART8		42
> +#define IMX93_CLK_LPI2C1		43
> +#define IMX93_CLK_LPI2C2		44
> +#define IMX93_CLK_LPI2C3		45
> +#define IMX93_CLK_LPI2C4		46
> +#define IMX93_CLK_LPI2C5		47
> +#define IMX93_CLK_LPI2C6		48
> +#define IMX93_CLK_LPI2C7		49
> +#define IMX93_CLK_LPI2C8		50
> +#define IMX93_CLK_LPSPI1		51
> +#define IMX93_CLK_LPSPI2		52
> +#define IMX93_CLK_LPSPI3		53
> +#define IMX93_CLK_LPSPI4		54
> +#define IMX93_CLK_LPSPI5		55
> +#define IMX93_CLK_LPSPI6		56
> +#define IMX93_CLK_LPSPI7		57
> +#define IMX93_CLK_LPSPI8		58
> +#define IMX93_CLK_I3C1			59
> +#define IMX93_CLK_I3C2			60
> +#define IMX93_CLK_USDHC1		61
> +#define IMX93_CLK_USDHC2		62
> +#define IMX93_CLK_USDHC3		63
> +#define IMX93_CLK_SAI1			64
> +#define IMX93_CLK_SAI2			65
> +#define IMX93_CLK_SAI3			66
> +#define IMX93_CLK_CCM_CKO1		67
> +#define IMX93_CLK_CCM_CKO2		68
> +#define IMX93_CLK_CCM_CKO3		69
> +#define IMX93_CLK_CCM_CKO4		70
> +#define IMX93_CLK_HSIO			71
> +#define IMX93_CLK_HSIO_USB_TEST_60M	72
> +#define IMX93_CLK_HSIO_ACSCAN_80M	73
> +#define IMX93_CLK_HSIO_ACSCAN_480M	74
> +#define IMX93_CLK_ML_APB		75
> +#define IMX93_CLK_ML			76
> +#define IMX93_CLK_MEDIA_AXI		77
> +#define IMX93_CLK_MEDIA_APB		78
> +#define IMX93_CLK_MEDIA_LDB		79
> +#define IMX93_CLK_MEDIA_DISP_PIX	80
> +#define IMX93_CLK_CAM_PIX		81
> +#define IMX93_CLK_MIPI_TEST_BYTE	82
> +#define IMX93_CLK_MIPI_PHY_CFG		83
> +#define IMX93_CLK_ADC			84
> +#define IMX93_CLK_PDM			85
> +#define IMX93_CLK_TSTMR1		86
> +#define IMX93_CLK_TSTMR2		87
> +#define IMX93_CLK_MQS1			88
> +#define IMX93_CLK_MQS2			89
> +#define IMX93_CLK_AUDIO_XCVR		90
> +#define IMX93_CLK_SPDIF			91
> +#define IMX93_CLK_ENET			92
> +#define IMX93_CLK_ENET_TIMER1		93
> +#define IMX93_CLK_ENET_TIMER2		94
> +#define IMX93_CLK_ENET_REF		95
> +#define IMX93_CLK_ENET_REF_PHY		96
> +#define IMX93_CLK_I3C1_SLOW		97
> +#define IMX93_CLK_I3C2_SLOW		98
> +#define IMX93_CLK_USB_PHY_BURUNIN	99
> +#define IMX93_CLK_PAL_CAME_SCAN		100
> +#define IMX93_CLK_A55_GATE		101
> +#define IMX93_CLK_CM33_GATE		102
> +#define IMX93_CLK_ADC1_GATE		103
> +#define IMX93_CLK_WDOG1_GATE		104
> +#define IMX93_CLK_WDOG2_GATE		105
> +#define IMX93_CLK_WDOG3_GATE		106
> +#define IMX93_CLK_WDOG4_GATE		107
> +#define IMX93_CLK_WDOG5_GATE		108
> +#define IMX93_CLK_SEMA1_GATE		109
> +#define IMX93_CLK_SEMA2_GATE		110
> +#define IMX93_CLK_MU_A_GATE		111
> +#define IMX93_CLK_MU_B_GATE		112
> +#define IMX93_CLK_EDMA1_GATE		113
> +#define IMX93_CLK_EDMA2_GATE		114
> +#define IMX93_CLK_FLEXSPI1_GATE		115
> +#define IMX93_CLK_GPIO1_GATE		116
> +#define IMX93_CLK_GPIO2_GATE		117
> +#define IMX93_CLK_GPIO3_GATE		118
> +#define IMX93_CLK_GPIO4_GATE		119
> +#define IMX93_CLK_FLEXIO1_GATE		120
> +#define IMX93_CLK_FLEXIO2_GATE		121
> +#define IMX93_CLK_LPIT1_GATE		122
> +#define IMX93_CLK_LPIT2_GATE		123
> +#define IMX93_CLK_LPTMR1_GATE		124
> +#define IMX93_CLK_LPTMR2_GATE		125
> +#define IMX93_CLK_TPM1_GATE		126
> +#define IMX93_CLK_TPM2_GATE		127
> +#define IMX93_CLK_TPM3_GATE		128
> +#define IMX93_CLK_TPM4_GATE		129
> +#define IMX93_CLK_TPM5_GATE		130
> +#define IMX93_CLK_TPM6_GATE		131
> +#define IMX93_CLK_CAN1_GATE		132
> +#define IMX93_CLK_CAN2_GATE		133
> +#define IMX93_CLK_LPUART1_GATE		134
> +#define IMX93_CLK_LPUART2_GATE		135
> +#define IMX93_CLK_LPUART3_GATE		136
> +#define IMX93_CLK_LPUART4_GATE		137
> +#define IMX93_CLK_LPUART5_GATE		138
> +#define IMX93_CLK_LPUART6_GATE		139
> +#define IMX93_CLK_LPUART7_GATE		140
> +#define IMX93_CLK_LPUART8_GATE		141
> +#define IMX93_CLK_LPI2C1_GATE		142
> +#define IMX93_CLK_LPI2C2_GATE		143
> +#define IMX93_CLK_LPI2C3_GATE		144
> +#define IMX93_CLK_LPI2C4_GATE		145
> +#define IMX93_CLK_LPI2C5_GATE		146
> +#define IMX93_CLK_LPI2C6_GATE		147
> +#define IMX93_CLK_LPI2C7_GATE		148
> +#define IMX93_CLK_LPI2C8_GATE		149
> +#define IMX93_CLK_LPSPI1_GATE		150
> +#define IMX93_CLK_LPSPI2_GATE		151
> +#define IMX93_CLK_LPSPI3_GATE		152
> +#define IMX93_CLK_LPSPI4_GATE		153
> +#define IMX93_CLK_LPSPI5_GATE		154
> +#define IMX93_CLK_LPSPI6_GATE		155
> +#define IMX93_CLK_LPSPI7_GATE		156
> +#define IMX93_CLK_LPSPI8_GATE		157
> +#define IMX93_CLK_I3C1_GATE		158
> +#define IMX93_CLK_I3C2_GATE		159
> +#define IMX93_CLK_USDHC1_GATE		160
> +#define IMX93_CLK_USDHC2_GATE		161
> +#define IMX93_CLK_USDHC3_GATE		162
> +#define IMX93_CLK_SAI1_GATE		163
> +#define IMX93_CLK_SAI2_GATE		164
> +#define IMX93_CLK_SAI3_GATE		165
> +#define IMX93_CLK_MIPI_CSI_GATE		166
> +#define IMX93_CLK_MIPI_DSI_GATE		167
> +#define IMX93_CLK_LVDS_GATE		168
> +#define IMX93_CLK_LCDIF_GATE		169
> +#define IMX93_CLK_PXP_GATE		170
> +#define IMX93_CLK_ISI_GATE		171
> +#define IMX93_CLK_NIC_MEDIA_GATE	172
> +#define IMX93_CLK_USB_CONTROLLER_GATE	173
> +#define IMX93_CLK_USB_TEST_60M_GATE	174
> +#define IMX93_CLK_HSIO_TROUT_24M_GATE	175
> +#define IMX93_CLK_PDM_GATE		176
> +#define IMX93_CLK_MQS1_GATE		177
> +#define IMX93_CLK_MQS2_GATE		178
> +#define IMX93_CLK_AUD_XCVR_GATE		179
> +#define IMX93_CLK_SPDIF_GATE		180
> +#define IMX93_CLK_HSIO_32K_GATE		181
> +#define IMX93_CLK_ENET1_GATE		182
> +#define IMX93_CLK_ENET_QOS_GATE		183
> +#define IMX93_CLK_SYS_CNT_GATE		184
> +#define IMX93_CLK_TSTMR1_GATE		185
> +#define IMX93_CLK_TSTMR2_GATE		186
> +#define IMX93_CLK_TMC_GATE		187
> +#define IMX93_CLK_PMRO_GATE		188
> +#define IMX93_CLK_32K			189
> +#define IMX93_CLK_END			190

Empty line please.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

> +#endif


Best regards,
Krzysztof
