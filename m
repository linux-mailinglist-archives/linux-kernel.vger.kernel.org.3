Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E44CA3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiCBLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCBLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:34:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E090262;
        Wed,  2 Mar 2022 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646220843; x=1677756843;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=y0e0DF3MspqEl8ha55uPDWvf5C90XzgSbIFCc/ooqro=;
  b=ezVyZ1D7Zfz2c8J/yUro6LfBlK1Lq5TQ76h4WYGsXrWqVQq+MPrYVKYp
   aR62JaDCIPz4txxZKEs6oCK6d/StYYgyUCjP7v52hRn+yTkCB7oOyxpXS
   heZCpJJKR9MoqfkIRWmF2zYwBxHyQTQvga4OEqR3idxM0AWcITLiqS+Dm
   Lq9/Cyxiyq1q2bwl0zthIoz17uK2hxVWbSreMqMYQZTO+zQLUq9E0Ns1v
   z5Ty79t4p9oHUOa36Irlve/Bak87AE0jbog3d3jDeAA84PkF89VzLBye1
   s9JNTT6lY3w77TAicfHpM/YUPea9w9Vxl4QiECWgNdWZ3MCgk2uodaF2q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="236889972"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="236889972"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:34:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="510975615"
Received: from ijpoole-mobl.ger.corp.intel.com (HELO localhost) ([10.252.1.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:33:59 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     CA+G9fYu4PPE6_91mzor0bW7RSzBDNJ3xqqgeeK-jR1jokmhYOQ@mail.gmail.com,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>, ville.syrjala@linux.intel.com,
        airlied@redhat.com, dianders@chromium.org, tzimmermann@suse.de,
        sfr@canb.auug.org.au, lkft-triage@lists.linaro.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: MSM8960: gpu/drm/dp/drm_dp.c:59:27: warning: array subscript 10
 is outside, array bounds of 'const u8[6]'
In-Reply-To: <8e13f51a-845b-1fdf-11ea-6053f7d8df9e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <8e13f51a-845b-1fdf-11ea-6053f7d8df9e@gmail.com>
Date:   Wed, 02 Mar 2022 13:33:56 +0200
Message-ID: <87ee3k6123.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022, Rudraksha Gupta <guptarud@gmail.com> wrote:
> Hi all,
>
>
> I am getting this warning when compiling the kernel for the MSM8960 with=
=20
> this defconfig:=20
> https://raw.githubusercontent.com/apq8064-mainline/linux/qcom-apq8064-nex=
t/arch/arm/configs/qcom_apq8064_defconfig
>
>
> Warning:
>
> ../drivers/gpu/drm/dp/drm_dp.c: In function=20
> 'drm_dp_get_adjust_request_post_cursor':
> ../drivers/gpu/drm/dp/drm_dp.c:59:27: warning: array subscript 10 is=20
> outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'}=20
> [-Warray-bounds]
>  =C2=A0=C2=A0 59 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 link_status[r - DP_LANE0_1_STATUS];
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~^~~~~~~~~~~~=
~~~~~~~~~~~
> ../drivers/gpu/drm/dp/drm_dp.c:210:51: note: while referencing 'link_stat=
us'
>  =C2=A0 210 | u8 drm_dp_get_adjust_request_post_cursor(const u8=20
> link_status[DP_LINK_STATUS_SIZE],
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>

Please see https://lore.kernel.org/r/20220225035610.2552144-3-keescook@chro=
mium.org

BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
