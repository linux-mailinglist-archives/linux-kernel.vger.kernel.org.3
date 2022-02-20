Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06DA4BCF50
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbiBTPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244174AbiBTPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2D3524F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x5so17986950wrg.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/VvSdH35ggdYDcqIG7rPDjoDjcMStnpl398SZrCoVM=;
        b=sBv2S4ThUynti8f6Ov4KGbgmJQjGpaq9nYPYhwFS75TV/dPTMnhi1ZJ9GL7qtg9i71
         /IzIX+JjfmIGvHuIY3al4rQl2j2KrcUEnG6Q2C9SkgUqce86+HexGgfMqDgxQ5BYSe7B
         1yhwkUuQeEMRUsDKlh27VcRBRuSKTqrxS8G4h2dYRHBuNV9D2WWnAE09zmPEVrW+JlhO
         s3ws94MUSonz9tcsdblgew6ofU8wdeUzw/prDMvNvFOl5dyX9evv17iHtwOU3NcY3DIS
         gpv+pMDo4hOhxefJOyuhmTQuPtjBHeRZeDHh5ET8SiSLRH0jPqLrIzhk1CvmFRMioam8
         4yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/VvSdH35ggdYDcqIG7rPDjoDjcMStnpl398SZrCoVM=;
        b=Vb9+nQQlgxmOc5BNTsruMijUB9cQ8PfRqaTBxvUWwnnzEvvvpEW2VPgFFKZobwykNT
         L0UPfVAT1J+gdLxcbMYeDe/NlwIktQPGJ+dm1xbPUig+vJsD602lBIg0pcZqZkYP067R
         rKFQ3RK4dsZpyvxChQ4o9FjycDbmqIDITwMeJHp8Bk4M5RCKY3amZl8NS6q9kZxbDfOM
         KyQsbjGL4JpwFqFK8pH1PxbgYh0Jo1o/6qSYF+xRzjK7smsY5VWs0AjWWYl0xAfGzRPI
         aY+Z8Jwa+OP6EM2Y1q04gMQnCdcoN96FL1MNyycd1LSZNN/p1sOf7gLhHgimVbUEnrEd
         V/SA==
X-Gm-Message-State: AOAM531yEjIhK9MYpFuNtkDIYpvzvr6EfDHUeq8kBrzJD7zncT0tmAGI
        D7/tjXdN9mIXyfmCcn+Lg5T3aQzFtAtNPA==
X-Google-Smtp-Source: ABdhPJxTxkdJtYzYi5GuA97M550o0mpl5acA+YAXlVRU0AFRSd7fEnOiP4Ql+bz6fUmKYaYeUaxRVw==
X-Received: by 2002:adf:face:0:b0:1e3:260c:f824 with SMTP id a14-20020adfface000000b001e3260cf824mr12570884wrs.181.1645370158718;
        Sun, 20 Feb 2022 07:15:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/13] doc: nvmem: Remove references to regmap
Date:   Sun, 20 Feb 2022 15:15:24 +0000
Message-Id: <20220220151527.17216-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

Since commit 795ddd18d38f ("nvmem: core: remove regmap dependency"),
nvmem devices do not use the regmap API. Remove references to it from
the documentation.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/driver-api/nvmem.rst | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 287e86819640..56352ad1b1b0 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -26,9 +26,7 @@ was a rather big abstraction leak.
 
 This framework aims at solve these problems. It also introduces DT
 representation for consumer devices to go get the data they require (MAC
-Addresses, SoC/Revision ID, part numbers, and so on) from the NVMEMs. This
-framework is based on regmap, so that most of the abstraction available in
-regmap can be reused, across multiple types of buses.
+Addresses, SoC/Revision ID, part numbers, and so on) from the NVMEMs.
 
 NVMEM Providers
 +++++++++++++++
@@ -60,9 +58,6 @@ For example, a simple qfprom case::
 	...
   }
 
-It is mandatory that the NVMEM provider has a regmap associated with its
-struct device. Failure to do would return error code from nvmem_register().
-
 Users of board files can define and register nvmem cells using the
 nvmem_cell_table struct::
 
-- 
2.21.0

