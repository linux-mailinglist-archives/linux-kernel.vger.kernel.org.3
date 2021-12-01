Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0714465922
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353601AbhLAW3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:29:21 -0500
Received: from 7.mo550.mail-out.ovh.net ([87.98.158.110]:60085 "EHLO
        7.mo550.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353583AbhLAW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:29:18 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 17:29:18 EST
Received: from player796.ha.ovh.net (unknown [10.110.115.246])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 40B3A23E13
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:08:25 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 5317F24DA5558;
        Wed,  1 Dec 2021 21:08:17 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R0067f55729a-1a8a-45c6-a52a-f5ace8f2f974,
                    738FF6B34265B71E218B6744B181DC2F08F41F15) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <aeb874ed-179e-5ede-6339-ea4b80b7806f@milecki.pl>
Date:   Wed, 1 Dec 2021 22:08:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH 3/3] phy: broadcom: Kconfig: Fix PHY_BRCM_USB config
 option
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <20211201180653.35097-4-alcooperx@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <20211201180653.35097-4-alcooperx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16449679117486041945
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrieefgddugeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjeetledugeejtdevheetieduhefgtedvgefftddvfedvieevjeegleffleegtdeunecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.2021 19:06, Al Cooper wrote:
> The previous commit 4b402fa8e0b7 ("phy: phy-brcm-usb: support PHY on
> the BCM4908") added a second "default" line for ARCH_BCM_4908 above
> the original "default" line for ARCH_BRCMSTB. When two "default"
> lines are used, only the first is used and this change stopped
> the PHY_BRCM_USB option for being enabled for ARCH_BRCMSTB.
> The fix is to use one "default line with "||".
> 
> Fixes: 4b402fa8e0b7 ("phy: phy-brcm-usb: support PHY on the BCM4908")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
