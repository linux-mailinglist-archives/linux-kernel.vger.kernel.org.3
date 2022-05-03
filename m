Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD0518C55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiECSdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiECSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:33:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572533CFDA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:29:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c11so14675282wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O//TZ8AQgOTifP2Ve5RKBVYlVaMT99XAuVZDHhF+ZX4=;
        b=t4OWS8r1F2PMxVGmJ7l2BzCN3j9MHsFr0g36f1x+UkP9Mu4fhMx8+F02GuRZiVqcaS
         CBEb6BOfkSt7k8jGNkQSLZGGawWlvmpo2tjX4RYNWVB0mY/DTG7YX6/V2IR9ZCPC9/M8
         zA7RDbXDDIYs76lQgCFo6irnG0tZqj0QvXUCrBqi+lqlEu8WvLYRdnnFsp2fx4Z6kA72
         V1JgYnf79xnfw0uXt28Tb2nsDIax7R2e7YS12EbwOjZc0VUym0BG3Z9eKmypvd9OrPR8
         ZU/ShcLVtaY7M5Pf65OdWdozf/4Ss+xs/ZoTmzstov7CNGichuYU2XqZdhsFDJcuDYgU
         /3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O//TZ8AQgOTifP2Ve5RKBVYlVaMT99XAuVZDHhF+ZX4=;
        b=x0SXm2LyCQACuThchsRD+yTmQbWYM5bwnOsokfgzakUEF3BkybnBMDwZbAPLPiuZUy
         1KSDdoCzHtLEh4D6eSTzQmaRePAxQfWTk2ZwTlyaAqFO82hJc0k+5pLOmBvxDkyjSaFh
         bpcaebq9i1pMuCTGf6zxsbTI9l9BlNh9BwmF8X0YvyNV4M8oby0e8nn3RVhAYk76XHBt
         VnnZ8l9IjzFJ4vz1tydMyr/cq7fW0M9fIeNEN6fMnm3IpIv+KzsxfWYNo8ivLT4ZQdiP
         pHzKlJG3DtFduVib6RHMA05M+lfKcaSEKgAYWympyw03Yd9KAqbnQbV3u3+e53G436S7
         QmPA==
X-Gm-Message-State: AOAM530cqv6Kjda4tVxH4XDAfpz7w7XQLk2/frdu1ygkNGjHd/qpsikV
        ttc0ws+3/OpnyzQfhU/hBASnbL8bz0C4DfLD0REU
X-Google-Smtp-Source: ABdhPJyXJN604FDM5zMX4YKzWSkjZxHuD5oPdFkB8NFvBP7EUSwC+tvj6LTz0VSqArxbIRSRaeV+KNtEIsVMNqgDa7Y=
X-Received: by 2002:a05:6000:80e:b0:20c:5b45:a700 with SMTP id
 bt14-20020a056000080e00b0020c5b45a700mr10114526wrb.662.1651602565860; Tue, 03
 May 2022 11:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220502140547.32685-1-cgzones@googlemail.com>
In-Reply-To: <20220502140547.32685-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:29:15 -0400
Message-ID: <CAHC9VhSyzKTpz4etPx0SMiGx2DwPcDOT7w-2uGzxRZXUbU8KSg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix indentation level of mls_ops block
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:05 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add one level of indentation to the code block of the label mls_ops in
> constraint_expr_eval(), to adjust the trailing break; to the parent
> case: branch.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 42 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
