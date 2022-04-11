Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9045E4FC6DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbiDKVjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350226AbiDKVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:39:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2273388C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:37:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec06f77db8so44063867b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CYEWBCjoPVU2bEv5a9LbpQRmjI0+I1tI73ri3XYIoPM=;
        b=rqtG92stK6xZiFkl/ErVmgchIx3LWNYKUPdmRAJNzwUATpL2JmlS/984/vO2BLll2a
         ywo/WM0L8XhG09dPOIWNaWOEIL7t4Na6QamadJ5f10GmsL38BaNcodokFTBs6iD/evgL
         7yByF+ry5MRttRPpe7WYrjZpuXh69M+y8FCUb4OCpFcgyhL5jtjCV9aYVX2B87cax5P5
         tisQxJdqqUTzbNkaf8bbhi0YakDMBP1SWLfu36yhvN3Ok5RWcghZRHlInxuvm/Ia55Ga
         hDDiySBphp85Xl/dYaGioSsRGDSBZMmI9rd06jBZMHYEtf3aVIgcMpmSZy5wV6i7Kkli
         6gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CYEWBCjoPVU2bEv5a9LbpQRmjI0+I1tI73ri3XYIoPM=;
        b=HqVC+WTnqiORZILpSaZiqGuz3pWrEYOlyaHfpyZji28xGnCCJDxWI9uc96NzQurOGe
         EpW1Sy6X/9T+bcRlehmWGOq/mhHEmdt8Ueb0phGqRJXB8itfdXHVzn6VygBpfeGH/a0F
         13RhgQvm2DLMjWMmIDSfrSHqx9Qz5ufoJyEYSV+sh+lSe3mM+4B4a1yshv0eSF80y5z4
         Hat6iuJIoyUs/Po0iMlS+diPP37BRcmNL3nKVgPC0sapUif+gbQY3sLo/LnJKN0hHeb9
         NYZ9Fm7+DUoP7OTgoldmPou3mgL2GNt38Mwz0BtKz6uOB6B5MEmB+oN2cfymI2L1Kzlc
         2VEA==
X-Gm-Message-State: AOAM532li3dC//3nFDZWB9r+NJf45JeEw+0VUOOjOmCUMjzRblVbsuYN
        BW6vaTuZjQSXmukD2fqO2lpVd4KdjGYV79k=
X-Google-Smtp-Source: ABdhPJwI+PA9ty1x20Uxqt8yUv0Sk8hbM+NDgGUyvjiF28v0Z8ljq+Bhdd2dZAbgNmbMOncezlxC6i+/+5uoJEM=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:15c:2c4:1:9e7:e99b:acc3:486c])
 (user=lixiaoyan job=sendgmr) by 2002:a25:d8d0:0:b0:641:7470:e597 with SMTP id
 p199-20020a25d8d0000000b006417470e597mr3446766ybg.532.1649713051953; Mon, 11
 Apr 2022 14:37:31 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:37:17 -0700
Message-Id: <20220411213717.3688789-1-lixiaoyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH net-next v2] fou: Remove XRFM from NET_FOU Kconfig
From:   Coco Li <lixiaoyan@google.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
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

Also remove the xrfm.h dependency in fou.c. It was
added in '23461551c006 ("fou: Support for foo-over-udp RX path")'
for depencies of udp_del_offload and udp_offloads, which were removed in
'd92283e338f6 ("fou: change to use UDP socket GRO")'.

Built and installed kernel and setup GUE/FOU tunnels.

Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 net/ipv4/Kconfig | 1 -
 net/ipv4/fou.c   | 1 -
 2 files changed, 2 deletions(-)

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
diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 0d085cc8d96c..025a33c1b04d 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -16,7 +16,6 @@
 #include <net/protocol.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
-#include <net/xfrm.h>
 #include <uapi/linux/fou.h>
 #include <uapi/linux/genetlink.h>
 
-- 
2.35.1.1178.g4f1659d476-goog

