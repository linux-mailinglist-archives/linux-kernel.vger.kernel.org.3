Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B06590631
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiHKSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:11:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0479753A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:11:52 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f41584236so180997187b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y2QNTJtA+QkycDzAJ2gpgSvPbeV+rknwYt+wRwQVE9U=;
        b=DOL0/7BCufuS1Z5S25RF66e3W79quG1uKIMs+Et22SQVj9mUJ5Rr1OR1MkhErrjmbx
         XeeZVG1bK+ZCf6fI+B/vROHj/GkE3FxDrzW1+pdtb/yN+8jpJ+NitKHfIJ5sRgsz0p8e
         Fe/7ViKYvUdEVhAJX83sc4T4S9xx6AZbsagBU00EehxhO+bX3XN8GMGy1UdfAosvv+zD
         lPHZ3xGY5RdmpfBsjtapQ8k5zkLzBFNU0cNnIxS6TJ3/lbcbRp3MoVlwAyFmcUDlvNRs
         ZyYdUDmCaJQrjUsZKMFxRjOYAOppWnhkzNrcMaA/v9MlmnB2CyoZ63JCmQTMzl+PXIiN
         SrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y2QNTJtA+QkycDzAJ2gpgSvPbeV+rknwYt+wRwQVE9U=;
        b=u/36bUrkpiPcEU6Yk0PF2MoBwDGISPqWcLN7QelG2oX7LOiQFZrv0ldVd9BII/5xTJ
         QP6WqA0uvf6k+MFKckbwE6Iwi6RjsEjUX6TccUuUQ6g3JiaQaNZEvlazpeitXnNJEiNz
         DOmVTe04btfwKJnaPSkX6Ot/YFBwsbaXJsmH4Fk43kCR/llxYLyOq9Q8zEXqJPXR88Tc
         QmCAzgMNMcCv/0m1RTXZE6qD9uDmVB5db/ZgwNmIyoGZPcfijgU0ZpB+oApeycRqp0D5
         l9y+LD24zazRpLGjir7gytU+Drnx3YHo1Y9XikFdcjclRbupilBf0vL0JUI6qQrINHSJ
         L+6w==
X-Gm-Message-State: ACgBeo0mQqdquXvYEzy3We7sBB1NLMXtv2iAESzqU/jugbxhyFrpYvHJ
        ji4nKudWGWRYsMpDWEDoB/NnW4ZAm4xRTuHTWvg=
X-Google-Smtp-Source: AA6agR4SU1v+xBEONP5Zol2FeSnVE6WaQBbeKZ+bxN8tcA2+V/9UzSOZ2jG8TlaLq1mJcPPxaSGer5ZC+xkULYAUMIU=
X-Received: by 2002:a0d:f846:0:b0:324:cb8a:e0ff with SMTP id
 i67-20020a0df846000000b00324cb8ae0ffmr432591ywf.478.1660241511833; Thu, 11
 Aug 2022 11:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmN_TzJKdfM40BQPW=cRm5VxX=qAKxq2yW4P_xDN6=VoOA@mail.gmail.com>
 <20220811175759.1518840-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220811175759.1518840-1-hamza.mahfooz@amd.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 11 Aug 2022 19:11:15 +0100
Message-ID: <CADVatmM3PdWy-75qJD29Xm2ow48GV5xPsE26L1_ZPL7LFgJdfQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix DSC related non-x86/PPC64
 compilation issue
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        hersen wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roman Li <Roman.Li@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 7:00 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Need to protect DSC code with CONFIG_DRM_AMD_DC_DCN.
> Fixes the following build errors on arm64:
> ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> Fixes: 0087990a9f57 ("drm/amd/display: consider DSC pass-through during mode validation")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Thanks, fixes the build failure for me,
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
