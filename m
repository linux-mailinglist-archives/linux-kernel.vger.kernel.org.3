Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6620E59160A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiHLTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbiHLTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:42:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33795B284C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:42:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cr9so1518462qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tRvDJSqP2PRIMIWloi0K1M5QOTLV+IKtWluTnY+gDdk=;
        b=ne8tXHS9XvFbtCPNTt4EzOKXPeOXPayChGUIi0O59otgNNRh9hOvuyIoWuZorZKyHv
         Cx7+EyMWJXUQcAOT2DLbJsV63zOs/uLKTtN6cHa40wFglhAzDCSreSR6Xx+drHLTj6qb
         BUGGbbVEu0laNe60mMgy58Av1pISjznYnbJc0h5u8JmQsbDCnAcKSnLf38ain7txGs0a
         VDYQbllmvWLlM8/h0GugU3g+t3LDl3SXlI71LigR8HWnMlkwY4Pp4I2IOB5GHCVV2oZa
         RUaoCvK9oVpjStRCUI4bRnQoPUgE8KjnUszbC7Ft8jNHedvdtrC7Nd4N4wTdzuofOeK/
         NCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tRvDJSqP2PRIMIWloi0K1M5QOTLV+IKtWluTnY+gDdk=;
        b=Aj605fHmBw+tOPNaoX0AbzTbeZkPyvM8PS4DZzPHZ+DAutMWGef7GetYn9uqyHaoK7
         j19bDpHz2VN/EShDylPBHQrrXqwEbBDOIPKfJsND/DK0E1pyzwNsSH8nzY8um4e6dGTV
         e0bvA33eKwX/SHeYdMY5KG7M7TZKK4SOK2Sr4fJvWBB9KlitP5UHBbP8a8wOHArxV3FE
         4jifPYTJnIZ+KvIVVHSRxfDAjAm4deyjrIXspkJ7A4e2NCt4lKwHJ9qTeDHSlJgSroAX
         JIPEQP3sg+amMI6FGX3VszpnM04swvgCQD20PfFtIoRQR8kfe1OF9R20nWa9WfPpwyOj
         nP+w==
X-Gm-Message-State: ACgBeo1He0VECS9qtEEBQ8QdJ/nAGOvxbXbhUvi3jJ853Mok//uKq+fy
        z9vMLbKTtyWQ9+LieSK1mCkmkg==
X-Google-Smtp-Source: AA6agR7KSWAqy9lWStTxVCzxXSLzRWMvDTYS2r4i3Gl1z15R1bxmL/BA95zCBx68zG4qMYnlsxLpeg==
X-Received: by 2002:ac8:5793:0:b0:342:ea28:742f with SMTP id v19-20020ac85793000000b00342ea28742fmr5017715qta.177.1660333326262;
        Fri, 12 Aug 2022 12:42:06 -0700 (PDT)
Received: from localhost ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id m20-20020ac84454000000b00342fc6a8e25sm2213257qtn.50.2022.08.12.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 12:42:05 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
To:     ntb@lists.linux.dev
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Date:   Fri, 12 Aug 2022 15:42:05 -0400
Message-Id: <20220812194205.388967-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
there to allow for notification of changes for it.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..47e9f86bd712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
+F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
 F:	tools/testing/selftests/ntb/
-- 
2.30.2

