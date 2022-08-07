Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614E58BA8B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiHGKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiHGKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 06:15:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816CE6441
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 03:15:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 73so6223804pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EYModRjGVK23spwzoAOGpPcUUe7H255sa6tEtE4StqrzCJsYMJd/dD+U0tm2hD9chz
         E2C3JukCMNy9Aaf0ifSDs2qE9pl00yBzt/7dPbRrYuFJl0Lb9NxL0y+UjDHra/sw48x7
         M/uN72rXX0TWAVeRRktmE7Bt522YdyAzDYvctty7/6U6eRPaqduy99DdgTciloMYXrRZ
         LrtE12bp7zqXQg6+ARvmFCpGAbCPfI+dhNPHcfYV9F5H3mNsexRytywd7TMa3ZA3HLDG
         OePtwgNXt15fQKcDhSsY237SJScpCNioNJojTqG5f1YOkrnMcNUoe0u1HkjltQYcrURD
         wQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=RP+dDvxFZw/YDsjBRynsYHIM/HdOS9jwM0xS+Tf7n44SvYBQqZdGS58sku4JEYy1YC
         RIM94G1zfDiJna3tQArNbOwJSHrb0Cmx8TSvs/7fO/b/Wa55A1ErCXoypWb4+CHJLciQ
         A0F2wDpK/N50n3prTDy41leoHCCFsEkFouDEvc29p88gf2Chf/mjYKmCIkH0Tm7JeEBM
         l7r+B1ShsQXkW5LDbdVvwIKBFYQSweqmh/drkgFbrWA89CTF6bNa/qYY3N7lux4M4fAj
         KbgtM+poeY0/7l8mI9YdkevJbFrEvkKFSVgOKpQHO6Bl3BzD/KiN9h5tVd1OBdB7qWgj
         Y7vQ==
X-Gm-Message-State: ACgBeo17j9a5Kd0ihzPJfecyJ05UAjr6UW0NUeBStRjuCEUT3FyqM8Bp
        mpU0IDkojg7iO8R7dlttC2688C2KoOU=
X-Google-Smtp-Source: AA6agR7bJsdPX0XyMI9GnWnxiwOZ1X4l6A2kMJQnTzENOzGsA1HbrWKlv7stkikPz46ADV5OGl/T0Q==
X-Received: by 2002:a63:c012:0:b0:41c:1148:ec9 with SMTP id h18-20020a63c012000000b0041c11480ec9mr11663300pgg.444.1659867340826;
        Sun, 07 Aug 2022 03:15:40 -0700 (PDT)
Received: from [192.168.1.6] ([120.235.8.25])
        by smtp.gmail.com with ESMTPSA id y6-20020a636406000000b0041975999455sm4336446pgb.75.2022.08.07.03.15.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 03:15:39 -0700 (PDT)
Message-ID: <3bc97ece-c0ea-6332-c2bb-6d07b2f0fe69@gmail.com>
Date:   Sun, 7 Aug 2022 18:15:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Michael M <michael5hzg@gmail.com>
Subject: subcribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


