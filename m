Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06705B05CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIGNzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIGNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:55:39 -0400
X-Greylist: delayed 108 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 06:55:38 PDT
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D3112C;
        Wed,  7 Sep 2022 06:55:37 -0700 (PDT)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-04.nifty.com with ESMTP id 287DoWWs003029;
        Wed, 7 Sep 2022 22:50:32 +0900
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 287Do0XI007532;
        Wed, 7 Sep 2022 22:50:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 287Do0XI007532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662558601;
        bh=gAIPR8Y06LZL5uermVk23B9ei5OC6Y1Yhw9VAHpRQZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TA5H1P++AqAV1O5HW+czAVaSv+tMvJt33re/AjUdgeYOAz9w4VyiRPwR4hYTZRRle
         tLY1LFix/SwTdcl+bxX4Wy9n089UzI++gzxvxM4dO8hF6JZVvfhRz6J3aJvnJC7WFl
         rrpmo7qfiDGQ7YjpI9sOgLZGJvHokZAi0Lj5YFMkM6TReAQaTbdd53+BKsBeW3uA/l
         5Nu5r8+TnS/f8zdDFOhp4DFAPRH8pjsCwRj66gobpG8lKz8Wf9l2qeINeoBUPClQIu
         7k/eYSoFF/ag9TJqaxDpaPC5MRPJBpfjBDLiOw77WR7SvMgkqdf3+ZQjQjtM5xEVdQ
         d+UISRgSY9zZQ==
X-Nifty-SrcIP: [209.85.210.54]
Received: by mail-ot1-f54.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so10277576otd.12;
        Wed, 07 Sep 2022 06:50:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo0VvoL74c0Tv877pAinXtMroJDy+k2Jh4fg7H7HA5xm8fPVEXKb
        1J5LS8gjFyASwY11LETU3WOs+0C3t9zvxlrv1Jg=
X-Google-Smtp-Source: AA6agR5PIeipmDoynoOEseujglN7M9iPc9mEEa16XHWK2DxJ5TrbiMG/i9TgzaLBhqriez+BXzcfsYEEyIZKhfN/9Ws=
X-Received: by 2002:a05:6830:658b:b0:63b:3501:7167 with SMTP id
 cn11-20020a056830658b00b0063b35017167mr1458523otb.343.1662558599703; Wed, 07
 Sep 2022 06:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220907223452.7f781217@canb.auug.org.au>
In-Reply-To: <20220907223452.7f781217@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Sep 2022 22:49:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqNU07UEEG_2ff6xTr+MAW-7Ez-7kKLXHd4n8n_0nrgQ@mail.gmail.com>
Message-ID: <CAK7LNARqNU07UEEG_2ff6xTr+MAW-7Ez-7kKLXHd4n8n_0nrgQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 9:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
>
> /home/sfr/next/next/scripts/mkuboot.sh: line 23: 153700 Bus error               ${MKIMAGE} "$@"
>
> Caused by commit
>
>   c4a7f46f7105 ("kbuild: build init/built-in.a just once")
>
> Reverting that commit (and the following ones) fixes the problem. It
> looks like UIMAGE_NAME gets corrupted in scripts/Makefile.lib as the
> arguments to mkuboot.sh change from
>
> A ppc -O linux -T kernel -C gzip -a 0x00700000 -e 0x007015a4 -n Linux-6.0.0-rc4 -d arch/powerpc/boot/cuImage.sam440ep.gz arch/powerpc/boot/cuImage.sam440ep
>
> to
>
> -A ppc -O linux -T kernel -C gzip -a 0x00700000 -e 0x007015a4 -n Linux-6.0.0-rc4 6.0.0-rc4 -d arch/powerpc/boot/cuImage.sam440ep.gz arch/powerpc/boot/cuImage.sam440ep
>
> (note the extra "6.0.0-rc4") when the above commit is present.
>
> So I have reverted commit c4a7f46f7105 and all the following commits in
> the kbuild tree for today.
>
> I had to do the above build with -j40 to make it consistently fail.
>
> --
> Cheers,
> Stephen Rothwell


Thanks.
arch/powerpc/boot/wrapper searches for the version string in vmlinux,
but now it gets two lines.

I will fix up as follows:


diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 55978f32fa77..5bdd4dd20bbb 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -433,7 +433,7 @@ fi
 # Extract kernel version information, some platforms want to include
 # it in the image header
 version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
-    cut -d' ' -f3`
+    head -n1 | cut -d' ' -f3`
 if [ -n "$version" ]; then
     uboot_version="-n Linux-$version"
 fi


-- 
Best Regards
Masahiro Yamada
