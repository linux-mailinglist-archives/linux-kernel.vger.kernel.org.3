Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4147E459
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbhLWOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhLWOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:10:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D001CC061401;
        Thu, 23 Dec 2021 06:10:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f5so21896862edq.6;
        Thu, 23 Dec 2021 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UjJkKz/JWKKHY4Lc0BtDfzIifxG8kvNPIELEZ6V+jDY=;
        b=NKzwnSNRYOXEwAggF5JDNwy5v8Mn81zuzcbWVzsjbz0srosH/h7yCUbFTUfmLmWdeC
         +DsN8gvOMvgVKOfXVPiakOi1CU/mA+PZBpVZRCAfBrFV+a/oF0lyzG5mOQ8r8eahej4Q
         0DatHCDcM3TODghtsFjPp2ULnRNgTmQcH7ZmzgLJGfE1fbGRi4mJhaBRtBKKKZ0q+L3M
         P12fXNAuYPEVT5lrsLUG89P5RcFy0L8pNCMC+Ntj5rFjC9HjMuL2S/E/Awb4KpuI4PMd
         U0mdBf+gZHHLuhyymQddTKZXknf9pbmC/IW5/sS0K4Bq3h2Kjxj4iT5rzIwpZi9SrDkZ
         PhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UjJkKz/JWKKHY4Lc0BtDfzIifxG8kvNPIELEZ6V+jDY=;
        b=BKwzbAIwmR/qg9ILTbB5w5pLs/AkwRi/AA4EJNCsb2vZ9WM1DzTtCE/v/QBIZhIm4+
         zXVQgTVAftlfQpxfaAv7JqALi8z959Mrz1WPQZgMOxM8SE2fdWtZ+4rdkvuKU8TS8ns0
         RlGq744wupwe7yn/78kBmU5Z5ME9XbQeTYKDna83jXS3whHbWQ8CqFijGr3HIpzPnh2B
         u6PixF2NAlZqNAgStCUJDMwwEGGapINgeX6y/IhdImIKFZN7ILOoRUc7Fm6cGS0Gc+rB
         gGZHdWTrjFwRAyF6AQdG6wohlWLegiM6LyYOMFS3f+9HoBHC6ndBQRpiQup8WR/7DRTk
         EqwA==
X-Gm-Message-State: AOAM531DPIyoPGDkkwt2SR/cCW+cK0kVbR7v62KSNDZt2iCKPakJTq3x
        teYi8CGIp5CEw36U6sFI36mGr66gyuQ=
X-Google-Smtp-Source: ABdhPJwED6pkRIcLk+EsacuGOReF+17cVzQfVNLpZvtcQGcSn16U9mhv+DWleHQztAyaEnftcWQ2iQ==
X-Received: by 2002:a17:907:7295:: with SMTP id dt21mr2023199ejc.441.1640268604463;
        Thu, 23 Dec 2021 06:10:04 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id 27sm1784451ejm.41.2021.12.23.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 06:10:04 -0800 (PST)
Date:   Thu, 23 Dec 2021 15:10:02 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add OnePlus
Message-ID: <20211223141002.GA5979@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for OnePlus (https://www.oneplus.com/)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1497303e2600..a13d6a19c2b4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -858,6 +858,8 @@ patternProperties:
     description: OLIMEX Ltd.
   "^olpc,.*":
     description: One Laptop Per Child
+  "^oneplus,.*":
+    description: OnePlus Technology (Shenzhen) Co., Ltd.
   "^onion,.*":
     description: Onion Corporation
   "^onnn,.*":
-- 
2.25.1

