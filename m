Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2E4FAA3C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiDISnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbiDISnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A45BCB48
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 11:41:12 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSckp-1nWM8T0dib-00SzaR; Sat, 09 Apr 2022 20:41:00 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Ivan T . Ivanov" <iivanov@suse.de>, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] MAINTAINERS: add raspberrypi to BCM2835 architecture
Date:   Sat,  9 Apr 2022 20:40:17 +0200
Message-Id: <20220409184017.114804-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zsmJB+KgfxpZtVlTRSiOUnBIJIV/4ohcGWFhE4ewp5+bVBltY7m
 yPHie505sRlclaRu23HDTefPWnDkybE8VNPJady689Lu17yUJilKRhzjADpbQodjqF6FjGT
 +fkNwHd5RXzpoYQ+Rpf0qYWE0Vwdj5Lh65TXRmCELgQlrK/GcsCeNJZ3ygictTUZgZH85s7
 xbF1+3j7qpUD7XVM/T98A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CeU5Jc4fvGk=:MheYd2Ib56eB2zOm+lQHQT
 mO61AgSuQGtsdEfRmvlm+7plZSo2NqltA+YVuTUsgJkFTk1FpRwY5QQEbeEEgLQrdXPMS3+sn
 PGg7qLsLUmNHiyyJY1AMkaSikQXoMCH4mXLfLb/QtUntHZo33RZQbiWpD7zWmMa92MFc+w4R2
 +qaI1pvsucoOKD7oMRMNuCLfe3Sa+lMoEWEgLhq9q90Smx4SxZVXAq6in4FrjQV+qFDf2dXQ8
 LQLcB0b5I9pLltSf761HpBxrUN0o9fFOKYrUk0dn9p9411iFUFE2LhAz2K7OCm4Jy5+ySkObK
 xBeC9TinhNHRN5RAW/oX4gjJHWcWhAPjKoIbcEtLWHxfpGjLrMIKlE9rdqJccyxJX9rfoPR6h
 oLoqW8LfLfjEZa71Xlev/3d6xbpsi/DadzkzdJxCWAKFem5fMo6ccuYv5QaUOFw8EAzPmeEZZ
 DrqpL0nBhD4RAwX+RaMj5xHB0buDDsFFk5aKBq4+ylY0KDTeuOl9GQAdkmHHunyAOuFkyBae5
 q75KU6vZaQLXZ2W67wKcuLCBRDpGQW6JUbVZFz+mQHgzJceYREZA9SlGrVYRajwrAb+0D0DYM
 woXyMVUv1++OV6RV0xg1wYMvxeFWclX64zGqdTGi3cJaYZASTI9ukxbAk/hm7dUl2UwUCLEJ4
 S2LevD4zyRMyIbAagqdkJQYsHhm7XfBCH3b6Z25TqhsePbKbrlOuTIeS+AEQ0CtEaWrkvsr5d
 oUDuMN6HhcukWpsu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to the firmware clock driver have not be send
to the architecture maintainers. So fix this by adding the
matching pattern.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..1432bd345d22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3752,6 +3752,7 @@ F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
 N:	bcm2711
 N:	bcm283*
+N:	raspberrypi
 
 BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
-- 
2.25.1

