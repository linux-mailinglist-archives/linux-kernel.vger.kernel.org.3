Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9A5A9F54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiIASoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiIASnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:43:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075DE57577;
        Thu,  1 Sep 2022 11:43:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so10840628wrq.10;
        Thu, 01 Sep 2022 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=tDY9KLkecT8kusGcpl2bZ2yreiehkuHM3UUVtCjmsPU=;
        b=cRpiB7VJPxof+TbCRpjBn2kZebccN+Y20+JcQ/ZDCHdNYW7XWtmQOElqX308u2e6WH
         zdH+XfgNLPKk67s6Y8V8mzI9SF7rK2O1zlfbQR41yTKwv2KEqMOWVshHvV0XHS4UVLdv
         6sHO45KmtXRcimrGN5IXFt9mQ8QsPsalQVNBTdYJbofz69jxK10K3M8M72Hekz9rs/WZ
         vWsqpnFD//u7x0mujoeNY8WKjZY90XmAISxuuY6OA1IkqGqUm/JfV06I5XKS8FyaFtBF
         wJGhJe3dlr5Oq9720Y6HEyOUefG/GAlrmSCCb27F/yz5WFa1Fti3ScGVqh4RhhgwUDIT
         I46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=tDY9KLkecT8kusGcpl2bZ2yreiehkuHM3UUVtCjmsPU=;
        b=kVzeLf4xMjP3LwNjsZin5RxPx4+/RmmHEBLmBj0wugBIQr2mKG58NYocbvdGyYpm2U
         7IMtEaTr07roh9/Npei0lQLM3EUoJhs+qlHxzS22jOWQSIZCdPLLev5sURCIp4Ww8Aq7
         olb69YxqRiDgBC7yIvFQ9lkibp80weLDwjzkOha9vPkTVsplOE0/D6g60X4kLevFCcbK
         SrEB0EXpiFiV/3kday/I9zpOqWfrA9Xt08/cZvsotPi/7zl/uKjQaETr0jHJnGtW3jnn
         cZaUBwovuwTsN2eWGDl5Uv5y5Kalw8d8v6F/iBW887qO3qQHNf+aMVs2AlmukDU/IAsW
         oJig==
X-Gm-Message-State: ACgBeo2NWGrbvtgO3sXe/X8WQP1+Rl3qK0Bw/PdavtfkoC/RQZuGWZBj
        Y9tblE+MMZwEmMpgQVlQDN4=
X-Google-Smtp-Source: AA6agR5xxGKb3IZESDBG+vlIDLuSiBO/5TT+x5KouHhG1Bx8oYWCNN6xIZr/GYugI7Vr3PvRCrEw5g==
X-Received: by 2002:adf:df84:0:b0:226:db0a:d8e5 with SMTP id z4-20020adfdf84000000b00226db0ad8e5mr11728021wrl.21.1662057816040;
        Thu, 01 Sep 2022 11:43:36 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003a319b67f64sm13103849wms.0.2022.09.01.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:43:34 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v3] Documentation: stable: Document alternative for referring upstream commit hash
Date:   Thu,  1 Sep 2022 20:43:28 +0200
Message-Id: <20220901184328.4075701-1-carnil@debian.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additionally to the "commit <sha1> upstream." variant, "[ Upstream
commit <sha1> ]" is used as well as alternative to refer to the upstream
commit hash.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
Changes in v3:
 - Revert to initial version as not adding the code-block:: none will
   reformat the block differently than the first variant.

Changes in v2:
 - Drop extra RST markup which just only clutters things without any
   advantage.

 Documentation/process/stable-kernel-rules.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index c61865e91f52..2fd8aa593a28 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -97,6 +97,12 @@ text, like this:
 
     commit <sha1> upstream.
 
+or alternatively:
+
+.. code-block:: none
+
+    [ Upstream commit <sha1> ]
+
 Additionally, some patches submitted via :ref:`option_1` may have additional
 patch prerequisites which can be cherry-picked. This can be specified in the
 following format in the sign-off area:
-- 
2.37.2

