Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597075ADEC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiIFFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiIFFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:07:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DB6C76D;
        Mon,  5 Sep 2022 22:07:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 145so10260045pfw.4;
        Mon, 05 Sep 2022 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=2s5V0OSPV4c3Wob277hCZSosTMutmUFFm9eFJDWUu8k=;
        b=PUaKs0lZtIMiU3TMf4n7P4YG6zVaixwdK0lxWjWI5rcShF/PvSGP6LM3/GMI1tzILb
         ZVbvk21WIVunG71LtyO8v915o1PGjdR7N4VrCSu1lS2CQ3sSbRI2LVpRS0R6yyhZYHxr
         z09P1fGZQ9IFKRx/NNGWj0d6r2CsaEC7DWUrpT5nfHRguEXptMgdAs4Hi7eAtQbEhQyV
         cF4uQn6lvs9lUQqvoxc/9jKN6XtJ8lZrU24ww5TiBlPtd61YQlm4fhMlsRrcGkC7Tf4Y
         fc1/qOmhEowr/dCFIj0jdmSWIuurUWddtfRgSAB50yMcuVpgLrVDWd6uKg8ZbwOb9Z1m
         7DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2s5V0OSPV4c3Wob277hCZSosTMutmUFFm9eFJDWUu8k=;
        b=UIW+2Bt0vJzZdJ1PrvdM+C5NIbK96ahf4QSWMVNgfbjOwWMY0QkQctWRsNKS/CSIjW
         PboYWZuI5XK/rIhe3FWkSHoZ+bk4KRyrqZHV/nLiDkRORCBwwZSs01/PIODlbFqR0vnk
         OFJwj23HlGHQnGrkU+KXhrmfmwdhXXMlscvIyq0nvWj9LWqlqtSObtpmFkjSEJaoK8SG
         Y1A8E4XbSdzY2o5KrqQCIioghnJqgJHVLPpy+wjjTwBeNdb9CcUuL6UUR5sZOYhKo6SV
         1/c0+4OcjCrsL0c2Hcoth6NoV7SqRvDoOWMen4ip79Gdx8yE5+OdpVApfdkpF1gasV4D
         UyHA==
X-Gm-Message-State: ACgBeo1f3njzeWMkiAdQpWN0a1ivIWzqvkp9qvSIiK14Tlt8ws3LCmD3
        zhKYOGRnEPPe2l8Dm+svN7c=
X-Google-Smtp-Source: AA6agR7ov8MpKvZvdt8mhftR6/1couiKhsu/FxmGcxp4j5xT/l5iSzKNHLkuusV1rJqifzgKdqPKfA==
X-Received: by 2002:a63:804a:0:b0:42b:8b81:72b8 with SMTP id j71-20020a63804a000000b0042b8b8172b8mr42100231pgd.218.1662440827872;
        Mon, 05 Sep 2022 22:07:07 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce1:13f0:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f64300b0016c9e5f291bsm8586423plg.111.2022.09.05.22.07.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Sep 2022 22:07:07 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:37:02 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v1] Update for Facebook yosemite V2 BMC.
Message-ID: <20220906050702.GA10565@hcl-ThinkPad-T495>
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

Added IPMB-13 channel for Debug Card communication.

---
--- v1 - Initial draft.
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..84236df522dc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -215,6 +215,17 @@
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	// Debug Card
+	multi-master;
+	ipmb13@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
 &pwm_tacho {
 	status = "okay";
 	//FSC
-- 
2.17.1

