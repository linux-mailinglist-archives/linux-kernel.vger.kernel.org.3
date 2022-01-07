Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11124487BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiAGSEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:12 -0500
Received: from mout.perfora.net ([74.208.4.194]:35629 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240374AbiAGSEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:10 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N4QTi-1mPWJn3EeM-011U6n;
 Fri, 07 Jan 2022 19:03:50 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/14] dt-bindings: gpio: fix gpio-hog example
Date:   Fri,  7 Jan 2022 19:03:02 +0100
Message-Id: <20220107180314.1816515-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ytzex8uojCkbk04+1zET92x9o8utwdOsZlxdHCWAqyylkF7JRec
 5en/28PTW12sX2ELW105nbTInJ0ckaVkDg5gFrDzrUX/ky5wwkRPASV09P+gOFWbRhH5XJI
 iBRXFX0HIRES2+ke9DCfPC7QjX87TBQ4wPAkg2B4yZftkpvlcnxRJsLswUarAWiP7IFtUZ2
 DkAMICIUlhc7XmpbS/4vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bop0A3kwWdw=:Yhg+4IsBVbPogG7HyRrSyM
 uEabtZ17tyjl/gp9+5stjTua0aGJYThfbSzl3Bf82Jmg2j0VQPhNPIjtoEdXNNuLNpWQqhs4M
 3ERqjIfqqHqj4JGBnCDzfPXf0vqqHWQHk7lLbZQCRgBQLJsxcbOLCRpOFmfHmBojHTovGjgvL
 CM/gB6jLTCcqtSkazufhX6DEtu84DRophzd6BZuRI8vD6xK35JaBjDrXXRz5vq9FDUcNQ2THS
 r+3Yx59wHFUbiGuF+gmSHw01pzwERRJPNuGsxSFxqrgH2JUPM6RkP4VTedcU3rh0UGCO0rfbc
 /TN9s9XdRgRjuSX8W6BIze+gKVlPFSrYOoJviRym1nVpeT4qELhiEOuy7qr6Ks992nidkhvMO
 Qq9cV5DcOPk06r+x8gwH8f+dLLM8NEasZ9/lRpFcHfq0xsINjczuMTcsLM/KyfUi2ibAUp4E0
 5t/coqc/Ek5WOSWrHyrPtxvC7VuGBBPRxiK8gfAI/4vTF34fkk98T/XbHS5BzdT2x1ksergBD
 z6mQL7YwfIpO03amvZSjXI9sJ4DaqX2aDO9Tm/T9UYUOzLaPKYqeduTBMMwt/Hj/v1iopN8Al
 xyx8Zjxr7yCbkV0ZsSaJmh+pfJirYngLw0lByMYG14dmTXpy+4K9g/qbWxK78i+1vleFYr7fc
 Yg35NYeW823SfuqH/YJAWygB6KvJ832hMcEqgEysRHEHm8ErTfqt8aCrDM02jBO9kpOA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Even if this is no yaml yet at least fix the example to be compliant to
later schema as e.g. found in gpio-pca95xx.yaml, fairchild,74hc595.yaml
and gpio/fsl-imx-gpio.yaml.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 Documentation/devicetree/bindings/gpio/gpio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index a8895d339bfe..5663e71b751f 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -213,7 +213,7 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		line_b {
+		line_b-hog {
 			gpio-hog;
 			gpios = <6 0>;
 			output-low;
-- 
2.33.1

