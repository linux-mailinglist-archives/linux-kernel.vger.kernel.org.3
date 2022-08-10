Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1458E46C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiHJBUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:20:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD0CF595;
        Tue,  9 Aug 2022 18:20:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o3so12913937ple.5;
        Tue, 09 Aug 2022 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=oGCv7UOSFGXLD0hQznWAtmA26tIFvqeIa9EinYUWVqA=;
        b=fC0U2DXU6q9z36mNMnyJd8n0tF2sj/fY4ZoMcLQUglJ5Mv8CeapvBbb7hzgSHJ7wZ6
         q1pWb3XaRBWx01MTbTw0YK//UMKS1o/PT4aN2QD6eJ2DfnBlH57zmqU0XWGWEKvutvtP
         Cxo77XVPWBLi+eUFsxt1b3Y02DBIBXJB/38TjW3EyLYgJrFTycwI8Zja8DE/7N5+OSyM
         RkqR2Dvco01PIFu1bTvvkMbsxVOGt0eHciLupObXtOqJ1GMVQaBI80VxcHvI1Su1arE6
         n7UXUsG9cRwaLeOcFX90v2jZCDmUmVEPIrj+ZmFYMTvZl48Z6obELvUcxTIghUvn3Tbo
         r7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oGCv7UOSFGXLD0hQznWAtmA26tIFvqeIa9EinYUWVqA=;
        b=S6zMy9mPjIzndAItNFeWRrqehNLbafYPKY4Wv5+J6mk3plm5MgTNWQ6P6c0lzjezW0
         xOL7DNnl/YtZWQiTaTK9YgQqVP1YXkFm5o4Eec5iBx67Kt3Bbf0HhTkLtrZip9dGBtoC
         db3B0PH63Kihc9+Q8qXaJ+rdS9+vgI4pZXQxPUoX1AXRAiuLKabWJD+EbQGwfS99L7Cp
         PZ1mKYRG/Ors3IvomxUXWF/2LRCuYD/69yUwV4HvQyVLoSq+VjgBDJPXcnnI7hPd9SQV
         nGng5m07j3Fv+zfrIq8eFTvZMzUL2GOQmuKHy6+Umep0QFkvUKGWX1mWpgfdNjP0+olM
         O82g==
X-Gm-Message-State: ACgBeo0PFTvmhaQYVwk0aTBHuXKbwGr1+sQQhAGaX8ofS5KcQ9ogqzq2
        /Z/jV8MQ+aVaSLTJ9YUzd3Y=
X-Google-Smtp-Source: AA6agR6ABR8JaIlus86kMkZiJWMLOXekVsGlDr2DXxQHm6TZBGj3W7vZVDhoDRAZOK9tv4j/eoAv5g==
X-Received: by 2002:a17:902:ce8e:b0:16f:8f2b:b16f with SMTP id f14-20020a170902ce8e00b0016f8f2bb16fmr22570853plg.167.1660094451054;
        Tue, 09 Aug 2022 18:20:51 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b0016c3affe60esm11356754ple.46.2022.08.09.18.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 18:20:50 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] Update Facebook Bletchley BMC devicetree
Date:   Wed, 10 Aug 2022 00:43:36 +0000
Message-Id: <20220810004338.329832-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add modifications as below
1. add a IPMB node for USB debug card communication.
2. remove hdc1080 node due to incompatible 2nd source (si7021). 

Potin Lai (2):
  ARM: dts: aspeed: bletchley: add USB debug card IPMB node
  ARM: dts: aspeed: bletchley: remove hdc1080 node

 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.31.1

