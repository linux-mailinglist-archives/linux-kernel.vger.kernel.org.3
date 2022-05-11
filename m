Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B4523D63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbiEKT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346836AbiEKT15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:27:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE038790
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:27:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a30so3861655ljq.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SW6iq+qYhyOT6jikrCxFTwADR0TMZdkkRDPETazGaSM=;
        b=nB3Xvk21FevH9/hA9Yk7i5EiWu5T7wG775A1abZsEReiLLe3bbhxjmdCJPypSFradb
         cFh5Gp4yTjPKn9AaewWZ/cnRXM3lpD1ZJfEq+C2UO7zBZ8d9EccVMseanvn4dga9Wu1t
         VPzaF/qFDbZQqFB1CaIWIXSzVB1K9OkNxjty5qGxMCBa0C0Y6lvequVJsxLt6qMJOrpr
         Pxuib0rhCsTJUsdyArRGSYyQOpbdWLQqEDdIqWh/RtIEfieUrbha3yEGRWYWj3W68NHV
         3R7XHUO0/HGijPUcjkbZtAATUyb7CrfyPk5orQ70v0A8YyGJ0bd/Jd7GmtiPm6uygzfp
         CIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SW6iq+qYhyOT6jikrCxFTwADR0TMZdkkRDPETazGaSM=;
        b=hOaWIS05Qf6f+NMAvE8QsAtvhHFIC6otCElqlopWgrVio7I4keF4UNhB3Pgmbg3YIm
         gVzdx6DQJ8UudcvFO8effXhhOLrHM4r3Ui+WLOxzWS6bQ62yN12jfY/9nEegn7vs4sR7
         t6SA1fGj6FiECXf86l51jFDA5AXPXz2uDDtNX4qyRFCeNn8JH+Mui9O+ygWTR+NXf1lV
         vw+3Id/6+kMNSy1o5jcPVJ5Fq6y2hDH1wiEbxxF1K9ghEYTCHz2YZpTDAAvUS0Wc38LD
         z2Kh5hZr+ld80TFLdRlumDtfejD9RtdjYj05VvGFsUmW/m1/fq/vXcS7mZLyAYOFExCn
         4ASw==
X-Gm-Message-State: AOAM533TYJI3S50Q7TXxQNLCL+1uE44F2Tt4SfVj7MjNgahzuIVBEF2t
        rFdd/EkMp3DOVTFqFyVj83tTDDJkwI4RQoTlqw7EBQ==
X-Google-Smtp-Source: ABdhPJydB8FVx07Gzpsea2mcu0GzM5Al7+CTg9CTEqkX8nYWBBx0ISM+XN60+ObYsYrs9KAMSUaYIZ1zXLZ2/xAGu8o=
X-Received: by 2002:a2e:a7c8:0:b0:24f:700a:4df5 with SMTP id
 x8-20020a2ea7c8000000b0024f700a4df5mr17838500ljp.472.1652297271133; Wed, 11
 May 2022 12:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-9-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-9-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:27:39 -0700
Message-ID: <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] scripts/min-tool-version.sh: raise minimum clang
 version to 14.0.0 for s390
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Before version 14.0.0 llvm's integrated assembler fails to handle some
> displacement variants:
>
> arch/s390/purgatory/head.S:108:10: error: invalid operand for instruction
>  lg %r11,kernel_type-.base_crash(%r13)
>
> Instead of working around this and given that this is already fixed
> raise the minimum clang version from 13.0.0 to 14.0.0.

Do you have the commit in LLVM that fixed this? Might be nice to link
to the particular commit in the commit message. Either way:
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

(Thanks for the series, will pull down and test!)

If you have a github account, let me know it if you'd like to be cc'ed
when we wire this up in our CI.

>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  scripts/min-tool-version.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 53fe64856015..f1e8358ec19a 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -24,9 +24,8 @@ icc)
>         echo 16.0.3
>         ;;
>  llvm)
> -       # https://lore.kernel.org/r/YMtib5hKVyNknZt3@osiris/
>         if [ "$SRCARCH" = s390 ]; then
> -               echo 13.0.0
> +               echo 14.0.0
>         else
>                 echo 11.0.0
>         fi
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
