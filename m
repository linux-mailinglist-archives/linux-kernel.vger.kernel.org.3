Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502554E50F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiCWLEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiCWLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:04:50 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17B2181D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:03:14 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id m42so548453uae.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=yU8r6tzitL+zxa9Gao4jxkZDG2058/F6sISy2Ia2K6g=;
        b=BmurdNgNZIIRWeaaIfbE55lYLRa/ZxR7IzX1yMv3XjF4m5KHV9RSlrAw4ODxBNW/9h
         yERc0N47g9CsOMnBmRomPeLlXPX6BIYjaA7CG0vs0oCtt8xJHQHXRWwGmNg0BkyylsMs
         oeTB0f4Cp/PNxEa5Hc0mVoKmbc7MsegT0a2cGQv1Y1WdL5sCBqMR2Cq0rOWlrrz1LHwi
         PpuLdkQxlB6b8dUBC+PqmNXKCPJmQeVaqzwcnFzmsyrCCHWtTK61C11PD6JedPISfnX2
         Dzgd48845zNCN/GE67GdmJ1kzaSl+Dr5tt/VXBY2yy6cxztRAYRZkbJHUfxfEJmeuupU
         XinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yU8r6tzitL+zxa9Gao4jxkZDG2058/F6sISy2Ia2K6g=;
        b=Ur4sxeYsy5Ki3XNkbJzfPloX1ienTfCYLB5zGkshL4ikEJzm3xWg6GT0hwaaZkCaYl
         OmMPCVKig0xOWR92K1KDqP8vek8Y39JGp6PLmsdMS7zEGVvfA/nCQsLEH83qZVK5SPsx
         NZ6qmKKt7ShlpLXCuMueYfG3qfndt7B2TUfX0Df77ea3h4zGX68BfU/1yiUY2bHD1Nnx
         0Z4M8Nx3+9hwORW/e4GM41TR2VfSM96WkkjMhn7fI2WOsbYvJLdO/pelXQnYL+dnTTZc
         3pWIu2Nr+eywbresX3vLyZ9W9k2F3FrtOUgVglhPSZGtow5KZZr0I1A8ogqcsq8rosHG
         sILA==
X-Gm-Message-State: AOAM532MFw5fDq8lm/ubuQj1k6NXVXSsHcBappnOikws1XF7LvH9f/8Y
        t5vZz3yrI+gECaPxyTHUvQFqp7cdrEZOR245N9QlU3SsqKLA8g==
X-Google-Smtp-Source: ABdhPJyzTi5JMgC8PVkdN3mwGkyveRQwxLKWoUQoX7LX8dkjzhL+pYFP6m1ICy1eX7SZiOn60mPeECxHbcCC4A7T1gY=
X-Received: by 2002:a9f:2161:0:b0:34b:cfdd:f89c with SMTP id
 88-20020a9f2161000000b0034bcfddf89cmr11322362uab.104.1648033392766; Wed, 23
 Mar 2022 04:03:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c783:0:b0:29d:c6c8:bcd0 with HTTP; Wed, 23 Mar 2022
 04:03:12 -0700 (PDT)
From:   Heggins Kate <hegginskate7@gmail.com>
Date:   Wed, 23 Mar 2022 11:03:12 +0000
Message-ID: <CAEAJ=VzbwUD5RdeQA_tZf4DCYh9et=2v=jeRdM9cMVR=fke+AQ@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Reaktionen
Viele
Vielen Dank.
Heggins
