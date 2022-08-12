Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC4591215
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiHLOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiHLOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:20:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3DBA9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660314017; x=1691850017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2cuTw/jbmlAeUfKTHT4pJ9M/UB15yaoen1sDJ7TWZWM=;
  b=duJHUaLT7xxVWpH78q3iSIb5cLAFov3OyQfjWwmpXzIa0aHzw9HjXNpM
   eI14mpXaZDWOvHaCHePjUDo12/QLf69TclWbfc1jMoiUkK+dymMHyJwT2
   7etsBgUo9sTJ+dD4taXzzwJVCSDERvSCJJFL4Myfl6Ak7A1YReexVbd1i
   +nQd7vrcbRU0ubRwgCcrGbSl7g9VB/dsNnzGOZKftW+FUXTWErVBH618c
   /GcGoQdaeSAHovnDcE3cxKmRvAcgj31J/RuIjB5gP9r49hHQ6aMtirmk4
   wJn7CUMxUfHXZ+dOQCqgXVI6S7Dse2t7VuZ+Po8L3H7AL7wVdM9eniPWZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278554070"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278554070"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:20:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634655949"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.73]) ([10.99.241.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:20:14 -0700
Message-ID: <0cf33957-83aa-5baf-735e-835ab3db9956@linux.intel.com>
Date:   Fri, 12 Aug 2022 16:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/13] ASoC: amd: add acp6.2 pdm platform driver
Content-Language: en-US
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-6-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220812120731.788052-6-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
> PDM platform driver binds to the platform device created by
> ACP6.2 PCI device. PDM driver registers ALSA DMA and CPU DAI
> components with ASoC framework.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---

...

> +
> +module_platform_driver(acp62_pdm_dma_driver);
> +
> +MODULE_AUTHOR("Syed.SabaKareem@amd.com");
> +MODULE_DESCRIPTION("AMD PHEONIX PDM Driver");

phoenix is usually written with "oe", so just making sure if above is 
not a typo?

> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);

