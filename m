Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5257748D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiGQE6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 00:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQE6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:58:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3416A12638;
        Sat, 16 Jul 2022 21:58:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso9782219pjo.0;
        Sat, 16 Jul 2022 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=pk35A4tnG9Ct8HadEgqknM1J2JwIT5p0DRJbULK144Q=;
        b=E7x/gc754j9YkZE5dHhV9H4L/ZUM8uK++3nWm69DwlHaX/Fx3pZW6y9CPgeKTRmDrt
         sFprVUy9uaRf4b1prO8hAqeTfp/q2Byi/bIzBQfP3Uxy9d642YmwHqq4zwi/NC7U22K7
         D+lUM6DatGSB0azB21HtkdRakGTAF+xNE/uOAEGA/jW/gYVTYRBmQKbds2lwRwUUlvUY
         bNIV9P01IcbY1V4uGytNAeLSBHryQkulanduAZ3zIw15Wiurhlr5BTZgrrCtSMPaDS6f
         KGBGsBwBwhQ7BW5Ci2f3dl6MuLdIEu8B1S5DoVOYcUwPXupB8YwaxvL9BNJnjGm63JCp
         VsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=pk35A4tnG9Ct8HadEgqknM1J2JwIT5p0DRJbULK144Q=;
        b=azsJ7qnFxdabUIr7wLnHtgnsEVKIUtaRJUl03UF2KBH90ZzsyX2O1YAvHEXmIql3gx
         lq943yfRt+49xYFmFgr+i20fu6AXhpxurVFu/RzOYCaUxqx2cQsq3HUWdiPJ5jhvyk4+
         y24Gd6FSgqt9xgLoaM4gVqffvi59d0E8cNxjeqbgT7QyD8cVacuxr0WO1+MZjHKCfv90
         O6rKk91gk3XIpiFEeoq66H3ovMl1kwMQOkibzBVmfLuv10/O+pcGobpfPapO3UXj2ztg
         zizlIBCiKxxOdKwqy5QDbsCgfTK37NlsQ6G52Gma0+M2LnXsB9PTqqOtohD22UliK7cB
         HGxQ==
X-Gm-Message-State: AJIora9/AwnF03qcemdbULNklzmXElqc4vC1T0s7qVW24RmxdBbBdgRc
        p06eHOTikpA3RNHj79PZ17RLnDErSUj+BA==
X-Google-Smtp-Source: AGRyM1tiKTVx2sxl/2KzNWT+GRA2wu7ho+PKJm9836c5JvH5g95cNgep16siD+7mFTohAyO0PBVqlQ==
X-Received: by 2002:a17:902:ee42:b0:16b:e518:d894 with SMTP id 2-20020a170902ee4200b0016be518d894mr21761770plo.5.1658033899426;
        Sat, 16 Jul 2022 21:58:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:e796:f778:8123:2ffa])
        by smtp.gmail.com with ESMTPSA id hk11-20020a17090b224b00b001ef87c5b7f4sm8623564pjb.30.2022.07.16.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 21:58:18 -0700 (PDT)
Date:   Sat, 16 Jul 2022 21:58:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.19-rc6
Message-ID: <YtOW6KABn6sd9ZDZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc6

to receive updates for the input subsystem. You will get:

- a fix in Goodix driver to properly behave on the Aya Neo Next
- some more sanity checks in usbtouchscreen driver
- a tweak in wm97xx driver in preparation for remove() to return void
- a clarification in input core regarding units of measurement for
  resolution on touch events.


Changelog:
---------

Hans de Goede (1):
      Input: goodix - call acpi_device_fix_up_power() in some cases

Johan Hovold (1):
      Input: usbtouchscreen - add driver_info sanity check

Siarhei Vishniakou (1):
      Input: document the units for resolution of size axes

Uwe Kleine-König (1):
      Input: wm97xx - make .remove() obviously always return 0

Diffstat:
--------

 drivers/input/touchscreen/goodix.c         |  5 +++++
 drivers/input/touchscreen/usbtouchscreen.c |  3 +++
 drivers/input/touchscreen/wm97xx-core.c    |  4 +++-
 include/uapi/linux/input.h                 | 11 +++++++----
 4 files changed, 18 insertions(+), 5 deletions(-)

Thanks.


-- 
Dmitry
