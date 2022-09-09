Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A255B2DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIIFLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIIFK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:10:58 -0400
X-Greylist: delayed 141625 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 22:10:57 PDT
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E9BC59E3;
        Thu,  8 Sep 2022 22:10:56 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2895Ahiw020701;
        Fri, 9 Sep 2022 14:10:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2895Ahiw020701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662700244;
        bh=Cf30ickxz8oHveT9Mo7QIyuz73tFj/0Da4C1/WMN0qY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gktZQJTF8WNoxxUlnbMx74o+NJvLOOoot/39hpmnjRRkjC7dePuAJLOFqyxwJVO7B
         /stEyEw8okTFRUBcdVnB3IKTxKfK4KHQRJx6EsKfgqmFrA+U+QZVNKtiE4EUmX4UgE
         S9WS3vpk7ksD+8y6T1flbiVoFRaS1Mb5/b0vIn+dYn0KKKWSa4phFIwkX7Is4AJRkU
         yNErRza1glLeC0KiboU2TSoc/oqu8z8Pl/6xp7xLdxdf5qN6sFHzmHoibd1gKzcgtO
         MS28v0oCt9rr7TbE/jA9ArAYxfB5rGVoLsFjnGoh4rjrEquo3lBj5yMQo6njEws5QQ
         GZLCoFXW7NX8A==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11eab59db71so1175296fac.11;
        Thu, 08 Sep 2022 22:10:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo3qIXUrmaKqb/BgHPFD/H0aIRWYYdUzkNnnhnkEc3yVMVzM25ft
        rCRsqkmiQajVSQ8OWmWN4Q/Z7RvX2Y+c7bAFFTA=
X-Google-Smtp-Source: AA6agR4wCAOPoePZj7f7sc9FEjARZo2ozA5Fjx+ewWZ7NNDn4/RHrQA8zOBwtDY3Meb+ggLvbmSX9gySzvfxkaFiJmg=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr3812627oab.287.1662700243127; Thu, 08
 Sep 2022 22:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220909090024.47458048@canb.auug.org.au>
In-Reply-To: <20220909090024.47458048@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 14:10:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
Message-ID: <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
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

On Fri, Sep 9, 2022 at 8:00 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> allmodconfig) failed like this:



Hmm, I am testing allmodconfig in my tree,
but it is not reproducible so far.

Do you have any more hint?
(which commit exactly?, and what build command did you use? etc.)



> make[2]: *** No rule to make target 'objtool/objtool'.  Stop.


Presumably, it is failing in tools/Makefile,
but I do not know how this can happen...






> make[1]: *** [/home/sfr/next/next/Makefile:1361: tools/objtool/objtool] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:222: __sub-make] Error 2
>
> I have used the kbuild tree from next-20220907 again (with the last 4
> commits reverted).
>
> --
> Cheers,
> Stephen Rothwell













--
Best Regards
Masahiro Yamada
