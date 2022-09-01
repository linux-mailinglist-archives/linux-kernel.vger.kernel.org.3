Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623C5A8DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiIAGBG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Sep 2022 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiIAGBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:00 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AEA50F1;
        Wed, 31 Aug 2022 23:00:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D8534632FA9B;
        Thu,  1 Sep 2022 08:00:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1ZOMFAHt6mKt; Thu,  1 Sep 2022 08:00:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5D123632FA86;
        Thu,  1 Sep 2022 08:00:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ddJBtG8D8sk; Thu,  1 Sep 2022 08:00:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 37FC9632FA85;
        Thu,  1 Sep 2022 08:00:55 +0200 (CEST)
Date:   Thu, 1 Sep 2022 08:00:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     masahiroy <masahiroy@kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <318503440.165958.1662012055078.JavaMail.zimbra@nod.at>
In-Reply-To: <20220901011252.550830-1-masahiroy@kernel.org>
References: <20220901011252.550830-1-masahiroy@kernel.org>
Subject: Re: [PATCH] kbuild: disable header exports for UML in a
 straightforward way
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: kbuild: disable header exports for UML in a straightforward way
Thread-Index: Tadpx3Rgv4hYtC6GLrek9Km8JVUDNQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "masahiroy" <masahiroy@kernel.org>
> An: "linux-kbuild" <linux-kbuild@vger.kernel.org>
> CC: "masahiroy" <masahiroy@kernel.org>, "Michal Marek" <michal.lkml@markovi.net>, "Nick Desaulniers"
> <ndesaulniers@google.com>, "Randy Dunlap" <rdunlap@infradead.org>, "richard" <richard@nod.at>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Donnerstag, 1. September 2022 03:12:52
> Betreff: [PATCH] kbuild: disable header exports for UML in a straightforward way

> Previously 'make ARCH=um headers' stopped because of missing
> arch/um/include/uapi/asm/Kbuild.
> 
> The error is not shown since commit ed102bf2afed ("um: Fix W=1
> missing-include-dirs warnings") because UML got
> arch/um/include/uapi/asm/Kbuild.
> 
> Hard-code the unsupported architecture, so it works like before.
> 
> Fixes: ed102bf2afed ("um: Fix W=1 missing-include-dirs warnings")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
