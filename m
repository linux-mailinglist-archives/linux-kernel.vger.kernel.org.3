Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEA472257
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhLMIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhLMIX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:23:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9166C061756
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:23:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v1so49768847edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EQDUpIoSFqwG7P7O3WH1lI7pcwpdW5NUWzFZVZ8Czs=;
        b=mR1BrMDzzSwu8PH7vAmYOWMFqLJiqtfo3njsMuNIkJ+VEqHi+FieJkN2Gj7pCg+Pd1
         s319hI5o76Wvz7gQbd7GpRvYcWoeAXLAfIfE1cvdbcgZ28hFl8g5uD3HSSzPQx2j408z
         lZJ0YwlHIf6oaWwx1b6ViefI57hpZAIwHJ8mlxDqd40jbUa7psazAVusN7xwpq364bU6
         004Cl1VIQmmwLebijE51WTcr0Sx3/3y5sYjkJPBY2xPEKU5fUJF8lVnOPqhYnJtJ6+Ah
         FldKTiCEDz1ozY2Iq2SfoKV0B06ucNz7HS8HfuzI0M0UtKVFUc6oCqczJNiSpFv3bAty
         1Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EQDUpIoSFqwG7P7O3WH1lI7pcwpdW5NUWzFZVZ8Czs=;
        b=ZPMI04EreHT2YDnINuNq0qapG9SD7iBKbZGykYyZSrl9SbOaTBpFhSNUoGFvgsUsFQ
         FR7QkrENPQpeoJmMp1AUyWllE7OB5dEKeHcs12TwNwNx3sJqYgIMkmNvvGAGvBUdpOIw
         W1NHPbTlKFwUCdXvvr9jt+SazUfRx+gt6kZuee5r4fZqpLMARLt4ZR3JKQsb/cmAuMXG
         E4eT0TJyxZt8bISzeGriGMZ1JZoYGxcM2rnHN8WzeTCGpKuwLOFtOox5VKWTAPKeh+Vx
         27o6wSWXzOhYIPlAk+GxJrI46bG4z6CVlzBCZNAn9G+qqjVlrd8vLWnwoesS+zSLjksE
         V/VA==
X-Gm-Message-State: AOAM532yCN4iXjRkmVHTo7RPLirAelC/DJkT/h+ZIfRloH35D9yaUsaP
        o7P+5vV/MCCndd8R/dEq5gCtnpXLgHe+QFoMPuc=
X-Google-Smtp-Source: ABdhPJySOAMNFVpQh/o6uYwh6kDwDwRNLz5GG6isp8dxFFlvoPji41+Ok1cCOoa2ZSvAR9f86Hhzjg==
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr61805725edb.175.1639383835356;
        Mon, 13 Dec 2021 00:23:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id nb17sm5535561ejc.7.2021.12.13.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:23:55 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/8] ADSP/CDSP/MPSS support for sm6350 and Fairphone 4
Date:   Mon, 13 Dec 2021 09:22:00 +0100
Message-Id: <20211213082208.21492-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the remoteprocs found in
sm6350/sm7225 and enables them on the Fairphone 4 smartphone.

Luca Weiss (8):
  dt-bindings: remoteproc: qcom: pas: Add SM6350 adsp, cdsp & mpss
  remoteproc: qcom: pas: Add SM6350 MPSS support
  arm64: dts: qcom: sm6350: Add MPSS nodes
  remoteproc: qcom: pas: Add SM6350 ADSP support
  arm64: dts: qcom: sm6350: Add ADSP nodes
  remoteproc: qcom: pas: Add SM6350 CDSP support
  arm64: dts: qcom: sm6350: Add CDSP nodes
  arm64: dts: qcom: sm7225-fairphone-fp4: Enable ADSP, CDSP & MPSS

 .../bindings/remoteproc/qcom,adsp.yaml        |  28 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 279 ++++++++++++++++++
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  31 ++
 drivers/remoteproc/qcom_q6v5_pas.c            |  37 +++
 4 files changed, 375 insertions(+)

-- 
2.34.1

