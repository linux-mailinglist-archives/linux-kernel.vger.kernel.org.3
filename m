Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E651157A4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiGSRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiGSRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:10:37 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4C21251
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:10:36 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id b81so5820556vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=t+pQa5dRvfaXNuusnmsa3SIVfyR2GaEPDHqht+u9DDE=;
        b=XQCAkhnA7mNuYuIpoxdZ46pFQ1GUHqOWGIPinA58WhbL+BxTGPchHB+WV19Rwx2J4A
         c9nPu1OsLat/rEtA6nWx5bpZX7oa7k8XvkntQvJmet0YWlRMROCrh0Fo0PQPUFBhfhuT
         geu9ht1d/6s4Ow0kkc/bRDuygGPHSgS4P1wIee9EqzSFWvpvgdcQ4i0RoAP5xtt+5ccd
         epEqjA4Uwg4NYfAYu0YtI3QtsTsAsl07rWOmVUWe8GHuEtpxkHgxUid9T6W8WbroWzUG
         lUZrdP2x+MLSxKIzOUhBLJM/5H7sfDb5f1Ho9DZ0m/IgeHRoPKrghv3uPf9snJfoxvR+
         q02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=t+pQa5dRvfaXNuusnmsa3SIVfyR2GaEPDHqht+u9DDE=;
        b=XRpqFZ27sQl2qLCP9PrnpcubVIDoBE/Htbvtpl/W+X7ZkKKVEoTnIstjJ1ajMnUkte
         uiogyhlesM6fSpl642DYL5N4U+If8PB4/AhAbjzkuwVIH102TkHUSp7+bTwXuyB86TW6
         sBg2BEiHBVeCjueP7k1n34ZVcYHPe6eY7EH8VWT4gG/WiWbtRC9QN2Qot31QxAe98xmr
         XqUgkPgO0GJ/aUze/3S103RoikwV0W6HHJuCywqJ6Ur1SAZa7C4qgC349BuiP7hA3Kh7
         j1NRzmqAWUoQFVmw3FLaqQ+Qg7FunYbXuRMnCVLZ1kPURA6rWl51m7x/tPkbKAlAL/7q
         pJxQ==
X-Gm-Message-State: AJIora/gEjSTwPVsJPSOi7HQFmm9UHDMYygOfA43J8qg7fTqCgQuBlnT
        tmFzCT4DOXq5p3QEMCv6dqW55nLMNfqs3VeLQ/g=
X-Google-Smtp-Source: AGRyM1tOmj4/Axjb7fzmg+gUpcndNHpFdiXLWdrsHFNQ3wh/qDFFLg62Qs93BjAJTGkzi/+GIOVrzlDA5fQKKrwoK6M=
X-Received: by 2002:a1f:2a55:0:b0:375:8e1b:d374 with SMTP id
 q82-20020a1f2a55000000b003758e1bd374mr4302231vkq.2.1658250635191; Tue, 19 Jul
 2022 10:10:35 -0700 (PDT)
MIME-Version: 1.0
Sender: saniumarm46@gmail.com
Received: by 2002:a05:6102:3fa7:0:0:0:0 with HTTP; Tue, 19 Jul 2022 10:10:32
 -0700 (PDT)
From:   Mimi Hassan <mimihassan971@gmail.com>
Date:   Tue, 19 Jul 2022 18:10:32 +0100
X-Google-Sender-Auth: UrtF_6bhvEuqSXzZLWV4e7Gmb8w
Message-ID: <CAEBNbt5zo9EDk5S43tfxBS7OYJDPwuB_kQorDCxfuiJfHydN5w@mail.gmail.com>
Subject: Good day.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad and i was diagnosed with cancer
about 2 years
ago,before i go for a surgery  i  have to do this by helping the
Less-privileged,so If you are interested to use the sum of
US17.3Million)to help them kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
