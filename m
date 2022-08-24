Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A391F59F9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiHXMUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiHXMUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:20:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BB25C64;
        Wed, 24 Aug 2022 05:20:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so817791wmk.3;
        Wed, 24 Aug 2022 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=G66/drvYS2iEqFWIV+4bPJS36NVBStHcVudJNSF3yhQ=;
        b=kefzOnf/qfhBVzoS1nyqVYdy/ANbGEwcXEAPVrFqDRQ19zlXZcp81PoL6gv3UWEm1D
         u+fHoJxS8niQ7bPl1Y4bQmKaoenlgHyVE4avZMTejFVdhlZ/8F7lmqh/PvLZiAySGOwT
         ZS7HiWQ0xWpr5tEddIMmZDos6GZd+kCD2Xus2BV8j8GcrKosNk3DsvSPmFHFLMlorgqh
         uX653UJY584lDKBc17D1nohJRRsLI1SWybC819K/IJ1nU5pkgyZYtf6DbSHWXun/Vhbf
         bjcx4O85HfNL+oxT8OIW8+wt5xqZxn4D6r3GtJCY28OeE/r8yUe9FrtH/CmfRTkrBtYY
         Uhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=G66/drvYS2iEqFWIV+4bPJS36NVBStHcVudJNSF3yhQ=;
        b=XTccX0/lMhgWt1m/SDOY9afVnJygRpuAQAdLO7FOXb8ITjqHQziLWX/CxXbzldDTbS
         G4cjVDs77zVSLAbXI/n3Aj86ql2O2Wgsuxymwn8iRufQx5oiAePRGL0Tk4OrItLihsiv
         v2nYHhHgfqzUkl84BZNmfGNcPEiHL7L4FrzP/t16I4R9+JTr0ZS0uMQZcbKsmRO/djl4
         kghmuDBenL2c79HgwbKDc3iGyf9eOoUQ4X9c+34aQ7b0H2qAO1tg015/SgGHHJKkjcI0
         oOXrvIefm+gaw66IsKAlNNmlwa8NuLYalCq6qMWRGrxxV8ZZNaIVQjX0va6y8i5WClBC
         yFbA==
X-Gm-Message-State: ACgBeo2rBql0g7Y3/tZEFNKBJ344N8cljWdDkS8s8YTJKsNZx9nWyjgq
        KTh6RhSzwH+vfrhunGn8mlN/xH6nIfBI8XiOpJnxGLzeJb0=
X-Google-Smtp-Source: AA6agR5ZhmLS+Mhy/WfaseRncZoMTp+3VXdUAJ9TS8aYgIXm2qRfCqPw1uZRTcxpGZz60ORA/1q6O0/GXXl9FtTlufI=
X-Received: by 2002:a1c:3584:0:b0:3a5:fb0e:102e with SMTP id
 c126-20020a1c3584000000b003a5fb0e102emr5278000wma.105.1661343627571; Wed, 24
 Aug 2022 05:20:27 -0700 (PDT)
MIME-Version: 1.0
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
Date:   Wed, 24 Aug 2022 15:20:00 +0300
Message-ID: <CAKErNvpk0VzzA_wk8hdnHNHm2rRdPS82V7879xsvmN7B3GwYWQ@mail.gmail.com>
Subject: Function keys on HP Elite Dragonfly G2
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Sorry for bothering you, but I found your message on the mailing list
where you mentioned you owned an HP Elite Dragonfly G2:

https://lore.kernel.org/linux-input/20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook/

I'm considering buying this laptop, so I thought maybe you could share
your experience with Linux on this device?

As I understand, the issue with brightness keys got resolved with the
BIOS upgrade, right? Do the rest of function keys and special keys
work (fn+f* and separate keys with pictures), i.e. do they generate
keycodes, are all the keycodes distinguishable? Do brightness keys
work with SureView both on and off?

Does screen rotation work in the tablet mode? Does the fingerprint reader work?

Are there any other things that you found not working?

You would help me a lot if you share your experience.

Thanks,
Max
