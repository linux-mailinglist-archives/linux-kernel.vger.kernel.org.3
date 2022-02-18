Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59F4BBE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiBRRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:18:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiBRRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DDB5EDFF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0iJFnqxw5ThWeOtkJ+J7gr6cY99ADstdDp+qUWNpHuQ=; b=pkwTHDaTjX6x1MJvAebDs3oPt1
        zAeKbiWXY2tw4mBVia5ozhKsM0rHtJ1TAUThh3BsnqtzycuWT8FKS+1ESXGxqgrTe3LS7Ufgot3Ro
        J1ywIXLx5N3zbcPaUnGdup4YBQ6Jh5V8NYgu0Aqcol2hYCTB2KWA2Bd05fXa8Nyb9zA1fTkdWPFwp
        tkLGr0r2vTOmrFSWRoJBZJwR0MbH/jeWV8GmA/svS5FCcV0DTTv2I+vKd+ZurbbXOvvklAQRsV42h
        Xv5+9U54MG0PV85G9js7OUvlue3RHxJSlquylzaIMv9mTNPBdIpG93t4I2AUvKKrd/zzAXv89zokc
        SWTFJeUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6tI-00FNCI-Pr; Fri, 18 Feb 2022 17:17:56 +0000
Date:   Fri, 18 Feb 2022 09:17:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yzaikin@google.com, sfr@canb.auug.org.au, mhocko@suse.com,
        keescook@chromium.org, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] mm: move oom_kill sysctls to their own file
Message-ID: <Yg/UxAv9foTXvlel@bombadil.infradead.org>
References: <20220218025149.40A8BC340E8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218025149.40A8BC340E8@smtp.kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:51:48PM -0800, Andrew Morton wrote:
> From: sujiaxun <sujiaxun@uniontech.com>
> Subject: mm: move oom_kill sysctls to their own file
> 
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we just
> care about the core logic.
> 
> So move the oom_kill sysctls to their own file, mm/oom_kill.c
> 
> [sfr@canb.auug.org.au: null-terminate the array]
>   Link: https://lkml.kernel.org/r/20220216193202.28838626@canb.auug.org.au
> Link: https://lkml.kernel.org/r/20220215093203.31032-1-sujiaxun@uniontech.com
> Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Queued on sysctl-next.

  Luis
