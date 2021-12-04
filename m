Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D005A468189
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354625AbhLDAtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:49:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:38270 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354612AbhLDAtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:49:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217769148"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="217769148"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 16:45:40 -0800
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="461097723"
Received: from hkagda-mobl2.amr.corp.intel.com (HELO [10.212.71.79]) ([10.212.71.79])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 16:45:38 -0800
Subject: Re: [Sound-open-firmware] linux-next: Tree for Dec 3
 (sound/soc/sof/intel/hda-codec.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Hui Wang <hui.wang@canonical.com>
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
References: <20211203194709.3bcfb3a7@canb.auug.org.au>
 <66206234-d0b9-da64-c75d-4ea73dda5ff9@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e2fb7287-cb60-319c-33b2-8c49b755107c@linux.intel.com>
Date:   Fri, 3 Dec 2021 18:45:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <66206234-d0b9-da64-c75d-4ea73dda5ff9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/21 6:34 PM, Randy Dunlap wrote:
> 
> 
> On 12/3/21 00:47, Stephen Rothwell wrote:
>> Hi all,
>>
>> News: I will (probably) do no linux-next releases between Dec 9 and Dec
>> 19, inclusive (i.e. that means 3 releases next week and none the week
>> after).
>>
>> Changes since 20211202:
>>
> 
> on i386:
> # CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC is not set
> 
> ../sound/soc/sof/intel/hda-codec.c: In function ‘hda_codec_probe’:
> ../sound/soc/sof/intel/hda-codec.c:132:35: error: ‘CODEC_PROBE_RETRIES’ undeclared (first use in this function); did you mean ‘DEV_PROP_STRING’?
>   } while (resp == -1 && retry++ < CODEC_PROBE_RETRIES);
>                                    ^~~~~~~~~~~~~~~~~~~
> 
> 
> Full randconfig file is attached.

Thanks Randy, Kai provided a fix already, see "ASoC: SOF: Intel: fix
build issue related to CODEC_PROBE_ENTRIES" on alsa-devel.

