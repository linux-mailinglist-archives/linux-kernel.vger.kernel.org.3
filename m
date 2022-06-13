Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1273B548415
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiFMJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbiFMJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C851928C;
        Mon, 13 Jun 2022 02:48:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D7bRpY017595;
        Mon, 13 Jun 2022 04:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=CRTviHcnTGYQGc17bUWtHNOWPL7Dy+tsuuEXIupdrr4=;
 b=AB1boW9dAs+Yf9LKm3cYDlA9u3I06+BGsMJFLbKaexcHZujzQyhBBE0tsMWZHWJ5/pk2
 Yyag1HGoBElpx5OnHF30JfOUa9g36GGrRtvJf8H1/Q9BY+yz/u9t+aL9XqxYrei5xnOs
 giKpcS9xQ70DzbDl2kRUxUopnvLFhKniuHn4fsycKcT7PipsEbs4vt1wJJx5iiSv9F0l
 nyIFrdF/LwwXcQTKm7V6Uzs8RHe+wlqHdVRKEyziQ/2tfUXJHhHmO02NGjhNqwYPGa25
 Q3TAabCTfGg/TVXobLSQVDwCqtFmMjvQA9oYzM0olaJ+nAbQHd7SjQvCcZr2zAy3HGn+ yg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gmrf31psy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jun 2022 04:47:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 10:47:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 13 Jun 2022 10:47:51 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7915B46C;
        Mon, 13 Jun 2022 09:47:51 +0000 (UTC)
Date:   Mon, 13 Jun 2022 09:47:51 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/23] ASoC: wm8731: update wlf,wm8731.yaml reference
Message-ID: <20220613094751.GZ38351@ediswmail.ad.cirrus.com>
References: <cover.1654529011.git.mchehab@kernel.org>
 <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: xy_jBaiF63BsDcKqeMRnyVUazqatw_C5
X-Proofpoint-ORIG-GUID: xy_jBaiF63BsDcKqeMRnyVUazqatw_C5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:25:44PM +0100, Mauro Carvalho Chehab wrote:
> Changeset 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
> renamed: Documentation/devicetree/bindings/sound/wm8731.txt
> to: Documentation/devicetree/bindings/sound/wlf,wm8731.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
