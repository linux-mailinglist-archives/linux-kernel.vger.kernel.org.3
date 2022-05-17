Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DD52A821
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350985AbiEQQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiEQQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:36:43 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C120BD4;
        Tue, 17 May 2022 09:36:41 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p139so12431861ybc.11;
        Tue, 17 May 2022 09:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XzZsCz+FEDhr5zfSeWU+bowEEKWP57VJ8xk562lPInY=;
        b=jqNRJecgJWG0orNedLcyhTebhAn71pml9sD8cIVjuQ8SU0FHi8ccPrbqjIeU+OW73/
         2bUrYGHMs8dOz1SFbl9nZhiGasxkH9pkdm2AmuiHRAIKWt7gwtMxbVIQ6nPbGQovnig7
         iE3KbEipVsTN5rpVbF40QLqTf52iHhZXi5TlAmR13bPXnLJr6Ah/M3QwVBzB+AGBiWZ6
         A6wbVcZFjKBSVxIPT5YT/U/JYQdoGn1JWXS6IxEFm0VviPALGxr7wFj9VPx21iWUAlgc
         3mA/6heoo2URQh6gztBgPjsnaQ0dKM5bJ6+k7j9oS2RibvWigb1VLRpso7zZumCwuiqB
         c+eQ==
X-Gm-Message-State: AOAM532kbN1Xz5K7dcCqSWZQ8gaEMags9pMBXQUM6XSNssKTOj3B4IdW
        GnXukWGoeRZOttVXFooPN2VHGAlUOlIAfuideAmQgGJjM7Y=
X-Google-Smtp-Source: ABdhPJx2hgUuHv/xBi+xAczLQQBmVAOVbS0p3qrHUhTBhMGTALjD7CIZDEbnEjM2Yt3ZNyEVKnHWuOzfmJE4CMXdgM4=
X-Received: by 2002:a25:ed06:0:b0:64d:e12f:5229 with SMTP id
 k6-20020a25ed06000000b0064de12f5229mr7140356ybh.622.1652805401179; Tue, 17
 May 2022 09:36:41 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 18:36:30 +0200
Message-ID: <CAJZ5v0ghkfwSznen8DTiS_O_obYWmOw8R_RyqK4ZYur+Kkus8w@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v5.18-rc8
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
 thermal-5.18-rc8

with top-most commit 7b145802ba545ecf9446ce6d67d6011b73dac0e0

 thermal: int340x: Mode setting with new OS handshake

on top of commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a

 Linux 5.18-rc6

to receive a thermal control fix for 5.18-rc8.

This fixes up a recent change in the int340x thermal driver that
inadvertently broke thermal zone handling on some systems (Srinivas
Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: int340x: Mode setting with new OS handshake

---------------

 .../intel/int340x_thermal/int3400_thermal.c        | 48 ++++++++++++++--------
 1 file changed, 32 insertions(+), 16 deletions(-)
