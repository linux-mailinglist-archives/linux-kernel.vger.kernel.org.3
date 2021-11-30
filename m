Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1E463C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbhK3QxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:53:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:9781 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244424AbhK3Qwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:52:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="297061726"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="297061726"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:49:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="601572330"
Received: from vschult-mobl1.amr.corp.intel.com (HELO [10.212.122.173]) ([10.212.122.173])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:49:33 -0800
Subject: Re: [PATCH 07/21] ASoC: amd: Add module to determine ACP
 configuration
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     daniel.baluta@gmail.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        AjitKumar.Pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Julian.Schroeder@amd.com, Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, Balakishore.pati@amd.com,
        yc.hung@mediatek.com, vishnuvardhanrao.ravulapati@amd.com,
        vsreddy@amd.com, daniel.baluta@nxp.com,
        Bard Liao <bard.liao@intel.com>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-8-daniel.baluta@oss.nxp.com>
 <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bdbea252-09e4-eb60-acf8-4ea8a1d924c4@linux.intel.com>
Date:   Tue, 30 Nov 2021 10:49:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> --- a/sound/soc/amd/Kconfig
>> +++ b/sound/soc/amd/Kconfig
>> @@ -96,4 +96,10 @@ config SND_SOC_AMD_YC_MACH
>>           Say m if you have such a device.
>>           If unsure select "N".
>>
>> +config SND_AMD_ACP_CONFIG
>> +       tristate "AMD ACP configuration selection"
> 
> This definitely needs proper dependencies, to prevent asking the user
> about this when configuring a kernel without AMD Audio ACP support.
> 
> I would have sent a patch, but...

There's indeed a missing dependency that was fixed in
https://github.com/thesofproject/linux/pull/3284

Daniel, you may want to squash it in an update?

To Geert's point, there may be an additional need to add a

depends on SND_SOC_AMD_ACP

There are also a set of

SND_SOC_AMD_ACPyx options, not sure if any applies as a dependency here?


