Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3896E577867
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGQVhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiGQVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:36:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193E12762;
        Sun, 17 Jul 2022 14:36:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a9so16488615lfk.11;
        Sun, 17 Jul 2022 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQ4UYKUzX7TyytcppzQjH+TUKoxUgRO5nyuabjhwe2w=;
        b=iuSwtSglL2SsVyGxmwpyIFZvHF1bPJ1eudZMD5U9X3Lt+5v091w9mCSycJXoPvUBRH
         0sITR0SWWStOS9dv8Q9ffAjpLsrwpFKEQ/ieMxGRvHjkLjc+hTPsQX9Em8yZhPR8zs7a
         0UyEs6ocTbWd03BhITvr1vINg+u5b9fJgEYh67Ss2ghLCkQGWdFm6D2rY202LsdvYy6S
         +RisWg80itY91QCzJMEyF2CW1eld34UUnraootd4xB0eilc/GRPGd9K0Xq9urrecBIfh
         +Q4hHtGXSDbMXPwKJDoFYqgt5tekNXkYLLowIRniFWAXQcEkPjW2lApzD3EWwFrsMsVN
         aooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQ4UYKUzX7TyytcppzQjH+TUKoxUgRO5nyuabjhwe2w=;
        b=PrGGFHnxx/K7AwRzLxEfxIB7lii9kN8GYFlsi84yoUqiijJdf84e6+Idn/Go7vtRWA
         fAIgXt5UNgPDqedpKlvRgpb5/DwpBXEldvnmqOC+1CA0AZ8g/Dwah1Gq6jlDr09QVmvI
         nogDSod/G0DD5BnF6VRol1E7EEC/Q5EKOpEKddKVd9am7kGTaR1zrftkJ4yhQxPAIQug
         l6wRlqfNUhThjGBZ+yelDfQSWi/QfcxlRcIdpwlPw/ySUjrf89M2MZlGoXaNWBm4B5KT
         4T1kt1Flm2puabqnCEwrLJPshppnc6ZdHYXwmRqNIIRR5qjT2kV7uAb/Z0LDK76EGK6/
         aRCQ==
X-Gm-Message-State: AJIora+Ox12OxLZ62oFbtZ/TwO3Gvzwwjxoa8DemcJruEGRvRAlmWIRT
        pGvpWZIUK+iiTFykQuOUMeFRha27/d+si6T73vXM+w==
X-Google-Smtp-Source: AGRyM1vV8Fm/TR20xRXnhPE+sCDzHMO8U+rN72p+/bDNBYzGoQIQeteWrbLI4tkhxxIWRK6IEy0CLA==
X-Received: by 2002:a05:6512:39d1:b0:489:d408:c0ae with SMTP id k17-20020a05651239d100b00489d408c0aemr13323975lfu.114.1658093786921;
        Sun, 17 Jul 2022 14:36:26 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b00485caa0f5dfsm2251088lfr.44.2022.07.17.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 14:36:26 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Mon, 18 Jul 2022 00:34:28 +0300
Message-Id: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
Tab 4 10.1 (SM-T530) tablet which is based on apq8026.

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add node for the GPIOs
  dt-bindings: arm: qcom: Document samsung,matissewifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matissewifi.dts  | 475 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  10 +
 4 files changed, 487 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts

-- 
2.34.1

