Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6C59B52E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiHUPoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHUPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:44:02 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE01D30A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:44:01 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id i129so4439379vke.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=EDlMQzzVbGTvS/Xi3jfsxW5Vdl1DnbH6ryI6Z5fSkFQ=;
        b=OBEL7JD/7BhVqgXxrmSRLhE3auzh1jlylSlahwP1vfPDH9kh/sZa3hEUpwOHvPGjCt
         yjb6H/St3boZOzyrEYEcm9wtzEy+5OMGgQo1JleD5HfP+9cXPeaoYjtI7qFu0/VIxc7X
         3MmUvNSGyc8Mz6rv2ccPPhO/7imQ6Donvuyc22WfVDqNTuMFdvOhXzRXbhp8/ZeX2ib7
         fidB1GjenoQWx0FKAi13q0i73aQ0zgrPkYecW4XCg9OdO4enPSigAsBZCH9Oahzg75S7
         eo7BoQrjQ4uYSXPavQyF+zzqxM6/tRyVGn2nzA2rYv81sZw2l3+Oyw59jXgQ7EoznaVg
         DelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=EDlMQzzVbGTvS/Xi3jfsxW5Vdl1DnbH6ryI6Z5fSkFQ=;
        b=A/Lt+VxRNqe9X5JU0WrY9yuhyTkwR2JiJWD0o8MaBSSSVvmVjkDF+8y/PbuYeiG4HO
         DSej56TmxT2CauqKVD7wtKFi4uNTpekkgtfqx/oEaV4oUQOOmqxevl0Gd7y7VF0k0wO7
         MVRATvoD7ziHCCmQD6pewoG6CVuNAhs6LcT4Z2MEQE3ih6vY5YWHXJ1XQAFcw4j0yuXG
         ISolEJDhKeL2W1EhY/bNGquOuppko5KiE42Z8sPOakz/2Q9kigPIxVwhKovkdJHluhCH
         pNQq9oUOqgY/husddmpc23+1wdiLow6qB1DA92WUKk4UUL3eWhSy1bhnSdhZBL5H5pEi
         84zQ==
X-Gm-Message-State: ACgBeo2DnAQSVIdDxatwrS+FFUeQWq/f5+l6L4dpTuV9dE7bWsQc2Z65
        LmY64/kWa75jC4SjnvI055ixg/+CON+bMCeoP8E=
X-Google-Smtp-Source: AA6agR64ii37EH405n4sWo5IW4nSZOaqT/OgTt35qcXq5u8gCvnE/56VABFsn7XhmLAhsrz2KxW2RqoEYAWdt4aA7b8=
X-Received: by 2002:a05:6122:639:b0:387:ea11:ab6d with SMTP id
 g25-20020a056122063900b00387ea11ab6dmr4270294vkp.36.1661096640994; Sun, 21
 Aug 2022 08:44:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:370a:0:0:0:0:0 with HTTP; Sun, 21 Aug 2022 08:44:00
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <manstone252@gmail.com>
Date:   Sun, 21 Aug 2022 15:44:00 +0000
Message-ID: <CAOvQE_-82Y1Naa=ANSKO8z0tWEizZgKKvnWWyPR=9+uyF2TjEg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4958]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [manstone252[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [manstone252[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bok draga, molim te jesi li primila moju prethodnu poruku, hvala.
