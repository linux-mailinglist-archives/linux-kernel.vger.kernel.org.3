Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2416E54C680
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbiFOKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243605AbiFOKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:50:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F442EF2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:50:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g7so15530279eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbCRVWIg4yL03ydTTeDTrw0h6dDwfLEEv0WldNRrBJ0=;
        b=TVggHuvr//aXDNq+7VKamTSVvqhHY9sfUq+r/SbSvc2QBQRcNFlBkxURmbGz223Bzr
         LmnQgN4H6WIJc1CmOmVavZSBuXp+FzNOpGUhVG5IAz5VRyL0JZ90AnvCKDBPZh1VNsV0
         VZFBAG/Tmf/Qltcm7iTocSof/MXJo5EqIlLF/Qq8BXlh54fOS8XM5RafTz6XkzehoeXw
         //zDQFeEbwfLIXciG0hhDYwX4LP1Lsp48VxCMRtZe7FiXBW8LhFvbuafbUrh6ClmDgsK
         mnQuMD3JhKUw+Li29Mi1p26ztKwjP+bwglh/+FSKxJK1YTNo8D29/BJBR+c031tp3TB2
         ZtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbCRVWIg4yL03ydTTeDTrw0h6dDwfLEEv0WldNRrBJ0=;
        b=k+n1OAhBrBFnUMuKADVPDDMs3z6BOsD71iHaFBGs7SyJ+ObKqApyYgmmoiOYHplwtH
         D0bE0LOm9EtB/coCINT6U8gALG/gbu1eJYIyS0AhwZOEjYIQY/ac86SfppXRafjv7dzR
         u0fKdjn8JQjH310MO2KDcUSx2ifVoe4gvkSJSTaVbBwnSDlndOMhDXg1QAY73GTPGbyh
         xQuczbT+paD8va0l+gpzkZpuTvYk7qKgsI1x2uEO4JQz2U2eBlJ+/te5vmVDX50Nt3Kk
         v60y2+wgCgg1NStYzz/xI4irTSkCFTa1DeAwaxQuDWNZ3Ku3hgmv1F4aiS/j4wbBWGjd
         GMPg==
X-Gm-Message-State: AJIora/Z7DvBaR/brmdfwoPecA3Fe21cvqsY5gnFJ0vkY06sFbY/DFv0
        cBHn10amdgyYEJMBTmKkE0vS2A==
X-Google-Smtp-Source: AGRyM1v4osd2jLFu0NBoRQ8Z2FPYoXw0b0vPMIyCD/IsDFsa9svxPp1gNAHB9OPT0w7HvcgiovglRA==
X-Received: by 2002:a05:6402:4241:b0:431:574a:d74b with SMTP id g1-20020a056402424100b00431574ad74bmr11789245edb.374.1655290244091;
        Wed, 15 Jun 2022 03:50:44 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-088-153-019-247.um27.pools.vodafone-ip.de. [88.153.19.247])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709060c5b00b006fec2097d53sm6098237ejf.118.2022.06.15.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:50:43 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] pinctrl: Add Cypress cy8c95x0
Date:   Wed, 15 Jun 2022 12:49:18 +0200
Message-Id: <20220615104921.1390138-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cypress cy8c95x0 pinctrl support.

v2:
 - Update DT binding
 - Support output pincfg through DT
 - Always expose all GPIOs and ignore ngpios property

Patrick Rudolph (2):
  dt-binding: Add cypress,cy8c95x0 binding
  pinctrl: Add Cypress cy8c95x0 support

 .../bindings/pinctrl/cypress,cy8c95x0.yaml    |  131 ++
 MAINTAINERS                                   |    6 +
 drivers/pinctrl/Kconfig                       |   14 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-cy8c95x0.c            | 1380 +++++++++++++++++
 5 files changed, 1532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
 create mode 100644 drivers/pinctrl/pinctrl-cy8c95x0.c

-- 
2.35.3

