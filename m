Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F795757B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiGNWgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNWgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:36:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057896D9EB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:36:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v16so4383726wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=Ij4qEcpFkjUUIYVFa3FgxlD2srrtnL+Z6YFdTTS/0SA=;
        b=j70CmUNRjfK1hNesxGTMnv1pSlIQ984VfuRCaK9TXAnvCQn92uSTm1OWvzwBxRWOpL
         iB063B3AFyPFlWcJJtBQY9oSwTXj+l2e+CgrqXuftsJbOVbJtES+Ac085I+eDIjYQkOA
         swvHyqnkNZiJiJh8XQit0W90z75clAUPgIuqZ/1AuIbLJbMHHgcMDgXPtyyBEqlzC2F4
         99s96wb527Keh3PTb+iXKIv7ytrpWANJ0eY+PzVnMeKXixiEHp2YMSd6eQtFiFDPDqPq
         1q117D0/E9ibdAJarx9itDuUiR3JbGlDuRgEiwmVl0nflJCxxYbGD5SL2lusZ+GBDs0Z
         PJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=Ij4qEcpFkjUUIYVFa3FgxlD2srrtnL+Z6YFdTTS/0SA=;
        b=nPdykUu8hwGf5efvVag0IGgO2mtCqFXFPkAXrqgnDt/2RDmLe0Hqni8iRX84pLYKfK
         1rbdZDbArpOOEfuk5yqk6os9GbdppxLmRDAWnEIfxu8NfDDAO3GtiBLRwG1MgxcQNecN
         ofWiJ7pbF6TFRWP5R8iC8IiDiPKhC3EfHDxIDh5fRPYkAd3SjVdy9I6RBjjSzAi8B2FF
         WG7NE7o1/YEuBH6eUAqRjS534lTzfHolHxJExLRlaQWTqzm88omHAisrVeLGzvbFZ+iG
         GLeOlLYLRpu/W29rbdnfARH89cFuw57zbnOMKvPFv3LGKt8uPxxO7VzcO0fGb4pdh/Pv
         5VoQ==
X-Gm-Message-State: AJIora+mTH+FSO4zXtFjo3l48+5bnaczbO3z/CoftVfNqxaLlLAmjTC+
        r+4EivNv66gVRuoZWf+KbesjHPuPZbc=
X-Google-Smtp-Source: AGRyM1sHc5H422l3Zx+jZbtE6e0zK2wfhTfHsehRwUhIfhmA0dK/fYK9wKPAKSKAXZyGGt/ofPNAGQ==
X-Received: by 2002:adf:fcc8:0:b0:21d:68dc:814 with SMTP id f8-20020adffcc8000000b0021d68dc0814mr10106076wrs.102.1657838160636;
        Thu, 14 Jul 2022 15:36:00 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd? ([2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003a300452f7esm3582665wms.28.2022.07.14.15.36.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 15:36:00 -0700 (PDT)
Message-ID: <2988f01e-6663-5dba-ce76-cbc655a66b91@gmail.com>
Date:   Thu, 14 Jul 2022 23:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>
Subject: search_binary_Handler
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hey,

why is search_binary_handler cycles through binary formats?! if there is 
only 3, why don't just return the pointers to then?

also, why does binfmt_misc ,exists?! couldnt we just use 
execve("interpreter","args)) , after reading some first bytes?

since ELF  does read first bytes, can't we just use a ELF subset?!


thanks in advance


i wish to get cc of answers to this email


andre albergaria

