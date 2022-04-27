Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F48511761
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiD0MZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiD0MZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:25:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A74A90A;
        Wed, 27 Apr 2022 05:21:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R5dQff017082;
        Wed, 27 Apr 2022 07:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Zs6p4o65vPg0fnOBmASDmGUweTAfe8SbB+zfqEskw6s=;
 b=It7lPxkPJc4Vz/PU5dW+xoKE55rJTlef1LAxVQNfyAcfuC/7IFKxSVBSAVPMzMPtBmWz
 INZOA7kgBZ1OIUWxosOMNaIQLVOhiHMwJKH/sDxmxhYH/Sd3WFFVa8aMiPCPmzBGbfnO
 zu497uDXaxsU/Ptm4st2e/jWkEv1IQiB5w8CaS1KBXO0pJA5VUSrndZejvhFpkkr0+DZ
 /vxZmksTq483tc4YxNM5/T/5p4t9hj0UwUmSHk/r67epQqArpY/xtekvXYGL2ja77OZF
 UNhTS7SnPFIBkalc7Jvo05gopsW0B4y0yZXIMBTIB1oeTtHyFmzTbeQKDN8fJBusgeqg MA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fprtb0ph0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 07:21:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 13:21:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 13:21:43 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8F53FB10;
        Wed, 27 Apr 2022 12:21:43 +0000 (UTC)
Date:   Wed, 27 Apr 2022 12:21:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Message-ID: <20220427122143.GB38351@ediswmail.ad.cirrus.com>
References: <20220427065102.109046-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427065102.109046-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: -bWfGsHz7_tcYDRT5Qn40Peq7XyYKx8A
X-Proofpoint-GUID: -bWfGsHz7_tcYDRT5Qn40Peq7XyYKx8A
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:51:02AM +0200, Krzysztof Kozlowski wrote:
> The Wolfson Microelectronics Arizona audio can be connected via SPI bus
> (e.g. WM5110 on Exynos5433 TM2 board), so allow spi-max-frequency
> property.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
