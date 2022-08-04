Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1558A2AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiHDVI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHDVIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:08:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B56FA34;
        Thu,  4 Aug 2022 14:08:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a89so1187125edf.5;
        Thu, 04 Aug 2022 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=Gainf9eaperrZD6f10SIq48VatKE6/ESw2CowVGlfgX7iz7Pas8zvPIYP9cMbNMhns
         /wpmz4+2FOVDOZq7grMubJH1F5g5fjR2aBFVyRpZZpo8EEK4I7D9E2oDfhLg6R61otzW
         dIoeqRYpuxDzhsi93ZlvhgUHHhUCnU0Va2H02J+tK/xQfEw73PohZddhOD2DAjnKtBrg
         oEDriTj9dWefjEcr1875vadCsRvz0jBTQCUgQ3ww9vaT1R89AGsZPX9yLecXF4EXc5DE
         6zNJkjygNcWw5DWbbUtwMwGy1z3kIw+YHeoqJyeD+MYDDIuQv2NiAcKc+gXHO5gSkd1t
         GOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=2AWjsJqXDN0a+W7fwm15UkjmsyFsxPxgsQrF2hhI5kgkeBAD5joTbMckg3eJ4OH0Lc
         zo0GY6QO7D/oOkQ9HMkdPC8EPyEqvJZs9EAiVYOmfkZpEog/j+MVAL9CVL/K/wd3L1S0
         XhEVXk4MzxEiS0JF+Plg/lt/sr5qgzfcDlbw3RPxTkK7fuYyddubkA8TJXiyyY8U9gyO
         jnnV8O3R+EoXYj0DKgpkP1RBQsuZBDhifI2qagLGpzWzyPkwZAoqGcn5S2FK3HICTNcL
         MNAQeZNwuu5/zTPYlQ8V2fHET0gwesChMe/drhVy1BIfW7EPtY0gJlBIq6ndp4zi7w3/
         V9kw==
X-Gm-Message-State: ACgBeo0kOlzxHkQv5/aenII4uSQXn2nbyILcYdej44tQqSfyzVsl82Hl
        n8qcaVVZnH4U0wx9TG3VnloL+rorrOSUqA==
X-Google-Smtp-Source: AA6agR5H1IRngd6quCP7Kc51vcY3TlKFCXz/igPnrCWC7kTK672PyHrxtjtjvXldIY3dZE6NAB4vhA==
X-Received: by 2002:a05:6402:2793:b0:43e:16a0:cb6b with SMTP id b19-20020a056402279300b0043e16a0cb6bmr3834401ede.387.1659647300335;
        Thu, 04 Aug 2022 14:08:20 -0700 (PDT)
Received: from ubuntu.fritz.box ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b007308fab3eb7sm699407ejg.195.2022.08.04.14.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 14:08:19 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
To:     kestrelseventyfour@gmail.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Add AVM
Date:   Thu,  4 Aug 2022 23:08:04 +0200
Message-Id: <20220804210806.4053-2-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
References: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

