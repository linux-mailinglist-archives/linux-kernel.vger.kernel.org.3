Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBD495426
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiATS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:26:00 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50288 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiATSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:25:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20KIPQTJ035437;
        Thu, 20 Jan 2022 12:25:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642703126;
        bh=2/qtOiX8+RrhrE/rS2MPeAIX4aF+I40EDhFEBNmbWWs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=y9WuRckUOeM+AD+vJnd2PCAaS9YpWbv3AURxDJuziO+sisVCApOE1M990Iarng8Ug
         j8Y+w2Rjc3TSI8hFbuEanqcgLBaYzzxIKRgj4+LCiFlfgz6gG9dqaG224EGX/pdSW1
         4QjfCcbFAB6R8RFU8GE1vlrQEAmG/gtacvC21zZo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20KIPQpT126366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jan 2022 12:25:26 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 20
 Jan 2022 12:25:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 20 Jan 2022 12:25:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20KIPPOv044230;
        Thu, 20 Jan 2022 12:25:25 -0600
Date:   Thu, 20 Jan 2022 23:55:24 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v5 2/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <20220120182524.d5fe3uigbelhcs7l@ti.com>
References: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
 <20220120175747.43403-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220120175747.43403-3-krzysztof.kozlowski@canonical.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/22 06:57PM, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format.
> 
> The conversion also drops requirement from providing controller-data and
> its data for each of SPI peripheral device nodes.  The dtschema cannot
> express this and the requirement is being relaxed in the driver now.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Thanks.

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
