Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C784D556F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbiCJXec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiCJXeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:34:31 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D1145ACD;
        Thu, 10 Mar 2022 15:33:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so12217191lfh.2;
        Thu, 10 Mar 2022 15:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GiRdS2o0Jp10Ayb6eTN0g1SxEyVYQBd6eUBGV3Vz1A=;
        b=j42KqE/Rq7wdyPwaY9DXI2NYGk45ZDhOAH+Cn/518yEO5gmNbfIZvT7rvol9J278X+
         1wgOs2cQVACRXg629cZfpsmMjGKwn3K69DhS4pViFL3A8VgOC66lBZtnLFSKFvtiEn3A
         koiCxgdiMPiht4VJ1DW9mIlEyXqc3ZtKaUznyhIpeaUPXWc9sh0ZWJJUMQweRoz1bMaW
         2AjwApgOqWWP4rb5jggga3xWTuSaP4TBI+kSYHvg1icKHRrqU211T88N96CAYxr10rlh
         S3w7Pp3Qrjzp/234xBkoj1JyUcZWUSpJprnGT8jcJoauiaQy3NghyciN4vFym7WvwfTh
         9IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GiRdS2o0Jp10Ayb6eTN0g1SxEyVYQBd6eUBGV3Vz1A=;
        b=FC2AI5k3B4DrnekJUQm3Dxxf0EnEid14Zp2ox4DYc2rsAR7crHfZYPBZEt3iEIDsHT
         Qla3QQSv1IklmTHVK8r0VCXpXa9mll0Wwjh/qS+YJThfs1LDvJX2jC/WkfeMsKfzuVas
         FmVsEXxzEMLgkm6OeS+FyHVMpKGBME4Di8p780wAomAD0UDeZhf9aZqF/I1vAp8C3ysf
         Uc0j9E6SB8AA6thC9niyHiMX+Tr9+oDXVy2/9SKsDFeMlpL9bd7aHxIxjwMruOyUIAtK
         KntCjd8iuGwmvJuyNROwSsDcw8lWDHbML0P6pp2eFPosOw3SfUPX4cGx2GXdNMPH03Bm
         koTA==
X-Gm-Message-State: AOAM531obHXtsIfIICsIDo4yXxmcIjjqLmZgC7PHb4Jvz80m3gz7dsEC
        +VMZmSK6jmf3yEwIddoN4ho=
X-Google-Smtp-Source: ABdhPJz9/0CV7K4BR9ZZSu3QogvcjmWrVZnGcdFN0E9yH1C11eCyz6rDSKCNWamfMsDS1/jNG0SUYQ==
X-Received: by 2002:a19:674c:0:b0:448:3f49:e6d5 with SMTP id e12-20020a19674c000000b004483f49e6d5mr4382982lfj.518.1646955207679;
        Thu, 10 Mar 2022 15:33:27 -0800 (PST)
Received: from dell.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id s5-20020ac24645000000b00448628b8462sm598481lfo.249.2022.03.10.15.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:33:27 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC RFT PATCH 0/4] ARM: OMAP1: clock: Convert to CCF
Date:   Fri, 11 Mar 2022 00:33:03 +0100
Message-Id: <20220310233307.99220-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main motivation behind this series is planned resurection of OMAP1
camera driver.  Since OMAP1 clock internals have never been visible to
drivers, that driver used to use v4l2-clk to expose a pixel clock for a
sensor.  The v4l2-clk code has been recently depreciated and removed from
the media subtree, hence the need for an alternative solution.

Janusz Krzysztofik (4):
  ARM: OMAP1: clock: Remove unused code
  ARM: OMAP1: clock: Remove noop code
  ARM: OMAP1: Prepare for conversion of OMAP1 clocks to CCF
  ARM: OMAP1: clock: Convert to CCF

 arch/arm/Kconfig                 |   2 +-
 arch/arm/mach-omap1/clock.c      | 791 ++++++++++++-------------------
 arch/arm/mach-omap1/clock.h      | 191 ++------
 arch/arm/mach-omap1/clock_data.c | 491 ++++++++-----------
 arch/arm/mach-omap1/io.c         |   5 -
 arch/arm/mach-omap1/mcbsp.c      |   8 +-
 arch/arm/mach-omap1/ocpi.c       |   4 +-
 arch/arm/mach-omap1/serial.c     |   6 +-
 arch/arm/mach-omap1/time.c       |   5 +
 arch/arm/mach-omap1/timer32k.c   |   2 +-
 drivers/usb/host/ohci-omap.c     |   8 +-
 drivers/video/fbdev/omap/lcdc.c  |   6 +-
 12 files changed, 582 insertions(+), 937 deletions(-)

The series has been tested on OMAP1510 based Amstrad Delta board,
where it works best on top of two recently submitted fixes:
ARM: OMAP1: clock: Fix early UART rate issues
ARM: OMAP1: clock: Fix UART rate reporting algorithm

-- 
2.35.1

