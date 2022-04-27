Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7E5118F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiD0NBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiD0NBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:01:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011134C42C;
        Wed, 27 Apr 2022 05:58:05 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R8mTZq008893;
        Wed, 27 Apr 2022 07:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=cTo4iGCRI0TEr3heseNQsJDxVX4XVWJW4qEdcisdkVQ=;
 b=mapUDoCtKZ+ZPfK7g0JFvMDSp+lT+lA/vZhJm8H6PGwB6XF7C5LSB6MgKr6rI6A0IFdV
 U5UOQsrtKsyVeze7eXHyCGq+FTRrQ78j1V8dR5oKc0taTmjeT75jlREspJfxsCQ/Jtsr
 a2mSfBKHvAxqHUbeELjn7qwFXYnsYI3ASwh+JE4mAEccNlbRlQavj1E70LPMZhZMc4ff
 qoh4veull4nmAg165f/l7o/29godByKpDDyEM3QBLUuA3bVpBcEJMIDu4Ula24g2bKmj
 aLmcVrpXObNQTjeWM4MPAzpcpVd6IKzfuKqGzClpiELieRQNz3h4P62kNsNiVh140RPx Ww== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60s4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 07:58:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 13:58:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 13:58:01 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 10EF1B1A;
        Wed, 27 Apr 2022 12:58:01 +0000 (UTC)
Date:   Wed, 27 Apr 2022 12:58:01 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Message-ID: <20220427125801.GC38351@ediswmail.ad.cirrus.com>
References: <20220427065102.109046-1-krzysztof.kozlowski@linaro.org>
 <20220427122143.GB38351@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427122143.GB38351@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 1aNiCFYk_OTQ-KiXfbYWMPbq02RgVaDl
X-Proofpoint-ORIG-GUID: 1aNiCFYk_OTQ-KiXfbYWMPbq02RgVaDl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:21:43PM +0000, Charles Keepax wrote:
> On Wed, Apr 27, 2022 at 08:51:02AM +0200, Krzysztof Kozlowski wrote:
> > The Wolfson Microelectronics Arizona audio can be connected via SPI bus
> > (e.g. WM5110 on Exynos5433 TM2 board), so allow spi-max-frequency
> > property.
> > 
> > Reported-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> 
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 

Apologies but looking at this again I can't quite see why this is
necessary. The Arizona schema should allow properties that arn't
specified. Do you have an example of what failed to warrant this?

Thanks,
Charles
