Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89919589F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiHDQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHDQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:06:46 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4EC18359;
        Thu,  4 Aug 2022 09:06:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m9so320442ljp.9;
        Thu, 04 Aug 2022 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doWgkAfEcmSMhRNIxRoHTjD9fSl7Q2XFQ3gDJGe0anw=;
        b=ol8FGt9Nf2Z6wRH9+PBYBRZWr/mV/XxqQGI6MsWoo8AAtYSdpU+ccBcQS+OBt/Cs7x
         y89b+5ZJJgMhmz2STGcabI/FvRtYUvFWHNpmD/zcR2SqufhuydBni9/X1su/VrQtGrAk
         b7OTuHYD+HcpBAn9Spnw5HpL4R/xdmMWNwt9d2lJODm/uzGSDKGwelMLKoGNfnJaJFdh
         uUK0YFMQT5XHNFP1zbQvy4XEkjlG55+IwyQ7IT+RK70lLpUjf2WfjLaDIyz+2VhKqnrL
         f+NCnaZnrDlByG64E4opEA0vClInStUiXu6uAG1qTdYJEfxBZX0j0n2H8ZzpE1qFjdKK
         PEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doWgkAfEcmSMhRNIxRoHTjD9fSl7Q2XFQ3gDJGe0anw=;
        b=26Xh1KGFzKLxAIrq4lpfiWDJP+o3PqIOBK+tF71IpYQUPgNB16ah6IkuZUzII4GMCO
         HG0Gw9hUCy3T9DPtjXMByv2Ei7FCjNfwIDkeOd4/xKlHOGoCKI7MyWwJeI0y7NFBYKWW
         T1GvjzsMl77peq2B0gUso58u0LTIfgrwhPAAsc5g8aO3T67bJDrVVAQWJLNYVpTwwFJv
         4NZXtKzXAwTYiIpwWvVk/GL0+OxfV0UIw4bdw9oJ55SyWQcbvGyv3nXDehMJQdWo/uWn
         jFAmhPuP66WVl2xAC1gOYyYLO9MSkJ5eZEldPCgKbz9Ies1o9NbKMr7BWOR2C87PeAYV
         RLiQ==
X-Gm-Message-State: ACgBeo3pp1doeFDUQg7o7XHhzR9k3lQF0LQCteB5pKx+5eHMn1l4AR9G
        C5xkmZBDzpVORZZL2c0SdIQ=
X-Google-Smtp-Source: AA6agR6arIMVr5ZpqkmYYrIbLYSsjbSmE1QXdkDiGQWBQKuq95jBD5GPbzFKhKy2A88I/chujsCzrQ==
X-Received: by 2002:a05:651c:1581:b0:255:48d1:fdae with SMTP id h1-20020a05651c158100b0025548d1fdaemr823958ljq.286.1659629203108;
        Thu, 04 Aug 2022 09:06:43 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id h4-20020a2eb0e4000000b0025e2b567434sm169804ljl.9.2022.08.04.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:06:41 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Add entry for RC Simulator Controllers
Date:   Thu,  4 Aug 2022 18:10:41 +0200
Message-Id: <20220804161041.4147310-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804161041.4147310-1-marcus.folkesson@gmail.com>
References: <20220804161041.4147310-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for RC Simulator Controllers and add myself
as maintainers of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..216b9f021f72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16896,6 +16896,13 @@ M:	Patrick Lerda <patrick9876@free.fr>
 S:	Maintained
 F:	drivers/media/rc/ir-rcmm-decoder.c
 
+RC SIMULATOR CONTROLLERS
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/hid/rcsim.rst
+F:	drivers/hid/hid-rcsim.c
+
 RCUTORTURE TEST FRAMEWORK
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
-- 
2.37.1

