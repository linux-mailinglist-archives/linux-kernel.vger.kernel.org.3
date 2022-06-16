Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE05F54D9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358411AbiFPFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiFPFYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:24:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECD5AEE2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:24:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so4632132pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Cgr0NudsllIuU4pYJfPAFPG4b+vxrvwuUcJfymOmGQ8=;
        b=Pz2BlSOI5/961Qe0d6ewdPk8pc1RUtgsiybGmOKnoAw/g6nq0HbH1M3DiKyDIsGtjX
         ahmjk0cFkiAFXz6rO6C3YC45KITyWpz5pO16d2aEeVPkoWMpia+tOq+wiZKQv1sCBMt1
         dIwxbLHNpn7MXkoE0zk/lV5iu2TvRXARi4KWb0xLUZc8CUY5vqEg8m1ZEIEzqLu+jDuN
         9EfZugpl/tebuMl9FlnQSWjlKSlBqWS2yxKCZjpoYmGMWaSTDz5SDceb53meF1DFH3+y
         WDim1NKugD4JTVssBjKYKtUc18bhFZXfba1E1hOU+QudxbmbSUM8pV5eeijRqLYJ7OdJ
         NpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Cgr0NudsllIuU4pYJfPAFPG4b+vxrvwuUcJfymOmGQ8=;
        b=UZLAoYauuXl8guebEhhQiWU7ELrG7HOtNvGpSUW2P1kdX9HjclaUIxJ0JQHqLRVNjK
         ZtUTt3JjVRj2bck1AgxHoQSnHWGgIF87s1b/2zsiBTxsf/2JMUFtnAw9V97XIQ9t2Uph
         T/EprcRyqCKKmSzglDQPplIIM+HfejzvWhiutMCiqSe6t/joGrrMwofL0S7ioBPUWZrk
         U2qhzPLcwZl9jbPcE6KsOye7NhJp+Cg3inU6lBX7pG0L5QkBnhYEXuJVU/tfnxpe+pK9
         0MdNrIo7YLL/OM5Sgx2DsEH25h11XEen4khRPXuixKdQIyoazTkkRJz34Uw40xt+JLRD
         0BIg==
X-Gm-Message-State: AJIora+QOxKnXiaiC7Az2rFEb+o3ccbt3aEXN2mItMSKFqvQPxKL5OzH
        N4SogHqBwK3DMVfpgWvGW+q/d+vOAzhsfpYTduA=
X-Google-Smtp-Source: AGRyM1vkK43W+RqKSJoLv94c/X/RYQb3rffIODZiZJCj3N8RGs98kNRxhwaRu+ub2/hB9Iqm4f0n1KtunJ+xo0z5a/E=
X-Received: by 2002:a17:90a:86c8:b0:1e6:7147:8b4d with SMTP id
 y8-20020a17090a86c800b001e671478b4dmr3196272pjv.45.1655357059365; Wed, 15 Jun
 2022 22:24:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:2d09:b0:65:e0f0:6a34 with HTTP; Wed, 15 Jun 2022
 22:24:18 -0700 (PDT)
Reply-To: abdwabbomaddahm@gmail.com
From:   Abdwabbo Maddah <mr.philipmichael@googlemail.com>
Date:   Thu, 16 Jun 2022 06:24:18 +0100
Message-ID: <CAP_WLbuchP7v21v_h0BUnVmFPuDZU5iMivryo5YPfPrCnObEuw@mail.gmail.com>
Subject: Get back to me... URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.

Abd-Wabbo Maddah
