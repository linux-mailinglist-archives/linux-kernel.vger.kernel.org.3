Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29437496BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 11:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiAVKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 05:48:14 -0500
Received: from 1.mo575.mail-out.ovh.net ([46.105.41.146]:54763 "EHLO
        1.mo575.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiAVKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 05:48:13 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jan 2022 05:48:13 EST
Received: from player687.ha.ovh.net (unknown [10.109.146.168])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 1550022507
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 10:42:50 +0000 (UTC)
Received: from etezian.org (82-181-27-157.bb.dnainternet.fi [82.181.27.157])
        (Authenticated sender: andi@etezian.org)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id 855ED268D492D;
        Sat, 22 Jan 2022 10:42:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R00227887125-d786-4907-a622-75ed417c6e98,
                    7845C3D69A5FB83312AE15A7A84010493B023798) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 82.181.27.157
Date:   Sat, 22 Jan 2022 12:42:33 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>, linux-fsd@tesla.com
Subject: Re: [PATCH v2 3/3] arm64: dts: fsd: Add SPI device nodes
Message-ID: <YevfmeGwmwLml+6b@jack.zhora.eu>
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06@epcas5p3.samsung.com>
 <20220120192438.25555-4-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120192438.25555-4-alim.akhtar@samsung.com>
X-Ovh-Tracer-Id: 16116412745235499534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrvddvgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpedtgfduudfhfeeuueejfeeihedtfeetgfegveehgfeuleelhfduteegieekudeifeenucfkpheptddrtddrtddrtddpkedvrddukedurddvjedrudehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim and Aswani,

On Fri, Jan 21, 2022 at 12:54:38AM +0530, Alim Akhtar wrote:
> From: Aswani Reddy <aswani.reddy@samsung.com>
> 
> Adds device tree node for SPI IPs
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Please, also allow me another nit-commnent for the next patches:
the tag section is in chronological order. I suppose that first
Aswani wrote the patch, then you sent it to the mailing list and
at the end Krzysztof has reviewed it, this means that the right
order is:

  Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
  Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
  Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thank you,
Andi
