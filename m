Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5A5905FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiHKRiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiHKRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:38:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D566FA0C;
        Thu, 11 Aug 2022 10:38:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 199so29324995ybl.9;
        Thu, 11 Aug 2022 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+OaTTx4oKfd+EHTbl5rmEQCqRiCYo959iJOiqkKHNok=;
        b=HeB+hPTiJ1uZaiTO/ANwYnKPfTZ9ZMXOV9MM63aIOh9DHNP7A5h2dND4zSDYTwwNJc
         DbzipewVIURR6bWo/hcoL7NpVnIMllhIsAJE+Cskv9AQ7vSHQEuMX42oFjXpkUwJ3z76
         se5z4IAAN2kbb5PlJVWqYVYSrLEAKWY4+eSpJ34RFmYXNDN3fu1wkmC2BpTEVgygrgor
         710Hunf3AFu150hTCgXWrJk5OF/dvvznrs6JY7JpLF24vvc2UFOsw7CC6lRcTH/G5q1I
         PvkYg0xfBW7X7KH7Rdq/d9v+k13bOP6FcdXVK6j5vDv/f28js4CuJwdhKs3aQj4ihH6g
         g1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+OaTTx4oKfd+EHTbl5rmEQCqRiCYo959iJOiqkKHNok=;
        b=53cy7utfT7n6eP+dsKbZy6sihIhCCVG7wxz6HdGeNUEFuw/TPKnN8sswx47EzTMqzK
         N2hCH8lt85+cw8SBRaGPWT4DtTuFpODHotdA7w1ELfUc6inZVQlET13X+pQh2BSLC/Nm
         H7LCf/MWWNGLRSFATHqj0wqMKm4DHMb9ebjq7OUJx5qLLp90gDbfIicDEbjXyW9nmfW7
         yvGG8WRyQTFEV7qSwUjQl2trmbK1otNZMfs3R0X4wgqGc75E7jUW8Bbvw/1KQ457Oh57
         Wd8IU1X+Y0y/DSn7E9Oa2gLa6/PQT0z9bULJcstHN5rfADp7KMe5hnp2acn/nK9jUq9+
         V8ww==
X-Gm-Message-State: ACgBeo2BhANJ366Gav3XIiB8q8/e3DpGRynwNKeulPKaguW9erDK7hKd
        Xhafk2iNF6lb5XrMwrk0Q5Bo52n9LOnv05djhF9Q6uz9OE1q8Q==
X-Google-Smtp-Source: AA6agR5k04ip0oNeMAM5/9PWslkduulNrUTTzhzoDjAL3q9yQnZ0ey9WtWfVfrYgoweBZiqNzvIuNVsdnVb6mprdvys=
X-Received: by 2002:a25:ac92:0:b0:67b:ac46:5e43 with SMTP id
 x18-20020a25ac92000000b0067bac465e43mr361354ybi.183.1660239497180; Thu, 11
 Aug 2022 10:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <YvU4GD8HtZ1A4dhI@debian> <CADnq5_PwbwjmvvKedpZeeQHk7N+kawKpXywjNGqa=1jSKRcw0A@mail.gmail.com>
In-Reply-To: <CADnq5_PwbwjmvvKedpZeeQHk7N+kawKpXywjNGqa=1jSKRcw0A@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 11 Aug 2022 18:37:41 +0100
Message-ID: <CADVatmN_TzJKdfM40BQPW=cRm5VxX=qAKxq2yW4P_xDN6=VoOA@mail.gmail.com>
Subject: Re: build failure of next-20220811 due to b1a63a0b48ad
 ("drm/amd/display: consider DSC pass-through during mode validation")
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-next <linux-next@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Aug 11, 2022 at 6:16 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 11, 2022 at 1:11 PM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi All,
> >
> > Not sure if it has been reported, builds of riscv, alpha, s390, arm,
> > arm64, xtensa, mips, csky allmodconfig have failed to build next-20220811
> > with the error:
> >
> > ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> > ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> >
> > git bisect pointed to b1a63a0b48ad ("drm/amd/display: consider DSC pass-through during mode validation")
> > And, reverting that commit has fixed the build failure.
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> https://patchwork.freedesktop.org/patch/497116/

Thanks, that has fixed this failure. But it has now caused these new
errors resulting in a build failure.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:
In function 'dm_dp_mst_is_port_support_mode':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1427:32:
error: unused variable 'bw_range' [-Werror=unused-variable]
 1427 |         struct dc_dsc_bw_range bw_range = {0};
      |                                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1426:22:
error: unused variable 'max_compressed_bw_in_kbps'
[-Werror=unused-variable]
 1426 |         unsigned int max_compressed_bw_in_kbps = 0;
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1425:49:
error: unused variable 'down_link_bw_in_kbps'
[-Werror=unused-variable]
 1425 |         unsigned int upper_link_bw_in_kbps = 0,
down_link_bw_in_kbps = 0;
      |                                                 ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1425:22:
error: unused variable 'upper_link_bw_in_kbps'
[-Werror=unused-variable]
 1425 |         unsigned int upper_link_bw_in_kbps = 0,
down_link_bw_in_kbps = 0;
      |                      ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1424:22:
error: unused variable 'end_to_end_bw_in_kbps'
[-Werror=unused-variable]
 1424 |         unsigned int end_to_end_bw_in_kbps = 0;
      |                      ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1423:33:
error: unused variable 'cur_link_settings' [-Werror=unused-variable]
 1423 |         struct dc_link_settings cur_link_settings;



-- 
Regards
Sudip
