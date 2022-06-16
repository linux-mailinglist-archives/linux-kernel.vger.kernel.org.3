Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5154ECD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378586AbiFPVr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378496AbiFPVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:47:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29012A95
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:47:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso1493448wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2iwmSxW/zurQ/hzT7KH/yGFMflQX3JQ4MQjt4RoS5Q=;
        b=3jlmS1Q08jetad3Cq6sFUbIV8WdH7mMZvOq8U5wJJ7H96dFhSZbMVHiwKtKALLYndh
         qMrFZtNw31+aketY5Zeg0UbPHW76KGatTbUp/y0QoqOIfMuDQC+3g1crwl5isyUfULoG
         /KjYyPYBbORY6WeOL2rZWpkq0cgQACHm4HsR9RnfRCjOlbWmCmgNXsUhqzdzFNDi1+zd
         vFGpg5xeaI9Y9mAKRJSgYOfojgdmO+vztA56d43eIXcJvDdUchvO64bWL5YMtXgaFARy
         kaNUXJSaT2u0uyqwEuJ6urLDCunq/l47Lda3hsyh7NLjSB158GSlQ90lhT+JYm/WAu0R
         7h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2iwmSxW/zurQ/hzT7KH/yGFMflQX3JQ4MQjt4RoS5Q=;
        b=QZJM2YIReajyI/WnRjaOnfvBNXDOLbvZ8Bi9ewrkXRTbAheCxy4+W9b3g5eXW5qbIo
         9oMxcDqsVpBq9tMuF1X0324l0JwxRFg57epDEWBmuv9xoncGFCbcQHgZswso6C9m4DcU
         wV0lQIQQ4XUhqI17v8nIyhItKM+P31MOq7pAInOj8ISz5n9gppcuWOBLlWnEtRGKX17o
         03RvSH5FvIiDjrDeSoJJ8fTOVJJPBzde2UnA5ayqXrgtcRM0UmMDSuBopLi/NbSu2AwH
         uLA6Iqc/ytZIM0emH7zseDsfuwxVN2R4TX73V7UgGHTxSU4qYgkZE3LqAlSCia784dX2
         Fb/A==
X-Gm-Message-State: AJIora/McxWhl3+fy/a1TMLrqILdGJEuaYg8DUFCqyzVNRDJ3BZ6a2Jf
        pqzy4DnAHMYM8k49OoojTZct8DxMHb2+qUdspSiK28B4Lhb9
X-Google-Smtp-Source: AGRyM1tTWflieB4dGBcrTUwLQ2Prn2DZlL6AIl1FW76esmDNIyRNnJ68SimZFRsAgjRj8RYZq6vRPIb81kIerI/aOII=
X-Received: by 2002:a05:600c:4f84:b0:39c:9897:5295 with SMTP id
 n4-20020a05600c4f8400b0039c98975295mr6904134wmq.158.1655416075578; Thu, 16
 Jun 2022 14:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
In-Reply-To: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jun 2022 17:47:44 -0400
Message-ID: <CAHC9VhQFi51nuyMXGaJcYcyQT89tMcizSEVGf39hDaf89QffNA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.19 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
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

On Thu, Jun 16, 2022 at 5:44 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Linus,
>
> A single SELinux patch to fix memory leaks when mounting filesystems
> with SELinux mount options.  Please merge for v5.19.
>
> Thanks,
> -Paul
>
> --
> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7=
f3:
>
>  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
>
> are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
>    selinux-pr-20220616

... that is obviously not the SELinux tree, although it does somewhat
hint that you're also going to see an audit PR in just a moment too.
Here is the proper SELinux tree:

git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
  selinux-pr-20220616

Sorry for the mixup.

> for you to fetch changes up to cad140d00899e7a9cb6fe93b282051df589e671c:
>
>  selinux: free contexts previously transferred in selinux_add_opt()
>    (2022-06-15 21:20:45 -0400)
>
> ----------------------------------------------------------------
> selinux/stable-5.19 PR 20220616
>
> ----------------------------------------------------------------
> Christian G=C3=B6ttsche (1):
>      selinux: free contexts previously transferred in selinux_add_opt()
>
> security/selinux/hooks.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)

--=20
paul-moore.com
