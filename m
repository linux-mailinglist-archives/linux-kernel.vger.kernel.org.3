Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736A859073C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiHKUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:09:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDB9C52B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:09:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so35383181ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=wtcF5E6HHYGtowaMckWSPycHkBLnOQTqJU55D/wwaFs=;
        b=NyXMEAqNG7fhpAylWgJx4k+gq42Ptr9gUlhfLyd3zUOnXGUSsYyBdCANEnSJI1xBmT
         nAiLeUspjjhoPyeV17dhuEuqIg8tKrqKpA9eisf5kQWV5owNxpdoOSSqwn1hy7d0sirv
         0Mbj93g5WFp7YpxdI09lMYZYpwTRn1lYoNFOpoH8Mv89743mT9k89by3qLFfumdLg0Aq
         ZIM+FYwEsnrq3PFAe37Coj+ANgxZWDYMX5yh4bU3uw0yoyBzKrYAi//u8cODSpeLAAFl
         uMup32sbpzLE9ft2/wYPd3znpvIxut8oJ0we3lbB+G0vM4pa1Zinz1NgW2vmedwOZmOW
         izIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=wtcF5E6HHYGtowaMckWSPycHkBLnOQTqJU55D/wwaFs=;
        b=DzwFhw2DvSJ81wivSV2OXH0doVvGgdF//62ZrqS+TbwzNBQdrOSYFRYVQRnCK5uXDW
         +RIEQMQ1kB5eP9JI8jWOf6A84fiHizc35JrWup/+InTbhV1wEKOekK/Z+lKhRM6Lf/1q
         +E4p1BE3hYn/XnIgVyaaoYgcpvYYfpLapVo1q5blSiPAVHuNULSl19X7nKR5T5QYov2U
         TT4WjrkGnUDpIsR1tBCiIFYF5CCRLwXAAuXDPnNjS0ln3tXut6Yz9irzuFYoTefO7mQk
         paBNZpFgBnQOZrnN1/8Ch94ofG9dfTeeHpnhFUrGIp2wiMAKxeX28raQcIYxQ38x1aDX
         5dIg==
X-Gm-Message-State: ACgBeo39tqtQmxfX72pdxxrWgOwHrSHewMC3uqVEuKtIe3BzvjkJcpc4
        +FeVJY8lLj8czcGTwbVfwge9zgxdToHrRtZr3CU=
X-Google-Smtp-Source: AA6agR5SI/7AnFOmm98ZrXP35jTyRo6XF8L8EWBJS7WGcfFvB7dTjYOfwcI2iqxg2YxgijaEdmELyLpw4UZBN4U7lNo=
X-Received: by 2002:a17:907:6d8c:b0:731:6c60:eced with SMTP id
 sb12-20020a1709076d8c00b007316c60ecedmr488338ejc.266.1660248595386; Thu, 11
 Aug 2022 13:09:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 Aug 2022 06:09:44 +1000
Message-ID: <CAPM=9twZGrzg6pXcHQkaPfCScrE-DMh5PC1UnRULbtv1eC6vdA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.0-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hey Linus,

not much to squeeze into rc1, just two small fixes, one for core gem
and one for shmem-helpers.

Dave.

drm-next-2022-08-12-1:
drm fixes for 6.0-rc1

gem:
- Annotate WW context in error paths

shmem-helper:
- Add missing vunmap in error paths
The following changes since commit 5493ee1919eae4f49d62276cf5986b7f7c7aa8f6:

  Merge tag 'amd-drm-next-5.20-2022-07-29' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2022-08-03
14:00:19 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-08-12-1

for you to fetch changes up to 36fa1cb56ac5189c78dacbbb14d452d0c44b86c0:

  Merge tag 'drm-misc-next-fixes-2022-08-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2022-08-12
05:57:12 +1000)

----------------------------------------------------------------
drm fixes for 6.0-rc1

gem:
- Annotate WW context in error paths

shmem-helper:
- Add missing vunmap in error paths

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'drm-misc-next-fixes-2022-08-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Dmitry Osipenko (2):
      drm/shmem-helper: Add missing vunmap on error
      drm/gem: Properly annotate WW context on drm_gem_lock_reservations() error

 drivers/gpu/drm/drm_gem.c              | 4 ++--
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)
