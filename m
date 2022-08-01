Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5126C58665C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiHAI3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiHAI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:29:51 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC833355
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:29:50 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r3so17820925ybr.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=PoF0Ci5N9+P5vYJClJnP46fqwkRugCMEdayMpX55RVc=;
        b=TnrJjFyXLTNPi360h6fyymw4nUxCWdxXdualQte6JR6wqIbahekZgdUy/Net5tiDdw
         tsAagUVgD68hlmRx5af+UZ+YwGCJmnXzaXZo4zp9HqN0K7SUxWVbY7v27Tcz89he8Nm+
         UmeGiLisUScNNCdG0Nr+AmOlLzmi2YufXurOgw05854P0U7t4zApndSnU0Oc82XNPcOC
         4r1uTuHzLrbCrZw/lm82H2K0qb22RGnqFBKGQaFRcmGZVmtNWGvmPsl1h8785p767MQZ
         Jaq/sdlWr3QuSjxLp7dRdw1bUb+QfyhroCJoqg5T/20zbXxXA5Y+/ewjGYUi5ioOBDMv
         QyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=PoF0Ci5N9+P5vYJClJnP46fqwkRugCMEdayMpX55RVc=;
        b=k6QdpJyMkT3EtffzfcevUMWCyvBNfqYlq6Den6FiAtuxE4VBc2wsaONRszCeEgQyU3
         HPqX5s+BgYDyKfgWQeWva7njKOQYFEjBc4977a09dPHDlmwInhHWESWZdQ7JUVyyRkYa
         VPtknYTfhd9n6Gg01PBsCVC4XYsuS83/r0IykVEvvjiUnj++TkR/HqCxijqoSB6i8JlT
         TFDFnYV980cj3Cef385CgDaRHN4SHUIJ8lsFKMLB/j93T5TdhiGopkrgOrncEhwFtJjH
         bv7RV8Bo0ITKNwRpL1nAqMWaWQeVS4Ws8s8NFpAY0sjFgeabB8KNa7m4cRmDKSbU+ktT
         E6/A==
X-Gm-Message-State: ACgBeo3wf0wRkEgbfK6fmN39ntYMIPI+lcyXYAr4jEaJVExWeNuIkxtx
        YvLUfkk8n22nmvziq+CgPbHcoYzfs40PD2TuZWU=
X-Google-Smtp-Source: AA6agR7qOcUgzUivPDGmqcz/fLsrAWEHUF7bniIcRt2aLzWmDTm2f3doRDHrC0o0eQXgkfh0xYyg64r6fKxka4y8YwQ=
X-Received: by 2002:a25:814b:0:b0:670:8018:ce99 with SMTP id
 j11-20020a25814b000000b006708018ce99mr10047724ybm.621.1659342589485; Mon, 01
 Aug 2022 01:29:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3d21:b0:2ec:5190:202f with HTTP; Mon, 1 Aug 2022
 01:29:49 -0700 (PDT)
Reply-To: mr.alabbashadi@gmail.com
From:   Abbas hadi <groseilboudou67@gmail.com>
Date:   Mon, 1 Aug 2022 01:29:49 -0700
Message-ID: <CAO-bv6tHvtHdbWN1onvh+oxXeLaMhFohSAE1BuO4bC2w0g225g@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a Mutual/Beneficial Business Project that would be beneficial
to you. I only have two questions to ask of you, if you are
interested.

1. Can you handle this project?
2. Can I give you this trust?

Please note that the deal requires high level of maturity, honesty and
secrecy. This will involve moving some money from my office, on trust
to your hands or bank account. Also note that i will do everything to
make sure that the money is moved as a purely legitimate fund, so you
will not be exposed to any risk.

I request for your full co-operation. I will give you details and
procedure when I receive your reply, to commence this transaction, I
require you to immediately indicate your interest by a return reply.

I will be waiting for your response in a timely manner.

Best Regard,

Al'Abbas Hadi
