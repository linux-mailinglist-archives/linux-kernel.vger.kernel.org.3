Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE25A7254
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiHaAUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHaAUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:20:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4066130
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:20:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11dca1c9c01so20753626fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=r3UDywg7SzSP8lAjOmZNa7pGOpHyE6/AGndbPKcXCmE=;
        b=bzVuZjsb/GbRdHuxaQjyUdoyBLSF+gq9Eh4rN4q+6+hC1N1zwJnwVT0LYde7+wmpTj
         Pk4eXS3foj3JLK0sxxlcQyjxMpGRkUUg6q5aeqLRthXQIwMiqArr8kev7r0ppBBloeTB
         ZN9aDjIqskVgS/KqfHDPj41Umu3SITKi4PAKzkGS8qdtslfuXfR9S2lfszNPPtAUrVIQ
         Bh7Jtys7EoRvHvZ2+nlBFWg/Yo8Sq2xwJPSr4xSwZTa8TcwFkJferwJK03yUe2cQcoMv
         Rimm2lqskmSgDJ26iYqEMbRUURBuxzpz85Md4Ckyly/GYMY4VtVhqXI5W6RTtGJ20Rt5
         3fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=r3UDywg7SzSP8lAjOmZNa7pGOpHyE6/AGndbPKcXCmE=;
        b=x/1JNz49UQFZHP4ZNx/XVjyM4iYBU/jszKhUCa2WXdNRf4ysIXqmGNLn+lC1IiN3m3
         1NW/SaH54u8U7T5Zwzp5EGDtl8itiXZh7FtRdBPxiI4fFQV55UFJ/lWjJ7GdeKSL1XjV
         s0K8sMwuzGOYiseaXwId6wBckZ9Gr9wcN49Sm5mEOcBwYNPqsxKZEiqw/QeXbfOP9kgo
         XmgbC9+89E63608bnNEantMcWiozth2wfBzngHmP9bSsZrUriM0ta4vtxSbN/WnK4U6c
         npC4q0ScJhl/btY7bE/1CcIz5eNXMgJ10twxpcfmqn1Tt3DLrsYQqy27/Z0fjXI/rhbZ
         pa1Q==
X-Gm-Message-State: ACgBeo0KzawqV6NsL1Zs/A8oXmn+Mp6rufjDBdOtoU+D/sY2y5LrZo6L
        1/6Yvg91ASG/+OdwT5/dFEBrpz8RHGCLMzyJ8OU=
X-Google-Smtp-Source: AA6agR62mmc2S08xI6FO+VBQIQ3CyAM+TxKO3ABv0UrnUPNo5vtWbOEhhvq5Mdr1OebdHmg+Nla78MZnDKmEclnTeN0=
X-Received: by 2002:aca:c287:0:b0:343:402d:950a with SMTP id
 s129-20020acac287000000b00343402d950amr209371oif.245.1661905236101; Tue, 30
 Aug 2022 17:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830105001.68478-1-wuchi.zero@gmail.com> <CAHC9VhSq7P8oHE5dQXdaYx33yMBFEASKgRngSZyNYMr96UYT_A@mail.gmail.com>
In-Reply-To: <CAHC9VhSq7P8oHE5dQXdaYx33yMBFEASKgRngSZyNYMr96UYT_A@mail.gmail.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Wed, 31 Aug 2022 08:20:24 +0800
Message-ID: <CA+tQmHDoGjLsq74cifBpe1LvpN3MKYW0O5J9pX=vh4VVHoir8w@mail.gmail.com>
Subject: Re: [PATCH] audit: remove obvious unnecessary header files
To:     Paul Moore <paul@paul-moore.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 01:04=E5=86=99=E9=81=93=EF=BC=9A
>
>
> Hi Wuchi, can you explain what process you used to determine that
> these header file includes were unnecessary?

When reading the code, if I don't found the user of the *.h in the *.c
file,I will think that is unnecessary. For example, #include
<linux/kthread.h> in the audit.c, I don't found the use of kthread* in
the file.
But, I just build that without "W=3D1 " , the after test robot show that I
was wrong. and I don't sure that if it is true to remove some header
files.

thanks
wuchi
>
> --
> paul-moore.com
