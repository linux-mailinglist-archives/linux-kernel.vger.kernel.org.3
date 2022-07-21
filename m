Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9957D017
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiGUPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiGUPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:44:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2D27969C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 984EEB82586
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB8BC341C0;
        Thu, 21 Jul 2022 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658418022;
        bh=ACCj27BOr1R48MusFeGl2HSWOEE0xoKwIzRbX5aiKL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQlypRMW2zxWfY4Bu6/W8sxeu34wdne164ZJePJ6b4A0rq/L2ySDWK9MtbQ/9xsC7
         +o1i9f/33ueF0CV8X9Tuw4iUpJNCa4zU+2P8rGlLGrzEKRgeXAXBoW0P18rB2XRrag
         LrxGKV1hhAW98eZzf8apZxAwIwDCfpWanSjDyMr/h9g11S+jjBdzlJ1pVadUt5uW/B
         r+TyN2v0+wreR4OXdOxhLmhJO6r4+wNZjsGHjH8Os+qEbg38c97juGNVd/OJnQdXzv
         LpX7hkNhbkMx+6AzHUbVody3sr1APq8JmL7+cduMDvuxOXFOyohEPF1U83AKfKcuQW
         sN3iYc5VLJj+w==
Date:   Thu, 21 Jul 2022 08:40:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Tom Rix <trix@redhat.com>, patches@lists.linux.dev,
        alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: avs: Mark avs_path_module_type_create() as
 noinline
Message-ID: <YtlzY9aYdbS4Y3+l@dev-arch.thelio-3990X>
References: <20220720185228.3182663-1-nathan@kernel.org>
 <c00a8b5e-6def-971a-d4f2-cd65c95fe430@linux.intel.com>
 <YtllwRY6F93uYRxz@sirena.org.uk>
 <d8e8e5e5-001d-5f22-b22c-aaea16ed8719@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8e8e5e5-001d-5f22-b22c-aaea16ed8719@linux.intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 05:28:09PM +0200, Amadeusz Sławiński wrote:
> On 7/21/2022 4:42 PM, Mark Brown wrote:
> > On Thu, Jul 21, 2022 at 02:25:20PM +0200, Amadeusz Sławiński wrote:
> > > On 7/20/2022 8:52 PM, Nathan Chancellor wrote:
> > 
> > > > This warning is also visible with allmodconfig on other architectures.
> > 
> > > My first question would be what clang does differently in this configuration
> > > (ARM) than in all other configurations (x86, etc.) and gcc.
> > 
> > See above from Nathan's commit message...
> 
> Ah, missed that. Anyway, what about if we replace multiple calls to
> guid_equal with lookup table and one call in loop?
> 
> Do let me know if something like the following works and I will send it as a
> proper patch:

