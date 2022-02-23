Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DC4C1F69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiBWXPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiBWXPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:15:09 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6C4969F;
        Wed, 23 Feb 2022 15:14:41 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id x6-20020a4a4106000000b003193022319cso892089ooa.4;
        Wed, 23 Feb 2022 15:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pDAbhMLqwFuK8xs2hO/0Bxu3J2o3Pp4IuTbDF5StkNI=;
        b=ODs/HvB2qIYZDjUw7h7O8RfgSkywzWGQL1VVtIM6cks1txqc9amFs3Obdn5pIDTr5Q
         jDeRY9V2sfEt7CFznYtdjnCx1sFQqjvdq92tmvUdLeKKEpgLUpM1/ivBVLeeYlHaT7x8
         4tY9bgj/Zc1dd+9pTEYxYsBdZ9SsmRsanE47YcXfltpMeLOYG1mtFmsoH4nmMtG/yzzj
         NtnicMZdmyWzTZbHvajBlFBd3KLGG2Yfvx3WzCOzIfcmxYAxbSoNGIjb/wctj0kQ4r1v
         fEcRxOF+4MASyVcH36cDKZTGVGDOjbjl9eNBBD+134YfWMpMnRVfBFTrjPNRFRJUHSMJ
         Jp1w==
X-Gm-Message-State: AOAM5318TkzUIPObHh8asFOuwbF0kZ2fdZk/NLN40K+W/DwzCDfKGU8I
        xfhN9XhcxurNsdrwarfFAg==
X-Google-Smtp-Source: ABdhPJwpSX0Fz2OEuOo15ErSfOFt6amqRw5vARvyJEffvXlmNa02ukbyfdrvsUbPxBu3rpSa+R+b9w==
X-Received: by 2002:a05:6871:82c:b0:d3:3713:4bd2 with SMTP id q44-20020a056871082c00b000d337134bd2mr972486oap.171.1645658080417;
        Wed, 23 Feb 2022 15:14:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o15sm405079ooi.31.2022.02.23.15.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:14:39 -0800 (PST)
Received: (nullmailer pid 1720462 invoked by uid 1000);
        Wed, 23 Feb 2022 23:14:39 -0000
Date:   Wed, 23 Feb 2022 17:14:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [GIT PULL] Devicetree fixes for v5.17, take 2
Message-ID: <Yha/383yJgJFHqPR@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes.

Rob


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-2

for you to fetch changes up to 0c0822bcb73f154d96ee648644ec5a8628e3b864:

  dt-bindings: update Roger Quadros email (2022-02-22 16:06:31 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.17, take 2:

- Update some maintainers email addresses

- Fix handling of elfcorehdr reservation for crash dump kernel

- Fix unittest expected warnings text

----------------------------------------------------------------
Frank Rowand (1):
      of: unittest: update text of expected warnings

Krzysztof Kozlowski (2):
      MAINTAINERS: sifive: drop Yash Shah
      dt-bindings: update Roger Quadros email

Nikhil Gupta (1):
      of/fdt: move elfcorehdr reservation early for crash dump kernel

 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml  |  1 -
 .../bindings/mfd/ti,j721e-system-controller.yaml         |  2 +-
 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml  |  2 +-
 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml    |  1 -
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml       |  1 -
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml  |  2 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml        |  2 +-
 MAINTAINERS                                              |  6 ------
 drivers/of/fdt.c                                         |  2 +-
 drivers/of/unittest.c                                    | 16 ++++++++--------
 10 files changed, 13 insertions(+), 22 deletions(-)
