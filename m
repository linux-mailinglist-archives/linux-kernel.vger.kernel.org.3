Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7369C4C979A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiCAVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiCAVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:15:48 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F228AE6A;
        Tue,  1 Mar 2022 13:15:06 -0800 (PST)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mf0Nm-1nr4vT01Iw-00gZTN; Tue, 01 Mar 2022 22:15:05 +0100
Received: by mail-wr1-f44.google.com with SMTP id bk29so5176100wrb.4;
        Tue, 01 Mar 2022 13:15:04 -0800 (PST)
X-Gm-Message-State: AOAM533T2PJZ0bXLcQ0Wx6xpkNfgq76avtl9Z3mvIUHFHpEylg2/zici
        Gxej40H+vt+4urfco9MpOKXvXXxAzmkvnU7oNR0=
X-Google-Smtp-Source: ABdhPJx5ed75xOYOqXWUFnTe2HbqlLYQT/i2bugoE3zanHbb3BgbR9ZtPWPu8dxYwnBDZQYhbksi06SlEg4363p0VtQ=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr20842737wri.219.1646169304578; Tue, 01
 Mar 2022 13:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20220302075602.0ea0de3d@canb.auug.org.au> <20220302075708.73e2d8b2@canb.auug.org.au>
In-Reply-To: <20220302075708.73e2d8b2@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Mar 2022 22:14:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Vq7=BokX24O_9AfhRZR8zXLC3BRzyBceAnDgx0mnTag@mail.gmail.com>
Message-ID: <CAK8P3a1Vq7=BokX24O_9AfhRZR8zXLC3BRzyBceAnDgx0mnTag@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uKX+Ctcp0ACODbHowwAmw0FFoLb7WJrWrwT8qPuzsTVeuE7Eksq
 IERjFHDpGHv1Jjc19djVTKlK2aSHZ8I8ZktJIacqrfewadHv/fIVNWQptpDsuvlkERGdXzJ
 8pXDV4lys6N5DiS204NhCmvf1BP8O+SB9ZjLHsY+fVDan1es0ClUJ27oMk79xWVEnKd+1Bs
 5uBljGEk9FwU29C+XGSMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QvnO9JxdjaE=:wqFvs27ue0Q5OaADQJh7HE
 uuC+X+TA1PAUHXyr9bnFgp84LpbCdTo83o4sT1+rGMXMjVzLHj8uLksRkr6Iu3UK79YMkDfwl
 rvqxC3MiDLzY6weOis2ZiBjRjSUmJQrZzd6iMomGz0agL6ycL2WI1ye7p9gYtgb6eQ7hFkAC5
 b91hsVoxwA+lbFBSiTz0MII1Rcg/tyjP0/RG+S2XKeIS/ypgUVhRRKjPj3revEIFuZxHE5bdR
 TazJ+bIXtscXMQcvigajv9hCoyyp4Q0pPB6yZbn/W6jdGOcYPDnkKrz42uGAj8M6XSqmEsesa
 ahIO3ZDI+8j8Hij54kNlkPi8dmHqGXFp/QVUiHnjp9ZIwZmcc5z5MGNukRnAACj/DdLcqMRap
 gb9aH6Hqcv09RHCFtiLGRz4Nj3bqJ/E+eN+Abon9MT8qHUV7gycote66aJDmEZPqA2rj1ye5D
 3YJ9vzsEtsVs7JmhJMuiVh/GfkbBCaMEFki0nC6zrm6pUvqoJ2UAj5Bxh051PQha/1CWOahD4
 DutZeIy2+riWiuorxsnNl8UrySP2tHApEO/l4Gq/40xA/x5KdYcAqdPBgZJoiNzaYYu7mC2bL
 7h/26gsgOlqsU9OWTjaUyFvTemqu6bMn0E+eIjthKLXPsgYARNWyDRLywBpiG0jN+Rr9YIw1U
 ngSSRX4b54qm3NTRD8tg7lnBcsNiUh8eY2oUgjvIgI2CPEfxvnVbOkpHAZ7BJoCNrqQ/+kf81
 ia8ziXcKBTMse9ab8IOK3EnHHboh3mdHFwqwNmQdTUKWym8WTmnFJ0UAEzT4nZ8PvkYj4WFBw
 3iO6lAlrDTa5q5sp3TxkGzNKwkhhsxR4IjEFxOkg5P4rZaBRRw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 9:57 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Wed, 2 Mar 2022 07:56:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Commit
> >
> >   8fcc54796bdf ("arm64: dts: armada-3720-turris-mox: Add missing ethernet0 alias")
> >
> > is missing a Signed-off-by from its committer.
>
> That is actually in the arm-soc-fixes tree.

Thanks, I updated the arm/fixes branch now to correct this. The for-next
branch still contains both commits, but only the new one is going to be
part of the branches I send to Linus.

        Arnd
