Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06357CEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiGUP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGUP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:28:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E67A51E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658417295; x=1689953295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WZ59twi+Y234fwpfoBS9XgGliCsgnLhK4MhvmcDYmj0=;
  b=leyOaD1LzkO3+Vbyv3JwSQQerckDYs14zCNhJsGBjqY37IErHh1cADgZ
   Jvo6n3tq/2ZeSC6wtCybo6ODC8tTZ/S3q3ujJUN3hAEc4xHq0M+0uQ+0q
   OTwijBp47oa0KV7fIgO7CmNE4OthJux2hfMxSsoIzi9i+1JlMwaAJwzLJ
   RZl5OS/7VyFcEuPUFUnWZ//y5xgJgptGnI1lm1Nw4E2TeJdbY1pwDxrZs
   63tUj7zk6iWhNhDyIGx1ECOTL8WdCd9rbVnRkj5xISij7K/zkgTV2ov5M
   4jiM0otWJ6FL0rkPi3oZ+GJu2WycePJnAlcs5XKn9UsiXwjKfLTGsEkLV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="312794154"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="312794154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:28:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="656794382"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.149]) ([10.99.249.149])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:28:11 -0700
Message-ID: <d8e8e5e5-001d-5f22-b22c-aaea16ed8719@linux.intel.com>
Date:   Thu, 21 Jul 2022 17:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: avs: Mark avs_path_module_type_create() as
 noinline
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, patches@lists.linux.dev,
        alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220720185228.3182663-1-nathan@kernel.org>
 <c00a8b5e-6def-971a-d4f2-cd65c95fe430@linux.intel.com>
 <YtllwRY6F93uYRxz@sirena.org.uk>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <YtllwRY6F93uYRxz@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2022 4:42 PM, Mark Brown wrote:
> On Thu, Jul 21, 2022 at 02:25:20PM +0200, Amadeusz Sławiński wrote:
>> On 7/20/2022 8:52 PM, Nathan Chancellor wrote:
> 
>>> This warning is also visible with allmodconfig on other architectures.
> 
>> My first question would be what clang does differently in this configuration
>> (ARM) than in all other configurations (x86, etc.) and gcc.
> 
> See above from Nathan's commit message...

Ah, missed that. Anyway, what about if we replace multiple calls to 
guid_equal with lookup table and one call in loop?

Do let me know if something like the following works and I will send it 
as a proper patch:

diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index 3d46dd5e5bc4..ce157a8d6552 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -449,35 +449,39 @@ static int avs_modext_create(struct avs_dev *adev, 
struct avs_path_module *mod)
         return ret;
  }

+static int avs_probe_create(struct avs_dev *adev, struct 
avs_path_module *mod)
+{
+       dev_err(adev->dev, "Probe module can't be instantiated by 
topology");
+       return -EINVAL;
+}
+
+struct avs_module_create {
+       guid_t *guid;
+       int (*create)(struct avs_dev *adev, struct avs_path_module *mod);
+};
+
+static struct avs_module_create avs_module_create[] = {
+       { &AVS_MIXIN_MOD_UUID, avs_modbase_create },
+       { &AVS_MIXOUT_MOD_UUID, avs_modbase_create },
+       { &AVS_KPBUFF_MOD_UUID, avs_modbase_create },
+       { &AVS_COPIER_MOD_UUID, avs_copier_create },
+       { &AVS_MICSEL_MOD_UUID, avs_micsel_create },
+       { &AVS_MUX_MOD_UUID, avs_mux_create },
+       { &AVS_UPDWMIX_MOD_UUID, avs_updown_mix_create },
+       { &AVS_SRCINTC_MOD_UUID, avs_src_create },
+       { &AVS_AEC_MOD_UUID, avs_aec_create },
+       { &AVS_ASRC_MOD_UUID, avs_asrc_create },
+       { &AVS_INTELWOV_MOD_UUID, avs_wov_create },
+       { &AVS_PROBE_MOD_UUID, avs_probe_create },
+};
+
  static int avs_path_module_type_create(struct avs_dev *adev, struct 
avs_path_module *mod)
  {
         const guid_t *type = &mod->template->cfg_ext->type;

-       if (guid_equal(type, &AVS_MIXIN_MOD_UUID) ||
-           guid_equal(type, &AVS_MIXOUT_MOD_UUID) ||
-           guid_equal(type, &AVS_KPBUFF_MOD_UUID))
-               return avs_modbase_create(adev, mod);
-       if (guid_equal(type, &AVS_COPIER_MOD_UUID))
-               return avs_copier_create(adev, mod);
-       if (guid_equal(type, &AVS_MICSEL_MOD_UUID))
-               return avs_micsel_create(adev, mod);
-       if (guid_equal(type, &AVS_MUX_MOD_UUID))
-               return avs_mux_create(adev, mod);
-       if (guid_equal(type, &AVS_UPDWMIX_MOD_UUID))
-               return avs_updown_mix_create(adev, mod);
-       if (guid_equal(type, &AVS_SRCINTC_MOD_UUID))
-               return avs_src_create(adev, mod);
-       if (guid_equal(type, &AVS_AEC_MOD_UUID))
-               return avs_aec_create(adev, mod);
-       if (guid_equal(type, &AVS_ASRC_MOD_UUID))
-               return avs_asrc_create(adev, mod);
-       if (guid_equal(type, &AVS_INTELWOV_MOD_UUID))
-               return avs_wov_create(adev, mod);
-
-       if (guid_equal(type, &AVS_PROBE_MOD_UUID)) {
-               dev_err(adev->dev, "Probe module can't be instantiated 
by topology");
-               return -EINVAL;
-       }
+       for (int i = 0; i < ARRAY_SIZE(avs_module_create); i++)
+               if (guid_equal(type, avs_module_create[i].guid))
+                       return avs_module_create[i].create(adev, mod);

         return avs_modext_create(adev, mod);
  }
