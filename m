Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F126D4E8033
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiCZJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCZJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:50:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644304BBA2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:48:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bi12so19664667ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=/TXRHh9thNzMbXH1B0crHzkh5AlR+CozJDtm1yFjNvk=;
        b=kOep6NPJcch8aIHNeUuzC3H9x8JSc9QjfTvHZ2/d8xI1DKAeIYaY17tuZ6L4S9JV0+
         H0AHjLQpJ8vrtA2WouxVEtAnQ8GWBSDWnq0aBDOaByuB6MYZShu1C6E9MVGfaPi4Zxsv
         THjFvdttf3/2Xg+xCyg4eV/vZOLKyyq+ZkpI5dNm69LXIp+TH27NeIpsU7ldPaITyYTc
         YHekjIhnyzeeSBYYi8st7XWrnJhZn242JgQ/DEYD2DGfdAUjxSQtZzr3kFMmjYy3BPU4
         1hvwDuCKJITJ1hbVyYexW1G7D6xbtkYA6KP3eD7y9nAPlMs4kbVIeUti0CjnWX+HIpGZ
         hXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=/TXRHh9thNzMbXH1B0crHzkh5AlR+CozJDtm1yFjNvk=;
        b=tCd1AIHNLX+SHBhBIMYiYqVyp2KyzdiXMHHD2zVw7Z/KND+KK0VKbaccaoZZnHY/g7
         9asMBTuBwS0J0s2QeOitlBciiOsUMBhiiVr/7KkJbrzh3sub31CRVD49aUqGRCLR5uQ3
         IUH8x8kT9/rD6PW1Kfp5F6QkbeU0QP2hGy3kP/s9F5WJ73kOP8/1LxdNSsTUGcHCgG6V
         bEnyRUNY8D0CnpGyTxPvsUyKgFMAT08qeep4qoB/89vZJK8Dyv/Igg4a6q7E+HDshknu
         IptqQOWjYad9TpcbzVuiHVWvVJTdAY3YF0114oaGtq0ejnoQ6pqFYOOQwFyE3nHoYZmL
         ro0Q==
X-Gm-Message-State: AOAM532lvUnb/Axs0lWztnDl2jW/aQTWTJ3fkct0YftOxPxMblqe2mBN
        6Y30gBKPGj652Wnu5/X3EYo=
X-Google-Smtp-Source: ABdhPJz4z6kX6Vyx3C7zg/uouL7Zhs6cwuBT/TNUcXpi+0z3GR/7OPvE9pd4kdnXrKcTFHxOvi8gLg==
X-Received: by 2002:a17:907:3d9e:b0:6e0:ac96:c1e6 with SMTP id he30-20020a1709073d9e00b006e0ac96c1e6mr7357174ejc.532.1648288129062;
        Sat, 26 Mar 2022 02:48:49 -0700 (PDT)
Received: from [192.168.0.101] ([154.66.172.197])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm3305833ejd.11.2022.03.26.02.48.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 26 Mar 2022 02:48:47 -0700 (PDT)
Message-ID: <623ee17f.1c69fb81.61c2c.e2b4@mx.google.com>
Sender: Elena Tudorie <mrssabahibrahim11@gmail.com>
From:   Elena Tudorie <elenatudorie987@gmail.com>
X-Google-Original-From: "Elena Tudorie" <sa2020bah1@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <sa2020bah1@gmail.com>
Date:   Sat, 26 Mar 2022 02:48:31 -0700
Reply-To: elenatudorie987@gmail.com
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I Wish to seek your conscience about something urgently, Please reply this =
message, once you get it.
Yours sister,
Mrs.Elena Tudorie
Email: tudorie_elena@outlook.com
