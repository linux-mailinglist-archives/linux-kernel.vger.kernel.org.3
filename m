Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3A53D721
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiFDN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFDN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:59:27 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA323616C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:59:26 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l84so13871158oif.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=j3Q0LJym9NHCAoQKr5tf8jUxASqpypr2WqtJ8dDdbHY=;
        b=Xu8llVDtR1IM9ZmJm3h2mwDcKiiN9IE3KxYVpomEjeD5mutNNhmAo56utG4A8I81MS
         Lx/Xm+vOsyv7fk0icH9LbeQ8ostx/JRouLbAxidQecQfEPpedMNyhXdhtkFdP2t5iUYp
         h4I3bBT7hUnrBAJ92oDbRVHmpQUYNb7+WlZy0tsMpkn+lp3sA50vTy1tFV/OEIZNJ/sp
         p9AqSvd9GOhXSdnbRcFZqJ2B05BSc+TuP0NtYA+pQxhVp/Yur8U1tuAxr4QJ2ENdcGwj
         bzMQ0ODHr7f0GG4DS7t/+sOh5g1xqjewscWtvoXpZOnErQk5yoMjuvDMTFGOOMXEMok7
         G3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=j3Q0LJym9NHCAoQKr5tf8jUxASqpypr2WqtJ8dDdbHY=;
        b=QVx3iCHAbetFrtGMDtzf/V4BvlBNqa8FEs5uav54FSw+J55x3o0TCH2ng5ADv8LZoU
         u38hXL4fKwMsZZVABSddym7vxKT9MqA1es4PcackvJ3S+2VqRR0OqWTtRKwHMAVYSUTj
         bRl05GelBVV2zqu83lECwcCQ77PYYoscIFQ3NkAIRHRoNIaQy3ZMEMYdz8E3VMkAq/AL
         BGyScMmMLrfTzb4O0ggfI++tbs4lY7pwE+4PNLhuU0ucZyxh159IyjHriuWb6sastLM1
         b2A8c4QrH6dbLXM+miAwclu/75livMJFxgNToqk5AX9nDuAdWefKH6Y98/ujjRn3ISjA
         QyGA==
X-Gm-Message-State: AOAM532mep/ZLfR5GPvX2qVDUrGqxF4AmTy39XgnPL+BIGT5souzwQG2
        uulrPvbFlEGN65UPpwKG99GhXn2cOGVzZJgT0lc=
X-Google-Smtp-Source: ABdhPJz8tgyKw/uSyq+izFKVeZbOqczwjKjElaFd+TIJX+dKjiSoqEORu1W3dUJ36yIfj1tIQdLFbxR2gLU8Kpe+4gc=
X-Received: by 2002:aca:6c5:0:b0:325:5bce:bbc1 with SMTP id
 188-20020aca06c5000000b003255bcebbc1mr24359520oig.221.1654351165623; Sat, 04
 Jun 2022 06:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:a9c:0:0:0:0 with HTTP; Sat, 4 Jun 2022 06:59:25
 -0700 (PDT)
Reply-To: davidcliff396@gmail.com
From:   David Cliff <bhimmatinou@gmail.com>
Date:   Sat, 4 Jun 2022 13:59:25 +0000
Message-ID: <CAK85DBwr7oNs2ukm+kCbun2FJDdVy2+irubppLCLhg-kbC6Arg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear. I have viewed your profile and I wish to say you are very
beautiful and charming, nice and gentle. I like you to know that this
beauty I see in you is the heart of every man, I would like to know
you better as I am searching for a long lasting relationship. I will
tell you more about myself when I get your reply, send me your email
address, here is my email: davidcliff396@gmail.com,
I will wait for your reply. Thanks
Regards
David
