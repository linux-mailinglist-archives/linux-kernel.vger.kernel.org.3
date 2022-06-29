Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D4560A03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiF2TJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiF2TJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:09:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397A62EA23;
        Wed, 29 Jun 2022 12:09:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so408929pjs.1;
        Wed, 29 Jun 2022 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z4J49g6Qwe75HF5FCqDmxDBqFfmEZoT5Wq6FJaYzqQs=;
        b=JYtUkdepOGn3VtwItgwBEjAPywq6lVd/SRNKCmcMspDXc1S6AyoKGjItvLcijSb5r9
         cdOP0WBL9pDBkg/uY/w48SDjMiWcSQdY6t70xADMlNsQZtIYGJuiRz1RkjVDJIMtaCw6
         5Jcugm2CERmimhJMjWZZjlbku1QOe0Wh9MNVvqGfVk4IwsfR2LSj68oIxskFYkekur9o
         r9z2QVLcYOGDwwdWoxWHnDwYMYKb/F0+dbdcnMM/bOBMy58GjKkpliS5nzhfcbbDyzhV
         zrb7LcyeH2aAjX2jpxeE/zN0RXUZ3SFVRqbb2F6FgeZAmVYk5ZoVF9P63dBlE0maN5gG
         FfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z4J49g6Qwe75HF5FCqDmxDBqFfmEZoT5Wq6FJaYzqQs=;
        b=JahyyJDsoY6YIZJ0nhzdByTNhg6CxKg11/419/2+o2GBSxkiklqWVWFyblCiFea/UC
         Se0InzdZwsjvFI5pLOr47z+KnUUoKb1quOIR0elxVGIgIKxHkU4kAS1+c8LLjqQN2yJ8
         mZfmPENIq6oyB892ar0B3ov0egLvMezBiYLo/XKZGbamY0weEmWDtNHAbzQFE3VnegBc
         mA7sBJWc47X9opEmxsMnhicmhHh2hbHzCbz37dPQmp7sCaxkS2WzVYZQ+vahphqz9tT4
         1u7kbRUbfLA2nTL1xUYwuxobJVqEzAzvE9XekpnpQIhrBPxlM0pS28gSuhBYkibx5TY0
         +gNw==
X-Gm-Message-State: AJIora89GRmCenIsPJnqz4KqRbpjRxkY2EOKQ55eNA/RGrfm65sBLEjR
        2KdwYyZvhiqqM+ioJavGMKg=
X-Google-Smtp-Source: AGRyM1vGZ2i9T3ALN/xBmKpw6NKO6KA8F7/pcXgMwYsocQe8uuRl4FxsbgouBwHWGwhw+bSF4ts9Cg==
X-Received: by 2002:a17:90b:1b4d:b0:1ec:c42a:7eb5 with SMTP id nv13-20020a17090b1b4d00b001ecc42a7eb5mr5433489pjb.122.1656529775675;
        Wed, 29 Jun 2022 12:09:35 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm11287867pll.103.2022.06.29.12.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:09:35 -0700 (PDT)
Message-ID: <88fced25-084f-5a29-8c49-50244e31b98a@gmail.com>
Date:   Thu, 30 Jun 2022 04:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: extcon-next: patch "extcon: max77843: Replace irqchip mask_invert
 with unmask_base" should be reverted
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        cw00.choi@samsung.com
Cc:     myungjoo.ham@samsung.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3AvtDmBqK77YBE1XGCycEcGxreGWRJSQ@localhost>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <3AvtDmBqK77YBE1XGCycEcGxreGWRJSQ@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 29. 22:09, Aidan MacDonald wrote:
> 
> Hi Chanwoo,
> 
> I just noticed that one of my patches wound up in extcon-next as
> commit a7d674db4612 ("extcon: max77843: Replace irqchip mask_invert
> with unmask_base").
> 
> That patch has been applied too early and should be reverted/dropped,
> as it depends on changes made in my regmap-irq refactoring series[1].
> My commit message was overly broad and didn't communicate that fact,
> however. Unmask registers are in fact broken right now so the patch
> doesn't work as advertised and will break the driver.
> 
> For avoidance of doubt my other two extcon patches you took,
> 
>     extcon: sm5502: Drop useless mask_invert flag on irqchip
>     extcon: rt8973a: Drop useless mask_invert flag on irqchip
> 
> are safe to take early and do not need to be reverted.
> 
> [1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
> 
> Best regards,
> Aidan

Hi Aidan,

Thanks for the report. I'll drop the patch
as you mentioned[1]

[1] "extcon: max77843: Replace irqchip mask_invert with unmask_base".

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
