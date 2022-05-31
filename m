Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC1539065
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbiEaMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbiEaMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:14:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE366994C0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:14:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i10so1725419lfj.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KziH/+AB14mwXJXKNK2mWJmseYRo6SnrFlxEG5kGD+E=;
        b=XYCy7FWgttCdCBRDdZJpqAQgsiXbwbGY4fSRZzhs9mQP/t+VgZjB8vBh8dPm6Q5TCJ
         KQYV4XBl3e8xLmvVvxIWkthbWNA+jVnnHZQ22RxxGj05/wIzF6XeBVprmiYN4xvVzgVw
         2tXcl9P3zCgwd2hGWmNy5p5xg+K1nGB4Hsl4fmzuT/afzOH5I72jY/+gyiIbkDn6kUQd
         Yza2sTkBg/rLtgdHeWEqKGeanc7kGt2Wx7oOw6E7ZyugRaw5+F4tVJg1IkHmCEjWaZAL
         1hSd7F7CDQ8FHl1Kgi2zKpqEQbxW7nMPND3rDvx5jx1g+mslzDtjvuZ9VteYmn0fJdtt
         1AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KziH/+AB14mwXJXKNK2mWJmseYRo6SnrFlxEG5kGD+E=;
        b=NmZbo8/XDI8W2CXpFL9lR0W/iiB0afWlnB3VlHySAXCSjmxeP9NGxOPSJ7M6dESCP1
         Fvfb/kb+HedJ90PSsxNYwzJ7znvzcD+5O/KbUcLLuBCSKVcTAiMnstYxiot9XnS9BNpZ
         r/EVuyKz8qH+D9enmx+a4JAff6+4vRPoxG+0FhbLgEvDQgrGOts5Escf3SYCg1ZdUJLR
         zOb3htHieW6ea8MZMLA2F1W11lHFN08oXHhchgvd8SqzpVzsWwBZUQuKVQN+KXi69ANS
         5GgKlQB+l2qSo/gF+bzRuZrRmDB8N9po1WmTKS/TZ8XfYnJ0sinpjyQWGW+GCM2GMnKu
         w/yA==
X-Gm-Message-State: AOAM531pA75v/e8zQWItpTc8pMfq0QnfuDJhkErJMho49RhcEpS8JS31
        PbO4aIREMf0TwC36GHRD3M4rE8slPs2IyFPSbLavhTUeeVQ=
X-Google-Smtp-Source: ABdhPJz/oQKihaMC4IcYDi3uDq3fBokuzPITwnGwNWAQDb4GZt0w4lx59DSyxLdjEydzQONfPG3CIPrWdTUFHJWoKg8=
X-Received: by 2002:a05:6512:b0b:b0:474:d:9586 with SMTP id
 w11-20020a0565120b0b00b00474000d9586mr43557585lfu.594.1653999281090; Tue, 31
 May 2022 05:14:41 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 31 May 2022 17:44:29 +0530
Message-ID: <CAHhAz+gUpxzukjde1rMqRcPre8yMROBd3yQTCm89wMGb2zWriw@mail.gmail.com>
Subject: Kconfig rules (depends, imply)
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

menuconfig SOUNDWIRE
        tristate "SoundWire support"
        depends on ACPI || OF

"depends on ACPI || OF" mean, SOUNDWIRE depends on both ACPI and OF modules?




config SOUNDWIRE_QCOM
        tristate "Qualcomm SoundWire Master driver"
        imply SLIMBUS

What does "imply SLIMBUS" mean?

-- 
Thanks,
Sekhar
