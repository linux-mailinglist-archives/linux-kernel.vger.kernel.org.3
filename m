Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAEE4B0A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiBJKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:05:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBJKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:05:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA11DC55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:05:27 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so13955117ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzUGZXiKrG3vda6RRywObRyVscV1BS6OieKdbSw13Dc=;
        b=ni3CJoCNoERTIgfISz9xr7FEisOgmtdFfM77P97vd3xYaiZ+5iEw6mDqNxp4TygXBk
         QGNBXKJPZa9O/C+G+wB0dJtk7qYeCwkoD/QhCs2HhM+H0EBrWFKPVKXFvXRpevg1zChG
         e4apKMnIKO+tB6a7Cw35m1/KK5FmopkSbFbwOmb7t1/EyYZDaNvns/irXzoRe1Ct3D84
         UvdUiSG5YJdh4Ogp9HIWcL1znZyuN4oBlOHvE0qpOTRr/WxTj8IVqwbrMp621mQ8nKws
         xN54N32R0/9QarBe/1j6soJsnDMp6+ud0ODsKr233QQSmsB1gbgFpkRJl8XohUxxPR0d
         aicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzUGZXiKrG3vda6RRywObRyVscV1BS6OieKdbSw13Dc=;
        b=QicnA8QGfJcnpW53WhOvAFep6+GF+Uj53dhpDTSYj/VgIYSu/gvIDmkHGamv17z6wj
         L/Q9jp3BLmcCzuPNfLkeo1wPAyBTDJtI/2lm5lwqP5PAnADHGrAprlAF9W2ex7uP0eiD
         Y7s1iObQMhOQIhFJE+MQRP2r2cvo4R1ZUigW4GdeT7GOdOijS+yZKJ81YNYaKs2G25hL
         yQoVx6wh7zbMQpDmu0j1Rz/qs+zxd+iA7NUiEWff+PUz+YjnZRmou1fzdudEvGTeVcMr
         zThkfqYhF4cXAoUNyjsdm8eZmygxH/MbX0RndR34OvT7MpZq+9K/HCoZYtAy1MRJbDBX
         ZnAQ==
X-Gm-Message-State: AOAM531p17++JXEZ4W6MUoEzQVFxzlBHoaYRIvGLNeewT5mV3r4Htq/Q
        UpzjI02+OluAFs7J4kxjVgE=
X-Google-Smtp-Source: ABdhPJwT3mN3Ygn68QfJuEMPQPLIfHRie17zDbi5JuaDQJnsmrjYE+5WzmtYMtSFCcxmS07VYyTJkQ==
X-Received: by 2002:a17:906:4fca:: with SMTP id i10mr5509634ejw.542.1644487526297;
        Thu, 10 Feb 2022 02:05:26 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id 5sm9729858edx.32.2022.02.10.02.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:05:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: clean up ieee80211.h
Date:   Thu, 10 Feb 2022 11:05:12 +0100
Message-Id: <20220210100514.8506-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This set removes unused struts and enums from the ieee80211.h header.

Michael Straube (2):
  staging: r8188eu: remove unused structs from ieee80211.h
  staging: r8188eu: remove unused enums from ieee80211.h

 drivers/staging/r8188eu/include/ieee80211.h | 266 --------------------
 1 file changed, 266 deletions(-)

-- 
2.35.1

