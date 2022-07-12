Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F705723AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiGLSuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiGLSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:49:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB30D9161
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:44:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o15so8710427pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JXdkmYna/AgnM3boSu6jMUHNj8pzeXCQg/r8djXWKX4=;
        b=ntX7+MpL9HElLcipfRzkkb6NbNvRulKb14juq6yQluHcj8C7ZaH7e2MWsJ/Q47INN/
         UawM7xVm+wy3g+ruE255DO9QQhFUZP9N8VCevxQO00AOWzXEpjXd+gUmt0himoDCV5Fb
         AyNpNftoVMP0xkesVLyoNneKHPa+eIQT7xMAmWLNbkBiXCaw5o92ahIqkFqBWCvw13A+
         i8IF31irxzvOpx9mgbrWkoWW5si5OYc/rW4Fhrmi5uaowMRowIUF2GmLeDLi5vlfH+oF
         Cw0TtwBc+v0e1wWDVIJvmLvndbphWuglTXbeM+QfB7FIqAJa7bmNE/+Hj5wGyxfl6z7r
         nfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JXdkmYna/AgnM3boSu6jMUHNj8pzeXCQg/r8djXWKX4=;
        b=sVMjh5r2xDYEmTmv7aPWhLd8gjH1U+trouUz9oSyYPbSR7g5Rdzi7ZA6FnrWafSDmo
         4JqT0g3rpzWZufaZIYz5CltkblXI1HeyFfq9VDn+aMGgipbSRRtdqWDAl+obKmv6wNJ1
         gLYjXYJFhmAx6GgwRLT44BABWHxxqZ/sdZTyg7A0D88cOfLWNosTotDrSBggtVFjyPdu
         yXGWOK84i1YHPFnQN+KPQw3U8qH73iM+n4YhqaLthv4pPEadow0RslAVpfWQNqUid8oq
         LZ8Hf8HAlYMaP1ecpi4lSuBhmz5JyTwEVqfX1RMgMLlXwRRKdQ0ZDkUTorzSzieriuKh
         ypEQ==
X-Gm-Message-State: AJIora9tzWtBhXhrP5cVtfI3v/S5nt8hX764GaEW+1mAuXefFhxnc67K
        WEhzZaoSZ2sLhw9Rvps1ZzA64yx7/Xg=
X-Google-Smtp-Source: AGRyM1u+CzrT26nvZv/AqubnYezvSnbsK8gypMISmWi95HQvCcm0uWMAJlAQiAtpX6LhH8QRMqs2fQ==
X-Received: by 2002:a17:90b:3744:b0:1ef:966d:1ff1 with SMTP id ne4-20020a17090b374400b001ef966d1ff1mr5919476pjb.210.1657651444604;
        Tue, 12 Jul 2022 11:44:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mi9-20020a17090b4b4900b001ec84b0f199sm3682665pjb.1.2022.07.12.11.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 11:44:04 -0700 (PDT)
Message-ID: <12bad174-561f-87d4-ba3f-273ef2744843@gmail.com>
Date:   Tue, 12 Jul 2022 11:44:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: brcmnand: update STB BRCMNAND driver
 maintainer
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, anand.gore@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20220712181811.3745-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220712181811.3745-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 11:18, William Zhang wrote:
> As the BCMBCA chip uses the same nand controller as STB chip and I
> have been working on this driver internally in Broadcom, I'd like
> to join the maintainer group of this driver and expect to contribute
> changes to support BCMBCA chips, general driver changes and review
> incoming patches as well.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

While at it, we could probably rename the entry to: BROADCOM NAND FLASH 
DRIVER since this controller is pretty much ubiquitous in all of what 
Broadcom did produce that runs Linux, that is, it was not STB specific 
very long.

Thanks for stepping in!
-- 
Florian
