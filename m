Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09BE48DDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiAMSi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:38:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:35394 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237587AbiAMSit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642099129; x=1673635129;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Gi4RruhGOfgPLhHsmifWsDVbzVX7ucpNyu1gYBrO4CE=;
  b=RPK7QQjVQwt1SdUVKSy40G+01e+Q7qhqlZod2xyGBfUn+uycKxJ8W5u7
   ybwc/24mH6j3xk0pwNYcQLOa+JZxnP51TV3t/SyDhVZd6NuPDdM0rcYLW
   vzo+ObM1Bchb6LId9owPAWCCEPre+x1qhRDU7qAek6+l2mLoDZSAlG8Ge
   1ZV+4Yx0WtEQHCRy0NPyA7o5ptAS/HC/wV7GQ9sTEL9mL6K9QcnAdghlj
   k5WtuD+wq/zXPtawiWXGTbryJu7SjzHirmTFsFdC/2rnRLr2+creCLyd1
   mYsbV5wBE9BIH+NVULVy9VRSd5pgekSbM6mAvZMSq2QlZXHBMw2t/YiWj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244290422"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244290422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:38:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="620699922"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70]) ([10.212.66.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:38:45 -0800
Subject: Re: [PATCH v2 3/6] ASoC: amd: acp: Add generic PCI driver module for
 ACP device
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
 <20220113163348.434108-4-AjitKumar.Pandey@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fad0f35c-0641-ee43-1efc-d6e5c8c44656@linux.intel.com>
Date:   Thu, 13 Jan 2022 12:36:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113163348.434108-4-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
> new file mode 100644
> index 000000000000..3a0511fd1de2
> --- /dev/null
> +++ b/sound/soc/amd/acp/acp-pci.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +//
> +// This file is provided under a dual BSD/GPLv2 license. When using or
> +// redistributing this file, you may do so under either license.
> +//
> +// Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.

2022?


