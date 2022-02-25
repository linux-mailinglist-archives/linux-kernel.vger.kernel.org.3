Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF674C3E69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiBYGcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiBYGcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:32:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030C1AF38;
        Thu, 24 Feb 2022 22:31:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e6so2403731pgn.2;
        Thu, 24 Feb 2022 22:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iKmbb5ucbZp5K7dfHQDKEihiAqkn6WCzt4BOscJ3yD4=;
        b=kjuQjICBQ7dzWL0H/JHSeBz9vXXK+N2w6OIQWMZYKn728gA+JsM9ImX+xK4fv67CHU
         w1FbkB/Are/1QZY/DC0fOkz6oDA1I6pn45aKA+DCxkDKbX9tsPrbJ5mD6b2E1ZPmghlS
         z7Ypk5R5jGI2Jc9Hm8xp5Lf3FeGxa5VEVSjg1gTzviJdVCsg/qBJ1uj6yRnkVmTXX0aV
         hOOXhR+EL4Zq8Kbc8yA9aorJ/Pkih9IIuLbmjRLeKcB0NQTBiOkyHagK7nq4Fm0b1AGf
         P0LrEUpXlUjYYbQOMh0v1rHFXIe/qbO1bbhcIihio65jXmlSpnuOETYW2A4wRUbnlwES
         Eo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iKmbb5ucbZp5K7dfHQDKEihiAqkn6WCzt4BOscJ3yD4=;
        b=svg2oTuMq2Z/Ro5YrPeyHbW6C7Oep4n5FKopoZX9tA7TG4mYHqXyOAD7LUhk6dmF9m
         pKtg9nI+mjXYhDWEY73la2jeOvTxcdNl85c9WzFZNqBpcxswRRDYezJkf/mCJ+QWQ+vr
         xL6ocZwf9r7ZB0DGHcsmvXOqsFcZP1dSaMMhX6BdclFYRrXyHLTLvYle4wKa/4PIElQa
         3GUO0x6ZciAKXgKmrVcVVn4C3vqJPJrUm8ASPMMHeIptYj1ckBtoF170H5qR9Uocmzwa
         p6wEi/CUTw6yF01p8p8FNkzvwCOGqDRJzqMtQPtbD2c8kn3YwjoWYsAKPrdgp5ZrR7KL
         wzgw==
X-Gm-Message-State: AOAM5313Ft1XhomV68vzv7+isw9/nPAAqPLikm1C44Tc0ctXBoKp3dMR
        WV5Lpl37Vcs4cT1RfRcMTGc=
X-Google-Smtp-Source: ABdhPJxJNKzhvpVLd0yf5JAP3wYExfPs1r7+3tbNJ5EuzHC0v6If/KgvuR9ngHo98GPGUOn+O520sA==
X-Received: by 2002:aa7:81c3:0:b0:4f2:6d3f:6158 with SMTP id c3-20020aa781c3000000b004f26d3f6158mr6366120pfn.82.1645770695471;
        Thu, 24 Feb 2022 22:31:35 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id f18-20020a056a001ad200b004bf321765dfsm1647472pfv.95.2022.02.24.22.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Feb 2022 22:31:35 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH] spi: dt-bindings: remove unused required property
Date:   Fri, 25 Feb 2022 14:31:53 +0800
Message-Id: <097bbc8b703b17e8fb3e3f6f6d2f97fe668bd5c5.1645770648.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix issue
/builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.example.dt.yaml:
spi@9C002D80: 'clocks-names' is a required property
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
delete unused required(clock-name)

Fixes: 3b8ab4da34 ("spi: Fix test error for sp7021")

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 298eac2..3a58cf0 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -50,7 +50,6 @@ required:
   - interrupts
   - interrupt-names
   - clocks
-  - clocks-names
   - resets
   - pinctrl-names
   - pinctrl-0
-- 
2.7.4

