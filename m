Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74B648D5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiAMKay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiAMKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:30:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F1C06173F;
        Thu, 13 Jan 2022 02:30:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i5so21316223edf.9;
        Thu, 13 Jan 2022 02:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=l+Q6v17oKYII+/DB9uT6D361AJit8HMlN7QFJ8BRyDk=;
        b=CSPRZhYVyAT1NHJU+RN0PehLl02opZWxtKcNtFqLu+zqFKe7dnUQIwk1Yl/ixisn8V
         KRkeiBjLQnDpMAupIue4xbrrK2Xcxf5W4TOSc3iW3kn0kzvzVF5COFICGjNfwNaM/JzU
         DbQWEPrtyJd5gVhO/qPXzjrzdpJXtYW7DAKpiwV7dJK/FCBYts+Jhy1BE6y/SImKD0eY
         mslCsvLqkVbF57mD4JreXOeAdvddyf5qw5lpa3EVKfTf3+q8SDjISU53z2aVO6p4a+WM
         sMkJYVoVOjjtHHK1Bdxafd71cXXk0TTXl5jpJ1HDmDSPB/NvgLbMBszsLz3PTyynwxWL
         m6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=l+Q6v17oKYII+/DB9uT6D361AJit8HMlN7QFJ8BRyDk=;
        b=p9IcGKVqyxdOF3IZtHRw18CvEnaeTvkxl9Yl0hft5TWu7Q8pEgXMQza04O4JEVtOB5
         AJnCrc++UQ6cjRH2/Z6dNQTzFQMeEaSaXCY19o65bJLHiMLYxX33xvvNotvFK2u3MNIg
         rTe0JRVZX5J6gaT5J9n/pyLXEcDvgbHn1fZtgkxo/kgTILo8ZY/7qgwwF8EwZvZ5Gsae
         QviTg/O9u3tZb/9dAs9gkVvI5tb6X+tIARpW08j+Nx7N5O1GJ5pkUpyWti/XbuBv7IF5
         Ih+RaYUZxA1/IMFzz0UWsjQ3MKt/yRtTy+H/JG+cSyQ5ANcDXBjGqGEQZriDKeiYDAWb
         is9g==
X-Gm-Message-State: AOAM531KQXmMJI21cZnpzkBo2Q0DWC3UTGhd/99Niyg1P9DUvITRzv3s
        N9S69D/Ry40iad9G2Uwmp+JTfjLkty0=
X-Google-Smtp-Source: ABdhPJwlSrTxMQXhmreotbrJgcaYpSUqSJiSv4iqUGxw+ZS5g7DKbRYrbed6S9D6C3+VVryUeXWx5A==
X-Received: by 2002:a17:907:7e82:: with SMTP id qb2mr3191740ejc.291.1642069838898;
        Thu, 13 Jan 2022 02:30:38 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id kw22sm730594ejc.132.2022.01.13.02.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:30:38 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:30:36 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: vendor-prefixes: add Thundercomm
Message-ID: <20220113103036.GA4456@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix for Thundercomm [1] is used in device tree [2], but
was not documented so far. Add it to the schema to document it.

[1] https://www.thundercomm.com/
[2] arch/arm64/boot/dts/qcom/sdm845-db845c.dts

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in v2:
  - Reworked patch description
  - Rebase on next-20220113

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b3de81e8290f..81815b8fb0a5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1211,6 +1211,8 @@ patternProperties:
     description: THine Electronics, Inc.
   "^thingyjp,.*":
     description: thingy.jp
+  "^thundercomm,.*":
+    description: Thundercomm Technology Co., Ltd.
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
-- 
2.25.1

