Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5B487134
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbiAGDYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344897AbiAGDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:23:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE45C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 19:23:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m21so17205888edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 19:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kKf+CD/ao0rjSkRE3ZyL+/Oy6FjN9bHh1KEcXllJnuU=;
        b=AxW355ZWhb1XUrvyneeJKALAKdrx6EinJv877EW2eXbv/50i2Y3ZTkGOgGi0LYRWGx
         ri1eFWHjTbEzDBrnQG2m+w87lXXw0o/EMwVyNXouD64SZGh1+yNz/96eHtCV9QDi/rZ6
         UqwtkmV7fxhMxhvuYUAwFHmLE7Y8PrqpcviB6O3UeEPbvGn/IBuAZpKlXuEH3ZGQ4LUV
         JW3umTyVi033vBc/UXc1i4ymI/25oG0rBbliqBlv4SJkCw/NKOReVSxyOutox/2lOOvM
         V7JI0A7S+hYU49S9cszjhr3zJL6a0lGI7VzO6nnHMIpUQnRkiSyMBx0ogj0x6QhtIly8
         7kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kKf+CD/ao0rjSkRE3ZyL+/Oy6FjN9bHh1KEcXllJnuU=;
        b=P4gyX9UNJIT+ev0CBv9WHuztJk07goq/vE80Dq4Us2xhu90ujOudkCzRB0DzNOvA69
         ySNZpM7edqJ70Fd7QPEZ0MKI+IL3tthX9QUxTmrwZMHH9wr97/iEBjjT/khKcdBBQLf2
         p5bb6FMonDoDNwobs9PQkakK3W2ZIOQNJWFGRYmwQiGDt5j5qwxF2mfsj6Pl+56X9EwQ
         waHFojn9LEWBuHEmXdjjS251REKmB3FNWlvl55tpuoeCz4Mn7aSuUNM0P1E6th/uRd4Y
         qkMHVuY/HbzoZQwYkizjiiZeHs+uoPYvygm81dXzKMBg3qqnUoVor5VUbYVeotn15OTs
         VMLA==
X-Gm-Message-State: AOAM5311IHa9+IMwb7slWc9X+CawURsXyf7WDBtjh7mP6lA5itco6oAt
        ik2XUvwxx0U6NWGskl9w2E715Q3omNMOyPr0zyM=
X-Google-Smtp-Source: ABdhPJwkID5JWif5YvCwDaMj7dKbtNDMViK1xvIKzZhFPSe86ibDhMOiKQ4NA3Q3pz++AXnBwvba7NUs0YqkxFs7aUI=
X-Received: by 2002:aa7:d55a:: with SMTP id u26mr59888661edr.265.1641525836614;
 Thu, 06 Jan 2022 19:23:56 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Jan 2022 13:23:45 +1000
Message-ID: <CAPM=9twnYJ8SrVzJEEH+Vksibomvk5CE+Nn6BXKYwLG_8r=GJQ@mail.gmail.com>
Subject: [git pull] drm final fixes for 5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There is only the amdgpu runtime pm regression fix in here. I'm going
to be away next week, I'll probably pre-send you the drm-next main PR
before I go, if I can get it done today!

Dave.

drm-fixes-2022-01-07:
drm fixes for 5.16 final

amdgpu:
- suspend/resume fix
- fix runtime PM regression
The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-01-07

for you to fetch changes up to 936a93775b7c4f2293f651f64c4139c82e19a164:

  Merge tag 'amd-drm-fixes-5.16-2021-12-31' of
ssh://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-01-07
06:46:08 +1000)

----------------------------------------------------------------
drm fixes for 5.16 final

amdgpu:
- suspend/resume fix
- fix runtime PM regression

----------------------------------------------------------------
Alex Deucher (2):
      fbdev: fbmem: add a helper to determine if an aperture is used by a fw fb
      drm/amdgpu: disable runpm if we are the primary adapter

Dave Airlie (1):
      Merge tag 'amd-drm-fixes-5.16-2021-12-31' of
ssh://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amd/pm: keep the BACO feature enabled for suspend

 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 28 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  6 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +++++-
 drivers/video/fbdev/core/fbmem.c          | 47 +++++++++++++++++++++++++++++++
 include/linux/fb.h                        |  1 +
 6 files changed, 90 insertions(+), 1 deletion(-)
