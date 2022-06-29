Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E155FDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiF2Kwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiF2Kw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:52:27 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49C3E0C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:52:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72-20020a9d064e000000b00616c2a174bcso7705708otn.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zwr+gvqINn5s/ZV6IyRPgfhaWD9WdQkp9Eb4Seu1lr8=;
        b=PN9QB48v3Ij66lJ5qvk3yfmi7ld8AqAMKXIsERdymFnqu7FsO5XySGVcKH/9WDxz3A
         /mVqiw65Bp9U7TztqaQDi3VlyiX3PZJnFC05GLwn90FpoKu/D/oFcwRqo5NDGb8uhD4O
         VSY/72DU9yomviC0a3cuH/OUFSoExQFjJTMS2t6LnAgMDEfYwLc3iEh+jpCpKXcKkU/B
         vP15rWxyy8CzM/p7vrRdJTkFXusW95db+DWyKD/DueTqzwqACgDvDB/0g+17op9SHGiB
         msCnwcLsrlho8bwabP6LurOeP3bgyEo0vnbAOjV6PNCjoFVxf8tpqMnY4wjueZ75m25D
         Q2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zwr+gvqINn5s/ZV6IyRPgfhaWD9WdQkp9Eb4Seu1lr8=;
        b=4k/d8gVTgZoB/ENWKZxPODY+COkS/YdxlAmT1V+U6qgYpKTMI2tFbRm+KG79qBIlU1
         6ZSbngmSdWb+j4cWd6EmIfQaehz22+9uVd7AZTdCGu4vd4jSxL/efUxXQW4F4yi1GqNP
         +VxbTm/hX7J/GMq4rjIN/87OuHNDXJBgXLf0X2vpuCxFGzyvrNzJIrZfVWBa75wbPMbX
         8u/ZmjTGffOGRseE52Rzgks/kbTS9kv/1Jz480NoTx/uZz2C/GIOpff5ZtSWtzG41Nxx
         t1fx9XGOpbh2iAOhK3EeMVc07wKoQWCSQDUyKZr/Ludycg2SdPaD86QyUG2BfFbdx5Rh
         JbVQ==
X-Gm-Message-State: AJIora+GT0OUoKGNgQxhPdZM/yDZyzj8+DCie7dmJVoVtb5CKUtmQ2zG
        kMjbcqZ73oZTArhv4OpPWspCK1AVVsudkCTXJ7E=
X-Google-Smtp-Source: AGRyM1vPhc1NlSd86iBqbYi0+6Hp7fSuXTSRXKkvOE858j8t83nZT7hjncCkNvIzjVpZNLTn6Yo0CUr0vMyyOq/vlPY=
X-Received: by 2002:a05:6830:438a:b0:616:f238:1562 with SMTP id
 s10-20020a056830438a00b00616f2381562mr1182445otv.111.1656499945255; Wed, 29
 Jun 2022 03:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:1e0a:0:0:0:0 with HTTP; Wed, 29 Jun 2022 03:52:24
 -0700 (PDT)
Reply-To: dravasmit09@yahoo.com
From:   Dr Ava Smith <misslidko01@gmail.com>
Date:   Wed, 29 Jun 2022 10:52:24 +0000
Message-ID: <CADmtpXnagXBpxBRtQ_q0tNhAzYtC0gaJS=dFcFSnnMjsC2t-HA@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
