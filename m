Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA55A6BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiH3SKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiH3SKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:10:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D94BA2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=EpEl/DobhYcf1wL8+3jtYw7OG3wsK8lDs0hnWxAIwFI=; b=W88hsrHUWhMA6NG8LTU8d1pbxs
        +hNb4LUdFnMg9k2YxNI+RTvkRN4NddihmoSbATU6UyeI2TDM6IDP+8c7FhM20V7JBQjmU5ir8dKZb
        iztuhnFizxfFSGM6ONqL//pFt4oSTT0An9GyAFBYHWuymJOjYlEBFK2d6JM7qPuC6NRrkLQGfTyha
        yLAMX8TlAJVPcepZOreZvGaD6a7XZAgNMhdiCZ6I0AlawCse4kbhjwICtgnjkBpN63jXPT07vYap6
        cKMZ9FGN55oxDppqpCD8TU0wumlFgKrdn90TzbcpV2yiVbX+yxIx/PAgAeRVKlIjjRUN0lGS+Y2yL
        kec4tEEg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oT5gj-0017CY-8C; Tue, 30 Aug 2022 18:10:13 +0000
Message-ID: <dd45cdec-ee8c-b699-2e23-064a866caa04@infradead.org>
Date:   Tue, 30 Aug 2022 11:10:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ASoC: amd: fix spelling mistake: "i.e" -> "i.e."
Content-Language: en-US
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Julian Braha <julianbraha@gmail.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830132259.7759-1-Syed.SabaKareem@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220830132259.7759-1-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/22 06:22, Syed Saba Kareem wrote:
> From: Syed Saba kareem <Syed.SabaKareem@amd.com>
> 
> trivial fix to spelling mistake in Kconfig File.
> 
> Reported by : Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  sound/soc/amd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index 68837d42736d..150786279257 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -122,7 +122,7 @@ config SND_SOC_AMD_RPL_ACP6x
>          tristate "AMD Audio Coprocessor-v6.2 RPL support"
>          depends on X86 && PCI
>          help
> -          This option enables Audio Coprocessor i.e ACP v6.2 support on
> +          This option enables Audio Coprocessor i.e. ACP v6.2 support on
>            AMD RPL platform. By enabling this flag build will be
>            triggered for ACP PCI driver.
>            Say m if you have such a device.

-- 
~Randy
