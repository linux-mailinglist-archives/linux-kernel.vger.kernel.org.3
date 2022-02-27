Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE97B4C5ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiB0L7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiB0L7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:59:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430913D1C2;
        Sun, 27 Feb 2022 03:59:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d10so19533511eje.10;
        Sun, 27 Feb 2022 03:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=MvJug4HjpA75M3roZduzKZWtrOEF3mkLSJ8qZAlurSmVYaK/npEZ88lECkBQdYQpdD
         OLLgn6botJ9sNF+HREocK5xKQz2o/2/f5KQwTLmKo85YIau/mW0qnXQ5gpq6IgEsmMLY
         5h46hvPd4sxXxiw1mQNS9800oRktBlphGtvq1ChwHbhZnffONGMSAzoXAOU/894MZtCf
         pkp97sknPmuFYFf/n/I6ACcpHHwxzhUg1kt6h1WLvXZXRkQ8VmYJgAJ0tvs8zNHaqso0
         XGSXZJ7Pc437pWc8jQXQz13gCEH4WH6oRDypaHs9SGjIymaySXoc7EMsbBc5W18sKfxX
         pnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=rvTDPkpB+o0CVENzIEmdN8F/ayxGdzu4gJ9V1HlsdmfanhRzdnsdhnlOeG9QBEvm9q
         WCILnyuPbMmkep/e3LyUMzxCX2+3V894iruvsMGNqYTnWdmjs7mHcOye29F46uywS+8A
         fBnjR1GFeVyI9WheFhyTCEy5ulnq0zXDVeASHOTjRaPbLWVEWiUCtHovNtAsYbOMo8Hp
         TtteYh4oB7uhQIeViRIV9vNLa88chH5D8Sh3cgK1X+6rbWKZWaYmg3ARsrbJKIRkoRsg
         0tGzAJcRTr1ZRe4Ym+SKsDOEwp/ubSFJGr8bfQ7pvuEppbNmcLG0snUnY+F+Sc9R8ZOI
         4Y0g==
X-Gm-Message-State: AOAM533+0ErhJmFt5VOGS0WqZ8Cm32p55VZ4wPqLylpUbY137H0C/UZT
        3Fpf4NY4pGbe0lY1CE50E9k=
X-Google-Smtp-Source: ABdhPJzPZO1WVCPmXhqeGZnER7gUT4R8bAF6591QAoHkqNbno0n1D4Sy1PetQ2dVzIbjs/saEMN08Q==
X-Received: by 2002:a17:907:920d:b0:6ce:a6fc:1ad8 with SMTP id ka13-20020a170907920d00b006cea6fc1ad8mr12242353ejb.448.1645963141725;
        Sun, 27 Feb 2022 03:59:01 -0800 (PST)
Received: from localhost.localdomain ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id dn14-20020a05640222ee00b00410b88abd6fsm4474577edb.45.2022.02.27.03.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 03:59:01 -0800 (PST)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add AVM
Date:   Sun, 27 Feb 2022 12:58:30 +0100
Message-Id: <20220227115832.13490-2-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227115832.13490-1-kestrelseventyfour@gmail.com>
References: <20220227115832.13490-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for AVM Computersysteme Vertriebs GmbH (http://www.avm.de/en)

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..0be52bb27f2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -153,6 +153,8 @@ patternProperties:
     description: avia semiconductor
   "^avic,.*":
     description: Shanghai AVIC Optoelectronics Co., Ltd.
+  "^avm,.*":
+    description: AVM Computersysteme Vertriebs GmbH
   "^avnet,.*":
     description: Avnet, Inc.
   "^awinic,.*":
-- 
2.17.1

