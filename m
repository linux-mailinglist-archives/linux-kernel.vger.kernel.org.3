Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47B485085
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiAEJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:59:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53610 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232437AbiAEJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:59:30 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2058aLLs003317;
        Wed, 5 Jan 2022 03:58:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=MO2PSHj23wq8N+iVx3WZD17yLglCV3U38GihkcUa5JM=;
 b=hqSwsX9BwItRgwBU2nN+Ky5xxicAB+9sdIKfnsVe6wSEgUbaQEZaINAQZo+AlyRzKLxm
 Hdx8hRyS9uBv3NuiFssQ9vxMfgztWxRI/ZqlFbMNst7xUeb5JVBiE1m+Gj6mYTLGsufT
 zAlfysFSYqcY/JqHxLQAoGg8Rny2sRmqbChHW9r1te1+acwutJVtk4BGmfGg6m6sCGa2
 xukKQTS4C+7lWz1wPwWFbNfpVnui64B3pap/bpzlUoa30LVaQiXswxQSFJORFNpx0ZsI
 4AoGxsIdPTIxnbDdg3nw5Zob7tB1hFSg2EsgbeuKOqPbPCglYynK/7sfYsKMRFgglDBf Dg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dd7y3g262-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jan 2022 03:58:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 09:58:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 5 Jan 2022 09:58:34 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 33897B0E;
        Wed,  5 Jan 2022 09:58:34 +0000 (UTC)
Date:   Wed, 5 Jan 2022 09:58:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/10] hda: cs35l41: Add support for CS35L41 in HDA
 systems
Message-ID: <20220105095834.GD18506@ediswmail.ad.cirrus.com>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-8-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217115708.882525-8-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: mQd4XZ9zG4wN_6-fzPf2Ov9s2DYnPmTR
X-Proofpoint-ORIG-GUID: mQd4XZ9zG4wN_6-fzPf2Ov9s2DYnPmTR
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:57:05AM +0000, Lucas Tanure wrote:
> Add support for CS35L41 using a new separated driver
> that can be used in all upcoming designs
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
> +	mtl_revid = reg_revid & CS35L41_MTLREVID_MASK;
> +
> +	chipid = (mtl_revid % 2) ? CS35L41R_CHIP_ID : CS35L41_CHIP_ID;
> +	if (regid != chipid) {
> +		dev_err(cs35l41->dev, "CS35L41 Device ID (%X). Expected ID %X\n", regid, chipid);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	ret = cs35l41_register_errata_patch(cs35l41->dev, cs35l41->regmap, reg_revid);
> +	if (ret)
> +		goto err;
> +
> +	ret = cs35l41_otp_unpack(cs35l41->dev, cs35l41->regmap);
> +	if (ret) {
> +		dev_err(cs35l41->dev, "OTP Unpack failed: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = cs35l41_hda_apply_properties(cs35l41, acpi_hw_cfg);
> +	if (ret)
> +		goto err;
> +	kfree(acpi_hw_cfg);
> +
> +	if (cs35l41->reg_seq->probe) {
> +		ret = regmap_register_patch(cs35l41->regmap, cs35l41->reg_seq->probe,
> +					    cs35l41->reg_seq->num_probe);
> +		if (ret) {
> +			dev_err(cs35l41->dev, "Fail to apply probe reg patch: %d\n", ret);
> +			goto err;
> +		}
> +	}

Probably shouldn't use regmap_register_patch here,
cs35l41_register_errata_patch has already registered a patch to
the regmap, and this will then overwrite that patch. Probably
better to do this stuff as a multi-write.

Thanks,
Charles
