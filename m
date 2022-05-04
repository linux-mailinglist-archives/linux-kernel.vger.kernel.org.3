Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B4F519D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbiEDLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbiEDLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:09:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB0240B8;
        Wed,  4 May 2022 04:05:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so4900243pjq.0;
        Wed, 04 May 2022 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FuHzk/nIGePrHZXHu5obeBKL4CwmtgVLQ7B81qaX0ec=;
        b=QEPx7U9hNlI3vRDWKAbDtfXmpeSpovU9WosXOMWPby75hsXz8BF9NJPpYo3SPZmwHd
         n/Gm3/On5FKA84ftZRrEaLUWoxrAPvc/+zBa2+gmMQfMDBntS3YRP0IlNfTaE+UX/o2F
         3QZNPYoUEKMzUZzz+TBxu5FwphTwigrUEW3T4jZxk6uAq/TLtFplG+CR/kJ8zCzXFRXm
         xhCvp73xVaUtWtQfb7uSmfudTePdsyBf9cAeTv/S5xSAmqKOP1PGExdXwVO7Ek8SbpRR
         zgfNv30iDlnORAwDnTuf+PLC0Ek4bma6TSaPA4TrmX+YkG2vVPV07cFmwFyuhbnkkwfN
         m0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FuHzk/nIGePrHZXHu5obeBKL4CwmtgVLQ7B81qaX0ec=;
        b=yWUv9F9O9xFaHPlr2DCC7dPEV1aOCzFracVLQj7RgOVSbqYeAoEsoHlSoCGbBElCtL
         hZsew3t+MiQQaxbLIiaKZqvBzXL9Q/aKtHi6r6yqT5ITUY76CDJADHixNDIHh3oqyMqU
         6jjMCdc9PzEvt1jPlalFbbhtMJjH5iYr+6v2tZEr0wgk+mp9M+jvNiKHRd58toDEtWAE
         VAruiWXGw7zoUgNT8811c1YVxGOOa0JDNMnygPw7AxpK0gCeIaF4GhJtD4LG4q0hp6bZ
         xKi+faxf2qp/ezsxgxKV+hLvU/wdFOTYAUFWrLO2QXiUFNF9Q/KEZezHwPGMoKEK+CpI
         K+Og==
X-Gm-Message-State: AOAM530vFZuEzn15bY0FzBdhgY3ZhlYSsoi5Bs6EBDL/j5dO/274cNLU
        vWdIbnlzs/rr8a8S3PDXapU=
X-Google-Smtp-Source: ABdhPJzxZ+xobWZQq60DnEg27iH6kRN+0zqq2JznY9vhTdiadAjubYEwreH4wT1gnCSEBBhDMd+WuA==
X-Received: by 2002:a17:902:f690:b0:15e:9825:291 with SMTP id l16-20020a170902f69000b0015e98250291mr17327173plg.89.1651662353882;
        Wed, 04 May 2022 04:05:53 -0700 (PDT)
Received: from smtpclient.apple (164.174.128.101.dy.bbexcite.jp. [101.128.174.164])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709029a9800b0015ebbaccc46sm2555977plp.159.2022.05.04.04.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 04:05:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 0/5] docs/ja_JP/SubmittingPatches: Trace changes in
 English docs, take 1
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
In-Reply-To: <20220503102429.48304-1-akiyks@gmail.com>
Date:   Wed, 4 May 2022 20:05:49 +0900
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2146482E-C509-421F-AF7B-C220F8E1614F@gmail.com>
References: <20220503102429.48304-1-akiyks@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 3, 2022, at 19:24, Akira Yokosawa <akiyks@gmail.com> wrote:
>=20
> Hi,
>=20
> This is the first batch of updates attempting to modernize Japanese
> SubmittingPatches.  Conversion to ReST will be done later when the
> corresponding commit doing the conversion is reached.  Pending list
> of commits is quite long (about 90) and this effort is expected to
> produce dozens of series.
>=20
> List of commits for English (then) SubmittingPatches:
>=20
> - f5039935ac68 ("Documentation: update GregKH links")
> - e52d2e1f25f0 ("Documentation/SubmittingPatches: suggested the use of =
scripts/get_maintainer.pl")
> - 755727b7fb1e ("Randy has moved")
> - 8543ae1296f6 ("checkpatch: add Suggested-by as a standard =
signature")
> - 0af5270324cc ("Documentation/SubmittingPatches: Request summaries =
for commit references")
>=20
> Note: Commit db12fb833a88 ("Documentation: fix spelling error in
> SubmittingPatches") does not affect Japanese translation.
>=20
>        Thanks, Akira
> --
> Akira Yokosawa (5):
>  docs/ja_JP/SubmittingPatches: Update GregKH links
>  docs/ja_JP/SubmittingPatches: Suggest the use of
>    scripts/get_maintainer.pl
>  docs/ja_JP/SubmittingPatches: Randy has moved
>  docs/ja_JP/SubmittingPatches: Add Suggested-by as a standard =
signature
>  docs/ja_JP/SubmittingPatches: Request summaries for commit references
>=20
> .../translations/ja_JP/SubmittingPatches      | 36 ++++++++++++++-----
> 1 file changed, 27 insertions(+), 9 deletions(-)
>=20
>=20
> base-commit: 81c653659d34ec253fba7f5d0f430813fe0f643d
> --=20
> 2.25.1
>=20

Resending the response to this patch due to misconfiguration of my email =
client.=20

For the series,

Reviewed-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>

Best regards,
Kosuke=
