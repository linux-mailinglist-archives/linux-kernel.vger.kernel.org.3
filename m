Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B636855D7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiF0RFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiF0RFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:05:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCB13D3D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:05:20 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w83so13704069oiw.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiy6+iiLMeGDFL3yjWewYCuuYeu2rtEHRH1Mk/XtDns=;
        b=QyMvNo8m4T4TgwC1HpgS28kutB5bX/froVFu40QZNr8jKdGTdFzyVD0Eho8FO90ag6
         b9PdDHM8MvcHpcDYzcGhJLRYWlCSfwv0JEO9m4YwDjiM70RE/SY9DYTsVTol0wEl4oj4
         y+rJU6jj4JNSYVaaDRSsIuTl92Jf5FV1LIhBxyOy0GhjOLS8S16EqNjLjq+u3/FxSB7N
         xZnfg2lS2BkhbtVMXoI/4p2sjmgnSrwquLhrO0kstzVdFaO9twKcFerIbX2zxSQ4NsZo
         pq5KOIMlue1YiiqONpRWXmDpwDlNf5eJuwTajSGUoJCP/jT4p4BnPoweMItLaYxbb3/d
         wrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiy6+iiLMeGDFL3yjWewYCuuYeu2rtEHRH1Mk/XtDns=;
        b=JqYfm9X+zdZsDdk656kdAC2evd8sfvMbd09AwvCM47V8vhsNp+XB50ocp70FPRK5S+
         nPM3WRysLG7xFZ1xdwUJ8e1iuZcjGlxvNw0UNY3i+xPiWz4OIGNmVvi+BdJrp6YHrXb0
         M9lcZL3k8I1CCNhfoUsYaalkZ/7L98M7H++3hRGA0e0ndo8fak23/0UYmT8T7hYdjJNi
         Q7oW3JHKqYjOG8sFBiJltepSJD7rnttkrec7iDZLxN/7md3xrwQashjG8hR3cW1IaGEa
         AGvMaGTsYqXeR9uiLkcL1AwIvIoTlTY7TP9WtCcl5MYR5G0DB8Arg00fkBKYLhz4IFmY
         kOow==
X-Gm-Message-State: AJIora/UFp1JGj0WD7nB4jsut+Zk6UbAowDrr5SeQtsO8wXrieu3gty3
        W+CwJl2MG/8wYiZ0+WKJP5abXWVaEHh2nQ==
X-Google-Smtp-Source: AGRyM1sY/DvE1sLhaZz0G6NJ4ve3bOkQmSv9AL7zpQxIJqIY3FhpZKQIVsCNUjWlNP6i46JvXnLxJw==
X-Received: by 2002:a05:6808:2111:b0:335:510c:eee4 with SMTP id r17-20020a056808211100b00335510ceee4mr8161509oiw.151.1656349519431;
        Mon, 27 Jun 2022 10:05:19 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm7303175oaq.55.2022.06.27.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:05:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: mhi: host: pci_generic: Add another Foxconn T99W175
Date:   Mon, 27 Jun 2022 10:07:17 -0700
Message-Id: <20220627170717.2252335-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

The Foxconn e0c3 device identifies itself as a T99W175 X55, add support
for this to the pci_generic driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bus/mhi/host/pci_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 57d5f611a979..bf82d90f9ca9 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -571,6 +571,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* T99W175 (sdx55), Based on Qualcomm new baseline */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0bf),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+	/* T99W175 (sdx55) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0c3),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
 	/* T99W368 (sdx65) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d8),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
-- 
2.35.1

