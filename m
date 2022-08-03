Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC3589477
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiHCWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHCWhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:37:42 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B122BC5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:37:41 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d139so253652iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Z+ddAlCjm79YIkQ6C3CDX8LeNGvGWVNKaDwuXcQrxn+E0VM+YAIacQ0y/xQKZhexug
         cFJTdqRkcw0cUjpL/+vkrgZo/eR+xq6m3QcpphyDpQ+af3nK6pqL3N9mfeNkbzoZtV8C
         vVC1RETw2pxYXIN4EQg+ItziJX/XUwuExKbBoLJGn5irdZjI7tGrZT+2uWxQM9HEFG20
         ONr/VAKr0Imeeua9gmHhw4HFhDDhZvJtYGDpCjQ5ZGYnY0aumzTLkvjGRnAtIgHgc5o6
         97g3CCwZNF+QOV5BEKHHsenoSTpEn+IX1LvIWSSgNg/Z/ekkQbQlnWRi6VagJRbc5bT5
         oHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fcILheWVloIRcZNdzrH2DVKvUE3gfh7hFPKuC+sAtidCnCPc/mg/W40gRgI2aybCVA
         8zlVP97gMFXmn9xfRyA3aeRnV6X+7RMTq8TFyWtH5glx7df8dqsxG3N0MMv6I9vv3y3P
         SXgVTeMHYgMnP/C+jLPRH+nZzvca25ZBjWaNIbtYb6vssFK6JQyYAj/aeCxgWUtsrx3/
         5MrDmhIePoJFp8tq6RAkGU591gEztlSXwXe7cV4sZJXNdWh0vY002EndXD9FHcZF1XGZ
         EL7X7QLkZd8cGnclKoJ6x+UMfLWT0ioI1kTHJZOcOsIyfNlAWDYfRDcN6RZ1qSMTtvVy
         CzvQ==
X-Gm-Message-State: AJIora+ASIuAdvnDMW6Be2kgYYui9qIShcvSy8vC4t/XGljJDnsZcxrw
        GZFAZGjDwdphPbSGnmJvbt/GderWibe0uG5zAYY=
X-Google-Smtp-Source: AGRyM1t2sP+2wZ78P8sck0cKtX63aNS6ehpZ0Kc0JD3hWjwJv0V6lH34Hs5ZEmILVCKyN/+xG+CcKefKHJb6JVpDN3Q=
X-Received: by 2002:a6b:f910:0:b0:67c:4d66:3a88 with SMTP id
 j16-20020a6bf910000000b0067c4d663a88mr10215230iog.49.1659566261383; Wed, 03
 Aug 2022 15:37:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:c455:0:0:0:0:0 with HTTP; Wed, 3 Aug 2022 15:37:40 -0700 (PDT)
Reply-To: buffettwarrenusa@gmail.com
In-Reply-To: <CAEVRjNO4YqeyUqsFeBcjAJ5=-_KU1ssCW4LzzJ0V2D7e93Uh+g@mail.gmail.com>
References: <CAEVRjNNY4eijFV1ZUTXBE8u3hXSLDhTfGp2KyjE7SCy0TooP6w@mail.gmail.com>
 <CAEVRjNNBsp9d1F6AFOgE5adOHE_rFqgEkdK0sPZtfDfdUH_J4g@mail.gmail.com>
 <CAEVRjNOh45AVe=RVFWqapQ9_hLtvqFeh-y+DctMk=FT5AGEM-w@mail.gmail.com>
 <CAEVRjNM8+WNfxsRFtHhckGT3XHLvEtSSbwzf+RGMT0Vi64H0WQ@mail.gmail.com> <CAEVRjNO4YqeyUqsFeBcjAJ5=-_KU1ssCW4LzzJ0V2D7e93Uh+g@mail.gmail.com>
From:   Warren Buffett <georgetteagbodohfalschau@gmail.com>
Date:   Wed, 3 Aug 2022 15:37:40 -0700
Message-ID: <CAEVRjNNWLQNrJXE=qHgD-KbLAKKG9vvW8Qe5LwGCLMX=G6ruAg@mail.gmail.com>
Subject: Fwd: I was wondering if you received my email a couple of Days ago?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