Yes, that works! With ARCH=arm64 allmodconfig + CONFIG_FRAME_WARN=128,
there is no single large function, they are all far below the default
2048 limit.

  sound/soc/intel/avs/path.c:819:18: warning: stack frame size (256) exceeds limit (128) in 'avs_path_create' [-Wframe-larger-than]
  struct avs_path *avs_path_create(struct avs_dev *adev, u32 dma_id,
                   ^
  sound/soc/intel/avs/path.c:877:5: warning: stack frame size (272) exceeds limit (128) in 'avs_path_bind' [-Wframe-larger-than]
  int avs_path_bind(struct avs_path *path)
      ^
  sound/soc/intel/avs/path.c:143:12: warning: stack frame size (144) exceeds limit (128) in 'avs_copier_create' [-Wframe-larger-than]
  static int avs_copier_create(struct avs_dev *adev, struct avs_path_module *mod)
             ^
  sound/soc/intel/avs/path.c:379:12: warning: stack frame size (144) exceeds limit (128) in 'avs_micsel_create' [-Wframe-larger-than]
  static int avs_micsel_create(struct avs_dev *adev, struct avs_path_module *mod)
             ^
  sound/soc/intel/avs/path.c:344:12: warning: stack frame size (160) exceeds limit (128) in 'avs_mux_create' [-Wframe-larger-than]
  static int avs_mux_create(struct avs_dev *adev, struct avs_path_module *mod)
             ^
  sound/soc/intel/avs/path.c:267:12: warning: stack frame size (160) exceeds limit (128) in 'avs_updown_mix_create' [-Wframe-larger-than]
  static int avs_updown_mix_create(struct avs_dev *adev, struct avs_path_module *mod)
             ^
  sound/soc/intel/avs/path.c:325:12: warning: stack frame size (176) exceeds limit (128) in 'avs_aec_create' [-Wframe-larger-than]
  static int avs_aec_create(struct avs_dev *adev, struct avs_path_module *mod)
             ^
  sound/soc/intel/avs/path.c:306:12: warning: stack frame size (144) exceeds limit (128) in 'avs_asrc_create' [-Wframe-larger-than]
  static int avs_asrc_create(struct avs_dev *adev, struct avs_path_module *mod)
             ^
  8 warnings generated.

Feel free to add either

  Tested-by: Nathan Chancellor <nathan@kernel.org> # build

or

  Build-tested-by: Nathan Chancellor <nathan@kernel.org>

when formally sending, thank you a lot for the fix!

Cheers,
Nathan

> diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
> index 3d46dd5e5bc4..ce157a8d6552 100644
> --- a/sound/soc/intel/avs/path.c
> +++ b/sound/soc/intel/avs/path.c
> @@ -449,35 +449,39 @@ static int avs_modext_create(struct avs_dev *adev,
> struct avs_path_module *mod)
>         return ret;
>  }
> 
> +static int avs_probe_create(struct avs_dev *adev, struct avs_path_module
> *mod)
> +{
> +       dev_err(adev->dev, "Probe module can't be instantiated by
> topology");
> +       return -EINVAL;
> +}
> +
> +struct avs_module_create {
> +       guid_t *guid;
> +       int (*create)(struct avs_dev *adev, struct avs_path_module *mod);
> +};
> +
> +static struct avs_module_create avs_module_create[] = {
> +       { &AVS_MIXIN_MOD_UUID, avs_modbase_create },
> +       { &AVS_MIXOUT_MOD_UUID, avs_modbase_create },
> +       { &AVS_KPBUFF_MOD_UUID, avs_modbase_create },
> +       { &AVS_COPIER_MOD_UUID, avs_copier_create },
> +       { &AVS_MICSEL_MOD_UUID, avs_micsel_create },
> +       { &AVS_MUX_MOD_UUID, avs_mux_create },
> +       { &AVS_UPDWMIX_MOD_UUID, avs_updown_mix_create },
> +       { &AVS_SRCINTC_MOD_UUID, avs_src_create },
> +       { &AVS_AEC_MOD_UUID, avs_aec_create },
> +       { &AVS_ASRC_MOD_UUID, avs_asrc_create },
> +       { &AVS_INTELWOV_MOD_UUID, avs_wov_create },
> +       { &AVS_PROBE_MOD_UUID, avs_probe_create },
> +};
> +
>  static int avs_path_module_type_create(struct avs_dev *adev, struct
> avs_path_module *mod)
>  {
>         const guid_t *type = &mod->template->cfg_ext->type;
> 
> -       if (guid_equal(type, &AVS_MIXIN_MOD_UUID) ||
> -           guid_equal(type, &AVS_MIXOUT_MOD_UUID) ||
> -           guid_equal(type, &AVS_KPBUFF_MOD_UUID))
> -               return avs_modbase_create(adev, mod);
> -       if (guid_equal(type, &AVS_COPIER_MOD_UUID))
> -               return avs_copier_create(adev, mod);
> -       if (guid_equal(type, &AVS_MICSEL_MOD_UUID))
> -               return avs_micsel_create(adev, mod);
> -       if (guid_equal(type, &AVS_MUX_MOD_UUID))
> -               return avs_mux_create(adev, mod);
> -       if (guid_equal(type, &AVS_UPDWMIX_MOD_UUID))
> -               return avs_updown_mix_create(adev, mod);
> -       if (guid_equal(type, &AVS_SRCINTC_MOD_UUID))
> -               return avs_src_create(adev, mod);
> -       if (guid_equal(type, &AVS_AEC_MOD_UUID))
> -               return avs_aec_create(adev, mod);
> -       if (guid_equal(type, &AVS_ASRC_MOD_UUID))
> -               return avs_asrc_create(adev, mod);
> -       if (guid_equal(type, &AVS_INTELWOV_MOD_UUID))
> -               return avs_wov_create(adev, mod);
> -
> -       if (guid_equal(type, &AVS_PROBE_MOD_UUID)) {
> -               dev_err(adev->dev, "Probe module can't be instantiated by
> topology");
> -               return -EINVAL;
> -       }
> +       for (int i = 0; i < ARRAY_SIZE(avs_module_create); i++)
> +               if (guid_equal(type, avs_module_create[i].guid))
> +                       return avs_module_create[i].create(adev, mod);
> 
>         return avs_modext_create(adev, mod);
>  }
> 
