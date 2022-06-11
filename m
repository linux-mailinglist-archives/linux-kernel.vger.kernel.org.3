Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333F1547306
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiFKIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiFKIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049AB9D;
        Sat, 11 Jun 2022 01:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15AFA61325;
        Sat, 11 Jun 2022 08:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721C3C385A2;
        Sat, 11 Jun 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654937438;
        bh=A9gpMifzyyUAuCAAynI4SJ22zYCLX+DmtB9S3Ie03Cg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pclBJxcd0SMR/gNbCxVd5rugE1XPpo4Z9r2otpgA619ywInM5jZMolLvFw+xfCGTE
         IjUBKpmrCFQLQkr+t8gSvdyT72yFBkF4sS2qjFPFTAiXIDdRRvoSpRxlUuiLJoWGR5
         aP8hksJ+iikB2pM5IjFRy+ds68/8vF2fyIexgdr/Szy1FbF0xEDVzkociDONTpQZge
         ioT6MFpxduupsAI4sTxKzYSvP3SFm2l5AcESfjEOCwrz7nfSwpHYx3lanPqrBvbhMX
         49BqFO1kBJC6+Cs7oBVtMnjQfoW3dQSWkxQPw1J252mR+9phzIHAXHGOQ/na7R2CC8
         uUb7bX3PqhvBg==
Received: by mail-wm1-f45.google.com with SMTP id q15so553764wmj.2;
        Sat, 11 Jun 2022 01:50:38 -0700 (PDT)
X-Gm-Message-State: AOAM531pszpnlBXvf29xMS4Gqx7RtWBmPVrkpQhhwOwt4LmBUh4SgDWE
        xLVntG/F8mH2dh4tTsyPPAacObCUpXzfDJ0CPgc=
X-Google-Smtp-Source: ABdhPJwYziB7c5nQc07ZX0uu4ZzS2qaW7GSxMJUB/0PkpUYU3eKdEGbFKJaLBNGrWPlKiAvGB6dqhoDn56dA914OepE=
X-Received: by 2002:a7b:c057:0:b0:39c:4579:42e1 with SMTP id
 u23-20020a7bc057000000b0039c457942e1mr3815263wmc.102.1654937436686; Sat, 11
 Jun 2022 01:50:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c4a:0:0:0:0:0 with HTTP; Sat, 11 Jun 2022 01:50:35
 -0700 (PDT)
In-Reply-To: <f9540b1a52a5d20ccfdc9c59e8016dd6a32a5b9f.1654936354.git.christophe.jaillet@wanadoo.fr>
References: <f9540b1a52a5d20ccfdc9c59e8016dd6a32a5b9f.1654936354.git.christophe.jaillet@wanadoo.fr>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 11 Jun 2022 17:50:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_cQcwgvCWuikRVsCabOeXvACgY6jy3ioxgDeWbzDovZA@mail.gmail.com>
Message-ID: <CAKYAXd_cQcwgvCWuikRVsCabOeXvACgY6jy3ioxgDeWbzDovZA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: smbd: Remove useless license text when
 SPDX-License-Identifier is already used
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Steve French <sfrench@samba.org>, Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-06-11 17:32 GMT+09:00, Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> An SPDX-License-Identifier is already in place. There is no need to
> duplicate part of the corresponding license.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
