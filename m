Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CAC53F82B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiFGI3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiFGI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:29:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439176A05C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:29:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p10so23039186wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:to:cc:from:subject
         :content-transfer-encoding;
        bh=mNqIfLl/p0QL5F3iAfVfaPdbC6XlfUmt6PRTT6WK24s=;
        b=FRLrwpLgjfUpPpEUy4tjf1bG7KT4OazdfHAguYBMGv/ozHcOWH/F63f+ZmGj9+3cTV
         Vr9BJdSIYRfQAHSJy6RZ/cVUgbdyXEmHRIT3z3UJjjGsz+xwndYRkqYiIYqUqQCCu1sp
         2jSc17xHxaOIeuf4pkn+DkSYX/+gPZwo5GwlNi27XguS2f2m77zxeZlHZVE9NcjroBrY
         5/fC0fYDAMQh8EdIab+ytn0Cf6tMhV2zo3S8UuPEAinIzZXS8RALl0TBEya34dzvErvI
         33S6UJDTxrz2QXf/9KtBbIWcouHhJ3x6w8YxebBkp3Y9u0e4ET5brm0qzPPgNOxoNSVo
         iCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :from:subject:content-transfer-encoding;
        bh=mNqIfLl/p0QL5F3iAfVfaPdbC6XlfUmt6PRTT6WK24s=;
        b=gZPjXVgcKHDoKVmwxqRFhtkyBa6qLAcQB51jowMUAhkV2KwPxCVzITH7XrzsM49Rp4
         nmjBz1T1w5vpj1E28dJV/qQGjRlHFGt42Sy2C07mcxwcLzLBVaVisTHMqNrK1t1Mzjny
         mExd/lM3piGMfIbFOhUwSiy2fnh42BICFGtZIiUQSaTUoCX6drBxk7nc6YM2/vNUuv3O
         d+7e9D3/u9Hm0ElMN46yCPddeb/56XSVRD/TSHXn5ond/9dBP84aBcsBOCzcag2cYYak
         kekYkEnYPDTehWHYpYI119oXI10kiQWuOvPeNUiDWJWXID2/DlbZqnS1brb8qWs28XcF
         YGeQ==
X-Gm-Message-State: AOAM533BJWGkOY0AY7f1Cmke1hpCBsZ+Uf3Z/CHeXHgk+Sr3miEETN3x
        bO6zffIe+sJQIEB/4np64i//CQ==
X-Google-Smtp-Source: ABdhPJx7o4Wk5jFgXz1+TL0Ff84JiR3S340A49e8hWu0taVSOBRrBuEl9OjVn4o1Ct6eN4QO4u+gJw==
X-Received: by 2002:adf:b358:0:b0:216:508c:e0bf with SMTP id k24-20020adfb358000000b00216508ce0bfmr15311946wrd.204.1654590549737;
        Tue, 07 Jun 2022 01:29:09 -0700 (PDT)
Received: from ?IPV6:2a00:1098:3142:14:901f:dbcb:c1e4:e4b8? ([2a00:1098:3142:14:901f:dbcb:c1e4:e4b8])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b002103cfd2fbasm18308660wrm.65.2022.06.07.01.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 01:29:09 -0700 (PDT)
Message-ID: <8cc7ebe4-442b-a24b-9bb0-fce6e0425ee6@raspberrypi.com>
Date:   Tue, 7 Jun 2022 09:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org
From:   Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v2] ARM: initialize jump labels before setup_machine_fdt()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is fatal for me in the downstream Raspberry Pi kernel - it locks up 
on boot even before the earlycon output is available. Hacking jump_label_init to 
skip the jump_entry for "crng_is_ready" allows it to boot, but is likely to have 
consequences further down the line.

The stable branch may not be living up to its name, but I don't think this is a 
quick fix.

Phil
