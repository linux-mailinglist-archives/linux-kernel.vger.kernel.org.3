Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13846BCF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhLGNyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhLGNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:54:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A5C061574;
        Tue,  7 Dec 2021 05:51:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so57501238edv.1;
        Tue, 07 Dec 2021 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=peAAMfNQlavTfkcTPAynnMHwh6U7PTunVQj9NAmKSBU=;
        b=Jn4LFwfmPtWbZ6coXfI5wIcOkFIQ9UoiqoAvrHohsV+th27Yl3Xit80Ym7gHkEvD/D
         x45f9EOsJhF18dlH7ZvghYE8TiachCU/CPCC4C+F8FfXmmNLWUC10OzKb30qtpjkFxpy
         sB39LbFwXJVqmodYOyJP9wb89zuXAm57Mxn4fmGX8gYx4qse/QQdH1m1du+ov0bnegBH
         V66cKTUA/03Rgzqxt7FXtZyjaC/CD872nKWFITzdgJaxsvpr54jaAhUavb1Yb1+HLH11
         pwawY5cqEcFRABZCcsfq4lYrySf+rFa6HOSTLXnfax/Aym5Wq7s6PYwNtgRXqBPotXpG
         0/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=peAAMfNQlavTfkcTPAynnMHwh6U7PTunVQj9NAmKSBU=;
        b=DqerEDxwFF90SvUUc4i24uqAMn6y34m5IRaWza4BDBrUbgbffQEbEzlAtC4C2uC268
         aqB6csYtWTr3ADp6ohTEVEv/Ysh51ptfv1RGFarCfkyjaJsmyY31nr4UF1mRS49XXYIS
         0hHBuqttmxzG8ozkSwx+37PNHDQG93a5ocZdNfP8aPbbCqPk0A4PUW4dG79VT6PGsU8S
         WFblpL0fjxNORBb+tj4/YAq0lZAoY26iTeuBVFeGIX+s4hBtzQLDsbROpmCFkjJwbawJ
         QgEqUlxUnxWl9mpK+0CXelviChbaCsC1GxZqGSYe9Lcl5rSiSZK455q8wY0XB/xUofmn
         rn9w==
X-Gm-Message-State: AOAM5339X5m/HuGjgygevk1B2CODmOAWb7BPM8LGqqY+xGPCnXIgqN+f
        01GogrfdRuycgfGvfYiMLNw=
X-Google-Smtp-Source: ABdhPJxugsNelYa9OVYYMTg2znmIEsCTwI76eBDj15y8KJTOD/xV3WcgFoO/HGpmTTRJc2vq/CRiIw==
X-Received: by 2002:a17:906:1290:: with SMTP id k16mr52309539ejb.566.1638885080416;
        Tue, 07 Dec 2021 05:51:20 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p26sm10150597edt.94.2021.12.07.05.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 05:51:20 -0800 (PST)
Subject: Re: [PATCH v3 2/3] phy/rockchip: add naneng combo phy for RK3568
From:   Johan Jonker <jbx6244@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com
References: <20211025080632.32063-1-yifeng.zhao@rock-chips.com>
 <20211025080632.32063-3-yifeng.zhao@rock-chips.com>
 <65898b49-87ee-211e-f5ef-39147107ef83@gmail.com>
Message-ID: <95ba0a5b-8f5a-3351-fc53-33021b2a0111@gmail.com>
Date:   Tue, 7 Dec 2021 14:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <65898b49-87ee-211e-f5ef-39147107ef83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

See question below.

On 11/14/21 12:40 PM, Johan Jonker wrote:
> Hi Yifeng,
> 
> Some comments. Have a look if it's useful.
> 
> On 10/25/21 10:06 AM, Yifeng Zhao wrote:
>> This patch implements a combo phy driver for Rockchip SoCs
>> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
>> sata-phy or sgmii-phy.
>>
>> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
>> ---

>> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

>> +
>> +#define BIT_WRITEABLE_SHIFT		16
>> +#define REF_CLOCK_24MHz			24000000
>> +#define REF_CLOCK_25MHz			25000000
>> +#define REF_CLOCK_100MHz		100000000
>> +/* RK3568 T22 COMBO PHY REG */
>> +#define RK3568_T22_PHYREG5		0x14
>> +#define T22_PHYREG5_PLL_DIV_MASK	GENMASK(7, 6)
>> +#define T22_PHYREG5_PLL_DIV_SHIFT	6
>> +#define T22_PHYREG5_PLL_DIV_2		1
>> +

