Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A45A72F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiHaAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiHaAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:49:26 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142AAFACA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:49:15 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11f34610d4aso10022730fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=iDNoZY/hBvrGVH9LpbmO3buefvxj4JAfYTN2Wri+2DQ=;
        b=pq9DkG8LD0vyPgq9WEPXiu3U57hBtkreyHiQfOfFNA0Cos7XvxQ/wPHSwUGtZz02d7
         mjjT5FVEOvaJ9leHUROlbXUUna04rmTV9RqJLdb1D7sLbEdATfkgnu3GzeFgK4Sg8aVq
         uAbYTbyCKoY2qJ4A8ENUXYx4V5na9iIYjZGy0nmKN+2lNHSf9/tGbLElX+QezcRa+mzR
         z4ClE+aqxF2OwjmYvzM4nOBvhsbC20DofQ1+EWeet39lPKxjQJuYOFVpiviJp9vMAY/X
         4neqjMpsnVxtABiGkzvKni1j2uTIyPyexUPhFkPzYm5/+bpGUu4iONyCLm2peGlW0lm8
         yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=iDNoZY/hBvrGVH9LpbmO3buefvxj4JAfYTN2Wri+2DQ=;
        b=RN4FlBH0s3fxRXXKWPBkhUpiErOss02Q34daAsRz8pqD30qUVgHfMdxm+qzrjAvV1a
         CPOCRUL18znTPT1FZsU+30l0G9OheqWgU7QlJBHjdaXyhCPWnopYuSAuLSoaJkt+4VNN
         bNPPssRL6oeg1ATHUHRSNE1Fj7rhJM8MHw0PHzCgC7Bhin/DOLvPYTaEzIbAe/v4WKrw
         hAqa5A3jJBPZGBDKHYH0goGFv95dqwCHfhngJ1VkaiGMFhMtQqMJo/HI+V117JfoQ4RN
         QeehIzmR5eoqfUKfgOcNBACm1Opj4UMF4epa23hOf4Z6UBpgx1VxpgBVblnxLfVFmOge
         X+gQ==
X-Gm-Message-State: ACgBeo3FcIcPG6ASj9xlhKAJ0Tif0r5yfsB2+R1EKbpDFvjV8oNmXuc4
        JD9VBa+JZCd+uTgrI9GpljcQV80xkKc+/4eT3YGX
X-Google-Smtp-Source: AA6agR7f1XUuWYsXWLmnvTy0fEROtU/LN1joOGlwOIGmh42zEcYAcEHYs30wYP49Fh5gUV322D7byAz3wqmMYGexfko=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr262314oie.41.1661906953828; Tue, 30 Aug
 2022 17:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220830105001.68478-1-wuchi.zero@gmail.com> <CAHC9VhSq7P8oHE5dQXdaYx33yMBFEASKgRngSZyNYMr96UYT_A@mail.gmail.com>
 <CA+tQmHDoGjLsq74cifBpe1LvpN3MKYW0O5J9pX=vh4VVHoir8w@mail.gmail.com>
In-Reply-To: <CA+tQmHDoGjLsq74cifBpe1LvpN3MKYW0O5J9pX=vh4VVHoir8w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 20:49:03 -0400
Message-ID: <CAHC9VhSPdD_tJYhynK=a3JcuU-2ez1S2VCUXLu0DJbWCn0-8zQ@mail.gmail.com>
Subject: Re: [PATCH] audit: remove obvious unnecessary header files
To:     chi wu <wuchi.zero@gmail.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
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

On Tue, Aug 30, 2022 at 8:20 PM chi wu <wuchi.zero@gmail.com> wrote:
> Paul Moore <paul@paul-moore.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 01:04=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> > Hi Wuchi, can you explain what process you used to determine that
> > these header file includes were unnecessary?
>
> When reading the code, if I don't found the user of the *.h in the *.c
> file,I will think that is unnecessary. For example, #include
> <linux/kthread.h> in the audit.c, I don't found the use of kthread* in
> the file.
> But, I just build that without "W=3D1 " , the after test robot show that =
I
> was wrong. and I don't sure that if it is true to remove some header
> files.

Yes, I would recommend that you focus your time and energy on other
tasks within the Linux Kernel.  I'm very happy to see patches which
improve the audit subsystem, but I don't believe verifying the header
file usage is a good use of time at this point.

--=20
paul-moore.com
