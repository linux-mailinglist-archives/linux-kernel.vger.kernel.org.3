Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF45119E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiD0Ovy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiD0Ovo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:51:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B63CFCC;
        Wed, 27 Apr 2022 07:48:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R5dQms017082;
        Wed, 27 Apr 2022 09:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=vaquiEachYy7Mpe5Ka+lZOH/BZtZThYtXK3LzhM4Uvk=;
 b=j52O/JvmuWNO8wd1FbQeW6m1LAfZ1g8qfyGyu9lSayevqP8Dar1r9eIffYSG8BnPup7M
 XbWGGwdsCGFbNGvI/QbcoCI9ySAvWB0o+JXA8sOgrdcxu8cSG5M9CZvdfx7Q3DEsP6Vw
 sJoi7T1YxBsjOSRtvYuFfIheMDOM/XZUnGhy1biBsk/R2a4OT8rAmA9hzoiNK4rrG8vJ
 COb844Neih6M5aaH6/jPOrh639/TXgysyGzEkFtrlJFdSrX8qiTciA45x0G/0tYy3W5K
 1kI4aSuv94lqmLu1am+veVKnfE7eq8icJ5EefuKxp3Lct+Sm82Dn4FN8Fk2S23xvFITf Qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fprtb0veb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 09:48:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 15:48:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 15:48:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3910611D1;
        Wed, 27 Apr 2022 14:48:25 +0000 (UTC)
Date:   Wed, 27 Apr 2022 14:48:25 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Message-ID: <20220427144825.GD38351@ediswmail.ad.cirrus.com>
References: <20220427065102.109046-1-krzysztof.kozlowski@linaro.org>
 <20220427122143.GB38351@ediswmail.ad.cirrus.com>
 <20220427125801.GC38351@ediswmail.ad.cirrus.com>
 <d43d7e40-40d7-a89e-115f-04a305d7239b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d43d7e40-40d7-a89e-115f-04a305d7239b@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Pcz8kFp6kbKi_3FQmQQTVXNeDN2Yg1ui
X-Proofpoint-GUID: Pcz8kFp6kbKi_3FQmQQTVXNeDN2Yg1ui
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:49:51PM +0200, Krzysztof Kozlowski wrote:
> On 27/04/2022 14:58, Charles Keepax wrote:
> > On Wed, Apr 27, 2022 at 12:21:43PM +0000, Charles Keepax wrote:
> >> On Wed, Apr 27, 2022 at 08:51:02AM +0200, Krzysztof Kozlowski wrote:
> The Arizona schema has unevaluatedProperties: false, which means unknown
> properties will not be accepted. Neither Arizona schema nor other
> referenced schemas define spi-max-frequency, so when the schema is run,
> the property will be unevaluated, thus cause a warning.
> 
> This is visible here at the bottom (with Rob's work-in-progress):
> https://lore.kernel.org/linux-devicetree/345716e9-5624-5ba0-09f0-46e9850c546c@linaro.org/T/#m4b5d7cfdf34dbd410003b2faae4d840113050c51
> 
> Although I think that I did not fix it properly, because I missed
> 'controller-data', so instead this should be fixed with referencing
> spi-peripheral-props like here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.17.y&id=f412fe11c1a9d815565f3918c56f3fd02167c734
> 

Ah yes I forgot the unevaluatedProperties didn't work properly,
sorry was running things on my DTs here with SPI and they were
all passing but of course I don't have Rob's fix to make the
unevaluatedProperties actually work.

Probably yeah include the spi properties yaml is a better
solution as that covers all the properties that might get used.

Thanks,
Charles
