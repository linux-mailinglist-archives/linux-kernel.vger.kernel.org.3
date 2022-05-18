Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB1452BE64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiEROki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbiEROk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:40:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E8E1D3D07
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652884823; x=1684420823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q20Z/BBS35WkC9iaGshSAyrghNxrcU17os220vjkvmI=;
  b=Wn0v0DF0phXOzo33U0onHFAJaJGSxerlNcSYwhqrApHFfKIkq6q7vpR3
   f2fQt/CtzvV3ijqOEoacc6kq2uBSmbS1L9g2yYkHyWlW+Rv0KIKr7glMF
   I1ahW75sQWNDaneaUT35O1oTW1PmXW8/EdMBu4pmDCAsE2uC/3kYqGaZh
   943J6vbwU/Hm1QTqMUAWh7yMgIHjQP7n/EkKZkrlrV6OdvyQW7MM2dmbX
   Sz+xK+QF6Jvkp7rL2orqRQDSU9kwtEdwYcdQcmRF/Zix5zP2lnsjyBPgJ
   Y60rMEM0IQjW8xXxVtnNL3ZCHpb97Qj5uiYaM3iSrcTQaMD4/EtIomceg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253748018"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="253748018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:37:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="597832130"
Received: from jbai2-mobl1.amr.corp.intel.com (HELO [10.209.83.114]) ([10.209.83.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:37:49 -0700
Message-ID: <728c697b-0df7-3d95-10cb-ce0111f0017b@linux.intel.com>
Date:   Wed, 18 May 2022 08:32:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [v7] FROMLIST: ASoC: Intel: sof_cs42l42: adding support for ADL
 configuration and BT offload audio
Content-Language: en-US
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, brent.lu@intel.com, cujomalainey@chromium.org,
        seanpaul@chromium.org, casey.g.bowman@intel.com,
        mark_hsieh@wistron.corp-partner.google.com,
        vamshi.krishna.gopal@intel.com, mac.chiang@intel.com,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20220518033200.1471841-1-terry_chen@wistron.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220518033200.1471841-1-terry_chen@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +	{
> +		.id = "10134242",
> +		.drv_name = "adl_mx98360a_cs4242",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &adl_max98360a_amp,
> +		.sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",
> +	},

To repeat myself, there is no precedent for using a topology file name
that refers to a codec from a different vendor used on a different
platform.

It may work but it's confusing and not maintainable. I don't want to
start a trend where confusion becomes the norm.

In previous contributions, platforms with Cirrus Logic chips used a
non-ambiguous filename, please follow this example:

	{
		.id = "CSC3541",
		.drv_name = "adl_cs35l41",
		.sof_tplg_filename = "sof-adl-cs35l41.tplg",
	},

and use

.sof_tplg_filename = "sof-adl-max98360a-cs42l42.tplg",



