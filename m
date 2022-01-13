Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365E48DDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiAMSki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:40:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:1868 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbiAMSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642099236; x=1673635236;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qqcMZ1IZfmNOmWmFj956qQSZ+kRWR/NKW/CT4jJutuk=;
  b=hi6QnFa8+T5GnyqHTE/8K4JZI9+B2bn68bEMbrhYOrEBD+0Ujudist8X
   pzCzFBYhbr2DE0WTB9giPCKbRxwgBsmPq+9aC1OHhHQmhm1VMCBaDntLO
   iYXmAaYBODkDgOwei+eGFhrO7nf+aRB0I+SKbsApg7JfjVpeFjhhrqDYl
   Qqrple8qi3FUvh16wbZ5ynr3NcCZjUNapUw5vUHOkMm5QRvlD0DY6vpmD
   WfNrvKzid0HN/n0Fw/eL7ozJxCxV2Lo9++MS24luUujsAJI6mb0jOeqOH
   OCh0D37lDA0A0n6QeLbpG8r2+skvIdRpm6T5ZGZ5njDIfH7N0QcaZFd0T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307431633"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307431633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:40:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="620700515"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70]) ([10.212.66.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:40:34 -0800
Subject: Re: [PATCH v3 1/1] firmware: mediatek: add adsp ipc protocol
 interface
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        cujomalainey@google.com, Kevin Hilman <khilman@baylibre.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20220113082234.29013-1-allen-kh.cheng@mediatek.com>
 <20220113082234.29013-2-allen-kh.cheng@mediatek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <32e116f5-7b71-2fe0-ad43-3fbc71a651a5@linux.intel.com>
Date:   Thu, 13 Jan 2022 12:40:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113082234.29013-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/22 2:22 AM, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Some of mediatek processors contain
> the Tensilica HiFix DSP for audio processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> We use two mbox channels to implement a request-reply protocol.
> 
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

