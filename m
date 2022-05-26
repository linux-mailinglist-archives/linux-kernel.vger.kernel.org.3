Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9097534C88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbiEZJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346854AbiEZJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:30:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA74C8BD4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:30:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q57RkV023806;
        Thu, 26 May 2022 04:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=9DDM0LbKfQSEqDIFkf3GZzb8S7Law86ajiZdUKL0XkU=;
 b=FJiMzA14ax0FiPf+dSDqIx7taXmdNRn4XnZ6Ce0RQZ6OzANRl7o0GTCtXKmzVUb/H+1+
 oremJbrI3I0YUXCQ7i9/sMxUeTa0hZ21kWOrupDE+4Awv+3YnwK91lt+jJ043bN1xZ90
 4+qwyYXoeUJ8HLfh/ke1jJLQk7FC38DHffCD9HbS7sNElVxjHPEkNn+1psU4PUFn1KEi
 oIlP/jCWPnlV3JoFkuORhvTxDF/4O/rOEv++5C/ir2SDlRHeCzN1tpQoGs5V+xmwO4gO
 3FbKu/3DmgXhrY2qUS9EFVYEgu/FlEu7owI+30w3/ILUIhe+E6hRZr4Hm1RMme20Fkfb FQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u4j0re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 May 2022 04:30:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 10:30:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 26 May 2022 10:30:01 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9FB8846C;
        Thu, 26 May 2022 09:30:01 +0000 (UTC)
Date:   Thu, 26 May 2022 09:30:01 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v4 01/17] ALSA: hda: hda_cs_dsp_ctl: Add Library to
 support CS_DSP ALSA controls
Message-ID: <20220526093001.GP38351@ediswmail.ad.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <20220525131638.5512-2-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220525131638.5512-2-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 8M0CM57Ixi5VEf7HnAbkmInPiHTY1NYg
X-Proofpoint-GUID: 8M0CM57Ixi5VEf7HnAbkmInPiHTY1NYg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:16:22PM +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> The cs35l41 part contains a DSP which is able to run firmware.
> The cs_dsp library can be used to control the DSP.
> These controls can be exposed to userspace using ALSA controls.
> This library adds apis to be able to interface between
> cs_dsp and hda drivers and expose the relevant controls as
> ALSA controls.
> 
> The apis to add and remove the controls start new threads when
> adding/removing controls since it is possible that setting an ALSA
> control would end up calling this api, which would then deadlock.
> 
> In the future, it will be necessary to load/unload firmware (and
> firmware ALSA controls) using a separate ALSA control, which means
> that the ability to call these apis from another ALSA control is
> required.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>  
> Changes since v2:
>  - Updated commit message to describe reasons
>    for adding/removing controls asynchronously
>  - Removed unnecessary code which handled unused
>    tlv or acked controls.
>  - Removed code which handled outdate firmware
>    versions when adding controls
>  
> +static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
> +{
> +	unsigned int out, rd, wr, vol;
> +
> +	if (len > ADSP_MAX_STD_CTRL_SIZE) {
> +		rd = SNDRV_CTL_ELEM_ACCESS_TLV_READ;
> +		wr = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE;
> +		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
> +
> +		out = SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
> +	} else {
> +		rd = SNDRV_CTL_ELEM_ACCESS_READ;
> +		wr = SNDRV_CTL_ELEM_ACCESS_WRITE;
> +		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
> +
> +		out = 0;
> +	}

This if should be changed if we are no longer supporting the TLV
controls, you want to report an error if we exceed the max
control size not switch to the TLV access flags.

> +static void hda_cs_dsp_ctl_add_work(struct work_struct *work)
> +{
> +	struct hda_cs_dsp_coeff_ctl *ctl = container_of(work,
> +							struct hda_cs_dsp_coeff_ctl,
> +							add_work);
> +	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
> +	struct snd_kcontrol_new *kcontrol;
> +
> +	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
> +	if (!kcontrol)
> +		return;
> +
> +	kcontrol->name = ctl->name;
> +	kcontrol->info = hda_cs_dsp_coeff_info;
> +	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> +	kcontrol->tlv.c = snd_soc_bytes_tlv_callback;
> +	kcontrol->private_value = (unsigned long)&ctl->bytes_ext;

Don't need to set tlv.c or the private_value for bytes_ext if we
are not using TLVs.

> +struct hda_cs_dsp_ctl_info {
> +	struct snd_card *card;
> +	enum hda_cs_dsp_fw_id fw_type;
> +	const char *amp_name;

Might be better to call this something slightly more generic than
amp_name. Just incase this stuff gets used with a CODEC or
something in the future.

Thanks,
Charles
