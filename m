Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEC57BB34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiGTQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGTQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:18:32 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F552FDC;
        Wed, 20 Jul 2022 09:18:31 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id y15so10674763plp.10;
        Wed, 20 Jul 2022 09:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KBeZWZNMYkb0WdQXbi6RNDT6EKxPyV0eftku1FVvkxg=;
        b=SwSuNfUH5rXoEyrf/NoKwr5hTtSikfhSEURpNvp22d60fdT2XVG3JXh7OggsmV3Ou1
         ieDvi01G4//nI3UV2WxsY3YjV7pePUsc8SO+JYcHRDllzKFLXBC5WJWHeGcHbuqhE/Q2
         /7RVdIqLOJebyWsQWW/mncXMO5vEaJAjhGPCRhwACj8T8U0heM6+tVjQjkJlnIPDrpqt
         rnjM8yjg62lPsArsCNLnBbX3XVJuTwlO6haFuDR7J+A9BtHM6gX5OjfSgIoq2fAx40PC
         Cyy8Z4MTbB/MYnVLkiENa/e0NgfsteFNWPW/k2SIjliWbIqKnCwkZ0PY/TIfeI3sdORH
         y98g==
X-Gm-Message-State: AJIora9yIJ8B6rokhvz2lBJ1Sdvp6EAazCrZb6L5tPIlJ8oojfi/B3XL
        ooxwB3JRLyLjj/xFvmkY9dE=
X-Google-Smtp-Source: AGRyM1vCUyRiDozUZoJpwRe5zxW3kEarIE3B4nosVMFS26mbx+dRB9eJTCkVdlheyf8RA65bZ2dLZQ==
X-Received: by 2002:a17:90b:3e8a:b0:1f0:6e06:92e7 with SMTP id rj10-20020a17090b3e8a00b001f06e0692e7mr6353902pjb.155.1658333911049;
        Wed, 20 Jul 2022 09:18:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id pj5-20020a17090b4f4500b001df264610c4sm6194575pjb.0.2022.07.20.09.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:18:30 -0700 (PDT)
Message-ID: <eda05d1b-bef5-b4c0-8ac3-ad8aa13242d2@acm.org>
Date:   Wed, 20 Jul 2022 09:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Improve mq-deadline performance in HDD
Content-Language: en-US
To:     Wang You <wangyoua@uniontech.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangxiaohua@uniontech.com
References: <20220720093048.225944-1-wangyoua@uniontech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220720093048.225944-1-wangyoua@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 02:30, Wang You wrote:
> 

The code in these patches has not been formatted according to the kernel 
coding style guidelines. Please try to run git clang-format HEAD^ on 
both patches and review the changes made by clang-format.

Thanks,

Bart.
