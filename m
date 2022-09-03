Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3635ABEC0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiICL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:27:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24866567F;
        Sat,  3 Sep 2022 04:27:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e20so5247191wri.13;
        Sat, 03 Sep 2022 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EmU59MN+6K34M9EwQYG2+BwMgpga4l/iY2fhPDKLmRc=;
        b=hSAbzxumnZnzExCYTDSIVujCMbMlE0EUIID7MQDUE7MbJewg7VCMGwHeRemKhlfQLn
         IJAu4lvzZPoq8iguRRdrNJncYTQHt55ovS9CH9XIUd7IgZzmcM5+P1iRkA6oHrJFEsVV
         AyjUARPJzei9TRcmq0MZS+nznU6lRMcChJzNzCF+TJGtUx8lWd3dRXZfco4sLhNuGNc6
         DwVQiuAIcAECsy3elh2VE2Xi56nAFOCv2cpOm5eY8VlCknh5pm1pL7EFcKIcf07WW4Jg
         Ys+/T1YMlMZFQK4yAmQeKL5jVt1fwoNClMRD93Agck9PA6rgjv+OOtH29TAhD4jAw2hv
         GeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EmU59MN+6K34M9EwQYG2+BwMgpga4l/iY2fhPDKLmRc=;
        b=dIo7inSNobLekfMT6hrckF6hpg5cTrTTKDHGDdgmyxthgO8fGIQrGmc6nUEhXiOjBS
         NoZ8Ev26ZqMMme8GQfBoekh3jWfCI+h4g5hUKlLLB7zZPp9cbtUtagyjZR+gtsgl/FDg
         a0DF824qBEfOGia51eRvHLW1EEeO3ykJltXiWAF9VFPHDGooTM6SCukzbv70CuqtO7mQ
         HKgM0sFIGVlaz/OAfKEkLXUtqX6ZTGUS7IjH9PQAOPrHPUF/1sYpj5mAO4fT3lO9pJmT
         ttI/ohR4CfDSoljCJaoN999jz6W8bs56Ui7fUs+RxW72cHoojfm2U9XnE4fRQVfzd4Tt
         nlCQ==
X-Gm-Message-State: ACgBeo0mkhhbSCG/LrUi6J1DRL4JJVhBC6ArEX9pF14W/r3B7IucGi4O
        JDobPzQHnkqYwlJAsinrlU6CO1V7Vk+jJKA9+8M=
X-Google-Smtp-Source: AA6agR428P9wSKk7anqVI/U0bPEeV+hWZQDa6jMyx4H339/sOp/UqNtKEPb/8/vYwTDP2RMkTm8/t5z3Y65V1a69kDk=
X-Received: by 2002:adf:e845:0:b0:226:d461:9cf1 with SMTP id
 d5-20020adfe845000000b00226d4619cf1mr18050662wrn.136.1662204458140; Sat, 03
 Sep 2022 04:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220903015340.7336-1-linkinjeon@kernel.org>
In-Reply-To: <20220903015340.7336-1-linkinjeon@kernel.org>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Sat, 3 Sep 2022 20:27:26 +0900
Message-ID: <CANFS6bbqb54E7HQCyEYASiku-1Vs+JkQhiY2AbJqwcaLNTFPng@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Tom Talpey as ksmbd reviewer
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        Steve French <stfrench@microsoft.com>
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

2022=EB=85=84 9=EC=9B=94 3=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 10:53, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Tom have been actively reviewing ksmbd patches as well as
> smb-direct patches. He agreed to help us as a reviewer,
> So adding him to reviewer list in ksmbd entry.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f512b430c7cb..f7ccb9abfe86 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11070,6 +11070,7 @@ M:      Namjae Jeon <linkinjeon@kernel.org>
>  M:     Steve French <sfrench@samba.org>
>  M:     Hyunchul Lee <hyc.lee@gmail.com>
>  R:     Sergey Senozhatsky <senozhatsky@chromium.org>
> +R:     Tom Talpey <tom@talpey.com>
>  L:     linux-cifs@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.samba.org/ksmbd.git
> --
> 2.25.1
>


--
Thanks,
Hyunchul
