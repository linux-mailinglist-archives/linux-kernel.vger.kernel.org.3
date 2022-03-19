Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F704DE7FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 13:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbiCSM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiCSM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 08:59:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC1B208C0B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 05:57:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so21616698ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKHgtGgppdxCrTFImfB4PFA7QqXSPdXanOtMdAWvnaE=;
        b=GnvufbiJu3B2y6vdbdoWV58kIyHlUBcuIXJcVIN9Dc3fHPJWOgqG6oiNSV2nG0ciqV
         /1tcTpzp4D2wNoD0cYWefP66bQ3EBYFqvlOaN3gU4Eqecy8+DnZnRFeeR2tjIKTdBA3+
         om8Vbezt4yjbAF2ehAoTnMrbX0wnbuJ1nYfunQ/ODFmXbaJSVR8zp9hyjkZpR6DIrJ4n
         +TTfAdL2BAXZxuwb6aPeo95JodgXzkJD5bPzmBcI6yvoqP+51hi1fGT6Tmz7G+kslzKo
         eY8FXX0PQ5iUFSmfolEBLo4rsYFruJsV4hAUQ1JcIvetIOcJ3xI+5IYzBkXdJkwszUxX
         MquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKHgtGgppdxCrTFImfB4PFA7QqXSPdXanOtMdAWvnaE=;
        b=zgPgpIVoiFbZzu50LUDQWVVxXIje2wF1Mfx8LePkQ9GRUBJVDl23bPf989f2zO8HVM
         hJvGzzn5Klg8vXpJLSc8XgO9saqTGKbCUrGV5GXOWGNLJs05T/AoD6gedLAqyo97eeC0
         oqbyyFpFJqwGoe77rZdv/m8/hlLssdlGdeJNn/YQ1EVpmQoEzrDuWARGf6t2EgB5QoxL
         JzPC70k4/ZlZA3q709VMJMZsYnTyxKdjUymuRUk6uL4irKbm90Dwv/+dbvRyShMXJX5d
         s96h22JobYC79iHQylPRBV5/r3SIXX82ZCjZlA/ZylQZOrGihE0C3Z9ni5EV7uzz36qj
         XQwg==
X-Gm-Message-State: AOAM5308EfIcqy7D5gjO/bgEM4pPQ47X+Phc1vsrvFJOH6CFnctGfCG0
        ZgQvA3B35fFyzFgvp+Y3gt0=
X-Google-Smtp-Source: ABdhPJy2UVgFsDUGOMzKg6BMSFZNj71Q9+LujWINzXU5yT835p+tdoqwHJUqXZcWkhGLy9uaapt19Q==
X-Received: by 2002:a17:907:9801:b0:6db:ab31:96f4 with SMTP id ji1-20020a170907980100b006dbab3196f4mr13024065ejc.571.1647694668926;
        Sat, 19 Mar 2022 05:57:48 -0700 (PDT)
Received: from nam-dell (dslb-002-203-132-165.002.203.pools.vodafone-ip.de. [2.203.132.165])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm4718857eje.183.2022.03.19.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 05:57:48 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH v2] staging: sm750fb: fix CamelCase name style
Date:   Sat, 19 Mar 2022 13:56:30 +0100
Message-Id: <20220319125629.21405-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YjXLp2pdGUQIWcFg@kroah.com>
References: <YjXLp2pdGUQIWcFg@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all names in CamelCase style to appropriate styles as suggested
by checkpatch.pl.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
Changes in V2:
  - Add patch description

 drivers/staging/sm750fb/ddk750_dvi.c    |  20 +--
 drivers/staging/sm750fb/ddk750_mode.c   |  90 ++++++-------
 drivers/staging/sm750fb/ddk750_mode.h   |   2 +-
 drivers/staging/sm750fb/ddk750_power.h  |  10 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 172 ++++++++++++------------
 drivers/staging/sm750fb/ddk750_sii164.h |  40 +++---
 drivers/staging/sm750fb/sm750.c         | 104 +++++++-------
 drivers/staging/sm750fb/sm750.h         |  56 ++++----
 drivers/staging/sm750fb/sm750_accel.c   | 149 ++++++++++----------
 drivers/staging/sm750fb/sm750_accel.h   |  42 +++---
 drivers/staging/sm750fb/sm750_cursor.c  |  14 +-
 drivers/staging/sm750fb/sm750_cursor.h  |  12 +-
 drivers/staging/sm750fb/sm750_hw.c      |  62 ++++-----
 13 files changed, 387 insertions(+), 386 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 029d9acec47d..6fef1ab484c1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -14,17 +14,17 @@
 static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
-		.init = sii164InitChip,
-		.get_vendor_id = sii164GetVendorID,
-		.get_device_id = sii164GetDeviceID,
+		.init = sii164_init_chip,
+		.get_vendor_id = sii164_get_vendor_id,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164ResetChip,
-		.get_chip_string = sii164GetChipString,
-		.set_power = sii164SetPower,
-		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
-		.is_connected = sii164IsConnected,
-		.check_interrupt = sii164CheckInterrupt,
-		.clear_interrupt = sii164ClearInterrupt,
+		.reset_chip = sii164_reset_chip,
+		.get_chip_string = sii164_get_chip_string,
+		.set_power = sii164_set_power,
+		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
+		.is_connected = sii164_is_connected,
+		.check_interrupt = sii164_check_interrupt,
+		.clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index e00a6cb31947..bcdd291d25c9 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -14,13 +14,13 @@
  * in bit 29:27 of Display Control register.
  */
 static unsigned long
-displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
-			     unsigned long dispControl)
+display_control_adjust_sm750le(struct mode_parameter *mode_param,
+			       unsigned long disp_control)
 {
 	unsigned long x, y;
 
-	x = pModeParam->horizontal_display_end;
-	y = pModeParam->vertical_display_end;
+	x = mode_param->horizontal_display_end;
+	y = mode_param->vertical_display_end;
 
 	/*
 	 * SM750LE has to set up the top-left and bottom-right
@@ -36,47 +36,47 @@ displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
 	       ((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
 
 	/*
-	 * Assume common fields in dispControl have been properly set before
+	 * Assume common fields in disp_control have been properly set before
 	 * calling this function.
-	 * This function only sets the extra fields in dispControl.
+	 * This function only sets the extra fields in disp_control.
 	 */
 
 	/* Clear bit 29:27 of display control register */
-	dispControl &= ~CRT_DISPLAY_CTRL_CLK_MASK;
+	disp_control &= ~CRT_DISPLAY_CTRL_CLK_MASK;
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resolutions. */
 	if (x == 800 && y == 600)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL41;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL41;
 	else if (x == 1024 && y == 768)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL65;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL65;
 	else if (x == 1152 && y == 864)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL80;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL80;
 	else if (x == 1280 && y == 768)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL80;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL80;
 	else if (x == 1280 && y == 720)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL74;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL74;
 	else if (x == 1280 && y == 960)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL108;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL108;
 	else if (x == 1280 && y == 1024)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL108;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL108;
 	else /* default to VGA clock */
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL25;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL25;
 
 	/* Set bit 25:24 of display controller */
-	dispControl |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
+	disp_control |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
 
 	/* Set bit 14 of display controller */
-	dispControl |= DISPLAY_CTRL_CLOCK_PHASE;
+	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
 
-	poke32(CRT_DISPLAY_CTRL, dispControl);
+	poke32(CRT_DISPLAY_CTRL, disp_control);
 
-	return dispControl;
+	return disp_control;
 }
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(struct mode_parameter *pModeParam,
-				struct pll_value *pll)
+static int program_mode_registers(struct mode_parameter *mode_param,
+				  struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -86,46 +86,46 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 		/* programe secondary pixel clock */
 		poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
 
-		tmp = ((pModeParam->horizontal_total - 1) <<
+		tmp = ((mode_param->horizontal_total - 1) <<
 		       CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
 		     CRT_HORIZONTAL_TOTAL_TOTAL_MASK;
-		tmp |= (pModeParam->horizontal_display_end - 1) &
+		tmp |= (mode_param->horizontal_display_end - 1) &
 		      CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
 
 		poke32(CRT_HORIZONTAL_TOTAL, tmp);
 
-		tmp = (pModeParam->horizontal_sync_width <<
+		tmp = (mode_param->horizontal_sync_width <<
 		       CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
 		     CRT_HORIZONTAL_SYNC_WIDTH_MASK;
-		tmp |= (pModeParam->horizontal_sync_start - 1) &
+		tmp |= (mode_param->horizontal_sync_start - 1) &
 		      CRT_HORIZONTAL_SYNC_START_MASK;
 
 		poke32(CRT_HORIZONTAL_SYNC, tmp);
 
-		tmp = ((pModeParam->vertical_total - 1) <<
+		tmp = ((mode_param->vertical_total - 1) <<
 		       CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
 		     CRT_VERTICAL_TOTAL_TOTAL_MASK;
-		tmp |= (pModeParam->vertical_display_end - 1) &
+		tmp |= (mode_param->vertical_display_end - 1) &
 		      CRT_VERTICAL_TOTAL_DISPLAY_END_MASK;
 
 		poke32(CRT_VERTICAL_TOTAL, tmp);
 
-		tmp = ((pModeParam->vertical_sync_height <<
+		tmp = ((mode_param->vertical_sync_height <<
 		       CRT_VERTICAL_SYNC_HEIGHT_SHIFT)) &
 		     CRT_VERTICAL_SYNC_HEIGHT_MASK;
-		tmp |= (pModeParam->vertical_sync_start - 1) &
+		tmp |= (mode_param->vertical_sync_start - 1) &
 		      CRT_VERTICAL_SYNC_START_MASK;
 
 		poke32(CRT_VERTICAL_SYNC, tmp);
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
-		if (pModeParam->vertical_sync_polarity)
+		if (mode_param->vertical_sync_polarity)
 			tmp |= DISPLAY_CTRL_VSYNC_PHASE;
-		if (pModeParam->horizontal_sync_polarity)
+		if (mode_param->horizontal_sync_polarity)
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
 
 		if (sm750_get_chip_type() == SM750LE) {
-			displayControlAdjust_SM750LE(pModeParam, tmp);
+			display_control_adjust_sm750le(mode_param, tmp);
 		} else {
 			reg = peek32(CRT_DISPLAY_CTRL) &
 				~(DISPLAY_CTRL_VSYNC_PHASE |
@@ -140,40 +140,40 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 
 		poke32(PANEL_PLL_CTRL, sm750_format_pll_reg(pll));
 
-		reg = ((pModeParam->horizontal_total - 1) <<
+		reg = ((mode_param->horizontal_total - 1) <<
 			PANEL_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
 			PANEL_HORIZONTAL_TOTAL_TOTAL_MASK;
-		reg |= ((pModeParam->horizontal_display_end - 1) &
+		reg |= ((mode_param->horizontal_display_end - 1) &
 			PANEL_HORIZONTAL_TOTAL_DISPLAY_END_MASK);
 		poke32(PANEL_HORIZONTAL_TOTAL, reg);
 
 		poke32(PANEL_HORIZONTAL_SYNC,
-		       ((pModeParam->horizontal_sync_width <<
+		       ((mode_param->horizontal_sync_width <<
 			 PANEL_HORIZONTAL_SYNC_WIDTH_SHIFT) &
 			PANEL_HORIZONTAL_SYNC_WIDTH_MASK) |
-		       ((pModeParam->horizontal_sync_start - 1) &
+		       ((mode_param->horizontal_sync_start - 1) &
 			PANEL_HORIZONTAL_SYNC_START_MASK));
 
 		poke32(PANEL_VERTICAL_TOTAL,
-		       (((pModeParam->vertical_total - 1) <<
+		       (((mode_param->vertical_total - 1) <<
 			 PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
 			PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
-		       ((pModeParam->vertical_display_end - 1) &
+		       ((mode_param->vertical_display_end - 1) &
 			PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
 
 		poke32(PANEL_VERTICAL_SYNC,
-		       ((pModeParam->vertical_sync_height <<
+		       ((mode_param->vertical_sync_height <<
 			 PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
 			PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
-		       ((pModeParam->vertical_sync_start - 1) &
+		       ((mode_param->vertical_sync_start - 1) &
 			PANEL_VERTICAL_SYNC_START_MASK));
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
-		if (pModeParam->vertical_sync_polarity)
+		if (mode_param->vertical_sync_polarity)
 			tmp |= DISPLAY_CTRL_VSYNC_PHASE;
-		if (pModeParam->horizontal_sync_polarity)
+		if (mode_param->horizontal_sync_polarity)
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
-		if (pModeParam->clock_phase_polarity)
+		if (mode_param->clock_phase_polarity)
 			tmp |= DISPLAY_CTRL_CLOCK_PHASE;
 
 		reserved = PANEL_DISPLAY_CTRL_RESERVED_MASK |
@@ -207,7 +207,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 	return ret;
 }
 
-int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
+int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
 {
 	struct pll_value pll;
 
@@ -220,6 +220,6 @@ int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
 	}
-	programModeRegisters(parm, &pll);
+	program_mode_registers(parm, &pll);
 	return 0;
 }
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 2df78a0937b2..1b70885f85e5 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -33,5 +33,5 @@ struct mode_parameter {
 	enum spolarity clock_phase_polarity;
 };
 
-int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock);
+int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock);
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 7002567a47d2..d43942d6a5aa 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -3,10 +3,10 @@
 #define DDK750_POWER_H__
 
 enum dpms {
-	crtDPMS_ON = 0x0,
-	crtDPMS_STANDBY = 0x1,
-	crtDPMS_SUSPEND = 0x2,
-	crtDPMS_OFF = 0x3,
+	CRT_DPMS_ON = 0x0,
+	CRT_DPMS_STANDBY = 0x1,
+	CRT_DPMS_SUSPEND = 0x2,
+	CRT_DPMS_OFF = 0x3,
 };
 
 #define set_DAC(off) {							\
@@ -15,7 +15,7 @@ enum dpms {
 }
 
 void ddk750_set_dpms(enum dpms state);
-void sm750_set_power_mode(unsigned int powerMode);
+void sm750_set_power_mode(unsigned int power_mode);
 void sm750_set_current_gate(unsigned int gate);
 
 /*
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 73e0e9f41ec5..230907ea214e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -12,11 +12,11 @@
 #define USE_HW_I2C
 
 #ifdef USE_HW_I2C
-    #define i2cWriteReg sm750_hw_i2c_write_reg
-    #define i2cReadReg  sm750_hw_i2c_read_reg
+    #define i2c_write_reg sm750_hw_i2c_write_reg
+    #define i2c_read_reg  sm750_hw_i2c_read_reg
 #else
-    #define i2cWriteReg sm750_sw_i2c_write_reg
-    #define i2cReadReg  sm750_sw_i2c_read_reg
+    #define i2c_write_reg sm750_sw_i2c_write_reg
+    #define i2c_read_reg  sm750_sw_i2c_read_reg
 #endif
 
 /* SII164 Vendor and Device ID */
@@ -25,45 +25,45 @@
 
 #ifdef SII164_FULL_FUNCTIONS
 /* Name of the DVI Controller chip */
-static char *gDviCtrlChipName = "Silicon Image SiI 164";
+static char *dvi_ctrl_chip_name = "Silicon Image SiI 164";
 #endif
 
 /*
- *  sii164GetVendorID
+ *  sii164_get_vendor_id
  *      This function gets the vendor ID of the DVI controller chip.
  *
  *  Output:
  *      Vendor ID
  */
-unsigned short sii164GetVendorID(void)
+unsigned short sii164_get_vendor_id(void)
 {
-	unsigned short vendorID;
+	unsigned short vendor_id;
 
-	vendorID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	vendor_id = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+		   (unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					      SII164_VENDOR_ID_LOW);
 
-	return vendorID;
+	return vendor_id;
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
-	unsigned short deviceID;
+	unsigned short device_id;
 
-	deviceID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	device_id = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+		   (unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					      SII164_DEVICE_ID_LOW);
 
-	return deviceID;
+	return device_id;
 }
 
 /*
@@ -72,7 +72,7 @@ unsigned short sii164GetDeviceID(void)
  */
 
 /*
- *  sii164InitChip
+ *  sii164_init_chip
  *      This function initialize and detect the DVI controller chip.
  *
  *  Input:
@@ -118,16 +118,16 @@ unsigned short sii164GetDeviceID(void)
  *      0   - Success
  *     -1   - Fail.
  */
-long sii164InitChip(unsigned char edge_select,
-		    unsigned char bus_select,
-		    unsigned char dual_edge_clk_select,
-		    unsigned char hsync_enable,
-		    unsigned char vsync_enable,
-		    unsigned char deskew_enable,
-		    unsigned char deskew_setting,
-		    unsigned char continuous_sync_enable,
-		    unsigned char pll_filter_enable,
-		    unsigned char pll_filter_value)
+long sii164_init_chip(unsigned char edge_select,
+		      unsigned char bus_select,
+		      unsigned char dual_edge_clk_select,
+		      unsigned char hsync_enable,
+		      unsigned char vsync_enable,
+		      unsigned char deskew_enable,
+		      unsigned char deskew_setting,
+		      unsigned char continuous_sync_enable,
+		      unsigned char pll_filter_enable,
+		      unsigned char pll_filter_value)
 {
 	unsigned char config;
 
@@ -140,8 +140,8 @@ long sii164InitChip(unsigned char edge_select,
 #endif
 
 	/* Check if SII164 Chip exists */
-	if ((sii164GetVendorID() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -176,7 +176,7 @@ long sii164InitChip(unsigned char edge_select,
 		else
 			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		/*
 		 * De-skew enabled with default 111b value.
@@ -214,7 +214,7 @@ long sii164InitChip(unsigned char edge_select,
 			config |= SII164_DESKEW_8_STEP;
 			break;
 		}
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
 
 		/* Enable/Disable Continuous Sync. */
 		if (continuous_sync_enable == 0)
@@ -231,12 +231,12 @@ long sii164InitChip(unsigned char edge_select,
 		/* Set the PLL Filter value */
 		config |= ((pll_filter_value & 0x07) << 1);
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_PLL, config);
 
 		/* Recover from Power Down and enable output. */
-		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+		config = i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		return 0;
 	}
@@ -250,157 +250,157 @@ long sii164InitChip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
-	sii164SetPower(0);
-	sii164SetPower(1);
+	sii164_set_power(0);
+	sii164_set_power(1);
 }
 
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Controller
  *      chip.
  *
  *      It's convenient for application need to display the chip name.
  */
-char *sii164GetChipString(void)
+char *sii164_get_chip_string(void)
 {
-	return gDviCtrlChipName;
+	return dvi_ctrl_chip_name;
 }
 
 /*
- *  sii164SetPower
+ *  sii164_set_power
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
- *      powerUp - Flag to set the power down or up
+ *      power_up - Flag to set the power down or up
  */
-void sii164SetPower(unsigned char powerUp)
+void sii164_set_power(unsigned char power_up)
 {
 	unsigned char config;
 
-	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp == 1) {
+	config = i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+	if (power_up == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	} else {
 		/* Power down the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_DOWN;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	}
 }
 
 /*
- *  sii164SelectHotPlugDetectionMode
+ *  sii164_select_hot_plug_detection_mode
  *      This function selects the mode of the hot plug detection.
  */
-static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
+static void
+sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mode)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
 	case SII164_HOTPLUG_USE_MDI:
-		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		detect_reg &= ~SII164_DETECT_INTERRUPT_MASK;
+		detect_reg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
 		break;
 	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
 		break;
 	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
 		break;
 	}
 
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detect_reg);
 }
 
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hot_plug_detection
  *      This function enables the Hot Plug detection.
  *
- *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
+ *  enable_hot_plug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
-	if (enableHotPlug != 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+	if (enable_hot_plug != 0)
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_DISABLE);
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
-	unsigned char hotPlugValue;
+	unsigned char hot_plug_value;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	hot_plug_value = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
+	if (hot_plug_value == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
 		return 0;
 }
 
 /*
- *  sii164CheckInterrupt
+ *  sii164_check_interrupt
  *      Checks if interrupt has occurred.
  *
  *  Output:
  *      0   - No interrupt
  *      1   - Interrupt occurs
  */
-unsigned char sii164CheckInterrupt(void)
+unsigned char sii164_check_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
+	if (detect_reg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
 		return 0;
 }
 
 /*
- *  sii164ClearInterrupt
+ *  sii164_clear_interrupt
  *      Clear the hot plug interrupt.
  */
-void sii164ClearInterrupt(void)
+void sii164_clear_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT,
+		      detect_reg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index d940cb729066..5e22311ec92f 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,28 +16,28 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164InitChip(unsigned char edgeSelect,
-		    unsigned char busSelect,
-		    unsigned char dualEdgeClkSelect,
-		    unsigned char hsyncEnable,
-		    unsigned char vsyncEnable,
-		    unsigned char deskewEnable,
-		    unsigned char deskewSetting,
-		    unsigned char continuousSyncEnable,
-		    unsigned char pllFilterEnable,
-		    unsigned char pllFilterValue);
-
-unsigned short sii164GetVendorID(void);
-unsigned short sii164GetDeviceID(void);
+long sii164_init_chip(unsigned char edge_select,
+		      unsigned char bus_select,
+		      unsigned char dual_edge_clk_select,
+		      unsigned char hsync_enable,
+		      unsigned char vsync_enable,
+		      unsigned char deskew_enable,
+		      unsigned char deskew_setting,
+		      unsigned char continuous_sync_enable,
+		      unsigned char pll_filter_enable,
+		      unsigned char pll_filter_value);
+
+unsigned short sii164_get_vendor_id(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
-char *sii164GetChipString(void);
-void sii164SetPower(unsigned char powerUp);
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-unsigned char sii164IsConnected(void);
-unsigned char sii164CheckInterrupt(void);
-void sii164ClearInterrupt(void);
+void sii164_reset_rhip(void);
+char *sii164_get_chip_string(void);
+void sii164_set_power(unsigned char power_up);
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
+unsigned char sii164_is_connected(void);
+unsigned char sii164_check_interrupt(void);
+void sii164_clear_interrupt(void);
 #endif
 /*
  * below register definition is used for
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dbd1159a2ef0..9b88685e4187 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -120,14 +120,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		sm750_hw_cursor_setSize(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+		sm750_hw_cursor_set_size(cursor,
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
-		sm750_hw_cursor_setPos(cursor,
-				       fbcursor->image.dx - info->var.xoffset,
-				       fbcursor->image.dy - info->var.yoffset);
+		sm750_hw_cursor_set_pos(cursor,
+					fbcursor->image.dx - info->var.xoffset,
+					fbcursor->image.dy - info->var.yoffset);
 
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
@@ -141,14 +141,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
 		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		sm750_hw_cursor_setColor(cursor, fg, bg);
+		sm750_hw_cursor_set_color(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
-		sm750_hw_cursor_setData(cursor,
-					fbcursor->rop,
-					fbcursor->image.data,
-					fbcursor->mask);
+		sm750_hw_cursor_set_data(cursor,
+					 fbcursor->rop,
+					 fbcursor->image.data,
+					 fbcursor->mask);
 	}
 
 	if (fbcursor->enable)
@@ -162,7 +162,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp, rop;
+	unsigned int base, pitch, bpp, rop;
 	u32 color;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -177,9 +177,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp == 1) ? region->color :
+	color = (bpp == 1) ? region->color :
 		((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
@@ -192,7 +192,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
-				     base, pitch, Bpp,
+				     base, pitch, bpp,
 				     region->dx, region->dy,
 				     region->width, region->height,
 				     color, rop);
@@ -204,7 +204,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 {
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bpp;
 
 	par = info->par;
 	sm750_dev = par->dev;
@@ -215,7 +215,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
 	/*
 	 * If not use spin_lock, system will die if user load driver
@@ -227,7 +227,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 
 	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
 				     base, pitch, region->sx, region->sy,
-				     base, pitch, Bpp, region->dx, region->dy,
+				     base, pitch, bpp, region->dx, region->dy,
 				     region->width, region->height,
 				     HW_ROP2_COPY);
 	spin_unlock(&sm750_dev->slock);
@@ -236,7 +236,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 static void lynxfb_ops_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
-	unsigned int base, pitch, Bpp;
+	unsigned int base, pitch, bpp;
 	unsigned int fgcol, bgcol;
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
@@ -249,7 +249,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 */
 	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
-	Bpp = info->var.bits_per_pixel >> 3;
+	bpp = info->var.bits_per_pixel >> 3;
 
 	/* TODO: Implement hardware acceleration for image->depth > 1 */
 	if (image->depth != 1) {
@@ -276,7 +276,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
 				      image->data, image->width >> 3, 0,
-				      base, pitch, Bpp,
+				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
 				      fgcol, bgcol, HW_ROP2_COPY);
@@ -393,9 +393,9 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		return ret;
 	}
-	ret = hw_sm750_crtc_setMode(crtc, var, fix);
+	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
 	if (!ret)
-		ret = hw_sm750_output_setMode(output, var, fix);
+		ret = hw_sm750_output_set_mode(output, var, fix);
 	return ret;
 }
 
@@ -512,7 +512,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		return -ENOMEM;
 	}
 
-	return hw_sm750_crtc_checkMode(crtc, var);
+	return hw_sm750_crtc_check_mode(crtc, var);
 }
 
 static int lynxfb_ops_setcolreg(unsigned int regno,
@@ -545,7 +545,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		ret = hw_sm750_setColReg(crtc, regno, red, green, blue);
+		ret = hw_sm750_set_col_reg(crtc, regno, red, green, blue);
 		goto exit;
 	}
 
@@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
-	return output->proc_setBLANK(output, blank);
+	return output->proc_set_blank(output, blank);
 }
 
 static int sm750fb_set_drv(struct lynxfb_par *par)
@@ -598,44 +598,44 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		crtc->vidmem_size >>= 1;
 
 	/* setup crtc and output member */
-	sm750_dev->hwCursor = g_hwcursor;
+	sm750_dev->hw_cursor = g_hwcursor;
 
 	crtc->line_pad = 16;
 	crtc->xpanstep = 8;
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
 
-	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
-				 hw_sm750le_setBLANK : hw_sm750_setBLANK;
+	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
+				  hw_sm750le_set_blank : hw_sm750_set_blank;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
-				    hw_sm750le_deWait : hw_sm750_deWait;
+				    hw_sm750le_de_wait : hw_sm750_de_wait;
 	switch (sm750_dev->dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -643,7 +643,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -651,7 +651,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -694,7 +694,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char *fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
@@ -719,13 +719,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->pv_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor) {
@@ -814,7 +814,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	fix->ywrapstep = crtc->ywrapstep;
 	fix->accel = FB_ACCEL_SMI;
 
-	strscpy(fix->id, fixId[index], sizeof(fix->id));
+	strscpy(fix->id, fix_id[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
@@ -870,12 +870,12 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 
 	swap = 0;
 
-	sm750_dev->initParm.chip_clk = 0;
-	sm750_dev->initParm.mem_clk = 0;
-	sm750_dev->initParm.master_clk = 0;
-	sm750_dev->initParm.powerMode = 0;
-	sm750_dev->initParm.setAllEngOff = 0;
-	sm750_dev->initParm.resetMemory = 1;
+	sm750_dev->init_parm.chip_clk = 0;
+	sm750_dev->init_parm.mem_clk = 0;
+	sm750_dev->init_parm.master_clk = 0;
+	sm750_dev->init_parm.power_mode = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
+	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
@@ -894,11 +894,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = sm750_double_tft;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = sm750_dual_tft;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
-			sm750_dev->pnltype = sm750_24TFT;
+			sm750_dev->pnltype = sm750_24_tft;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
 			g_hwcursor &= ~0x1;
 		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
@@ -1061,7 +1061,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->pv_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1092,8 +1092,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->pv_reg);
+	iounmap(sm750_dev->pv_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index aff69661c8e6..9319ffc6ca8b 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -13,9 +13,9 @@
 #endif
 
 enum sm750_pnltype {
-	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	sm750_24_tft = 0,	/* 24bit tft */
+	sm750_dual_tft = 2,	/* dual 18 bit tft */
+	sm750_double_tft = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
@@ -39,20 +39,20 @@ enum sm750_path {
 };
 
 struct init_status {
-	ushort powerMode;
+	ushort power_mode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
-	ushort resetMemory;
+	ushort set_all_eng_off;
+	ushort reset_memory;
 };
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem *dprBase;
+	volatile unsigned char __iomem *dpr_base;
 	/* base virtual address of de data port */
-	volatile unsigned char __iomem *dpPortBase;
+	volatile unsigned char __iomem *dp_port_base;
 
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
@@ -97,12 +97,12 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *pv_reg;
+	unsigned char __iomem *pv_mem;
 	/* locks*/
 	spinlock_t slock;
 
-	struct init_status initParm;
+	struct init_status init_parm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
 	int nocrt;
@@ -113,7 +113,7 @@ struct sm750_dev {
 	 * 2: secondary crtc hw cursor enabled
 	 * 3: both ctrc hw cursor enabled
 	 */
-	int hwCursor;
+	int hw_cursor;
 };
 
 struct lynx_cursor {
@@ -170,7 +170,7 @@ struct lynxfb_output {
 	 */
 	void *priv;
 
-	int (*proc_setBLANK)(struct lynxfb_output *output, int blank);
+	int (*proc_set_blank)(struct lynxfb_output *output, int blank);
 };
 
 struct lynxfb_par {
@@ -193,26 +193,26 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
 
 int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
-void hw_sm750_initAccel(struct sm750_dev *sm750_dev);
-int hw_sm750_deWait(void);
-int hw_sm750le_deWait(void);
+void hw_sm750_init_accel(struct sm750_dev *sm750_dev);
+int hw_sm750_de_wait(void);
+int hw_sm750le_de_wait(void);
 
-int hw_sm750_output_setMode(struct lynxfb_output *output,
-			    struct fb_var_screeninfo *var,
-			    struct fb_fix_screeninfo *fix);
+int hw_sm750_output_set_mode(struct lynxfb_output *output,
+			     struct fb_var_screeninfo *var,
+			     struct fb_fix_screeninfo *fix);
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
-			    struct fb_var_screeninfo *var);
+int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
+			     struct fb_var_screeninfo *var);
 
-int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
-			  struct fb_var_screeninfo *var,
-			  struct fb_fix_screeninfo *fix);
+int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
+			   struct fb_var_screeninfo *var,
+			   struct fb_fix_screeninfo *fix);
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
-		       ushort red, ushort green, ushort blue);
+int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index,
+			 ushort red, ushort green, ushort blue);
 
-int hw_sm750_setBLANK(struct lynxfb_output *output, int blank);
-int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank);
+int hw_sm750_set_blank(struct lynxfb_output *output, int blank);
+int hw_sm750le_set_blank(struct lynxfb_output *output, int blank);
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 			 const struct fb_var_screeninfo *var,
 			 const struct fb_info *info);
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 24b9077a634a..19e5c6395c5c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -18,19 +18,20 @@
 
 #include "sm750.h"
 #include "sm750_accel.h"
-static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
+static inline void write_dpr(struct lynx_accel *accel, int offset,
+			     u32 reg_value)
 {
-	writel(regValue, accel->dprBase + offset);
+	writel(reg_value, accel->dpr_base + offset);
 }
 
 static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 {
-	return readl(accel->dprBase + offset);
+	return readl(accel->dpr_base + offset);
 }
 
-static inline void write_dpPort(struct lynx_accel *accel, u32 data)
+static inline void write_dp_port(struct lynx_accel *accel, u32 data)
 {
-	writel(data, accel->dpPortBase);
+	writel(data, accel->dp_port_base);
 }
 
 void sm750_hw_de_init(struct lynx_accel *accel)
@@ -86,11 +87,11 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 }
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
-	u32 deCtrl;
+	u32 de_ctrl;
 
 	if (accel->de_wait() != 0) {
 		/*
@@ -103,14 +104,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
 	write_dpr(accel, DE_PITCH,
-		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+		   (pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
 
 	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
@@ -122,24 +123,24 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr8 */
 
-	deCtrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
+	de_ctrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
 		DE_CONTROL_COMMAND_RECTANGLE_FILL | DE_CONTROL_ROP_SELECT |
 		(rop & DE_CONTROL_ROP_MASK); /* dpr0xc */
 
-	write_dpr(accel, DE_CONTROL, deCtrl);
+	write_dpr(accel, DE_CONTROL, de_ctrl);
 	return 0;
 }
 
 /**
  * sm750_hw_copyarea
  * @accel: Acceleration device data
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @s_base: Address of source: offset in frame buffer
+ * @s_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -147,21 +148,21 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int s_base, unsigned int s_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int d_base, unsigned int d_pitch,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
-	unsigned int nDirection, de_ctrl;
+	unsigned int n_direction, de_ctrl;
 
-	nDirection = LEFT_TO_RIGHT;
+	n_direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (sBase == dBase && sPitch == dPitch) {
+	if (s_base == d_base && s_pitch == d_pitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
 			/*  +----------+
@@ -174,7 +175,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = BOTTOM_TO_TOP;
+			n_direction = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
 			/*  +----------+
 			 *  |D         |
@@ -186,7 +187,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = TOP_TO_BOTTOM;
+			n_direction = TOP_TO_BOTTOM;
 		} else {
 			/* sy == dy */
 
@@ -199,7 +200,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = RIGHT_TO_LEFT;
+				n_direction = RIGHT_TO_LEFT;
 			} else {
 			/* sx > dx */
 
@@ -211,12 +212,12 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = LEFT_TO_RIGHT;
+				n_direction = LEFT_TO_RIGHT;
 			}
 		}
 	}
 
-	if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT)) {
+	if ((n_direction == BOTTOM_TO_TOP) || (n_direction == RIGHT_TO_LEFT)) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
@@ -235,14 +236,14 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
+	write_dpr(accel, DE_WINDOW_SOURCE_BASE, s_base); /* dpr40 */
 
 	/*
 	 * 2D Destination Base.
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, d_base); /* dpr44 */
 
 	/*
 	 * Program pitch (distance between the 1st points of two adjacent lines).
@@ -250,9 +251,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((d_pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (s_pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -260,9 +261,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((d_pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (s_pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
@@ -278,14 +279,14 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
-		((nDirection == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
+		((n_direction == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
 		DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
 	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
 
 	return 0;
 }
 
-static unsigned int deGetTransparency(struct lynx_accel *accel)
+static unsigned int de_get_transparency(struct lynx_accel *accel)
 {
 	unsigned int de_ctrl;
 
@@ -300,38 +301,38 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 /**
  * sm750_hw_imageblit
  * @accel: Acceleration device data
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @src_buf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *	      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @f_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @b_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2)
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
+		       u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 f_color, u32 b_color, u32 rop2)
 {
-	unsigned int ulBytesPerScan;
-	unsigned int ul4BytesPerScan;
-	unsigned int ulBytesRemain;
+	unsigned int ul_bytes_per_scan;
+	unsigned int ul4_bytes_per_scan;
+	unsigned int ul_bytes_remain;
 	unsigned int de_ctrl = 0;
-	unsigned char ajRemain[4];
+	unsigned char aj_remain[4];
 	int i, j;
 
-	startBit &= 7; /* Just make sure the start bit is within legal range */
-	ulBytesPerScan = (width + startBit + 7) / 8;
-	ul4BytesPerScan = ulBytesPerScan & ~3;
-	ulBytesRemain = ulBytesPerScan & 3;
+	start_bit &= 7; /* Just make sure the start bit is within legal range */
+	ul_bytes_per_scan = (width + start_bit + 7) / 8;
+	ul4_bytes_per_scan = ul_bytes_per_scan & ~3;
+	ul_bytes_remain = ul_bytes_per_scan & 3;
 
 	if (accel->de_wait() != 0)
 		return -1;
@@ -346,7 +347,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, d_base);
 
 	/*
 	 * Program pitch (distance between the 1st points of two adjacent
@@ -354,9 +355,9 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * register uses pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / bytePerPixel << DE_PITCH_DESTINATION_SHIFT) &
+		  ((d_pitch / byte_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (dPitch / bytePerPixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (d_pitch / byte_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -364,17 +365,17 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * in frame buffer for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / bytePerPixel << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((d_pitch / byte_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (dPitch / bytePerPixel & DE_WINDOW_WIDTH_SRC_MASK));
+		  (d_pitch / byte_per_pixel & DE_WINDOW_WIDTH_SRC_MASK));
 
 	 /*
 	  * Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
 	  * and Y_K2 field is not used.
-	  * For mono bitmap, use startBit for X_K1.
+	  * For mono bitmap, use start_bit for X_K1.
 	  */
 	write_dpr(accel, DE_SOURCE,
-		  (startBit << DE_SOURCE_X_K1_SHIFT) &
+		  (start_bit << DE_SOURCE_X_K1_SHIFT) &
 		  DE_SOURCE_X_K1_MONO_MASK); /* dpr00 */
 
 	write_dpr(accel, DE_DESTINATION,
@@ -385,28 +386,28 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
-	write_dpr(accel, DE_FOREGROUND, fColor);
-	write_dpr(accel, DE_BACKGROUND, bColor);
+	write_dpr(accel, DE_FOREGROUND, f_color);
+	write_dpr(accel, DE_BACKGROUND, b_color);
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) |
 		DE_CONTROL_ROP_SELECT | DE_CONTROL_COMMAND_HOST_WRITE |
 		DE_CONTROL_HOST | DE_CONTROL_STATUS;
 
-	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
+	write_dpr(accel, DE_CONTROL, de_ctrl | de_get_transparency(accel));
 
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
-		for (j = 0; j < (ul4BytesPerScan / 4); j++)
-			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
+		for (j = 0; j < (ul4_bytes_per_scan / 4); j++)
+			write_dp_port(accel, *(unsigned int *)(src_buf + (j * 4)));
 
-		if (ulBytesRemain) {
-			memcpy(ajRemain, pSrcbuf + ul4BytesPerScan,
-			       ulBytesRemain);
-			write_dpPort(accel, *(unsigned int *)ajRemain);
+		if (ul_bytes_remain) {
+			memcpy(aj_remain, src_buf + ul4_bytes_per_scan,
+			       ul_bytes_remain);
+			write_dp_port(accel, *(unsigned int *)aj_remain);
 		}
 
-		pSrcbuf += srcDelta;
+		src_buf += src_delta;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a..8a5d1fe5075a 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,19 +190,19 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop);
 
 /**
  * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @s_base: Address of source: offset in frame buffer
+ * @s_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -210,34 +210,34 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int s_base, unsigned int s_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int d_base, unsigned int d_pitch,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
 /**
  * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @src_buf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @f_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @b_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
+		       u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 f_color, u32 b_color, u32 rop2);
 
 #endif
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 43e6f52c2551..ff643e33fa44 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -58,13 +58,13 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 	poke32(HWC_ADDRESS, 0);
 }
 
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
 }
 
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
 {
 	u32 reg;
 
@@ -73,7 +73,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
 	poke32(HWC_LOCATION, reg);
 }
 
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
 {
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
 		HWC_COLOR_12_2_RGB565_MASK;
@@ -82,8 +82,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
 	poke32(HWC_COLOR_3, 0xffe0);
 }
 
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-			     const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask, opr;
@@ -132,8 +132,8 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 	}
 }
 
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
-			      const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
+			       const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index b59643dd61ed..88fa02f6377a 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,11 +5,11 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-			     const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
+void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
+			       const u8 *data, const u8 *mask);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a7c6eb07b62e..d4cf66e5990b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -50,20 +50,20 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->pv_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->pv_reg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	} else {
-		pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
+		pr_info("mmio virtual addr = %p\n", sm750_dev->pv_reg);
 	}
 
-	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pv_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pv_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->pv_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -78,14 +78,14 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->pv_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
+	if (!sm750_dev->pv_mem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	} else {
-		pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+		pr_info("video memory vaddr = %p\n", sm750_dev->pv_mem);
 	}
 exit:
 	return ret;
@@ -95,7 +95,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
 	struct init_status *parm;
 
-	parm = &sm750_dev->initParm;
+	parm = &sm750_dev->init_parm;
 	if (parm->chip_clk == 0)
 		parm->chip_clk = (sm750_get_chip_type() == SM750LE) ?
 					       DEFAULT_SM750LE_CHIP_CLOCK :
@@ -106,7 +106,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	if (parm->master_clk == 0)
 		parm->master_clk = parm->chip_clk / 3;
 
-	ddk750_init_hw((struct initchip_param *)&sm750_dev->initParm);
+	ddk750_init_hw((struct initchip_param *)&sm750_dev->init_parm);
 	/* for sm718, open pci burst */
 	if (sm750_dev->devid == 0x718) {
 		poke32(SYSTEM_CTRL,
@@ -136,12 +136,12 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		      ~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
-		case sm750_24TFT:
+		case sm750_24_tft:
 			break;
-		case sm750_doubleTFT:
+		case sm750_double_tft:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case sm750_dual_tft:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
@@ -175,14 +175,14 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	/* init 2d engine */
 	if (!sm750_dev->accel_off)
-		hw_sm750_initAccel(sm750_dev);
+		hw_sm750_init_accel(sm750_dev);
 
 	return 0;
 }
 
-int hw_sm750_output_setMode(struct lynxfb_output *output,
-			    struct fb_var_screeninfo *var,
-			    struct fb_fix_screeninfo *fix)
+int hw_sm750_output_set_mode(struct lynxfb_output *output,
+			     struct fb_var_screeninfo *var,
+			     struct fb_fix_screeninfo *fix)
 {
 	int ret;
 	enum disp_output disp_set;
@@ -221,8 +221,8 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 	return ret;
 }
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
-			    struct fb_var_screeninfo *var)
+int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
+			     struct fb_var_screeninfo *var)
 {
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par = container_of(crtc, struct lynxfb_par, crtc);
@@ -247,9 +247,9 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
 }
 
 /* set the controller's mode for @crtc charged with @var and @fix parameters */
-int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
-			  struct fb_var_screeninfo *var,
-			  struct fb_fix_screeninfo *fix)
+int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
+			   struct fb_var_screeninfo *var,
+			   struct fb_fix_screeninfo *fix)
 {
 	int ret, fmt;
 	u32 reg;
@@ -305,7 +305,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		clock = SECONDARY_PLL;
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
-	ret = ddk750_setModeTiming(&modparm, clock);
+	ret = ddk750_set_mode_timing(&modparm, clock);
 	if (ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
@@ -372,8 +372,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	return ret;
 }
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index, ushort red,
-		       ushort green, ushort blue)
+int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index, ushort red,
+			 ushort green, ushort blue)
 {
 	static unsigned int add[] = { PANEL_PALETTE_RAM, CRT_PALETTE_RAM };
 
@@ -382,7 +382,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index, ushort red,
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank)
+int hw_sm750le_set_blank(struct lynxfb_output *output, int blank)
 {
 	int dpms, crtdb;
 
@@ -423,7 +423,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank)
 	return 0;
 }
 
-int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
+int hw_sm750_set_blank(struct lynxfb_output *output, int blank)
 {
 	unsigned int dpms, pps, crtdb;
 
@@ -476,7 +476,7 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 	return 0;
 }
 
-void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
+void hw_sm750_init_accel(struct sm750_dev *sm750_dev)
 {
 	u32 reg;
 
@@ -506,7 +506,7 @@ void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
 	sm750_dev->accel.de_init(&sm750_dev->accel);
 }
 
-int hw_sm750le_deWait(void)
+int hw_sm750le_de_wait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = DE_STATE2_DE_STATUS_BUSY | DE_STATE2_DE_FIFO_EMPTY |
@@ -523,7 +523,7 @@ int hw_sm750le_deWait(void)
 	return -1;
 }
 
-int hw_sm750_deWait(void)
+int hw_sm750_de_wait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = SYSTEM_CTRL_DE_STATUS_BUSY |
-- 
2.25.1

