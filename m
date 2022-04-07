Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7B4F881C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiDGTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiDGTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546529AD1A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bq8so12917047ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86bWkUU1DWtqExQIpuhgVcDC/r0eepfnI3UV3du+ILA=;
        b=ZF2eIv9ThBCqKphf5UMqpw+cNVjGX1YXmq3VIN2ZG93OmjFxooJ63vFD/WayYDMhSz
         4kR1GsaWyTnu7Ah8tJuLyNGvAY/FKomCHoki9gT/ELaTi0J1CZfnOWUwEQ33gHjP9wU0
         shH417CVQUtfVxRtAOe1MxfAg05a6HN304tCV1HjhQG1HWSmPTQAZTJz1SLe/opBo/oT
         mKLDAu3fqxTqCWdT8sQjsOhHLLNkkocVPi9bmZQ1WBo/TzrtTbwNs/Tm+cIhGV+mV8xU
         giAuMOTgDOskKbuTMBrNU540HXV9jdmgSSBPYy01eJOWt6UAXaz5bhN0HoOeng6b3J/B
         rP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86bWkUU1DWtqExQIpuhgVcDC/r0eepfnI3UV3du+ILA=;
        b=l+0H/D8xegrBD2Bu5tLpLxL70fFL6qp2NEcMPJSrTqB3U3yRoKrIMYgeYo/EU+YdSx
         muJk00xB8CDnxFe0cMCdDezm51FA+jYE3IhtZCmpiAwuZrQlGwLxJah7xo4KtqJVSnAe
         Fwl+MLFEMC72DsoIuEOXLyVt8jvnUVjKv6gtLxVOIs6gm6vzSDJQqrESsnThfP1ZCRJA
         thw1YLz8EaRdcb6JrOQsh+iHlZXVb8XnSfIe/wP/hFcHODIU3XhZ02IOpDBOJYIGvoGj
         +M+89RBlT5GASzE1PZZOEXvwdtP83vWg3Lb7+FRFIQYfZwqXS0D/U0Be2xvkNebiH1VA
         ZLHg==
X-Gm-Message-State: AOAM531hTaeQhBoIxjsPeuMfejVCSKuI3WUKuJkrto2iamydm6mknAzg
        xCXf2wQxxNCoXy9R1TIySHw=
X-Google-Smtp-Source: ABdhPJzaDeHLK//UqDlGr1gZKqD0RXONg04r9gqQGNsD312Pou1R2vAcj3+LLuu11D1pIy3u8bUNEA==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr15353946ejc.401.1649359707559;
        Thu, 07 Apr 2022 12:28:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: r8188eu: remove unused prototype usbvendorrequest()
Date:   Thu,  7 Apr 2022 21:28:17 +0200
Message-Id: <20220407192819.10661-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

Remove unused prototype usbvendorrequest().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_osintf.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
index 3e777ca52745..32ca8ef95b23 100644
--- a/drivers/staging/r8188eu/include/usb_osintf.h
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -13,9 +13,6 @@ extern int rtw_mc2u_disable;
 
 #define USBD_HALTED(Status) ((u32)(Status) >> 30 == 3)
 
-u8 usbvendorrequest(struct dvobj_priv *pdvobjpriv, enum bt_usb_request brequest,
-		    enum rt_usb_wvalue wvalue, u8 windex, void *data,
-		    u8 datalen, u8 isdirectionin);
 void netdev_br_init(struct net_device *netdev);
 void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb);
 void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);
-- 
2.35.1

