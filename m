Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FE560DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiF2Xh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiF2Xhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:37:55 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02B26D1;
        Wed, 29 Jun 2022 16:37:53 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 86C622006F;
        Thu, 30 Jun 2022 02:37:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1656545869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZPcDubcZRZtSjPHiS3Ehon8rbBcOHGnS6yupHDAd+g=;
        b=Ol0MQFGKXsgs0jRxDWkXWJBWFE19e3lfSpPbSI7YzjcF68fsswJu1vnZ44pbHElOwCwRI8
        9G7JEXR8CyEl9DOUCOJYsMj1YBcwAUdl72/Z2XmGb96oSTBPadp1+iFmyByKw86LewnKTo
        dG39dN2ULNHhnGeKRHNkwwVZ1r9e5kg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 31D12634C92;
        Thu, 30 Jun 2022 02:37:49 +0300 (EEST)
Date:   Thu, 30 Jun 2022 02:37:49 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
Message-ID: <YrziTabYLlZ2bX+1@valkosipuli.retiisi.eu>
References: <m3pmn66pie.fsf@t19.piap.pl>
 <m3h78i6p4t.fsf@t19.piap.pl>
 <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
 <m38rtt7sx7.fsf@t19.piap.pl>
 <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
 <m37d7ufrzx.fsf@t19.piap.pl>
 <m3pmkryywn.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3pmkryywn.fsf@t19.piap.pl>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1656545869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZPcDubcZRZtSjPHiS3Ehon8rbBcOHGnS6yupHDAd+g=;
        b=VYoKt6nuS8XsYbpRE397cvA/0SVwH/2vDNIQ+33LEyR+fOPz4YOPnDtugToUumUngrW2Dz
        X2bk5k64J5cXWrhlQNgzUEMJ8g9Ikq4uXjpKtLq9vUaI7xG/BuvHpICMWb8wgo4bXqSQVI
        s4eb5yddlrZGsLvoZbeTp5n2ZHV0JJ0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1656545869; a=rsa-sha256; cv=none;
        b=PiHxDhpesbXzajxc3GiQnn3hHmN+RiT2UxicFPOv55yoFM3+xHb8lvVffz6nB8ggU8/BRx
        VWbUIrpESvbVSLoxYX226MU1sFk2d4DNiIwyKonhkp5zHydtjhahGsnbQF8lynn/dKM0r5
        E/muJHCpXbrNJP4KgPNUds+7vpmrJM8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, May 06, 2022 at 08:10:16AM +0200, Krzysztof Hałasa wrote:
> Hi Mauro et al,
> 
> Mauro, you are the drivers/media maintainer. Is the AR0521 driver ready
> to be merged, are there still unresolved issues, or the driver is not no
> be merged at all? I understand everyone's so busy but a simple yes or no
> isn't too much, is it?

Apologies for the late reply.

Please run checkpatch.pl --strict --max-line-length=80 on the patch in the
future. Some of the output is often troublesome to address though. I've
applied it with these changes:

diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
index 1cce512ff62b0..9c7a07d31ace6 100644
--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -347,8 +347,10 @@ static int ar0521_set_stream(struct ar0521_dev *sensor, bool on)
 		return ret;
 
 	} else {
-		/* Reset gain, the sensor may produce all white pixels without
-		   this */
+		/*
+		 * Reset gain, the sensor may produce all white pixels without
+		 * this
+		 */
 		ret = ar0521_write_reg(sensor, AR0521_REG_GLOBAL_GAIN, 0x2000);
 		if (ret)
 			return ret;
@@ -1056,4 +1058,4 @@ module_i2c_driver(ar0521_i2c_driver);
 
 MODULE_DESCRIPTION("AR0521 MIPI Camera subdev driver");
 MODULE_AUTHOR("Krzysztof Hałasa <khalasa@piap.pl>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");

-- 
Kind regards,

Sakari Ailus
