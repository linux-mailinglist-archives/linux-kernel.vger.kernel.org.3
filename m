Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D231146D0BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhLHKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:18:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19880 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhLHKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638958477; x=1670494477;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8fvNVbusAPRFGuvksh4uPO16Z5rLgfIbr2/Vq3gqWxk=;
  b=15GhdyjMp9i1PUJyeBGZagzwcDvR+VoCOY5HGtrcKjNhVBJlJIFuRV3S
   jdUacb8XfMYum6RkwCvXI/kJ1Tnz7uaMENcyBtnG9fLMS6uDU5zNj26U8
   sP4oSzXcUyt0TQq7++jDkoG+LE5M/ZdSI1bOsuHkXZo/lFNJMKd0b2i7K
   YuymcNnKDv2aShMMoq9gqSlr3ae1KvJhraw74Gavm5RZrFlIzKqfRkc9I
   It7lOMZW+ujX5GNdGIugGLhRIEg886eKwKywQIZLgCqX77DjMV2VDtUhk
   ig8OjOem/epPWaUNAUuTY+t7/J+G+T0d0y5eiA86kie3ba/+LqqrpkJBN
   w==;
IronPort-SDR: SF+n8McBnVIdD0Slhu+E814mhYylefqWCwIv8j7JwMJSCW/2NQC18cqXvwRhXccOeIAAhk+Nxa
 U3EY/RojxlizwMfR5Y6SFXKxLA01+7lfMa/IFIgMq/lHpDSS6T6f1hHAZrnTY9aEm+RKEtERGe
 laf//jHD2WlwMB0C/RnHnReJSsnbfYbaQCUx49OjA4KONCk1tTyLTV0XRTW3p9GGQ/HHTqendU
 B0354f0LM7nrAYx2GZLi+LpE1n1ReKZPZ9IFH8LmFzPgtVlWx9P98fpUA5da//8WUzcipR+p31
 nh2ZQpJQUsydHLXcKsjuldbV
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="154692092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 03:14:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 03:14:36 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 03:14:35 -0700
Subject: Re: [RFC PATCH v4 0/4] Extend lan966x clock driver for clock gating
 support
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <0308422f-4a97-8d7e-8e03-ad03129db6ae@microchip.com>
Date:   Wed, 8 Dec 2021 11:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2021 at 09:50, Horatiu Vultur wrote:
> This patch series depends on the following series, therefor keep it as RFC.
> https://www.spinics.net/lists/linux-clk/msg62795.html
> 
> This patch series extend the clock driver to support also clock gating.
> 
> v3->v4:
>   - fix reg property in the schema file
> 
> v2->v3:
>   - add devm_clk_hw_register_gate function
> 
> v1->v2:
>   - add Acked-by tag for patch 2
>   - make the resource for clock gating as an optional resource
> 
> Horatiu Vultur (4):
>    clk: gate: Add devm_clk_hw_register_gate()
>    dt-bindings: clock: lan966x: Extend for clock gate support
>    dt-bindings: clock: lan966x: Extend includes with clock gates
>    clk: lan966x: Extend lan966x clock driver for clock gating support

For whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I'm queuing these patches on clk-at91 branch and plan to seed a 
pull-request to Stephen soon.

In the meantime it's sitting in the at91-next branch as well which is 
picked up by linux-next.

Best regards,
   Nicolas

>   .../bindings/clock/microchip,lan966x-gck.yaml |  5 +-
>   drivers/clk/clk-gate.c                        | 35 +++++++++++
>   drivers/clk/clk-lan966x.c                     | 59 ++++++++++++++++++-
>   include/dt-bindings/clock/microchip,lan966x.h |  8 ++-
>   include/linux/clk-provider.h                  | 23 ++++++++
>   5 files changed, 125 insertions(+), 5 deletions(-)
> 


-- 
Nicolas Ferre
