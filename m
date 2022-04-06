Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823BE4F6EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiDFX6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiDFX60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:58:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC929D59A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:56:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb8b94ad35so35085977b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a7MFOIv+cMm30GNhkmbq9vOvWe/8bMdwsHFnjI1lmmE=;
        b=AYJiAcfivAAW190IQXodXNrufah3MinQVbZ3zfs/8rH0HYTgV6Yl/qMJW7eNtq9BeX
         1bO+Koyi3jOMnAvct2P1lrSlz+Xa53lInb3t6uyM0VTRY9FVMXsU5QPhNXClrL/3IF+/
         gqX3dZI4+TBZYM4nLXFQlGIW4tPbGk+yLkcomBESEkB2FzovoQ2ScibnEFBTiHianO/S
         ve5RCpHHqWUK89DQFO/VN15mHryPgjxLrjJqfCsmD1cut4R91+a5/fVGvGbWLKWp9e1i
         HjGia7DyjtzqWJBHiRrGgQ5FbMumGwB7qVjCav6gC1C2WH9q8FE3VWHbfViSjERuHAWw
         KJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a7MFOIv+cMm30GNhkmbq9vOvWe/8bMdwsHFnjI1lmmE=;
        b=CTFY57dUQI44s58MS9zxMoOwOUf3eG3A8V5/81cqrN2FMAFPqMjTmsX015ItYV2MhT
         vG89oRCotdUe2Vtcsz4sdiK4eUMgmxNh78Df7xrPEfnKYWdMX9zjWjVfGzE7Xz1L01eq
         82xLyEgdkPzK+hE81AlMKELJfS4i3FZ/7N8h0yPbRaoGoRycELZo+uMloX7vt12DxOXB
         Ht0sJOE07pr2R37n8nMA3bXx+z5bNKBwuULKxzqoQGLHNX8gk506cPhLb4TFKaGl2XhN
         9yx4ACOH5sdDHEQJDcZQ5fajq2wBUjDkPwNArWTcxde8aZwxTKOTjtMUjXpyBFkNY9Js
         +zRA==
X-Gm-Message-State: AOAM532HdB2gub7RlHH2Leu2Ia/iD9zWTe3gvhZGUlf+Y7sGEUTUvv57
        L8zKXCQVS0s9PAnZSlme/17y8FOhIQZ1q1w=
X-Google-Smtp-Source: ABdhPJwWa7REdHw79q9SJnjOiw3haqkQJpo1uTBwENxLVn6YIjK8QRsHx9f9sqmJJU6hpgTtwyvfxa8i0QhqnDc=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:0:1000:3002:60a3:41bf:126d:cf69])
 (user=lixiaoyan job=sendgmr) by 2002:a25:ca53:0:b0:63d:878e:b9d0 with SMTP id
 a80-20020a25ca53000000b0063d878eb9d0mr8023286ybg.41.1649289388089; Wed, 06
 Apr 2022 16:56:28 -0700 (PDT)
Date:   Wed,  6 Apr 2022 16:56:24 -0700
Message-Id: <20220406235624.2037687-1-lixiaoyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] fou: Remove XRFM from NET_FOU Kconfig
From:   Coco Li <lixiaoyan@google.com>
To:     "David S . Miller" <davem@davemloft.net>
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
2.35.1.1094.g7c7d902a7c-goog

