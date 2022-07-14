Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C195741B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiGNDHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGNDHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:07:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE524F21;
        Wed, 13 Jul 2022 20:07:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f65so329847pgc.12;
        Wed, 13 Jul 2022 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpsIYGCJRtvbx2TcIK1tJ0iVgorLSfDv+9DFPy2DSN4=;
        b=Lazwfo/fqpF69TOA7jtjH+td4DBb9lswP6ZkMoCisBJqfq6Ha29peoOA4YDgyj8BvI
         uCdYKYzDNp156QXqYEoe+t9Gu3dGnNoolpMFBMf0GS24bFMxZruHRpid18sTWzFh7eOE
         jmK68/pzXdwOuKFiIfHlH54//pEhEqJI2aE7sbRTMr9eab2fqjoaYX761fkBdFaaNGNI
         p39mWvg/jierzVIs0/OACdP9DFm02SPXgFT2nj3ySYpl0cVykHyuKsNL1P2NtBYLocxf
         GuUMIoLNcIf0F/f1CFlYdx2SJjsv9jL3Y4orbEcNp2uJEBMH6ktr8AGhytFYUw1U0o+W
         I7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpsIYGCJRtvbx2TcIK1tJ0iVgorLSfDv+9DFPy2DSN4=;
        b=08ozk5lbfdyWxlcg8b87/DJ6CyylNh5aRVeHtf7FrJmFcpure+gm9WYCThxalMDE6R
         3KcdzrxEhnt+8nGZPeSrYL0/F92cXOqRwnMJhLM0PVQbNx34sZx9zZYcAvk5WckOwBXa
         gA1SFBRmB/BqnHWpNsU3B4WHqM8traPPYCD9j6uGJ5g2I9htH4aUHcNY+FF7eeLk+rOY
         ejA0G6Xsw7+tV7zH5U2A1vG3QEVv8tJVh+v8hITFCRBwUR3af4cIX4oS6+BpQKiTH/l0
         rXhruWfoSOBeErnyq5gVn0I66yzYdhCnoZVP/or3r1dcaO9yZ4ASjuWv1WvRMnXxPaNk
         y4kA==
X-Gm-Message-State: AJIora8w223Vz7ZKYKze62YYyPwQLKHrzmNYOPvH5nnlpwB8YzLtSyen
        kTUfm59t5NOpWJj7bqKRw/g=
X-Google-Smtp-Source: AGRyM1shLTh26wR2ftEvFV03APn1UHO3jup7nrXQ4QA0BJT9Kx9IUVLf32gdKb6a3nLP9ydlwp7V0Q==
X-Received: by 2002:a63:4462:0:b0:40d:fb07:ec27 with SMTP id t34-20020a634462000000b0040dfb07ec27mr5453401pgk.346.1657768019609;
        Wed, 13 Jul 2022 20:06:59 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id x89-20020a17090a6c6200b001e2f892b352sm2343604pjj.45.2022.07.13.20.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 20:06:59 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Date:   Thu, 14 Jul 2022 11:06:35 +0800
Message-Id: <20220714030636.3000-2-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220714030636.3000-1-jimmy.chen@moxa.com>
References: <20220714030636.3000-1-jimmy.chen@moxa.com>
MIME-Version: 1.0
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

Add DT compatible string for Moxa UC8210/8220 i.MX7D board.

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..fd26b93b4388 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -756,6 +756,8 @@ properties:
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
               - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
               - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
+              - moxa,uc-8210              # MOXA UC-8210 board
+              - moxa,uc-8220              # MOXA UC-8220 board
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - remarkable,imx7d-remarkable2  # i.MX7D ReMarkable 2 E-Ink Tablet
               - storopack,imx7d-smegw01       # Storopack i.MX7D SMEGW01
-- 
2.20.1

