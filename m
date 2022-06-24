Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F45558C10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiFXADI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:03:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EF1A823
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:03:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NNji0v003654;
        Thu, 23 Jun 2022 19:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=gyBBWsc4IRlpSrs5M9bU0WFzV/JSzwtI3Nj8Qod6CvQ=;
 b=TAZ/1dtEk562uWzYSjbbw8sOAVtcJbSQtcFTVHs6ObZMEPW2WlPgRLpLn5k6lI1cXObA
 BgSVLHzInBUR08ZSECJQeuxnPTUuJDUjJ0xV1LnJL35tLkyt85YWefRFyfv7ENhAbL4E
 Sl0P1r+20XF0G+h5tkwh0aFEaF9XCymVrciNQj8LdKh8xpImXzR0pVUVqmPbGEW25m5o
 df15Swzg1lhFqweERBLgu0uWxWxfuxYP4g5526HSCzxSlRKvkSVh7EkdHOsZJqObX2S7
 a+ebp6/dIUjeIelUdlMJegpjwoFh05A42HuTISHZbzNqDoM889lBldOkPOdjXaHUyNPF QQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41g5sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 19:02:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 01:02:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 24 Jun 2022 01:02:00 +0100
Received: from [141.131.206.39] (david-linux.ad.cirrus.com [141.131.206.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25424478;
        Fri, 24 Jun 2022 00:01:58 +0000 (UTC)
Message-ID: <e85bad57-a2b5-1729-858d-19e3a2fa1245@opensource.cirrus.com>
Date:   Thu, 23 Jun 2022 19:01:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: cs35l41: Add support for CLSA3541 ACPI device ID
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <kernel@collabora.com>, <linux-kernel@vger.kernel.org>
References: <20220621213819.262537-1-cristian.ciocaltea@collabora.com>
From:   David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <20220621213819.262537-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hrAdwrV8JaIbucK30ADxJMy_RYtWKerm
X-Proofpoint-ORIG-GUID: hrAdwrV8JaIbucK30ADxJMy_RYtWKerm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 16:38, Cristian Ciocaltea wrote:
> Add support for the CLSA3541 ACPI device ID used on Valve's Steam Deck.
> The driver is fully compatible with the indicated hardware, hence no
> additional changes are required.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

This is the ID for CS35L41 on the Steam Deck, which uses the CS35L41 
ASoC driver and the acp5x machine driver. Cirrus is aware that this is 
not a compliant ID (Cirrus does not own vendor ID CLSA), but similarly 
to the Lenovo devices that use CLSA0100, the ACPI entries were created 
before the driver was upstreamed.

Acked-by: David Rhodes <drhodes@opensource.cirrus.com>

Thanks,
David
