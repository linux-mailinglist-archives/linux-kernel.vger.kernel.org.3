Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0ED4E1F98
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiCUEgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiCUEga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:36:30 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB514926D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:35:05 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b7so9608273ilm.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=wNrJMzmUs8L1uyhCpCulO8HdWj50qKBCSBf44V+e8WA=;
        b=UfxGQcW1Gpo/sRxf/yxPj2Z7q0HAVnsKS+0aYE55NotAkdV4sc5gYXigF2fysUT+iJ
         jjHJPJ1v67HvuV/dHQt1CNrxjRaaFBlmjpo7bETQRGVj8RZXKLekuvLtMU+SsZnKiMxY
         2UQn6RSVP4JUPCEZK8PiJG3ASsYVTu80NDPNGo0bd0ShHn2cakruMzA/qil7bECyFV2t
         deSY/mLxzSLxulEVDN2aPUjcy1lcDfXiOytMrQBMl9ee4m+4EdIwxsBV4W/jAmxeP0xL
         +FFNe8o3r6rFntEEcJrN5fw9H78YtKKrB3copOOAtyK2/qKT5uPuLCO+M9uDq8/6D7EQ
         zxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=wNrJMzmUs8L1uyhCpCulO8HdWj50qKBCSBf44V+e8WA=;
        b=6sfHjX48TYVh9tR7J0WQaU/zRczLgiBb+Tu0H9kchYJRQ+NJLqDLsDL+VBJMKhaSq4
         Tht3SmslYdmIru0cYGpXBm0xkqc9xssHMvwywLHFTq84jvZTtq99b+CoTynet+/e84h+
         Un6SmrNplQv4ZWBMdV62aABrOawP+t4SU/xdgECi5GlTcLyXEfOlqY26sUTpLsC3XZnY
         JnMIZN40xQjZvN8IhFH8db9d0Abn6Mpailh+6zlnZrbMTRz84PVQzYtkAs7bvqPDNkfx
         2XEgBbSGyZZrhzgpOXCl4/FsmdeAbG+hOeI3JAh62OE4SkzGAocCY+FexVTywCXxFOdy
         Yy0A==
X-Gm-Message-State: AOAM533xlkh5XXMj3Fa4pjhv6R02LLgx/xerXcmWqsr1WZDbdf0R1HUv
        DEQcUx0KR9HC15qvV34tiaKKCPpKTs63gtEoa+w=
X-Google-Smtp-Source: ABdhPJyGoOEcbR4tua9ckdH3foOFoLMHXerGVX6dN30Brn7sm6+Ack+IbhJZUBWQsnuTdY7GQWtl/j++S6dXnaexA2o=
X-Received: by 2002:a05:6e02:5b1:b0:2c6:218d:fb38 with SMTP id
 k17-20020a056e0205b100b002c6218dfb38mr9131997ils.266.1647837304712; Sun, 20
 Mar 2022 21:35:04 -0700 (PDT)
MIME-Version: 1.0
Sender: hadjara.sawadou@gmail.com
Received: by 2002:a05:6638:dd4:0:0:0:0 with HTTP; Sun, 20 Mar 2022 21:35:04
 -0700 (PDT)
From:   AZIZAT ABIATU KASIMU <kazizatabiatu@gmail.com>
Date:   Sun, 20 Mar 2022 21:35:04 -0700
X-Google-Sender-Auth: WDpioDsT-HRKdn2JXB6fwpmmwc0
Message-ID: <CAKFm-kHEEtr8yHg4HQTyNFFNz1oduAY8q-4_r_8yp7x7yMsQoA@mail.gmail.com>
Subject: compensation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello....
this is to inform you that you have be   compensated with the sum of
1.2 million dollars in your pass effort,and  the payment will be issue
into ATM visa  card and send to you from the UBA BANK we need your
address and your Whats App number

Thanks

Mrs AZIZAT ABIATU KASIMU
