Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39DA52F162
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbiETRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiETRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:15:43 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD8185CA8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:15:42 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 28AB46172F;
        Fri, 20 May 2022 17:15:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 8E06342;
        Fri, 20 May 2022 17:15:39 +0000 (UTC)
Message-ID: <8d86b87edc9c9fa33b6a18fac8b160ee56e6a07c.camel@perches.com>
Subject: Re: [PATCH 1/2] s390: Kconfig: Fix indentation and add comments
From:   Joe Perches <joe@perches.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Date:   Fri, 20 May 2022 10:15:38 -0700
In-Reply-To: <20220520115708.147841-2-juergh@canonical.com>
References: <20220520115708.147841-1-juergh@canonical.com>
         <20220520115708.147841-2-juergh@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: xmfrcrw9tmkmjw8ohx6e3fjwj4xmiz78
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8E06342
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18+TkFCMkdWt0lCIlALcSjDn4yaCJE5V+U=
X-HE-Tag: 1653066939-396885
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 13:57 +0200, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While add it, add trailing comments to endmenu statements for better
> readability.
[]
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
[]
> @@ -607,7 +607,7 @@ config RANDOMIZE_BASE
>  	  as a security feature that deters exploit attempts relying on
>  	  knowledge of the location of kernel internals.
>  
> -endmenu
> +endmenu # "Processor type and features"

An endmenu comment is relatively unusual.

$ git grep '^endmenu' -- '*/Kconfig*' | wc -l
394
$ git grep '^endmenu.*#' -- '*/Kconfig*' | wc -l
20

I believe it doesn't really help readability.


