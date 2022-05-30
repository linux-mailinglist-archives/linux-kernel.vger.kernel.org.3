Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D7537B13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiE3NI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiE3NIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:08:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D247091E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:08:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l30so11585207lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIujuQod5DVdj9IOGigqFZqjY7YBi3dVh/6yMdzrZAw=;
        b=h5G+fuIO0MXa4WegYi6cGx9uxOUwGL335ePiupowBAHxVsTjTv2zGMWmH5tYUKXBku
         rQD7zP4p2tefsKn8OeY9Suv7SpgxClthr5atyE/xpNfG8OyVmLysyisekAbr3VPL2j9X
         q5BxejUFlVOAmUxVcrqVFvi3Hkw3aow9gqo9SfvPDuksIl7MmNaG6ZIBtT9oPtSQ0/Ca
         4o42P5s44jkJmlsUJiz7HhpZFc1CVxMn3hIf1mFXsUmQx2gJvIwoKLJzq5tIlHZSwkUf
         s3j4aoatQRS9eYBLKzGnmfB9CUI4LMeH8yQkv1jKI+DDqmeOMQBwDNF4M+WDs0+lLwgH
         eGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIujuQod5DVdj9IOGigqFZqjY7YBi3dVh/6yMdzrZAw=;
        b=4+ObcrRNdYpe410mv78bhTKmhbUk54Q40jYJEmJqdSpoIZy+TblKAsaLwYH2IHk41u
         4RiPq3kCscQ2PDZTGigQej1IbGhERBKIp4kom6xDhkkrx22Gsv7SIQd04+4HTeC1x9UC
         ZKFMOIHoUqfFLoWHjrshirfbH66gDgcyZOQlgMpvGFY8GkO6Ii4tszbXb3KqxhofRjsl
         yaX/ApJOzoOhr14QFSw2m+9PtStyTtz3KxEy1xQVmvehstATUiLIsSxtm2H2itBb+aNC
         IWzLJZzzWbKZnnOJGkB0cJwpksoDCGaI89c78MYzRrnpcEezVj/QAEkrGME4icHVvKDl
         g5Hg==
X-Gm-Message-State: AOAM5315dTpJB9s1M4HnqiBy4tlxlu8YgwsklfDAlJ/nr7TU5e4WLv93
        /yLsAGdKUssEX2G6q/RCg2FBfg==
X-Google-Smtp-Source: ABdhPJx8Ofkq27A7VN9Zy9Ow+GFIdKR30yfpaUH8g5z3Y7eK9RQtvqHPV2ok6+38zrAwcIU01Cjw2Q==
X-Received: by 2002:a05:6512:224e:b0:478:8f1b:50be with SMTP id i14-20020a056512224e00b004788f1b50bemr21778528lfu.639.1653916127590;
        Mon, 30 May 2022 06:08:47 -0700 (PDT)
Received: from panikiel.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id d22-20020ac25456000000b00477a7c8a0f0sm2295701lfn.295.2022.05.30.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:08:46 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 0/3] Add Chameleon v3 devicetree
Date:   Mon, 30 May 2022 15:08:36 +0200
Message-Id: <20220530130839.120710-1-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Chameleon v3 is a board made for testing both video and audio 
interfaces of external devices. It acts as a base board for the
Mercury+ AA1 module.

socfpga_arria10_mercury_aa1.dtsi and socfpga_arria10_chameleonv3.dts
have also been sent to u-boot:
https://lists.denx.de/pipermail/u-boot/2022-May/485107.html
https://lists.denx.de/pipermail/u-boot/2022-May/485111.html

Paweł Anikiel (3):
  dts: socfpga: Change Mercury+ AA1 devicetree to header
  dts: socfpga: Add Google Chameleon v3 devicetree
  dt-bindings: altera: Update Arria 10 boards

 .../devicetree/bindings/arm/altera.yaml       |  2 +-
 arch/arm/boot/dts/Makefile                    |  2 +-
 .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
 ...1.dts => socfpga_arria10_mercury_aa1.dtsi} | 68 +++-----------
 4 files changed, 106 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
 rename arch/arm/boot/dts/{socfpga_arria10_mercury_aa1.dts => socfpga_arria10_mercury_aa1.dtsi} (58%)

-- 
2.36.1.124.g0e6072fb45-goog

