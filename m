Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5F57CBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGUNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiGUNUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:20:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38723163
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:20:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LBc3LT005144;
        Thu, 21 Jul 2022 08:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Sk2v+4C0j9sxQiOuU4jhIsVMoQvIwBpR9MTlFn7X9aY=;
 b=FZT7UNlR077kT3PPoj0hi2TM4hTJz6gPWZX+TVR22HA6g1IxvrQJ3H8+9tzbxxcUm0VF
 +BRe2AYSuZxslom7Te+3zdbPFX7Ib/9PD+zdv/1NNTlMg3L67/7i6IYojKtND+5iScA1
 X8jdzkbYRLmWCCZ2MQ0vAjb1jKYaeEiEJoS0HsizJQhyTFJgpiCUYpKLg+7aNGE4Td7O
 pJ8qU9gp9g/UL56IUdn2pgW5bsPL7QJFzZjOvHlT2Po+eSnKZ8HBb6mZGGvEHkL3xM4J
 OgmiL5cceoiRo6Mu+VG1idHgPwjhi9QN6Gg6OIAUtZXCyRElsHJCRhNAEKAGZzpUJnhW qA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hdrqfk38e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 08:19:30 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 21 Jul
 2022 08:19:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Thu, 21 Jul 2022 08:19:28 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7740AB06;
        Thu, 21 Jul 2022 13:19:28 +0000 (UTC)
Date:   Thu, 21 Jul 2022 13:19:28 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <kernel@collabora.com>
Subject: Re: [PATCH] ASoC: cs35l41: Set the new legacy DAI naming flag
Message-ID: <20220721131928.GD92394@ediswmail.ad.cirrus.com>
References: <20220721121454.1378945-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220721121454.1378945-1-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: PmvaTdVQy3GeoVh_5BEv1IAUx1skmKXh
X-Proofpoint-GUID: PmvaTdVQy3GeoVh_5BEv1IAUx1skmKXh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:14:54PM +0300, Cristian Ciocaltea wrote:
> Unlike most CODEC drivers, the CS35L41 driver did not have the
> non_legacy_dai_naming set, meaning it uses the legacy naming.
> 
> The recent migration to the new legacy DAI naming style has broken
> driver functionality because it is now expected to set the new legacy
> DAI naming flag in order to instruct the core subsystem to use the
> legacy name format on DAI registration.
> 
> Let's fix this by setting the legacy_dai_naming flag accordingly.
> 
> Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

It is really not intended for any CODECs to be using the legacy
DAI naming, it was only intended for platform side components.
Would be good if you had some details on the affected system and
if that could be updated to use the non legacy DAI naming?

Thanks,
Charles
