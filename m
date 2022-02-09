Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757224AEB36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiBIHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiBIHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:36:22 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E8C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:36:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so4695672ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khhrPYhhB+d5bD7jt+HViCNb3g2CeK68FLJCl0hiF1k=;
        b=N4EsKMbbTMGDAM6TclaOWAxv80Dl+AawV34nCCSLGq3svNfM/s+BD+TZFsnQ7EmX50
         END5iKLZ8BHdco3ceVAMFKFXfan5FmMLOIzuoHPF5Hj69+b87hKOSHUoOFHSI2UyDatt
         nTD3cH0FgySyLj8Qy7VtA2EmBIkQ4L6ULWz3t4P9Pp2cXzllo5bx42lOQa+SCB6RdXeF
         fkl+KuyIwfhVNmBhmGZmQmUUbwpFheMWGIsaZpNWZHBvKTFicdqSq91/78C1xZu5CPxy
         g1Qowv4049wUYm3Rub/KUYsbAOXbq5ZFRwSSy15NOIbNTklfJPJHrgZW9YhZrblvbAal
         uI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khhrPYhhB+d5bD7jt+HViCNb3g2CeK68FLJCl0hiF1k=;
        b=gyzx6q7ks53bLbBSRGGQU/hFSKgRG9Rq5e6EyMKvXKsYVJZDPKRDQJMJJzfzWX5b1m
         zABH9+8VokT7kHoDSzNKU5AhG8Wbb7+kqMAK00vUys3Qn0JGgdBmhr61iieAgrHZfJQb
         z+N2UuvW0ig4Kwgz3ihNJz8J447VNd+9kQsR02EwD/UR6QLspvp+SW4hIge6jfqPoyj5
         9vrjVAwlUmClxy/099QYrnwIilnpBu3hfRUZeKx+wus7/k8CAsmRLZ9PdpvLQMgr7NQ+
         LEwQWpi3frQuLu6/VRd1WDAdfPZJ7pgUQSxgENvNmjcxPC+LqH0iDS+9uY6No88qyB1m
         633A==
X-Gm-Message-State: AOAM530Haz9Y17hGTGNuDSdoH2ptzLRs+PuN4yCQ2qXlxH0z45X7DbFo
        AXlMc49CS/Y7MnhTqh0yfb7C8y9eYEQ=
X-Google-Smtp-Source: ABdhPJyaIZmFE2PWWixo/NCiVL4Hg1mRmzvOgO3DgGsNdxYQz5e7A3uANmoYGMj8azpPZanQCASezQ==
X-Received: by 2002:a17:907:724c:: with SMTP id ds12mr781398ejc.203.1644392185116;
        Tue, 08 Feb 2022 23:36:25 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id y27sm3731813ejd.19.2022.02.08.23.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:36:24 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: two simple cleanups
Date:   Wed,  9 Feb 2022 08:36:16 +0100
Message-Id: <20220209073618.29725-1-straube.linux@gmail.com>
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

This set removes an unused enum and unused constants from the enum
hw_variables.

Michael Straube (2):
  staging: r8188eu: remove unused enum
  staging: r8188eu: clean up enum hw_variables

 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  8 --------
 drivers/staging/r8188eu/include/hal_intf.h      | 17 -----------------
 2 files changed, 25 deletions(-)

-- 
2.35.1

