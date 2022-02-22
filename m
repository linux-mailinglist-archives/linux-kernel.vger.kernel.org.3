Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA04BF385
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiBVIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBVIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:24:16 -0500
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 00:23:50 PST
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55597111DFD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:23:50 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 525C5A0040;
        Tue, 22 Feb 2022 09:15:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 525C5A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1645517734; bh=sSCPoD/RQHN+SwDKJfGd09BCH/QOzkFeSK7690X41mU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mb3GVzjRlYWtpTwmSQO0FB2KpUBf5GGwYhgajw10onla6aHBl4LOZ0NfgJNLlr2T1
         Gj58DMJ9i+XEYIjwH5KKj3l+12mmCTGKIiVcQfk5knQnbjb1BGQlLTW8mjhlbkcgid
         hVOWY2iEFOWwerYNQPGVdGZr+haXxwsC9+1SRbyQ=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 22 Feb 2022 09:15:23 +0100 (CET)
Message-ID: <4bfa587f-3605-646c-8662-40c561beecc0@perex.cz>
Date:   Tue, 22 Feb 2022 09:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] ASoC: amd: acp: Change card name for Guybrush Machine
Content-Language: en-US
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220222061128.719400-1-AjitKumar.Pandey@amd.com>
 <20220222061128.719400-2-AjitKumar.Pandey@amd.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220222061128.719400-2-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 22 7:11, Ajit Kumar Pandey wrote:
> Change sound card name for guybrush machine with rt5682 as primary
> codec and rt1019 amp to align with names given in UCM config.

It's a Chrome OS UCM config? I don't have this config in upstream.

> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> ---
>   sound/soc/amd/acp/acp-legacy-mach.c | 4 ++--
>   sound/soc/amd/acp/acp-renoir.c      | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
> index 91140d15691b..50a5aa4d6da9 100644
> --- a/sound/soc/amd/acp/acp-legacy-mach.c
> +++ b/sound/soc/amd/acp/acp-legacy-mach.c
> @@ -96,7 +96,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
>   
>   static const struct platform_device_id board_ids[] = {
>   	{
> -		.name = "rn_rt5682_rt1019",
> +		.name = "acp3xalc56821019",
>   		.driver_data = (kernel_ulong_t)&rt5682_rt1019_data,
>   	},
>   	{ }
> @@ -113,5 +113,5 @@ module_platform_driver(acp_asoc_audio);
>   
>   MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
>   MODULE_DESCRIPTION("ACP chrome audio support");
> -MODULE_ALIAS("platform:rn_rt5682_rt1019");
> +MODULE_ALIAS("platform:acp3xalc56821019");
>   MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
> index d06ad5ce7fec..b8dc25a1d31d 100644
> --- a/sound/soc/amd/acp/acp-renoir.c
> +++ b/sound/soc/amd/acp/acp-renoir.c
> @@ -47,7 +47,7 @@ static struct snd_soc_acpi_codecs amp_rt1019 = {
>   static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
>   	{
>   		.id = "10EC5682",
> -		.drv_name = "rn_rt5682_rt1019",
> +		.drv_name = "acp3xalc56821019",

I find this naming cryptic. Also, we have other ways to identify the exact 
driver / hardware configuration. It may make sense to have one driver name 
(like amd-acp3x) and use the sound card components to refine the hardware 
configuration for the user space. Your way will introduce a lot of new drivers.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
