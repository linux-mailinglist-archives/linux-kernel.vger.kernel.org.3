Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A6A4F85B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbiDGRS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiDGRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:18:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103319321A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:16:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb2bc9018aso53925047b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m+o8vH305sH+IlbC7nxi+b473EiNSwI1NcAhd5gcKNg=;
        b=o+RQ8J/gC363Mlt3fxzfhIWxELTFITTjaGnXwvQL2n8ybudr7pgauF47SCrVAj2Mi3
         iQCY+SifSUxbn8w7qenVGfVtga/hVGMJAA55alpuJzKeOLcgkucnWTsiNmpqblC0kYRO
         ZXRdrzzNC8ZIPF5mJlbXP8d9jkQytK59iAct01jj4gLmSLbv2RCcI0UYsC5oNJd4mH/Z
         y9AM1fE7cY9mHD1S4J81bhR2UqmSM5a0oteoav40LcRNn4DGGAtEoh11JbPw+hldjXOH
         Wd8KbHfs1hv1BonwD+Cmlixr8czYZJaOvHgMvzEP8VfkamkZU4HDLMa3Tz1PwgXLiftd
         ncNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m+o8vH305sH+IlbC7nxi+b473EiNSwI1NcAhd5gcKNg=;
        b=J46SymGQAXeHMcRqvkB5kC51WxwPXNIqQp62+mw+OcyoZl3K4QbZViPjbC2heIhn9M
         Ibvh+tBMjWj8DXUUvIjwua6lvC0RFCpaj44Jh7FEl/lolpu1V1CcOEbnYFOx1S0nUkAy
         2lYSfJGsn1EiGWEJp0pNSfsEQJUUAGUFBQId0AaCnGDJAt+Y7eF9Lj5j8n8XgaE14dp1
         aSef9SlRG/50m3ucVvAceZ3BKYITwnYExeFMnskkENM5jlM+SX4a4lNgY46K1USWAWH0
         N/MtmFg4NVha8lFSrkP19b+MzhH4UjWUS2zr4nipc7Yw3Yo9TWvRmd0Z2S2KecoP57s2
         cBRQ==
X-Gm-Message-State: AOAM533EOQgwuL07ko8nLT6ZjFS8fT1hCwXdZP92TmK9hiL0rHeykF6J
        DZ2yK2WPB8MgylqrmQS8GAVK9pt59HjHx6I=
X-Google-Smtp-Source: ABdhPJwB7Q4sp3n8PJrlqof8f5/fiXurYzXoeOtomKaGguidvlKHK9cIepPKzksFxW3s/Y46jwKoMLhDfy+eeys=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:0:1000:3002:cd29:e4bc:e58c:dcd6])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:20e:b0:627:f1cb:a9ee with SMTP
 id j14-20020a056902020e00b00627f1cba9eemr10500309ybs.129.1649351780504; Thu,
 07 Apr 2022 10:16:20 -0700 (PDT)
Date:   Thu,  7 Apr 2022 10:15:54 -0700
Message-Id: <20220407171554.2712631-1-lixiaoyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH net-next] fou: Remove XRFM from NET_FOU Kconfig
From:   Coco Li <lixiaoyan@google.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        willem de bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XRFM is no longer needed for configuring FOU tunnels
(CONFIG_NET_FOU_IP_TUNNELS), remove from Kconfig.

Built and installed kernel and setup GUE/FOU tunnels.

Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 net/ipv4/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 87983e70f03f..e983bb0c5012 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -321,7 +321,6 @@ config NET_UDP_TUNNEL
 
 config NET_FOU
 	tristate "IP: Foo (IP protocols) over UDP"
-	select XFRM
 	select NET_UDP_TUNNEL
 	help
 	  Foo over UDP allows any IP protocol to be directly encapsulated
-- 
2.35.1.1178.g4f1659d476-goog

