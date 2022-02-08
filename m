Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989C4AD2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348864AbiBHIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbiBHIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:09:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947EC0401F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:09:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so445876wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ikw43MPriiIAbjOZjzCbDdxoeo6GLo0YMTk+PKI0AMQ=;
        b=p/48KqgkBezydVHKW62KCOR7fRF5aZ8bJ7Vj5qZA5bfYwBfnfi9TKAhktIK8ngNClb
         HmXxYBa+RRqFIgbmP7+d33LkGWz9h4oC/59oQNIl7VlFGfjxUx1LSE3MHaFJxL84QKt3
         a8LJa58g9sCZZ8W6rYPptgncbvigRRvgAVtSi9cgoJjIPBuGbon+mI1cdPWcTkbYwmzB
         ojnUD8kWvypHp1DQ/0WWidUrV7BU5FDPVrv+LnJxJ+xH75SetzXU5jleezoEmlfpjle8
         Hyiqqhy7CaXehaLx7JMJcJdqGQhh2whEE2Wwa89I7tdsf4d/esyPXS2sNbaszS3h/AS9
         iscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ikw43MPriiIAbjOZjzCbDdxoeo6GLo0YMTk+PKI0AMQ=;
        b=Ypk2tHZgNihk30BdyojWPYo7Ih5tyBjT7fl/4Bx71O/+j41GrmItpC3L5OChg70pS0
         cincnFb0z0SWG0i0ri7qH3vWtoEdujbBtbc3E3SdWh0spnMjXCJg6/0/fpozF2my3k7K
         YVgx+QcLzTjjMpHMEEup6MBHTLCDXQTEcrGOTw/vXRHoPl4L5us3YweQohKmdEog5j2S
         0hiCH1D8EfI3WlLAmHHrvjrzLrkSj9yVZjDOdei+xXkGWG35Dj5aNL8/CoHBlJwtGeEH
         bXeaYIvUd+qhyAc/v1AoV0CIJZgDKzEQRi7F/hdQclM74iNE9iLB2Qb3Vo+5EduUlWFZ
         tSdQ==
X-Gm-Message-State: AOAM533OdixCYXa8QMseoBZv/IgX0y7IJBW9iK9PC4QhKl96MeBrn0px
        4ItxYs44SJcUBMzJaIO7g7M=
X-Google-Smtp-Source: ABdhPJzByC8Qgzyw0Yz/LNKRPF6ZW1JT1tyJHCxE+8t8cF66Tkwl/xvUXqulqoZqdB4rwwrF0+a8oQ==
X-Received: by 2002:a05:600c:4f02:: with SMTP id l2mr21703wmq.115.1644307753769;
        Tue, 08 Feb 2022 00:09:13 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id r2sm1840146wmq.0.2022.02.08.00.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:09:13 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: Re: [PATCH] Staging: r8188eu: core: 'associcated' may be misspelled - perhaps 'associated'?
Date:   Tue, 08 Feb 2022 09:09:10 +0100
Message-ID: <2122312.NgBsaNRSFp@leap>
In-Reply-To: <20220207234210.26097-1-leonardo.aa88@gmail.com>
References: <20220207234210.26097-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 8 febbraio 2022 00:42:10 CET Leonardo Araujo wrote:
> This patch fixes the following checkpatch.pl warning:
>=20
> CHECK: 'associcated' may be misspelled - perhaps 'associated'?
>=20
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
"Staging: r8188eu: core: 'associated' may be misspelled - perhaps 'associat=
ed'?"=20
it's not the way patch subjects are created for inclusion in Linux.

Please follow what is clearly described in the "Philosophy of Linux kernel=
=20
patches" document at https://kernelnewbies.org/PatchPhilosophy...

"In patch descriptions and in the subject, it is common and preferable to u=
se=20
present-tense, imperative language. Write as if you are telling git what to=
 do=20
with your patch.".

It's not my job to accept or reject patches for this subsystem and I don't =
want=20
to tell you what to write but, if I were you, I'd send a v2 with a subject =
like=20
"Fix misspelled word in comments" (or something else similar to this subjec=
t).

=46urthermore, please take note that the name of this subsystem is "staging=
" (it=20
is not "Staging").

Decide by yourself whether or not the other two patches that you submitted =
this=20
morning have to be sent anew as v2 with due changes in the subjects.

Regards,

=46abio M. De Francesco =20





