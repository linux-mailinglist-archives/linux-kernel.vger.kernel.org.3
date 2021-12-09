Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0546E93D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhLINkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:40:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhLINkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:40:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 609A51F467CB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639057002; bh=BwWLLiPj4d7OGh1PWyvfAONfVoOgWMc8xrXlLBFUDyo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LUJDSGW0FzY+eHALf/gQ7GQKEr2sV036I0SBFeSwyHgdTpeXkxP09J+9d+X/IoxAK
         x5gKhvPItvyQVdFE0J6bCo/YGR5PH+GXb9DU6lykUidKxmztnkefPpF4VzfwUhYBT+
         vMo4gqM6sLV1h0KGCKtueYazt8+fptAvdmtxbCQX4joleUutXMkAigm6njHQbbznMS
         sQxbwMCDkC4IwqgkeZ9mYFOntebRRQNmaOad9w1utQzA3j+K3FiUOChMRlimtb4/X4
         TZ5YqzSAL+KtLfjaBVpRdtv3GAu8wQQPBoB91qi+uiKZyjJtZnOyM05Q7gBhC0o4RE
         vhdZjP5BJKNOg==
Subject: Re: [PATCH v3 5/5] arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2
 IMX6ULZ SystemMaster
To:     Fabio Estevam <festevam@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        ioana.ciornei@nxp.com, jagan@amarulasolutions.com,
        kernel@pengutronix.de, krzk@kernel.org, linux-imx@nxp.com,
        matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com, robh@kernel.org
References: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
 <20211208192009.322190-6-ariel.dalessandro@collabora.com>
 <CAOMZO5CnzVm83yHbzg2OD8HqNEV0-sXduDH9zPHctRy2i9ErDA@mail.gmail.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Message-ID: <078e6466-121e-1f1d-625b-7a0ffa684501@collabora.com>
Date:   Thu, 9 Dec 2021 10:36:31 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CnzVm83yHbzg2OD8HqNEV0-sXduDH9zPHctRy2i9ErDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 12/8/21 4:26 PM, Fabio Estevam wrote:
> On Wed, Dec 8, 2021 at 4:21 PM Ariel D'Alessandro
> <ariel.dalessandro@collabora.com> wrote:
>>
>> From: Michael Trimarchi <michael@amarulasolutions.com>
>>
>> Add DTS of BSH SMM-M2 SystemMaster.
>>
>> This version comes with:
>> - 128 MiB DDR3 RAM
>> - 256 MiB Nand
>> - wifi
>> - bluetooth
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>>  arch/arm/boot/dts/Makefile               |   3 +-
>>  arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 146 +++++++++++++++++++++++
> 
> There is a typo in the Subject: it says imx8ulz, but it should be
> imx6ulz instead.

Ah, you're right. Will fix in v4.

> 
>> +/ {
>> +       model = "BSH SMM M2";
>> +       compatible = "bsh,imx6ulz-bsh-smm-m2", "fsl,imx6ull";
> 
> Shouldn't "fsl,imx6ulz" also be added here like it is done in
> imx6ulz-14x14-evk.dts?

Yes, it should. Will fix in v4.

Thanks a lot,
Ariel
