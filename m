Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010AD575E79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiGOJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGOJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:25:21 -0400
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 02:25:19 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234FA7A519;
        Fri, 15 Jul 2022 02:25:19 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 15 Jul 2022 11:17:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1657876648; bh=0IekHBlcmPpyzZw3GYC5sqAejwnOmaePZ2yt2T56XvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYk9iigAfGFIhjFfT8I9dJJP0AESz9zHZf9qs9ajY485SduwNO+aAwFcc1V4Gvc6s
         g9q/jkPL6rMAqPyiQQF0DZALuAW0khFjS+iAJXp4XBgNokH8nzC2m5xIEFi9LByzKq
         3s0DIgH5NEQGAaB+6eL3YTh0YGSNehDh0h7QkzFo=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 78403800C7;
        Fri, 15 Jul 2022 11:17:28 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 7358F182DDB; Fri, 15 Jul 2022 11:17:28 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:17:28 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] kbuild: error out if $(INSTALL_MOD_PATH) contains %
 or :
Message-ID: <YtEwqJ2qodSxzjXF@buildd.core.avm.de>
References: <20220714050243.16411-1-masahiroy@kernel.org>
 <20220714050243.16411-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714050243.16411-4-masahiroy@kernel.org>
X-purgate-ID: 149429::1657876648-D1BAA7E9-F4C7D76D/0/0
X-purgate-type: clean
X-purgate-size: 401
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:02:43PM +0900, Masahiro Yamada wrote:
> If the directory pass given to INSTALL_MOD_PATH contains % or :,
> the module_install fails.
> 
> % is used in pattern rules, and : as the separator of dependencies.
> 
> Bail out with a clearer error message.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>
