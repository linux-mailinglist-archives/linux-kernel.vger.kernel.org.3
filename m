Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6353E6E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbiFFP0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbiFFPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED51CD351;
        Mon,  6 Jun 2022 08:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7411261520;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFFFC36B02;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=bqkt61u+zvKhwW9PscdIFrK0g5ODerAJEm1NGd0q9cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIwcWmEQkwvekBuusFzO+9SrNOpfcqguYyWSat2fDmJmoudC6CFT11yEYRv3M+yiW
         WwOIki82j2qvn3Ei6L/mbwpK+ZE54sZN1MDL/iwEbqSQFipL/ih7rujoV1jaOsAqxc
         IoFFBVKPq9HOSnQu9/BCTRLpAsZjF2yW+5GqQxw8hvpJvK9bAyKh36BQg5gDmmrrZ6
         h2DUudu7BszmgnAocVjCFjX2aJdHc05ykiy65lZhta+yJg7vxTDehyCXmA9Cv+zuhX
         k1V8KHkn02h6fHmohFjRg/LqL0zdqg+uctXiP7jno+Shi722+5lsgx4Sv7fUmtquXV
         CyK//GWV8jGEQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Ot-2R;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 02/23] dt-bindings: interrupt-controller: update brcm,l2-intc.yaml reference
Date:   Mon,  6 Jun 2022 16:25:24 +0100
Message-Id: <a40c02a7aaea91ea7b6ce24b6bc574ae5bcf4cf6.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 539d25b21fe8 ("dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML")
renamed: Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
to: Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml.

Update its cross-reference accordingly.

Fixes: 539d25b21fe8 ("dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 .../devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt b/Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
index 73470ecd1f12..ce91a9197697 100644
--- a/Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
+++ b/Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
@@ -16,7 +16,7 @@ has been processed. See [2] for more information on the brcm,l2-intc node.
 firmware. On some SoCs, this firmware supports DFS and DVFS in addition to
 Adaptive Voltage Scaling.
 
-[2] Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
+[2] Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
 
 
 Node brcm,avs-cpu-data-mem
-- 
2.36.1

