Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59344DA0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350415AbiCOREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350399AbiCOREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:04:36 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67129FDE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:03:23 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so14407957oti.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=71QdEmlwBmyzW2/4qEGlb6RuQKZwUgr5VIqT5E3Y77g=;
        b=RjCythX3FpbNqR9vGLZWl+kMIpDgBCgGUfdzb02+kBUsh19zfeufZ++MhsNTfzDLa1
         dIh9Vmyqz0yhYPZS6F2TaZ1sYVzhRBcyoxWiyzX4sZ6YOiyJ0LLgyQyAeWcjy39TZJgI
         POgt08OGYYCmsd6fpB+wfv+6+1wOGZq8OAGryKaVeqYlPFzmdKphH+F85t4L0DluYbU9
         oXtIusJKbjqxwMiw2LTuOQPSSjAR2p1KSgopocb2tnivSnYICs7827adwV5VbHmMFgAO
         QaD3sbcYMQYs07cBaD8//BjkL47bCT7t1otIPKHGl4yjk6KiUOSHYPwqQSTsboCWC3LT
         CPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=71QdEmlwBmyzW2/4qEGlb6RuQKZwUgr5VIqT5E3Y77g=;
        b=dN3lg5I4KydshsRbXE3DT44VtplF69OXhFBzyUArgHwQ5JJYDsh6UzX/o5tuU6vVka
         9YImbxxqNJssbmevw5A8OCkncTegtkw/aw7HBIeBVFGlP7/y6aNExdOSyv2bjSNaeXJY
         TkWyRQ3PSJtqS73cuvCx8BFjiwRrRsRKvVT/lKv+pj7vhihMEfW6tBnSPHVQudpiPBHT
         Gakutoo9oclUsUGiTbvxDCVc2SxVq2VKmts+zcEhdhMx7UZw009RhaEB2MsbQfhRwME/
         /Z2noZAGfMnt2ET4WngMhKb/c1T2R7M64gUtDY1UptBLWj4I8TVm1WUBJHB9fVPJlfet
         50+g==
X-Gm-Message-State: AOAM530A3Y63oMRNL1LetNTKwT025jxHEHH4qHAjYh9r37gEu5iyeZCC
        1tPad9S1Y4jDRqIsDOgzZ/QVtuD0CuWbWyBuN2Q=
X-Google-Smtp-Source: ABdhPJwRmddOUY3fjwABCrtXLFbXbuDGteOAWAhHTwg7wUNg+AuzU0KI/my7ekqLupnRkkmgYDLvzp+pCQXKDqMJxf8=
X-Received: by 2002:a05:6830:4489:b0:5c9:4650:dbf7 with SMTP id
 r9-20020a056830448900b005c94650dbf7mr8321455otv.346.1647363802940; Tue, 15
 Mar 2022 10:03:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:e01:0:0:0:0:0 with HTTP; Tue, 15 Mar 2022 10:03:22 -0700 (PDT)
Reply-To: jeai2nasri@yahoo.com
From:   Jean nasri <jhadgrs@gmail.com>
Date:   Tue, 15 Mar 2022 17:03:22 +0000
Message-ID: <CAKxEN0uh0F0ihCDJF6MZqH6kC6aw5_rrE-T6QHdQvieoRTqbaQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Do you have an account to receive donation funds? Please reply for
further explanation.
Nasri.
