Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFE51EEC5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiEHQFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiEHQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:05:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD5E0AB;
        Sun,  8 May 2022 09:02:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so16373049wra.4;
        Sun, 08 May 2022 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0vM5uaC/Yln1i6PCZyVhBPCayMsRTDuqyjVDZg1hYQ=;
        b=ijcLEL2BBNxKSqySmgoHF+VfVP90PwJqc0ddsfcdIkC0yGwdsmQIkQTmr7fAGt0r9K
         JL8BGrtPJZyZ2TVOWW+MofeM4DQaCeKMPDSoCP0qH/uUzUJKJqvWSyoxkaow98rCsplF
         Bxdnxd71z2m3MWLSMvi8DZjN9ExG4fnQw67pAMQS1klPiaiIgY4Eg81TQ2W+xnHCai9W
         enndfQFvxc9Nj17DoaeHicxYiHCHxpKX3jLcW4EmlwjRd42YZeAGP+pPyx/cqdA6eN/7
         4t61Cw8lP2H/GjcJvWN3PIpot5ZrosohgSmtQ1UPXcWEOmtS+vWJEo3AtRgFFXm3dEnn
         Jkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0vM5uaC/Yln1i6PCZyVhBPCayMsRTDuqyjVDZg1hYQ=;
        b=Tz1gOvgNrl42PKz8zoAntWBVtp1WXk37Dh0ReWy05MZoHLaP5URctEGX5cOXnMkG/8
         7Nn9pd/M+ckgxl7FAyV/Q+eZu7/vlTOCkPdE5nRI6368O+sfQEyoMahYoyxQj5zis724
         bbPb5N7XatIi/W2bvCrQaVqidSy4oHOWN4DcNqI6TSMtzjxrNXYTmbN0VTunO6EE31y9
         3yVZZfinRuVtFV0TjlQ3i4XriD7Jr0sTUHGu15oLx4gW+imTDzkPILcfKBTyYOfAgYz9
         pgTe9ot9uInhHlfVcGgW6ncJ0GmcdHmir/Ru1TJNT4zr1KnECu7OEibCf3HErspel1c/
         8Jrg==
X-Gm-Message-State: AOAM530UMSukWaIdK1OrDIcaxfCXqv1+dydzan6OIPLshlFB+xeAikUH
        fFaVMGmZ94uJcJLZr2CsbXk=
X-Google-Smtp-Source: ABdhPJzX1X1yyfqOsrpxFjCIrwTEfKbvZgj0ERpM2gxYUssiQJxjDYdVN1a7ksrlezzV+WrpP5b7iA==
X-Received: by 2002:a5d:47ca:0:b0:20c:72c9:d3be with SMTP id o10-20020a5d47ca000000b0020c72c9d3bemr10299167wrc.114.1652025718481;
        Sun, 08 May 2022 09:01:58 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:01:58 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 0/7] DIGImend patches, part VI
Date:   Sun,  8 May 2022 18:01:39 +0200
Message-Id: <20220508160146.13004-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series is a follow up to [1], [2], [3], [4] and [5] upstreaming
7 more patches from the DIGImend project.

After 3 months, I'm happy to write that this is the last batch of
patches :) Once the patchset is applied, DIGImend and the mainline
kernel will have the same code... And I'll finally add support for my
tablet. This should also allow Stefan and Alberto to continue with
their work.

This last patchset is a bit of a mix. The patches don't necessarily
make sense together, but I needed to send them at some point to include
all features from DIGImend, so they ended up in the last batch.

Thanks a lot to Jiří for the reviews these months,
José Expósito

[1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
[2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/
[3] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204111653000.30217@cbobk.fhfr.pm/T/
[4] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204211005520.30217@cbobk.fhfr.pm/T/
[5] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2205060834580.28985@cbobk.fhfr.pm/T/

Nikolai Kondrashov (6):
  HID: uclogic: Move param printing to a function
  HID: uclogic: Return raw parameters from v2 pen init
  HID: uclogic: Do not focus on touch ring only
  HID: uclogic: Always shift touch reports to zero
  HID: uclogic: Differentiate touch ring and touch strip
  HID: uclogic: Switch to Digitizer usage for styluses

Roman Romanenko (1):
  HID: uclogic: Add pen support for XP-PEN Star 06

 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-kye.c            |  12 +-
 drivers/hid/hid-uclogic-core.c   |  29 ++--
 drivers/hid/hid-uclogic-params.c | 267 ++++++++++++++++++++++++-------
 drivers/hid/hid-uclogic-params.h | 143 +++--------------
 drivers/hid/hid-uclogic-rdesc.c  |  70 ++++++--
 drivers/hid/hid-uclogic-rdesc.h  |  12 +-
 drivers/hid/hid-viewsonic.c      |   2 +-
 8 files changed, 315 insertions(+), 221 deletions(-)

-- 
2.25.1

