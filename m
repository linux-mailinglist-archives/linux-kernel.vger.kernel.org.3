Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D078652B978
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiERMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiERMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:10:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C090AEE04
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:10:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so3276316lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=0g7yfMu4xCSIVHCVIGNCQOlaN6kewY2P9A0tD20ICLA=;
        b=ds3eUN+dNaVVValwr99xS/sS1bYFOO+X4hToNb0ioC4zrERQFjJFWvzqNOvGACCwwU
         uIT4di61+d4UyW7nsqeKhBVxCPqhxgdUCY3cHTkWxf4Hw8h7xMFtZU12MWRUB5S2ALzk
         UkTDaFfE1QnbX3j90KvljUFzhMezFIL+ES4P6OBpF/r3bnquJixamrvKYHge4Z1vRGVH
         VhFk4MHAiXrqUI0CfXyLQMWCwzFExa0rAI53wM7gKcw4NZbKXeD2/9pEuHtcru+f8+m0
         j5rzIfStoXY8w3/Gw/cJz9ZKXOP3PyEnxpOGEg28+mSz9Cxf4jQ6iPjx7qDKDY/cOTwb
         9YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=0g7yfMu4xCSIVHCVIGNCQOlaN6kewY2P9A0tD20ICLA=;
        b=jTCr0ZJjO5vpkmQ5u2QfKIbD4ggY8oV1MQxXrJv5PmTVxhqV6cuzH5gsa4n5+Mv61m
         A8SrDWChnNr195u5x+iRiwNocFzQnOUgH7xClFtT2v7FuD0dwp4IymGjvnBnkRzBe4kM
         WOLgaBYvzA6gTXeeDT14sGMdwr/r8lNUbzerU3ct8fcozYyAi8i2EKcvozj2AMf5Z9nq
         cfMF0Zv5kOubp5mzzex8qjGjQILtXALhE8eZkG1I4yWi6rISyTXuLeqKVaLguxo+5R1D
         5hS5MlqTUM4xchRgh95Z6F0RytBYaGDwiZJA/yD858ZC9Z/agPApcouYPTEliUFtG8b/
         9gTw==
X-Gm-Message-State: AOAM533EdZu1iVveRxubc0MmU7kA00xswzTUBYCCJBKmulM+J7nxsoGh
        0VApZ0FCidHtHL89tj5DYN4UQVWZu70hyQ==
X-Google-Smtp-Source: ABdhPJx1Etk3lrBUM3tTNom3YZzjRejYzCiGQdWf/gzByf6kPJDz0GFgzb7sxUyQc/Mt+HdA9ZwMuw==
X-Received: by 2002:ac2:50d6:0:b0:477:a6d0:be6e with SMTP id h22-20020ac250d6000000b00477a6d0be6emr5401964lfm.197.1652875837833;
        Wed, 18 May 2022 05:10:37 -0700 (PDT)
Received: from [10.0.0.2] (89-69-162-27.dynamic.chello.pl. [89.69.162.27])
        by smtp.gmail.com with ESMTPSA id s5-20020a2e83c5000000b0024f3d1daf04sm187245ljh.140.2022.05.18.05.10.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:10:37 -0700 (PDT)
Message-ID: <54db8933-f2f3-d31a-c71f-860285e25abf@gmail.com>
Date:   Wed, 18 May 2022 14:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Micha=c5=82_Dec?= <moog621@gmail.com>
Subject: Alternatives after removal of ReiserFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does the Linux kernel actually offer any alternatives to users whose use 
cases are satisfied by ReiserFS? These users will probably be stuck with 
a much older kernel once ReiserFS is completely removed. I'm one of 
those users and I use ReiserFS to keep around large quantities of small 
files and quite ironically these are copies of the Linux kernel. I keep 
around 2, maybe 3 separate kernel trees to make sure the kernels I have 
on my devices can be rebuilt at any time.

Best regards,

Michał Dec

