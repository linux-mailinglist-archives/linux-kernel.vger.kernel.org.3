Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA2521177
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiEJJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiEJJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:56:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E52A1FCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:52:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e24so23012041wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CookHd0MvuVbQa5PxsatEqFr6KkhzJQUo0lR12lr+EI=;
        b=pYhb2JWhVE9vii8rxTpqlQ8KyFYzxYyGOnvdcvKAJla1oRK0C7eJjkJYBdGUN04j61
         VX5LZxUrOECEB08+KMjuINiSJxRWnCfqUq1hNUA5PSw8utqruS8P2Z8mwWdRUNM+tnKC
         yf/lSNnBLpAd5lnjiRkMBvF4NQlev71keCFaJOBHPEzbPkX52XIFFI8aPLuPgZ3Dv+70
         aUMx45nW5Ve8Huw38PM1mJe5s5mhsON6PHLZHWOR7AEKCHnek80KrVZs8cT8Hpb0JsxV
         rHn9stl3Lm+kyfz8ofxEVsPRCt4NjHECxBuuSiSfxxXo51JvWBVJq/ey25unhUZm12Hv
         XoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CookHd0MvuVbQa5PxsatEqFr6KkhzJQUo0lR12lr+EI=;
        b=BMxtapWvDMAjZ+3AhcwKXRdscwakOvRiaI3SGBUBuHMG9ZuYbZFIKlYQzYgbKgLSzT
         vPKx9HMGuPopCyWgJ9P11IuHYWn7MjS3ENuFc0U60kjYRpCnj1BJfgjwlI9TuSSVBGsr
         qbnzXf5DWFlp6YIWaVR8wJTNzdmLhJZh4GiHDMum9h+CE8UHJ5J2k9c+D49AKh6h5M7f
         akXa26ikqTeCC+btHeQm8faF6ynGvO3V83YHi7SCsIhMv7b51K1I0Q3RxDnc6kfDaPCg
         91Aj4wrrSeuNX3wn6ON1EwDzJ4I1aDpurVE/EecyQiT/oWsKVfklKKBYPTwTU2I469zC
         9KnQ==
X-Gm-Message-State: AOAM533pn4njHSkObdHFwYAUjJ9/5V/NeXr01U+Ko6V9yE1px6zQ2Fbx
        fxV72k4wApwc+zmEmyEq+W3Q/Bra0VU6sw==
X-Google-Smtp-Source: ABdhPJwl4shdOfP6u4t1LmyRqD8ge0iUdvWJdWmVWZsE76oF4i6m0AQabQjomNKEFct4TqnXSCKcTQ==
X-Received: by 2002:a5d:4252:0:b0:20c:6ffc:77b1 with SMTP id s18-20020a5d4252000000b0020c6ffc77b1mr17526805wrr.483.1652176368142;
        Tue, 10 May 2022 02:52:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003942a244f40sm2268252wms.25.2022.05.10.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:52:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] slimbus: patches for 5.19
Date:   Tue, 10 May 2022 10:52:03 +0100
Message-Id: <20220510095205.337-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some trivial SLIMbus patches for 5.19 which mostly includes
cleanups around get_irq.

Can you please queue them up for 5.19.

I had to include a fix in this series as other patch depends on that.

thanks for you help,
srini


Changes since v1:
- Included a depended patch in this series

Miaoqian Lin (1):
  slimbus: qcom: Fix IRQ check in qcom_slim_probe

Yang Li (1):
  slimbus: qcom: Remove unnecessary print function dev_err()

 drivers/slimbus/qcom-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.21.0

