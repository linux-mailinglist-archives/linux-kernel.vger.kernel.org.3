Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10604D11C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbiCHILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbiCHILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:11:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2EC3EF3E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:09:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so1521985pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=w9D6iWO0MWv1/HxyhvxBgbJwCmIgSuOmNtaaVMp02a4=;
        b=FVI8cFf+IetQf2vzJ9vIWvUUo/8ocMiWxktiC58PYPpjyDmjZzj4MdkRm/dEmiq+lm
         +GyISVdgghdnheUPZ6agmNdsfn13WEt0fbzgBsxB8MhbMNotWcCx1coy2HeSTtdoNEaM
         e2mBpFhfm1J7NrSJsboTsyadWISTos14/h7/JT0K0812e6IYqHsr1N6VAdjM7k6Ezt4U
         thKyaAnB0QQeu/fjnAwexjHL3rV/8lqM0xu25WSYZUFC+s2BT1/heHL8Ce68YVW26dEG
         luHBQEjGUAFMKfGirhjuGcERzUoBawtyC1TEnrMdhAode1zJP9uT+KouHB9Z6t+rCkUn
         V1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=w9D6iWO0MWv1/HxyhvxBgbJwCmIgSuOmNtaaVMp02a4=;
        b=bEtImRvpMl6dN7lXitF6LHn2HOvamkHCsRoIz44uPPuyjcJapjhhokpTp0CRRNDv7Z
         Ar1mysebF6mdEKTKSF6HQ0OZ2hJOXcLP2X1ETjCn7zUmCnDHOE4be3roc9opsznJjjxh
         SdJQopvBbLcdniK9M6hjV1aTOsR61nZcHtYTVgyQwcPcTYpRHoR+g/fktietK/TN7EHj
         Knj6noLLQW/C/eCe5MtW/v+rsAxgvEi4H1ljAESEoyoioZ4M71UP5RMto4v8ZGwtAHNH
         ml4rPTYsVLkX7hEqzj4Fg4FVLnXSb5RcZy3hQuOLgsNFc3NrU62jJhAaeDU6ceXWdX0B
         dt+Q==
X-Gm-Message-State: AOAM532jUEve0zQDk1BcGENLiN/6hzQQ3DaXsdvU0ufURp8njGCfoxNB
        BPTxNsDeQMtBNJjUy2Ue+dso0jojbQtVrA==
X-Google-Smtp-Source: ABdhPJydB8DkbxuwT7AnfQwGafcuYCoWxT9DgzyDr2HbzpIp+ynJD12cvZsMY2S6HA5F40z3n0awTA==
X-Received: by 2002:a17:90b:17cb:b0:1bf:138d:e0f8 with SMTP id me11-20020a17090b17cb00b001bf138de0f8mr3333248pjb.157.1646726990886;
        Tue, 08 Mar 2022 00:09:50 -0800 (PST)
Received: from mail.google.com ([122.58.164.114])
        by smtp.gmail.com with ESMTPSA id m20-20020a634c54000000b003739af127c9sm14223979pgl.70.2022.03.08.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:50 -0800 (PST)
Date:   Tue, 8 Mar 2022 21:09:42 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove hardcoded mask value for easier
 readability
Message-ID: <YicPRrH3HmpiTCxe@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace hardcoded value with the bitwise complement of the mask used to
extract value sent to rf69 chip.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 3028018f0b45..659c8c1b38fd 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -741,7 +741,7 @@ int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold)
 	int retval;
 
 	/* check input value */
-	if (threshold & 0x80) {
+	if (threshold & ~MASK_FIFO_THRESH_VALUE) {
 		dev_dbg(&spi->dev, "set: illegal fifo threshold %u\n", threshold);
 		return -EINVAL;
 	}
-- 
2.34.1

