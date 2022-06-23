Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA65588D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiFWT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiFWT3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:29:07 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678E8EF82;
        Thu, 23 Jun 2022 11:58:52 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 15so662026ybc.2;
        Thu, 23 Jun 2022 11:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lI4mCx3whxOUC4X09M0nTfZ+oGlW9rf6dVQE1au+tlA=;
        b=Kjdc1B6Kz6aKxttAJDHAYrtIni/Bn49AdnWIK3SNhp/YmbjIcZwNI0dMSDz3Yfsn8W
         ay6CbKsHO6toZ2BMYTYjo2xQvdFIsCmyX02yPQP/opUkdrVT6bmaWuZ6t3QTf92pV7J4
         5F62Isn5xf+phcKrD6ptTyFIgMd14gStYoA3LJ2nUeLTlU4vupsJIMx6CA1eZ3Qby8EC
         8Yog6hznYqimr4myuNf/WRiW0OBDMQ4qvGLZDt1wR93B9wsfNdhEc74R+7mvtVRLuZaZ
         kJy7ly1/4FicEskPwiOV2LSbOjdExaCF1QF+ZYWHJ9M0j+IQr2Bxtf2tUTx26OHPqX2n
         fK+g==
X-Gm-Message-State: AJIora8EL3A87IXfH3PCkZwygr/mo4/O0U/aKUPzsfJ36ciyNqPmnwn3
        HrJq9eLxtnlqQDDTrIasCCjmEu+zOhBaE5tQ1zU=
X-Google-Smtp-Source: AGRyM1v8RMiz7PDJqAFsyY9GUECSIoz7S30xCjilh79QODSpyibddy/527AzKVflhKiO/Qv8P0ih6SF55lfkhYNejiI=
X-Received: by 2002:a25:d841:0:b0:668:ab2f:7b01 with SMTP id
 p62-20020a25d841000000b00668ab2f7b01mr10902028ybg.482.1656010731199; Thu, 23
 Jun 2022 11:58:51 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jun 2022 20:58:40 +0200
Message-ID: <CAJZ5v0hHCBE5PpqayYi8kKF-+-juJwbQZtzoQ0mNDo_4iGQ6Lw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.19-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.19-rc4

with top-most commit 202773260023b56e868d09d13d3a417028f1ff5b

 PM: hibernate: Use kernel_can_power_off()

on top of commit a111daf0c53ae91e71fd2bfe7497862d14132e3e

 Linux 5.19-rc3

to receive a power management fix for 5.19-rc4.

This fixes a recent regression preventing some systems from powering
off after saving a hibernation image (Dmitry Osipenko).

Thanks!


---------------

Dmitry Osipenko (1):
      PM: hibernate: Use kernel_can_power_off()

---------------

 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
