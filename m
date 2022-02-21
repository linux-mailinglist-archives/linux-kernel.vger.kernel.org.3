Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F884BE099
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376772AbiBUNxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:53:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377098AbiBUNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:53:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41224BF7A;
        Mon, 21 Feb 2022 05:53:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lw4so33444023ejb.12;
        Mon, 21 Feb 2022 05:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=El2FYnbFWqJ8MOcEYqcNQD/+HC9m/bKVYX0CqwB0WKY=;
        b=UaYlQ5AKDy3ry1iI3lPRHhO5dQzDmKBfoRvlmUk/2DI4JQQMdoLX467rqqwpxhF7cW
         VxIZcsfQccGv9H+99wSTFWDUISoeKy4ut9V+tdmUXOP6C7ssRqsahg+67Sr2rYWibQzX
         BS9JQFuZSbtT2Y6S8KtFJuYVwOGXw8dYumX/oZstBfSWuxKgWu58mYHjbqVOs9/6m7en
         8rCfq2Pi4qldA0RMqRHIm83jY3MgdYdzxp2edMyYBb5Q942cmytpAiuNw+aQx5/VCQJz
         J6Rw/mKCfxguO+g+OcRw/ArU4cLuFNAXH29tum+/iG8ae6HZJgdiHrCIhYeoUXqZxFmt
         adkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=El2FYnbFWqJ8MOcEYqcNQD/+HC9m/bKVYX0CqwB0WKY=;
        b=5X52BxKZaFei29vj5xZS1/b0DZN+Ol9DzIKswpY6Exi1BOYgvw/kxMizQO/b3moDsf
         LId5YwRgDL3UgnX03c55a3QRFBAPaOmO9q3Z1QkyuT/db3q9WsYx5KJSPAF/GX4QQXrt
         AM2p9UwhcUIJ3mRHwcIDNl1lrLUPlIPzGo49+wA32WtuS5rB1uyGk8n4ZsOHRt+Eg/pC
         41sSgbKHU8xY3RWDTSNbS8TSJEE3DbW8AclaCVFHToWyE1GbPsCAvVV/XcmzFQSQwlGM
         ZWGX2aW5Om3KQw5oNHGWuGQuOcLQQouedvbSocJOu8Veb3YdEK49uDdKRH6weUC7mMvI
         6opA==
X-Gm-Message-State: AOAM532oGAngZziCiss0WQMt1tldHknVHcZy8QQQuAghH5/Od72VHSI2
        FrHPpIlnhViplgqKT/P72wdTmNvd5R23EA==
X-Google-Smtp-Source: ABdhPJwUjlffjPBP0V/IgMWBf3DmtadHWtnsx+jWBG0vCh0XG1ohzkpQP4E/gckz+q5KcEfPClkkZg==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id m9-20020a1709062ac900b006cedc0f9139mr16060173eje.206.1645451580122;
        Mon, 21 Feb 2022 05:53:00 -0800 (PST)
Received: from ubuntu ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id m17sm9053091edc.2.2022.02.21.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:52:59 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:52:59 +0100
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add AVM
Message-ID: <20220221135259.GA7306@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for AVM Computersysteme Vertriebs GmbH (http://www.avm.de/en)

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
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

