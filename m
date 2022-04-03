Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E34F072E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 06:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiDCERD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 00:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 00:17:01 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2C2FFC9;
        Sat,  2 Apr 2022 21:15:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id jo24so5074078qvb.5;
        Sat, 02 Apr 2022 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=9cCBVkUbekjSw+j5qn5A9qX8bKkHIGEnNByJ0l5fEyQ=;
        b=MOMuGDXMgpDSbmmdQ49YMEAHLF2pgCcQxxaHF0L04omNxPsz7VsjfHEmnEj8wyA+JO
         AC9vuPAQG2Y1U3BDYGWxk84vvI1zgl9JAb9IjUQzqHHghDKVtYuMFEQcJBDUnEJOIkwH
         Qu7u0BmSGHBSXH0TQf1Piq1hz0qkVSEWwGWVk81iEo27XUSHO43Os6lwZNELHoy85ZNA
         RgYSbyCbnA/g4M9aP9WCCU8QQnodiLwQYyETLF8KQJ9eyXw87aPzVq/tCNmJCmVg+QIc
         1s8eRLu65HNGVrFEj59KZXQ3dpiVVdiWLUg1k6z1ONUuqMaQu2IopaxOJHEHxthaKw5x
         71IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=9cCBVkUbekjSw+j5qn5A9qX8bKkHIGEnNByJ0l5fEyQ=;
        b=ydGUg9JDD2Ai7JS7+LuoYQI6etx0XtRBSSgCsYnF8gooWDnqe2p3mddHIrqjhNC1Ng
         HhJWAA/lTcaGdVfOuA9IwVRY2vsq+eMFhXMYc27J085UiK3ge0S5G7UTr6QdCoqdyC2f
         DmWjsgGx+3WWldyKJ2N6kTlld3PB4KJBCT/yLrFhJne31Ep5H9RFWE69sO5HKzbgNIl0
         IUeahtp0lkYFIHuE/4nAcISkIVEAhZd2KJ/bmauH/NU+0jDW3Euhf0V4XrWfyfM+djIe
         4AlIGRUSszMT7XWEpmWbdUL8dcoY2NVvXQr0+QOhjxkGi/b03tIKA3bKX+3PxREAHNT3
         0zBA==
X-Gm-Message-State: AOAM530wF+o5wYOaCWL7uqqA/wMq9ZJ3uU4ohgFxxpDdF2GHV53ckjIk
        klXxhZaMv5+Z+0f5705VvSE=
X-Google-Smtp-Source: ABdhPJzlo96IT6SMLC8LWD4BkWBOvbcpC3JC0rO1MfwaqldaFf7aBkrciFyO5UW0maPUdddyEdqdrQ==
X-Received: by 2002:a0c:f18a:0:b0:443:ce3d:542f with SMTP id m10-20020a0cf18a000000b00443ce3d542fmr2278171qvl.106.1648959307066;
        Sat, 02 Apr 2022 21:15:07 -0700 (PDT)
Received: from [192.168.200.197] ([72.49.221.197])
        by smtp.gmail.com with ESMTPSA id 188-20020a3709c5000000b0067b147584c2sm3930667qkj.102.2022.04.02.21.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 21:15:06 -0700 (PDT)
Message-ID: <bb6473ac-3a12-9667-9425-7b61746e8078@gmail.com>
Date:   Sun, 3 Apr 2022 00:15:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     yaliang.wang@windriver.com
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        geert@linux-m68k.org, huangpei@loongson.cn, kumba@gentoo.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        penberg@kernel.org, rppt@kernel.org, tsbogend@alpha.franken.de
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
Content-Language: en-US
From:   Donald Hoskins <grommish@gmail.com>
In-Reply-To: <20220310113116.2068859-1-yaliang.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This fix should backported.  Effectively, all mips64-based Cavium Octeon 
processors have been broken since the original commit; this has been a 
persistent and surreptitious issue for the OpenWrt community since 
nearly a year ago (referencing 
https://forum.openwrt.org/t/upstream-kernel-memleak-5-10-octeon-ethernet-ko/111827/), 
and nearly ended with OpenWrt marking the target as entirely unsupported 
and moving on.

We understand that there are ultimately few users of mips64, but it's 
really important that our memory management work. While OpenWrt can 
backport until upstream inclusion, I am sure there are other users and 
software platforms unaware of this fix (and unable to take advantage of 
it), thus making those platforms on this arch completely unusable.

