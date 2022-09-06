Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B1A5AE647
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiIFLMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiIFLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:12:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8F79628;
        Tue,  6 Sep 2022 04:12:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f124so2044755pgc.0;
        Tue, 06 Sep 2022 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=SaAS/zEVeX9aW0q1fpyxO05gvDdBuKUtUdG6Vtt1kqY=;
        b=EbT8jl7kMqIb2ZrGnLPw+3qlMxE6yCNckMaWo1NvNsMrIQl1Pu8yXfIBVZRddVf5vy
         Sg0DMR9Qh/jfTKXGkx0IHViHX4qTk4eJg13Y5QgpiOyMpkeYiMoIN9XSP7X8NJZ8vD67
         MePeCLdqhJw7h8Zk3HDp8+/o401RMd9cyHwyjp6VHtIoKwb8mcKiN1LJaINiqPBiQ1QY
         VZfWh5TYG84VdHYHdnYa/u7fJ6afRlRwMukoPcSUxFadKOWF7Cce6mqp5E5lDXgNrgen
         CVIGIzbB4697b7eXhMVdswffK9jNDRVBN2Ut5xoo+N73uZiN+ndmu7rhKAgEG3P5uaJL
         Uiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SaAS/zEVeX9aW0q1fpyxO05gvDdBuKUtUdG6Vtt1kqY=;
        b=4zuCLmFUODa5Xm0Y89U14Kf2jhZeVXq+sJNA5EVedIxqJdcFXwTWMBhKUTQ23/wqJ0
         cnyAQ+JBjS7l8L/ig74AUqLtzvi0o5YPCQV4bokszwwjEQ6bUZGSV3JdK0YgvYCVatih
         i3rpbGLWEglvHIjDIOsccDVzkaeKG3GBg2sQdLrykaozXUN2dvRGJR7Y7p+wrD4FNDCt
         TJc0OK1mX61Yh+YcsBTDx80lIYIGgDflPlCFQmIV6zyFBnc35QW/ToKCd8VLTuYOwoik
         SA8tOZkGJJsTPS5RHhUdycB6wtotlCqb1YX520yA7cW6Kv0RSmi2lU2fPXi1NbrYUynp
         Ie+g==
X-Gm-Message-State: ACgBeo3/0dbuPm1rPIUN6opyhgcMasU71WvcJJV2MToh763c6wUaCNXb
        2I9ruHYQUkAwT2S3DgA3jT0=
X-Google-Smtp-Source: AA6agR4UlyMIdI6ISnbB4ysRbFQPseOYt+uq+FzYFyjbH0klhw1Ba+7fS0f2daADAZ3eNvNX7JHnwQ==
X-Received: by 2002:a62:4c2:0:b0:52e:bd4d:50e1 with SMTP id 185-20020a6204c2000000b0052ebd4d50e1mr55860465pfe.8.1662462750183;
        Tue, 06 Sep 2022 04:12:30 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce1:13f0:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001753eb66692sm9548734plg.250.2022.09.06.04.12.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Sep 2022 04:12:29 -0700 (PDT)
Date:   Tue, 6 Sep 2022 16:42:23 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v1] Update for Facebook yosemite V2 BMC.
Message-ID: <20220906111223.GA1779@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed NIC EEPROM driver IPMB-12 channel and keeping it as
"status ok".

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..2293f10e94d6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -207,12 +207,6 @@
 
 &i2c12 {
 	status = "okay";
-	//MEZZ_FRU
-	eeprom@51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
 };
 
 &pwm_tacho {
-- 
2.17.1

