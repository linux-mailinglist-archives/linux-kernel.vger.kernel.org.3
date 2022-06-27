Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD255CB59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiF0NRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiF0NRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:17:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2263B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:16:37 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RBx6KT005329;
        Mon, 27 Jun 2022 08:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+Ktnk5f65Jy5OZte53NBOIGEjEqKx/iC8LlAlqmjVY8=;
 b=mpCmOZDGOiMQUxQQDR13vj7pi5Swt2piZoVt4mfp1TbereQr7C8a0d2nh3sfq9fCzhpk
 EXP3WTmoJp+dHO/pYJCmG0MefwjgZYbgugQ5tPLqpEtPAxlF7XyqAtR81qfoScqYueik
 Q2Vh3vCC4/sqcGUq5RogvIl3azmSSvOrQqkIt0nQPOBvaqJBXUwtZrkJZNgyYd9jCGKQ
 5y4rVexJWQlGXL1VBjQX9SROB2twYUGcItczPSHpHwrMVJYIkdxhmz2oAE0XUdmQoLJV
 B6500x6G43cioPVqCTY4/RTEBT5+SsOnqpPjH6ktsxaIVwsRzt8Fl2o6UukdgEkCmlrG Tg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gwxsq2n4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Jun 2022 08:16:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 14:16:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 27 Jun 2022 14:16:28 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E139211D1;
        Mon, 27 Jun 2022 13:16:27 +0000 (UTC)
Date:   Mon, 27 Jun 2022 13:16:27 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Mark Brown <broonie@kernel.org>, <s.nawrocki@samsung.com>,
        <jrdr.linux@gmail.com>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Message-ID: <20220627131627.GI38351@ediswmail.ad.cirrus.com>
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
 <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: N3G3SsD-QENDmQF7ckTvBwVESW7xbwyM
X-Proofpoint-ORIG-GUID: N3G3SsD-QENDmQF7ckTvBwVESW7xbwyM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:11:13PM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2022 13:45, Mark Brown wrote:
> > On Mon, Jun 27, 2022 at 11:49:46AM +0200, Krzysztof Kozlowski wrote:
> >> On 27/06/2022 11:43, Charles Keepax wrote:
> My comment was not a requirement (procedural blocker) but a suggestion,
> because maybe Charles was not aware that developer trees can be tested
> for free.
> 

Would be awesome if I could run things through the build bot
before sending them up. Are there any docs anywhere on how to get
a tree added to that?

Thanks,
Charles
