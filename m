Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA949540F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbiATSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiATSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:19:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5DBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:19:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id f13so5882350plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7I5OODOa5piQNsKmLmbhAnVs29y4MT3sx3I0fLDPy2w=;
        b=qAcObxObCDq1N919u4ec4prmW472518LnFhDPyYfYOqdct9Jvu/bgC6p9ASucwA6xR
         pKbhJ/cMqkrdIq00r96VE6qFmsYm0U+x8Day96Wq46xWEjKT+JNUnI8Sjs2q5BP/uagl
         E5iz5A8s/Szvs6xgy7BC6WS1V27HLVpTVkPrroIj8sDaxnU+18uGbeO1GN9HbCl2pW3T
         DYPaN/7V+BL0N6A1sAE8gWk1WzxljeeKtMn1Wd7FZ1IgonzdiBLmHtqz6TWl4nMgnCOG
         5cp5Ns4zrtkIPeVZ1ceUH9FchijSaTAlpNlLm9DlhQoF5cSxjr7sbHlz5YNaZwY/z8KO
         Dw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7I5OODOa5piQNsKmLmbhAnVs29y4MT3sx3I0fLDPy2w=;
        b=Sh5utQMwMFeTat7HEf2iFpyFbuoNgxnQCIcdcvlE87Su1K/0DZX/zt4DW/TYfeLZBP
         p3XHMyZ/xhVMJZ15rte1aAPMTFkJoKo03Ex0CR1JeeSCVhFQM01sq7I47i2zBmWCQY7x
         tEZpf5OJNYu15E1WZwMIJodSe2w0DEV++lF4G6/2w5GHvRLhFUhwPRnT+79ZKAg2O6+n
         Oi2FsTW5blZ7Lf+oXntAr+6FGuXNE0Dk5VjY6a+vnkWJVPxl7WKxIYoQBi0ZnhGC4WvO
         5Nw05HlmZEe+4AxSYxU4KyG+4yai6L4YPWHwtCM6cihHMLV5P8UxoWA6dX2l9Uxmf4mb
         JPeg==
X-Gm-Message-State: AOAM531L3gzuVCdYd+kgiBbp9273XMJ0Ug/KVJ2Ao3R+WvVGL3TYuyqT
        spOV54x/vk3tDKRmPePLcClv3g==
X-Google-Smtp-Source: ABdhPJwb05nkzkp2TpQCijXSNYaPtKpZw3Qs733bSdJ9zS0nGG4S4+IbLGn7RLmphX1r0U7O10Ihuw==
X-Received: by 2002:a17:902:f54a:b0:14a:97ad:b877 with SMTP id h10-20020a170902f54a00b0014a97adb877mr203886plf.152.1642702792943;
        Thu, 20 Jan 2022 10:19:52 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id t31sm4200143pfg.92.2022.01.20.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:19:52 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:19:52 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 10:19:24 PST (-0800)
Subject:     Re: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT source
In-Reply-To: <DM6PR04MB70816AD80E3D9BD56A59FEFFE74D9@DM6PR04MB7081.namprd04.prod.outlook.com>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        heinrich.schuchardt@canonical.com,
        Atish Patra <atishp@rivosinc.com>, bin.meng@windriver.com,
        sagar.kadam@sifive.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Damien.LeMoal@wdc.com
Message-ID: <mhng-f042ecd2-dc39-4212-a2c6-3ea842c20e3c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 18:14:00 PST (-0800), Damien.LeMoal@wdc.com wrote:

I just see an empty message here.  Not sure if it's something wrong with 
my mail client, it's always a bit confused by yours -- it's usually not 
this confused, but it is generally a broken mess so I wouldn't be 
surprised by anything ;)
