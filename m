Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3CD4D5A57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346284AbiCKFQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbiCKFQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:16:24 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64871AC2BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:15:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qx21so16680002ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JPFOajUMKTyb3rrUNNHEscSQIB+wen/tqKi4y6uiIl8=;
        b=Xu0bGoP827dHnS7HAEt/MyCA45yKbD/+QWTyirHwt9sS3D7hiaQmQsBPGUzNUF9atG
         3VjEbF6mD5Ddcn2msG6Ip1NadFNYhZwNRISDzokL+I5yF90TgG8n2PiAIMa9/E1bAd1z
         teV9tYeoZ2NxMWwz0b5Bt2xaSTLVzkWx5S+b3rb3pPRSqNrLplBBcDTOVyQTksO7A2U9
         0ndxekXuNN1uKwc2CHE1mmDBSD8Dair2MvDCdnAP42yaVH1FnwNzcCIq4Xl4bAu5nZ/9
         fnBgpUCWN4/X+ppZwEgWcOZUSSb/dXT7Jn5A5exWZ8xFW5+2DrR7xyZu/3rfLvkybRU7
         X3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JPFOajUMKTyb3rrUNNHEscSQIB+wen/tqKi4y6uiIl8=;
        b=pD1PIddrlJ0AUfbaxsxhc5jOv6fAlgE/Gn2lQey9jva+FbKXSLWiprkojDMn/sgAjy
         8TinQ1yapDnWN2Xc/vZNorROsxG05px1Iio3Tm1zxXICashnHoGlG4cGPRr3eW/WWOfq
         n22tcBOIqxgC/vG1iOHUKkJmlAOYisqr1fumHFl0WOTGnfY7zXQaLDue8d79225ey6/h
         g3hukLECVNQG3kuwtqoogWTO8Lyy2n2j22QabyVRbVAOIDMjROBtoY5bkcrZhYeaUPV+
         G+iZj4M1ED6wDb6dlY0XDJs1DkRv9rGLj7EQLNwUNs3fleUpCxjQymiOH9r5CaeRpKa/
         Ov9Q==
X-Gm-Message-State: AOAM533Hg+Kz+2b6QmLFAP4GMOHeiLVeYdHzRgUsk2F1k5SspRH08ZwT
        YzVd9swDGyqNGIDX1eXV4nAzO8ArQdgUuhsejYe2ki75Izs=
X-Google-Smtp-Source: ABdhPJxbXy0v9XlONwFwb+XmeF6M7vXW1IH4xECzIi+6iYV/aJ/372uJncF0/oMZuK7KJdYT+sazpSwkPl495QfXerI=
X-Received: by 2002:a17:907:968f:b0:6db:a3c5:ae3e with SMTP id
 hd15-20020a170907968f00b006dba3c5ae3emr1142716ejc.770.1646975720289; Thu, 10
 Mar 2022 21:15:20 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Mar 2022 15:15:09 +1000
Message-ID: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As expected at this stage its pretty quiet, one sun4i mixer fix and
one i915 display flicker fix.

Thanks,
Dave.

drm-fixes-2022-03-11:
drm fixes for v5.17-rc8/final

i915:
- psr fix screen flicker

sun4i:
- mixer format fix.
The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2=
:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-11

for you to fetch changes up to 30eb13a26014ca640b5eb57b6d010114084d5c92:

  Merge tag 'drm-intel-fixes-2022-03-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-03-11
13:26:19 +1000)

----------------------------------------------------------------
drm fixes for v5.17-rc8/final

i915:
- psr fix screen flicker

sun4i:
- mixer format fix.

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2022-03-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-03-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Jernej Skrabec (1):
      drm/sun4i: mixer: Fix P010 and P210 format numbers

Jouni H=C3=B6gander (1):
      drm/i915/psr: Set "SF Partial Frame Enable" also on full update

 drivers/gpu/drm/i915/display/intel_psr.c | 16 ++++++++++++++--
 drivers/gpu/drm/i915/i915_reg.h          |  1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.h      |  8 ++++----
 3 files changed, 19 insertions(+), 6 deletions(-)
