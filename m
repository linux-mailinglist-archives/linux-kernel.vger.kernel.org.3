Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446C44EA49F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiC2BdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2BdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:33:19 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C046B35;
        Mon, 28 Mar 2022 18:31:37 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d6ca46da48so17168674fac.12;
        Mon, 28 Mar 2022 18:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hOkp2b7cCGdHLUJIn9iwgpkz8KjzZSClL6Y3bsniN08=;
        b=VLa5FoT4kkOPBzrqKZelc50x/bukOpE74vhMnoCoOg6NMBDHD6ry62CyTJGyt3Df1N
         Yw2oobuYE1ED2AWWfaxnuSI0/QMsSFMOnI7W4VH6sP5GXvj0cFl69sohe6Exa0Jr91VQ
         DdiyujMOicAoOi8HXqR3PG1TMFcTRQZ08fzE8OjmfbCMs0euc86lyQElqLZhoXJWKfBS
         qwh02SOWuLXyt+GprRQij3UdCG52DywDVe0qVAayLcfw7VIox230WNmBJtUtKO+NlCap
         x+3ZpqvjOi82rZm/O/ENfCvURXfbtWeN5DJU7Q1WjOsP9RUzZAeudv2OQjeCjJbAsJWl
         Yveg==
X-Gm-Message-State: AOAM530WXBRcufYuiFqpm0TyJJ/oAn+aeqZ8uoNbBOVbVMBaTKVXpb4c
        TDKx4ZbJfLwyPPpjRiSg6A==
X-Google-Smtp-Source: ABdhPJwMspGsWseezeQN7a6YfynW2z7z862xFVW7VEkyda1K80XIrGigHCp4ABfQUofLXCydksAoJg==
X-Received: by 2002:a05:6870:51c9:b0:da:b3f:2b75 with SMTP id b9-20020a05687051c900b000da0b3f2b75mr1030761oaj.276.1648517497176;
        Mon, 28 Mar 2022 18:31:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm8286256oth.27.2022.03.28.18.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:31:36 -0700 (PDT)
Received: (nullmailer pid 3490320 invoked by uid 1000);
        Tue, 29 Mar 2022 01:31:35 -0000
Date:   Mon, 28 Mar 2022 20:31:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [GIT PULL] Devicetree fixes for v5.18, take 1
Message-ID: <YkJhd/QX64LDANXN@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I haven't seen any progress fixing the MediaTek DRM binding issues, so 
I've applied the fixes here and a few others (also MediaTek, sigh). 
There's still a QCom DRM fix pending that hopefully lands before rc1.

Please pull.

Rob


The following changes since commit 7203062171db6669f746d14148c4af76af619e74:

  Merge tag 'tty-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2022-03-28 13:00:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-1

for you to fetch changes up to 22a41e9a5044bf3519f05b4a00e99af34bfeb40c:

  dt-bindings: Fix missing '/schemas' in $ref paths (2022-03-28 20:17:55 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.18, take 1:

- Clean-up missing '/schemas' in $ref paths

- Fix MediaTek Vcodec decoder example 'dma-ranges' errors

- Expand available values of PBL for snps,dwmac to fix warnings in
  mediatek-dwmac.yaml example

- Fix warnings in MediaTek display bindings

----------------------------------------------------------------
AngeloGioacchino Del Regno (3):
      dt-bindings: display: mediatek, mutex: Fix mediatek, gce-events type
      dt-bindings: display: mediatek, ovl: Fix 'iommu' required property typo
      dt-bindings: display: mediatek: Fix examples on new bindings

Biao Huang (1):
      dt-bindings: net: snps,dwmac: modify available values of PBL

Rob Herring (2):
      dt-bindings: media: mediatek,vcodec: Fix addressing cell sizes
      dt-bindings: Fix missing '/schemas' in $ref paths

jason-jh.lin (1):
      Revert "dt-bindings: display: mediatek: add ethdr definition for mt8195"

 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |   2 +-
 .../bindings/display/mediatek/mediatek,aal.yaml    |  23 +++-
 .../bindings/display/mediatek/mediatek,ccorr.yaml  |  23 +++-
 .../bindings/display/mediatek/mediatek,color.yaml  |  23 +++-
 .../bindings/display/mediatek/mediatek,dither.yaml |  23 +++-
 .../bindings/display/mediatek/mediatek,dpi.yaml    |   3 +-
 .../bindings/display/mediatek/mediatek,dsc.yaml    |  23 +++-
 .../bindings/display/mediatek/mediatek,ethdr.yaml  | 147 ---------------------
 .../bindings/display/mediatek/mediatek,gamma.yaml  |  23 +++-
 .../bindings/display/mediatek/mediatek,merge.yaml  |  49 +++----
 .../bindings/display/mediatek/mediatek,mutex.yaml  |  27 ++--
 .../bindings/display/mediatek/mediatek,od.yaml     |  14 +-
 .../bindings/display/mediatek/mediatek,ovl-2l.yaml |  26 ++--
 .../bindings/display/mediatek/mediatek,ovl.yaml    |  28 ++--
 .../display/mediatek/mediatek,postmask.yaml        |  23 +++-
 .../bindings/display/mediatek/mediatek,rdma.yaml   |  28 ++--
 .../bindings/display/mediatek/mediatek,split.yaml  |  17 ++-
 .../bindings/display/mediatek/mediatek,ufoe.yaml   |  19 ++-
 .../bindings/display/mediatek/mediatek,wdma.yaml   |  26 ++--
 .../media/mediatek,vcodec-subdev-decoder.yaml      | 122 +++++++++--------
 .../devicetree/bindings/net/dsa/dsa-port.yaml      |   2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   6 +-
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   2 +-
 .../bindings/spi/mediatek,spi-mtk-nor.yaml         |   2 +-
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   2 +-
 .../devicetree/bindings/spi/sprd,spi-adi.yaml      |   2 +-
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |   4 +-
 .../devicetree/bindings/usb/mediatek,musb.yaml     |   2 +-
 28 files changed, 338 insertions(+), 353 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
