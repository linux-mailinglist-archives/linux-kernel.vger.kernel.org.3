Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC87597A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiHQX7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHQX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:59:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7473302;
        Wed, 17 Aug 2022 16:59:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 202so13247044pgc.8;
        Wed, 17 Aug 2022 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=Niq05ZlOgUrh6vX28ExFQ/HZPhi4Hjl0ZKDCJqxaD6E=;
        b=d1OFspnJweo67R2xXSepg9703G0DQHublnLafWhwOfGFiPc35P/+DTr+uLRlcaLCwO
         oWoKu8uhO0TpnVcNh8SBvdgMqyDtd+yHzwbQGh7e2ubNKeRUgFdZufrPvqBt8UohHDLw
         Y93hdwJ5rOpduzVShGxKLmfNoUr84VV/N3FXyBR2GmMbnqpcZxZdcQOi4nyThBamkDkz
         9cPdmceCtA934ncHyqJIBbmJcmEK/usbep1avdGDTo4nApHeNOXxrQG7Pwe2EP1PNo3s
         saTPWKSfugFqP6obj0+ptaPIuoyyFKZ8dqIJjJX1x4PB5eRTkd1RMlISWveClR/JwAeQ
         CSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Niq05ZlOgUrh6vX28ExFQ/HZPhi4Hjl0ZKDCJqxaD6E=;
        b=eA4w4iLnVHyZ+xWIt9ZQgI5SdfWdVZ9a2OQqm4UY8olOFPiG85kB0Ru2CqeLgvwOHd
         6GxVwEzKYCdbcubQUSiSqPZUiZnNsRj5V+o0L37iC8Xl8AN4OXOzAm9MuKQtxD6OzT5B
         q9xxpXDOhFnAciQumH9qWo3y3oD7Bs5b6H9jD32xhEGItWrpXDg5+A6kCStrbnlXfcOs
         AhA52zEokZ2dAfCpz4ps0RJbLBa5akMyrRJ6TkefZ7cbyY7yzJ2aYlxXLQbH7n7ciuJY
         eT1k3K3uLCQQe7CZeupXzB/SUgUpRYNEWCO80dTqTKQ5o2dd4z5AMpFGUZ6QS8jWnAE0
         lCcw==
X-Gm-Message-State: ACgBeo3z5RIRFy1IspgZsI0/mBZcM2qbi3CpDkwFosv8k8b3jwS5xQWP
        ptZbrWEEpXlV5V4iIv5P3+f8oUSG4hk=
X-Google-Smtp-Source: AA6agR5o5napcMSJPXhhrusA3eLJ79A10eMQMCKcmQKrbBMeg1roqU/EGt22l8lNz/P70BeEphc8dg==
X-Received: by 2002:a65:6d85:0:b0:429:9ce8:6a60 with SMTP id bc5-20020a656d85000000b004299ce86a60mr497064pgb.352.1660780748134;
        Wed, 17 Aug 2022 16:59:08 -0700 (PDT)
Received: from thinbox (23-122-134-180.lightspeed.sntcca.sbcglobal.net. [23.122.134.180])
        by smtp.gmail.com with ESMTPSA id c138-20020a624e90000000b00528a097aeffsm95218pfb.118.2022.08.17.16.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:59:07 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:59:06 -0700
From:   Maurycy Z <10maurycy10@gmail.com>
To:     linux-config@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH/RESEND v1] "system" mispelled as "ststem" in help for
 configuration option SND_AUDIO_GRAPH_CARD.
Message-ID: <Yv2AytbyUT/pCrn+@thinbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"system" is mis-spelled as "ststem" in the help for SND_AUDIO_GRAPH_CARD.

Signed-off-by: Maurycy Zalewski <10maurycy10@gmail.com>
---

diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index b6df4e26b..72f3446e1 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -16,7 +16,7 @@ config SND_AUDIO_GRAPH_CARD
 	help
 	  This option enables generic simple sound card support
 	  with OF-graph DT bindings.
-	  It also support DPCM of multi CPU single Codec ststem.
+	  It also support DPCM of multi CPU single Codec system.
 
 config SND_AUDIO_GRAPH_CARD2
 	tristate "ASoC Audio Graph sound card2 support"

