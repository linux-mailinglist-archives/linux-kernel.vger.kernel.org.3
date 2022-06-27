Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012E55E252
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiF0NIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiF0NIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:08:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC1101F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:08:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RCMpjp014019;
        Mon, 27 Jun 2022 08:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=GrOloieBaIyDgUypeGB2lfu4ByBgp/A0DVGfWo/Eq/I=;
 b=GQ/6QxyS+UBoWXtUPLJTiYqBz5qRBN93NiXxGZHs4Er2GeEFWAztSgrb/fRouL6ZfgpT
 JREkFSEylM8pjCYB3Io4ernzfXKfUv9/vKJ85rH6TOCSHfT6Ey88KOYPyV3iJ1+HVQyz
 48hvl1uwOqB16bR5PIXsBBDSngCFxvvvIMhiUaiT/dFgaGe8afHskZogDDR/KXuR1Ojf
 wxFk/+XscQmXvGp8p2G76K2gQaT04JdvF2RgOIqvqd2wCma5NDey6YLhlycFcaQGD+0s
 XiqNtTJCF4HKfMJDnxX9tGoUbVnOY3q6URF+V7BqNLoXO3k04Y9u1R9lP5uCUomUL1LH jQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gwxsq2mqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Jun 2022 08:07:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 14:07:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 27 Jun 2022 14:07:49 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0B345B10;
        Mon, 27 Jun 2022 13:07:49 +0000 (UTC)
Date:   Mon, 27 Jun 2022 13:07:49 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Mark Brown <broonie@kernel.org>, <s.nawrocki@samsung.com>,
        <jrdr.linux@gmail.com>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Message-ID: <20220627130749.GH38351@ediswmail.ad.cirrus.com>
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
 <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: M6X0Z1D8p84pbdtMCuK-AEUuWM_Q7r8V
X-Proofpoint-ORIG-GUID: M6X0Z1D8p84pbdtMCuK-AEUuWM_Q7r8V
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
> >>> The conversion of the set_fmt callback to direct clock specification
> >>> included a small typo, correct the affected code.
> > 
> >>> Fixes: 91c49199e6d6 ("ASoC: samsung: Update to use set_fmt_new callback")
> > 
> >> Where is this commit from? It's not in next.
> > 
> > 0b491c7c1b2555ef08285fd49a8567f2f9f34ff8 - if you can't find something
> > search for the subject, people often get things wrong.
> 
> Finding it by subject does not solve problem with Fixes tag, that it
> might be pointing to incorrect commit (e.g. rebased).
> 

Apologies I will resend with the SHA corrected there and sorry
about missing the issue in the first place. I was pretty careful
trying to make sure I built everything but somehow missed this
one.

Thanks,
Charles
