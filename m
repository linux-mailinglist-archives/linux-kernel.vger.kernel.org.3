Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634B575E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiGOJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiGOJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:25:21 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6AA7B7AE;
        Fri, 15 Jul 2022 02:25:20 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 15 Jul 2022 11:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1657876628; bh=UmMXRp06hwWFNl9ZF+/DETdSf2klmjeRuIt0QOFWKWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9nnTRE9nu5fytrusrTf6PIEUoPH8bVLfT9vah5RV8iNBXm0upphk7Ja+GY3FUTJu
         7CTNoKvlkuicY69baccavY5TshKdfKzwoqt03xl0pKGI9EBr0l/lxaYF8F8FzmwxET
         lWWhRDPrDBMnZ9F0eYgaaWEGuckClipR0o59njtI=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id EA5F380A3D;
        Fri, 15 Jul 2022 11:17:07 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id E0381182DDB; Fri, 15 Jul 2022 11:17:07 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:17:07 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] kbuild: error out if $(KBUILD_EXTMOD) contains % or :
Message-ID: <YtEwk3dV1Zrx85EZ@buildd.core.avm.de>
References: <20220714050243.16411-1-masahiroy@kernel.org>
 <20220714050243.16411-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714050243.16411-3-masahiroy@kernel.org>
X-purgate-ID: 149429::1657876628-8F3FE9DB-EA9F4B9E/0/0
X-purgate-type: clean
X-purgate-size: 407
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:02:42PM +0900, Masahiro Yamada wrote:
> If the directory pass given to KBUILD_EXTMOD (or M=) contains % or :,
> the module fails to build.
> 
> % is used in pattern rules, and : as the separator of dependencies.
> 
> Bail out with a clearer error message.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>
