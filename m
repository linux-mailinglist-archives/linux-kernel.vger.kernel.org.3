Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116C45A6885
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiH3QiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3QiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:38:03 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED6AC12FF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1661877477; bh=3tCvRvddQpP82lIcaHbRu8fAaq17w4nPzNxY0aFUxZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E2sgRNYW70PndjaaibTGBxyugpL+RC0LcAJRlOEvREvBMFcAHf/8fYYgLOT1a5UPl
         Nw+B5HtEq5axBTLVO3Z+XWQKRohnXVLqDjiENKvI6+GrRuqzy42ag5k04lQmAf+eRA
         jMIzUT7uXg5zWf2QUbdQM7yqJHIYc07tLOlVW37I=
Received: from [192.168.9.172] (unknown [101.88.26.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id C40D160087;
        Wed, 31 Aug 2022 00:37:57 +0800 (CST)
Message-ID: <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
Date:   Wed, 31 Aug 2022 00:37:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101
 Thunderbird/106.0a1
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation
 types
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
References: <20220830104806.128365-1-xry111@xry111.site>
 <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 21:05, Huacai Chen wrote:
> Hi, Ruoyao,
>
> Thank you for your contribution, this whole series will be queued for
> 6.1. Though lkp reported some warnings, I will fix them myself.

And of course add my Tested-by:

Tested-by: WANG Xuerui <git@xen0n.name>

(I've run the v6 actually, but there is not substantial change from v6 
to v7 so the status should stay good.)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

