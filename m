Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC64FF17E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiDMINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiDMINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:13:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634533E1C;
        Wed, 13 Apr 2022 01:11:15 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23D6IFDP015619;
        Wed, 13 Apr 2022 03:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=O4GoFNVVTf47ppwTSm5vJVuvbs0wXiJG5IAnDR+VmCs=;
 b=Ph4a58+G3WJ1IkQhNki3uX/KrDbxtqzTepvtCPDC0XrTv7mk7b09s/x0kB+6jyfHQU+X
 k//aDLP5QmplUyv+MNG7tftHGCtNWUWUqB6oBhrsUnNfe0UQ5q8c58ttyu6e0glGp/0h
 LqE0P235t+R7OzTKThr8TbD3ExB0p5z/rfWlRrU6wGjgp7FcP2zNMAM9CE52OgU87aHu
 x5ewIUataEhPcZfpRvyxXU2Bg7bx4zh5IEFisDdfN8YhTyLrmISH+yeTghvMrDN0M4wt
 G2HJx7HS1n0gOoB6Yvhpcy0G7k/WvJ7JsrDgRVS1G5VZxs/Jg8jVL0W/qaGuISfsFend 3w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fb7hymvex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 03:10:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 09:10:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 13 Apr 2022 09:10:17 +0100
Received: from [198.61.64.152] (unknown [198.61.64.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2826E475;
        Wed, 13 Apr 2022 08:10:17 +0000 (UTC)
Message-ID: <f3926070-34e0-4004-22cb-99f26aec34f4@opensource.cirrus.com>
Date:   Wed, 13 Apr 2022 09:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   <tanureal@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/16] Support external boost at CS35l41 ASoC driver
References: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
 <s5h1qy18lpg.wl-tiwai@suse.de>
In-Reply-To: <s5h1qy18lpg.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZGKUxCH8Q4Lm2O9JyzL89XjML9VP9zNY
X-Proofpoint-ORIG-GUID: ZGKUxCH8Q4Lm2O9JyzL89XjML9VP9zNY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 8:51 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 09 Apr 2022 11:12:59 +0200,
> Lucas Tanure wrote:
> >
> > Move the support for CS35L41 external boost to its shared library
> > for ASoC use.
> > This move resulted in cs35l41_hda_reg_sequence being removed,
> > and its steps were broken down into regmap writes or functions
> > from the library. And hardware configuration struct was unified
> > for its use in the shared lib.
> > While at it, some minor bugs were found and fixed it.
> 
> The patch series seem inapplicable via git am.
> Could you check the setup of your mailer?
> 
> 
> thanks,
> 
> Takashi
> 
Hi,
Could you explain how you apply this series? So I can reproduce it and see what's going on.
To apply a series of patches I usually:

1 - Find the patch series on https://patchwork.kernel.org/
2 - Click the series button on the right top corner, which will give me the single patch file with all series changes
3 - git am ~/Downloads/Support-external-boost-at-CS35l41-ASoC-driver.patch

And that works fine for me here.

Thanks
Lucas
