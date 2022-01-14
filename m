Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EAF48E935
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiANLdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiANLdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:33:42 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072EDC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:33:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f8so2537824pgf.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CBlaERLpJj7dIk48HIUvM5e4ik/vy9mtJGQxiVH6MVw=;
        b=BSrwxDk56IjZQ1HzQYDCjg+yVbndyHXEWkJSmoFeu5FqLhlqQdkzSsnKo3VlcQLOab
         bLzDnnI2YGXQOATTAUp8CEwqbVXUdTw8AjJg6Wv9qZmcV3sNUqdqbM3D4hn8i8/1Ue16
         L8iYWkephKOAHmMaNmp1G9ntSxrvsoSPMRhBCAfBJsI6YzaLNFlNNNPx/BbGC8LGSh47
         5ugLFU0Ph9orz+kn3DlTQAT59GUMB9fNpGMCFg8psOHpC9lduggMNheFOAQiKeEI/JLz
         FQS3Sae/AV+tzccWOu7ClR2sG7eza3PynoqGB7OVzTaj+ObVf79RI9qylOqfeQkXLwtn
         4wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CBlaERLpJj7dIk48HIUvM5e4ik/vy9mtJGQxiVH6MVw=;
        b=5IGIKD1B+xtMT8+bpXB9N3QH36iElrzsHz5/hOKd1uWoqNQrJWuA0cFtHLpNiabXDs
         QlV8jcvceJM47Qbsrb0sIUoIpMyPu6vsephkpc++8l5Ath5gSbcabSH/eApRbOiAiBFK
         1wMY/D4ilMdFpOhWE9tT2/zEHLW3RrDIyPzdREV68LvD3T5FYTIzv+GSkE6aKK6rJFFQ
         jdgM/RNzqD+Fu/4vpWE1Vqw5H8d5L8LtDqSo6MmbIptC4encSsAXjZUAymb8g0K4/E5U
         qQLg3lKMCLdr0t21Wff9dNcDJRHWVPTgKnk0dqziIBUpZ3dEBwf0z4GViV9K1UE33It6
         qOMQ==
X-Gm-Message-State: AOAM531E0PVEX7RzLPFv1Cio0m1k6nXzUN7EbseZQfMlMcUsqsTPVZSA
        2E1fPExDY8BukMtckkvDwwNaug==
X-Google-Smtp-Source: ABdhPJxDPUxgFGjgGhFhA1Juf5QMziYDXPu7RzE3gPmc2KLZ29AcI5RXIkK3Joo+0xBv50TfG8Cc6g==
X-Received: by 2002:a63:a745:: with SMTP id w5mr7688435pgo.374.1642160021469;
        Fri, 14 Jan 2022 03:33:41 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id m17sm5701429pfk.59.2022.01.14.03.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 03:33:40 -0800 (PST)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     phoenixshen@chromium.org
Subject: Re Re: [PATCH v2] HID: google: modify HID device groups of eel
Date:   Fri, 14 Jan 2022 19:33:36 +0800
Message-Id: <20220114113336.21182-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> Color me confused, but anything with HID_GROUP_VIVALDI should be matched 
> by hid-vivaldi driver, so what is this about?

yes, HID_GROUP_VIVALDI will be matched by hid-vivaldi driver. 

CONFIG_HID_VIVALDI will be set to y when it is used.  

thanks.
