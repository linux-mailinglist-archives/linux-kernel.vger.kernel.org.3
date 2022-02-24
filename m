Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBC4C2E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiBXObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiBXObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:31:53 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F517C42D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:31:22 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so4176284ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yN4qqwzRUbf48GIlrimNl5sMWvOFulKNBolCSX/vfSs=;
        b=ueUn5iqUjUYldOHpCUKXR+wfQojXmywKv3+H2krKYsKK642HIuat0fTLg9wk1Ee8ea
         mcolfxfYSHLI6NSj8TwUIDeC5Hx56X5uRgwWqEROPqKGls9/BFYx7tCQUTg6UqWzhdz9
         L2WHYtp6ZZ1Hk8pGJaxUdcfaUybg2gZmI9pfBoHGxVg/Zjep4YtM+/3oychx5Q72LXgo
         IWKa77qzorc88gHqjp+C3GwBwrFrS5AKV/+2ZLo2JGvCgQDlq1/sc8B/+EsN3odlmDq1
         4qr6DfrU4ENLvh7OsvsDJ3xobLKGPY68ZLnCxGUuSFiyb2ay9BO5w0lAnNYPJUcibq20
         S93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yN4qqwzRUbf48GIlrimNl5sMWvOFulKNBolCSX/vfSs=;
        b=aj1n1AsCmH3DC6WopQ+fbN/NtmvR02kLkBezuIKscUFQi6dUyc9TavVrbJ8J2gfkyh
         rqqA0UFEWMHQiiXd/+TgLjEqxHRwH7IsoUeNZeHznmaLjBfeSecJAHnlRtRSTiNqqXGN
         qE07xrJPpBzjvG1ZJ3wP6FOgoyGYvasn92lUHqWwBU0hhwChqCWZW/ml/8KrO5EQHhd7
         nUF+MnCX1UbbhL6iRBzydCaU+4HweNZ9tuLdjmJ08nNMX8oXk4eEqI7dOWw38nYNKoet
         U1w+HpUmy/X2Dk4atzvgB6H7h3pHJghp9UnuwW9gleAxI0jYT6rCcBvXuYDR84XFBe4e
         wpOw==
X-Gm-Message-State: AOAM533xiLLONZGi8k2/MyHyZZKYcxUjjQBaO//93Ia10q7cLQ3uT9Aa
        zXbGSHM5Gnfj9lIMUz1UE/NcmAQuZkRV1clKZT7oJw==
X-Google-Smtp-Source: ABdhPJzCAv17bPxxtrBHUsYVgjz+4kPNay/KOgbfa2FRXojMJEjYMnZBpYaZ7q1jNSMEQ4TypGvXqY148lSE5HmF/i8=
X-Received: by 2002:a25:6993:0:b0:624:55af:336c with SMTP id
 e141-20020a256993000000b0062455af336cmr2650572ybc.412.1645713081929; Thu, 24
 Feb 2022 06:31:21 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Feb 2022 20:01:10 +0530
Message-ID: <CA+G9fYu4PPE6_91mzor0bW7RSzBDNJ3xqqgeeK-jR1jokmhYOQ@mail.gmail.com>
Subject: gpu/drm/dp/drm_dp.c:59:27: warning: array subscript 10 is outside
 array bounds of 'const u8[6]'
To:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please ignore this email if it is already reported]

Linux next-20220223 arch riscv build warnings noticed.
Build configs:
  - riscv-gcc-9-defconfig
  - riscv-gcc-9-defconfig
  - riscv-gcc-10-defconfig
  - riscv-gcc-11-defconfig

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: d4a0ae62a277377de396850ed4b709b6bd9b7326
  git_describe: next-20220223
  arch: riscv
  toolchain: gcc-11

Build warnings:
-----------
drivers/gpu/drm/dp/drm_dp.c: In function
'drm_dp_get_adjust_request_post_cursor':
drivers/gpu/drm/dp/drm_dp.c:59:27: warning: array subscript 10 is
outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'}
[-Warray-bounds]
   59 |         return link_status[r - DP_LANE0_1_STATUS];
      |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/dp/drm_dp.c:210:51: note: while referencing 'link_status'
  210 | u8 drm_dp_get_adjust_request_post_cursor(const u8
link_status[DP_LINK_STATUS_SIZE],
      |
~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[1]: Target '__all' not remade because of errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/25XO99nwfQgKrWKz4yfBPYw0wyU/
