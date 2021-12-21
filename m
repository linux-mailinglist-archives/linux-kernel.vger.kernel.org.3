Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9F47C684
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhLUS2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhLUS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:28:33 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C5C061574;
        Tue, 21 Dec 2021 10:28:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u20so23179pfi.12;
        Tue, 21 Dec 2021 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hm9wxEeaDEyWpSuzCto+olZxKZ0nKIQxXR9pF5LHrQU=;
        b=d0UwYVXOLQkZ6PInaya1W+N+UGBMBKrHdSzoDTZ+eW7Oglrn22iPQlLUJvkwDacHqQ
         fgi67bEi8xRmu+cp2Rd4Qv8o+ouQBhuwQsdibkn8QwYIUcnQFpuY8AaY/CyD1g0rozxH
         1CXK/iDYwCwSBRDQIHOI3FqHabsF62o4iY9kvxfte8aKoAGMXgXg/I/OW3xMw39/HqMS
         ahRskCo13Kvth/ytQuMJpG8YZKIZ6paXoO7l37eVVQNAnIjVSdHT0MkDLNK17NHrheJP
         8jOOJnR8k+NAgD0CyB5q3qgf8PXHrCV/l9NdCojjXFDl6p2jJqcgnzYxpQxmu3b/+MSp
         uJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hm9wxEeaDEyWpSuzCto+olZxKZ0nKIQxXR9pF5LHrQU=;
        b=VE/7uiXyRJCOW+IBu31rkTodk+xzov4mstZGEOshSRoyhy9PM1ihjfmXvO0un6Nwsb
         W6wj2gJYrEUA84RXro32Um0z3sqVreblbZAuupGkatyp3gFBobWQ7G1/ziatj1dU/QJE
         wxf8fb0ZtD5O8wbaXrU/QcgcwubfFsJUfYT5YrrjVqxImUyWOPNSrXfN3SfRIZ1L3HcP
         GEBz+BaCMhf7zUGo7IwyzTXf9FcQmHYOp/5MYo6TG89dFNsXe4Au2GdukO9S7Hn4bwfs
         Mqirn13aUyJtUUoBp4ai78/pKH88G1lA+8rxJnHLLWJ/1GiHmElVVY8IhUw7kJp4oV1n
         Mymg==
X-Gm-Message-State: AOAM533eERidnKtGocTMuwE1jK7CI7Q9EL6aGkig6G00v+fxqGd13QYE
        6axGZUk7V6aTW8Fg55ERKfo=
X-Google-Smtp-Source: ABdhPJyO4P1OJY0lyc6KMrylx/Mv0PwcAGcPgUBbYYK5GYbBB2VrXBY0AHC+Yhwy6c8HIiT5rCS+/w==
X-Received: by 2002:aa7:9298:0:b0:4ba:7d3a:1742 with SMTP id j24-20020aa79298000000b004ba7d3a1742mr4519732pfa.62.1640111313077;
        Tue, 21 Dec 2021 10:28:33 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:36:b871:81c1:f2ef:8174])
        by smtp.gmail.com with ESMTPSA id s19sm23436133pfu.137.2021.12.21.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:28:32 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        bjorn.andersson@linaro.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH RESEND v4 0/4] platform: surface: Introduce Surface XBL Driver
Date:   Tue, 21 Dec 2021 10:28:22 -0800
Message-Id: <20211221182826.2141789-1-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce the Surface Extensible Boot Loader driver for the Surface Duo.
Exposes information about the driver to user space via sysfs for
consumption in manufacturing mode.

Resend due to not showing in mailing list.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v4:

 - Small binding definition changes
 - Removed ACPI propagation from patch series since it has been
   cherry-picked
 - Fixed the Signed-off-by: and From: mismatch

---

Changes in v3:
 - For the yaml documentation:
    * Updated description
    * Fixed examples
    * Updated 'required' field
 - Further propogated ACPI dependency in Kconfigs
 - Updated sysfs several binding descriptions
 - Renamed files to conform to naming conventions

---

Changes in v2:
 - Per Maximilian, added patch 2: propagated ACPI dependency from the
   directory as a whole to each individual driver
 - For the yaml documentation:
    * Removed json-schema dependence
    * Elaborated on description of driver
    * Updated example
 - Changed target KernelVersion in sysfs documentation
 - Updated MAINTAINER changes to be properly applied across patches
 - For the driver itself,
    * Added types.h inclusion and removed unused inclusions
    * Minor updates to code and acronym style
    * Remove __packed attribute on driver struct
    * Use .dev_groups for sysfs
 - Added more in-depth description of driver in Kconfig
 - Modified dts to reference a newly added section in sm8150.dtsi

---

Jarrett Schultz (4):
  dt-bindings: platform: microsoft: Document surface xbl
  platform: surface: Add surface xbl
  arm64: dts: qcom: sm8150: Add imem section
  arm64: dts: qcom: surface-duo: Add surface xbl

 .../ABI/testing/sysfs-platform-surface-xbl    |  79 ++++++++
 .../platform/microsoft/surface-xbl.yaml       |  64 ++++++
 MAINTAINERS                                   |   9 +
 .../dts/qcom/sm8150-microsoft-surface-duo.dts |  10 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   8 +
 drivers/platform/surface/Kconfig              |  12 ++
 drivers/platform/surface/Makefile             |   1 +
 drivers/platform/surface/surface_xbl.c        | 186 ++++++++++++++++++
 8 files changed, 369 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-surface-xbl
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
 create mode 100644 drivers/platform/surface/surface_xbl.c

-- 
2.25.1

