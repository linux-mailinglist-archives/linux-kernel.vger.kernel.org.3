Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D774CBC34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiCCLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:10:50 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5724C17C435
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:10:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d62so5246309iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=nQQ6ThY+6myp78NAC9NDHv64T6ErQ7SQdtasVA/loeuDCPHgy20qHi3JOmwf7a1ijL
         PPa088SnKi2Bx2kia/xysByEp5thq6wJ9OmZUdeBFnfP5KOm/koq7YqPELC5gMdgGB3Y
         piXzD5GK006KGxahMV/q6ZCPukiSGd1oRHm+jvyBVhEcPn3Ekak3ezHXLXWnu8Tgv2IL
         rPRz4AcLBUOjTJZEQCZtPJjoKtfYZXX/5GKMKF9GLeK94sntC4bcnQ7DICgcRa/xJnpf
         mWi3KHRHZF04n+cpxrXDuJJqKcf2mueKM1hRdp4IY4safAQvoXQPsJra0cf/t7uaQonB
         8tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=s+TzSMwZ8QTC9Nn0QF9vpmpYFYn7aSRu/RM/XI2QZcC5M4P3xxVKnzgbBzxU4YB9tJ
         fBWzUtE0YEPGNc8K7DshGFxTFn2dR03X9ThLBGY5iflSYSIKEn07KRx58XyBalKdxBsa
         fqBH3vTvpxHGRp10xswMzuWtsR9WOXKIqFtWAiftnWUpmAYivcc9Qn6sfiUSgomuePyw
         yMdNq8AAAgj52tYiZimkRABZ97nRKEjswvlAdnb2giY7OHGPrjcsHbF9tRtZq9oFP2dp
         EZR2Ja0bc7qwWyd7QGYP/Mglqh2dWr8d9x16yhmduU7VGQOnfcTo1dol0D2frDsw7igb
         4PVA==
X-Gm-Message-State: AOAM530ut++PsASTEdteoGn5xNQorW0QbJavZYYDpxfJ2zQdQOXyZHVN
        e1bTFzean1ZxzesCTft9Dq29SvMXw+/Mzcyu+g==
X-Google-Smtp-Source: ABdhPJyh3Xa9K+6koLrNAOHu5jGfK8aFGou4dMT2UlRo2UEmZD2s3WQkxCfFai+9exuTQ75GAiFja0LX+z+h7TUGhjk=
X-Received: by 2002:a02:ce33:0:b0:311:92e9:41bc with SMTP id
 v19-20020a02ce33000000b0031192e941bcmr29908474jar.114.1646305804679; Thu, 03
 Mar 2022 03:10:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: dr.tracymedicinemed1@gmail.com
Sender: servicedhlbfouaga1@gmail.com
Received: by 2002:a05:6638:1301:0:0:0:0 with HTTP; Thu, 3 Mar 2022 03:10:02
 -0800 (PST)
From:   Dr Tracy William <ra6277708@gmail.com>
Date:   Thu, 3 Mar 2022 19:10:02 +0800
X-Google-Sender-Auth: pdAl5ZaYaR2tIwIhDfR_u8kK1Zc
Message-ID: <CAECaA6uBbnZb=QNBV+eGrhp5wcPS=n18GjUQL4vDLt5shdQHnQ@mail.gmail.com>
Subject: From Dr Tracy from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great.

It is my great pleasure to contact you,I want to make a new and
special friend,I hope you don't mind. My name is Tracy William from
the United States, Am an English and French nationalities. I will give
you pictures and more details about my self as soon as i hear from
you Kisses.

Pls resply to my personal email(dr.tracymedicinemed1@gmail.com)

Thanks.
Tracy,
