Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56D5335D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbiEYD2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiEYD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:27:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A27893F;
        Tue, 24 May 2022 20:27:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cv10so1863978pjb.4;
        Tue, 24 May 2022 20:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Niq05ZlOgUrh6vX28ExFQ/HZPhi4Hjl0ZKDCJqxaD6E=;
        b=UFNJG2oZurZg3v7j5Narl6MtJ4nkth27Ho67qrh/HKi8+SaPqmT2jKKJ+J/yz9SYdr
         B/ur/OvCwEBYdmJaUzHrz1v6RkSs3yBJAmJfUMKrqDgPk2rlSzMEZO6K00j9AN88JUpt
         XMaPkkfD4frTyNI6fTDXJB59Wzd3qgMZlXgheA5bu0V6yJOE5lEwq/4KOi6nVJiRSTgB
         xnikiSpXFjMKNpK7mut1iOgVDR+POOshCy3vxrPScblFogMRmRaNzUiOkXbr0zZ5gl39
         qAYEHbmzU2Gu4VHLliy8DCb4w3DJzxInxhGJt+RLUWfOIofS7JHl2U6GKF2hw5rV78wr
         1Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Niq05ZlOgUrh6vX28ExFQ/HZPhi4Hjl0ZKDCJqxaD6E=;
        b=QzXAQ3iesl0I+ovFSaWx9g4hXZqtpXdMcmd25ITx2Q76PUwOfkjwvR46u3D4AQ/9py
         EFpLNNiRpQZm9d/Hial7wMl3mY3f/dy3efGK9ePcRErIXrpr21rdolSwTki2aU0gFsIE
         Eiymo73xaNIfWaJJutWAyBBOO8/KCzTkCve4q51t4SB4OL8DeYftnuPjwywP8aj8mewL
         2ITOithuDRJ8joxf9e+LgawohnKlV3204P4ad9DdiK7wKipH/zr+ZptD4+X18mn5T7Qa
         mwin2d1Aff2TDTM/90StizHnYZQEAEPboDur0usEysFLCidBq7Gtzpy8UeZOUYp50sye
         v+PQ==
X-Gm-Message-State: AOAM533eD5nzfN+Q1VubmgkndDx+REv1CsG4neJrhoN0l9wFMISXsrnN
        QcepMGorp4o/UkFqXBWvH8Y/Up+4rRk=
X-Google-Smtp-Source: ABdhPJyLW8iahjmdUv5zLm1LbAWkN51eKUGeoXA4FSqrRWsiC8ceZkNlQsS3m0UZu6MhzpQx4r7L7Q==
X-Received: by 2002:a17:902:8303:b0:15f:86f:70a with SMTP id bd3-20020a170902830300b0015f086f070amr31292646plb.5.1653449273184;
        Tue, 24 May 2022 20:27:53 -0700 (PDT)
Received: from thinbox (23-122-134-180.lightspeed.sntcca.sbcglobal.net. [23.122.134.180])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090a178e00b001df3a251cc2sm326491pja.4.2022.05.24.20.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 20:27:52 -0700 (PDT)
Date:   Tue, 24 May 2022 20:27:51 -0700
From:   Maurycy Z <10maurycy10@gmail.com>
To:     linux-config@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH v1] "system" mispelled as "ststem" in help for configuration
 option SND_AUDIO_GRAPH_CARD.
Message-ID: <Yo2iN2R6o0HdkToZ@thinbox>
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