>> +#define RK3568_T22_PHYREG6		0x18

Multi-PHY_Register007
Address: Operational Base + offset (0x0018)

>> +#define T22_PHYREG6_TX_RTERM_MASK	GENMASK(7, 4)
>> +#define T22_PHYREG6_TX_RTERM_SHIFT	4
>> +#define T22_PHYREG6_TX_RTERM_50OHM	0x8
>> +#define T22_PHYREG6_RX_RTERM_MASK	GENMASK(3, 0)
>> +#define T22_PHYREG6_RX_RTERM_SHIFT	0
>> +#define T22_PHYREG6_RX_RTERM_44OHM	0xF
>> +
>> +#define RK3568_T22_PHYREG7		0x1C

Multi-PHY_Register008
Address: Operational Base + offset (0x001C)

>> +#define T22_PHYREG7_SSC_EN		BIT(4)

See Rockchip RK3568 TRM Part2 V1.0-20210111 page 1957-1958

It looks as if all PHYREG defines add -1 in value? I'm I correct here?

===

SSC_EN
In U3 and SATA mode, this bit= 1, set SSC on
In PCIE mode, this bit=0 set SSC off

      If Spread Spectrum Clocking (SSC) is used it is
      required that a common reference clock is used by the link partners.
      Most commercially available platforms with PCIe backplanes use
      SSC to reduce EMI.

Maybe a dumb question for in a possible YAML description:
Is this above text from the TRM correct?
Is SSC only used in combination with PCIE instead of U3 and SATA?

===

Johan

>> +
>> +#define RK3568_T22_PHYREG10		0x28
>> +#define T22_PHYREG10_SU_TRIM_0_7	0xF0
>> +
>> +#define RK3568_T22_PHYREG11		0x2C
>> +#define T22_PHYREG11_PLL_LPF_ADJ	0x4
>> +

>> +#define RK3568_T22_PHYREG12		0x30

Multi-PHY_Register013
Address: Operational Base + offset (0x0030)

>> +#define T22_PHYREG12_RESISTER_MASK	GENMASK(5, 4)
>> +#define T22_PHYREG12_RESISTER_SHIFT	0x4
>> +#define T22_PHYREG12_RESISTER_HIGH_Z	0x3
>> +#define T22_PHYREG12_CKRCV_AMP0		BIT(7)
>> +
>> +#define RK3568_T22_PHYREG13		0x34
>> +#define T22_PHYREG13_CKRCV_AMP1		BIT(0)
>> +
>> +#define RK3568_T22_PHYREG14		0x38
>> +#define T22_PHYREG14_CTLE_EN		BIT(0)
>> +#define T22_PHYREG14_SSC_CNT_MASK	GENMASK(7, 6)
>> +#define T22_PHYREG14_SSC_CNT_SHIFT	6
>> +#define T22_PHYREG14_SSC_CNT_VALUE	0x1
>> +
>> +#define RK3568_T22_PHYREG15		0x3C
>> +#define T22_PHYREG15_SSC_CNT_VALUE	0x5f
>> +
>> +#define RK3568_T22_PHYREG17		0x44
>> +#define T22_PHYREG17_PLL_LOOP		0x32
>> +
>> +#define RK3568_T22_PHYREG31		0x7C
>> +#define T22_PHYREG31_SSC_MASK		GENMASK(7, 4)
>> +#define T22_PHYREG31_SSC_DIR_SHIFT	4
>> +#define T22_PHYREG31_SSC_UPWARD		0
>> +#define T22_PHYREG31_SSC_DOWNWARD	1
>> +#define T22_PHYREG31_SSC_OFFSET_SHIFT	6
>> +#define T22_PHYREG31_SSC_OFFSET_500PPM	1
>> +
>> +#define RK3568_T22_PHYREG32		0x80
>> +#define T22_PHYREG32_PLL_KVCO_MASK	GENMASK(4, 2)
>> +#define T22_PHYREG32_PLL_KVCO_SHIFT	2
>> +#define T22_PHYREG32_PLL_KVCO_VALUE	2
>> +
