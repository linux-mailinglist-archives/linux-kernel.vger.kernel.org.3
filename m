Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E227B587364
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiHAVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiHAVa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:30:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38599DE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:28:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y13so8677800ejp.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=1EIa6V63zjy1lGAmZDYKEzUXJjPopTFe1+5v1SXtYeo=;
        b=EM3kKdmofh/kf6JJQraq8CuYC37HvAJX7TGvFetMP5uIYUDaW1vS2+6JTAvFG7DmvN
         P9l1t8oiGjq6l6RD4eLtF6RnB/zFMG3KcMcngdaHT+yepFo7S1T57rs+5Ldw2LzE4S+h
         /5vvmREmEstXg0vV/BKgY/SzLeltKR6IKZAgl+0UC0n2iBT2bvhmcdjgqtRHcquM1vgh
         H8AeB7dKf2Wub+WeCNF0Iqk9ZDCBtTVBnpFvSD0gOg0xYfvlD3hZrde2XtKtorkOeahH
         nzenZEIYFhPlf2Qjou8iDpJFJcM8QmJA7OECTYmT/uYBlpATpmjyTOy1aNzcdbY5TOJp
         NeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=1EIa6V63zjy1lGAmZDYKEzUXJjPopTFe1+5v1SXtYeo=;
        b=mozVAIjdOu+PoHLOYzNwJYaJSCYlfXtNrCh71kVPjcNgfy5/1W6JAgXYYG0gyx8l4o
         bd30fzmATDXH1t7UGpw/nSwIIgcavHF6Vm2/OesUfYrzRN9FscbQuwYrTLMcofxkHDLy
         P6bmgpgPk8Mzoj2T39y1qoBIv/OLQcib1xN6Mbhyo1Jt39uIMQCDLBxesiYEZkOzEzZf
         vTQ8uETvhrVf4KVKyVnwOiK2xuJP5wbjtz7KvSe7bY0aDs4NY/lALJ1dPutn1/5uwKU1
         P1uAsaUt3k/8ngi1MwCsmjs4C5yw/h5R1cCR/DAu/bzewwLj0DIkYylBGDV7z80+8P1r
         /uyw==
X-Gm-Message-State: ACgBeo2otykhFmv3+HGbMR4HfK+8biXf2cWMJsVjxxI+w42jhbQ6BAHC
        MvhdSPhfsozCnxNalk4nS6Vl+MH4QX/sMWT5l7U=
X-Google-Smtp-Source: AA6agR5pykkNIaerqViQtEV/IFhtHXTa5MjlReqJgiejSncdFteVAlB8wslXvpNigDk6UXCOmvN0BbJb4sSAsjdVz2Y=
X-Received: by 2002:a17:907:2d20:b0:730:8bb6:3f9d with SMTP id
 gs32-20020a1709072d2000b007308bb63f9dmr4306358ejc.668.1659389310822; Mon, 01
 Aug 2022 14:28:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:7486:0:0:0:0:0 with HTTP; Mon, 1 Aug 2022 14:28:30 -0700 (PDT)
Reply-To: mr.yihuiman@crscn-cn.com
From:   "Mr YI.M" <sikemi07@gmail.com>
Date:   Tue, 2 Aug 2022 05:28:30 +0800
Message-ID: <CAP+C1cz3SxEjb_kUVu2adx-YHiK3WsCR5=zzi=70xXsNbeyiNQ@mail.gmail.com>
Subject: Re:Re:Messege sent to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I want to be sure if you got this message. For a piece of important information.
Thanks
