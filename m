Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB757DD25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiGVJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiGVJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:06:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E1E83F39
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:06:23 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M5SHGJ029230;
        Fri, 22 Jul 2022 04:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=fUH/IDEchZ9dPIGJX0NwZHAYP1mAyq3V+B8mNGztKLE=;
 b=RgzJDEj5WdcqKgU6kDfNFDQt6Sc9JLuq1s3B4/1AlTltHfanM5vjWNIq36o3faCI6k8x
 KRUmqMJzG1gTEo68gerNIIDYZgLdGL9+rpxeXNv1QNCU9ECAI64xwgGKvPrqqmDAB1pg
 2jLbWri/ImwOqkn1jcNmA9Mkg62bQu7iDHZbAsQ/497lurs8yWo4Q63u/cynsAAnW/XE
 2dB4t68pBJ39NXr7TQAoezq/vbR9rEAgOYu5yEewBwKWPR52sEoquM1pjuOrrpefUYbn
 X9y3P6aquSc9e/oKGD1DcsY9SWo9mATU7HgQzxv9k7mJtdASO2rV+h02U2cUvOVAZGSJ sQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hdxffbnb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 04:05:34 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 22 Jul
 2022 04:05:32 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Fri, 22 Jul 2022 04:05:32 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CB63D46B;
        Fri, 22 Jul 2022 09:05:32 +0000 (UTC)
Date:   Fri, 22 Jul 2022 09:05:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
Message-ID: <20220722090532.GF92394@ediswmail.ad.cirrus.com>
References: <20220721233227.1459374-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220721233227.1459374-1-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: xPwS9w7hBwax5mWU939OdQEsh3UOH1LT
X-Proofpoint-GUID: xPwS9w7hBwax5mWU939OdQEsh3UOH1LT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 02:32:27AM +0300, Cristian Ciocaltea wrote:
> Unlike most CODEC drivers, the CS35L41 driver did not have the
> non_legacy_dai_naming set, meaning the corresponding DAI has been
> traditionally registered using the legacy naming: spi-VLV1776:0x
> 
> The recent migration to the new legacy DAI naming style has implicitly
> corrected that behavior and DAI gets now registered via the non-legacy
> naming, i.e. cs35l41-pcm.
> 
> The problem is the acp5x platform driver is now broken as it continues
> to refer to the above mentioned codec using the legacy DAI naming in
> function acp5x_cs35l41_hw_params() and, therefore, the related setup
> is not being executed anymore.
> 
> Let's fix that by replacing the obsolete DAI name with the correct one.
> 
> Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")

Although sorry just noticed you might want to double check the SHA
here, I think the upstream one is 129f055a2144.

Thanks,
Charles
