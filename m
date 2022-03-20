Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880464E1C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiCTP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245419AbiCTP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:23 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFD54194
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:56:00 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by gnuweeb.org (Postfix) with ESMTPSA id A68447E2C4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647791759;
        bh=MUkfzPrle+kb1qYPBpYlCE1LTNjiPsoixowosGS7nsA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rzMkkXtRmMr1W5s+aSU1JiQ8ibociU8exrReBgL86vaELhs27ausvcszlN3A4JGVD
         b/CAEoVOAektHKqTpXuX+eZ5ucFWPj/NTg3rzOk6eqT+UIAH9JeX7AE0pFXIB/Ucxm
         wiK1CQca+de0mIsJLv2er+EJud5rbZ2BeSfXl58iTLOn+6v+aNH0SGUel+MfSoa6Db
         WtHoV8MYuz+8KhLPLT9hgrNQsq3pwNytqmp4JupCmcn+hESQ39yhPomt9H0pTLQH/e
         W6MZAISY/XQGYXdlbYP+dH5ptcFfQg9cdaj+mqKWAMHLw7tXWF6+CGawP907KFt0f5
         Xw6aglT/G4d/A==
Received: by mail-lf1-f41.google.com with SMTP id e16so7029093lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:55:59 -0700 (PDT)
X-Gm-Message-State: AOAM532U4Eu2OLE13xMwSJ+Vcrvwxu7LcqHP4S/ktL1qFXHV+mWou2y9
        /mpJCDhdR/lwqpDvGS3YcV2g/yblRNJHqctbMwk=
X-Google-Smtp-Source: ABdhPJyi66E5LNkV2GYJBrRGfMSl8Uczfua83fXipEG1krylx/uA3kfQ2Pj/GGE/YO1BV43AP12cyKYkbXX5LxtmaVI=
X-Received: by 2002:a05:6512:c08:b0:448:56a2:b936 with SMTP id
 z8-20020a0565120c0800b0044856a2b936mr11559647lfu.636.1647791757801; Sun, 20
 Mar 2022 08:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org> <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 20 Mar 2022 22:55:46 +0700
X-Gmail-Original-Message-ID: <CAOG64qPc7ZT414CS6HoYF+mvDgYGomFCSpMqsb_FznnwHjU6dA@mail.gmail.com>
Message-ID: <CAOG64qPc7ZT414CS6HoYF+mvDgYGomFCSpMqsb_FznnwHjU6dA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()` and `strndup()`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 4:37 PM Ammar Faizi wrote:
> +}
> +
> +

(Trivial) Got double newlines here, one newline should be good.

>  static __attribute__((unused))
>  size_t strlcat(char *dst, const char *src, size_t size)
>  {

-- Viro
