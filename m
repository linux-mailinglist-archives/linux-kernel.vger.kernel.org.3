Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687E4F475F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351291AbiDEVKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573316AbiDESxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:53:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3AB1AA2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:51:44 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-df22f50e0cso374710fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5LQhptvFdbZ0C3sjhDpLAbcs/GIdoE2HKrU0D1husVM=;
        b=SBAWX77d+jdUm+o+vqnl+olI+0dd442QoBAJ8p4Yy5WxGYltH0vPA+D7F3oUMH6z9C
         LcrfY5mR+FU0amxawwfOHcaz5MhQNV1SFInR7+ewsuX5B1R03RZwUJdM1DN42Qt+Qb3j
         1hh8IYk1Ng97+7Kgee10OuNEK5If0o+wlozzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5LQhptvFdbZ0C3sjhDpLAbcs/GIdoE2HKrU0D1husVM=;
        b=A5CI/dm1fSr9SSN1hXgBEvGaqKNz/v0thi4sSsjfWRoIbrXaMGITAT2eL1UxowtRtS
         NkwkhwY/eAQYchhg5WER91VBlF6BEC420e2H+DTpokuUrfpiWDumE/o0icyigru2ZZQo
         EzlH6JpgWdvO+u8kcVzAzllLU8kppKX8umhNmjI4g7P8uHO9JTW3S24QCFTCnJYsjvz5
         d9zofvy/05qnfk+SB9FDZti3sOQ7I1RMkyb4KJQRXrnsRKjOPZwa8daORJ2JXTY59tmS
         3mTUoxh9YDVsf8XnkWx3MPocKDEfaRlOZ2ufSQP4Lu5JjJSZ6r3PERlatAWymY0F9j1m
         JKzA==
X-Gm-Message-State: AOAM532akydxP5EvU615RnTHpm+yCFeiimGqzOglQJ5+0y4J5SpCTbwU
        /85UiZit4zAh5uutwHxmrNhadeiMJNMJLA==
X-Google-Smtp-Source: ABdhPJwi+u7HNJhVQTGZDxxKz5cHq6mQW2Zkj43J2nGB1hYNnpqiKg0YO6qpo1B7p+loLoDAaaM4RQ==
X-Received: by 2002:a05:6870:c20b:b0:dd:9f25:b736 with SMTP id z11-20020a056870c20b00b000dd9f25b736mr2236137oae.201.1649184703898;
        Tue, 05 Apr 2022 11:51:43 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 190-20020a4a0dc7000000b003244ae0bbd5sm5264152oob.7.2022.04.05.11.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 11:51:43 -0700 (PDT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     tech-board-discuss@lists.linuxfoundation.org, conduct@kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: March 31 2022
Message-ID: <4401af50-083d-0239-6b7f-3454c8d69fec@linuxfoundation.org>
Date:   Tue, 5 Apr 2022 12:51:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: March 31, 2022

In the period of October 1, 2021 through March 31, 2022, the Code of
Conduct Committee received the following reports:

Unacceptable behavior or comments in email: 2

The result of the investigation:
   - Education and coaching clarifying the Code of Conduct conduct
     related to normal review process: 2

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.

------------------------------------------------------------------

This report and the past Code Of Conduct Committee reports
can be found on the Code of Conduct website at

https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
