Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3D4C05ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiBWA1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiBWA1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:27:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C053E30;
        Tue, 22 Feb 2022 16:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HgX98OwrP9QUu0q0EJFJcZeLVOY5T3k3JWd4rYr6BMo=; b=HSGt8JyaiSyOrUJRY5Ho2bSdmd
        tt5G6vXTlofiiErK/Ujm0KeRMlREfmjY4AiXNOgNvCmhIMLwEVzbUEwXXl54e1gnFm08z0HUTuAO4
        AglCy/ANITMXpUXBT9AMevUYLxlD8agzYyG2gMSuOcAEPTIPGAD23T3IEYazkF8f1jBS2a+ohIdUG
        rdLQfFUi4SRo9C0Z8f66m1IJBHxTuhYtwJCmMCSzbPuMCUA2/pUOIWyegMBK/WVQolThVPOOx6H+c
        rdvUzrIYkpfGXbsThE72Co4DGrgg4y+iSptCmrD4syM5M4I488z13tCScXYFqivizmKjEyq1bI/zy
        LFVLNwMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMfUz-00C0ys-V7; Wed, 23 Feb 2022 00:27:17 +0000
Date:   Tue, 22 Feb 2022 16:27:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Miscellaneous cleanups
Message-ID: <YhV/ZQKsO2rElYdL@bombadil.infradead.org>
References: <cover.1645542893.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645542893.git.christophe.leroy@csgroup.eu>
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

On Tue, Feb 22, 2022 at 04:16:30PM +0100, Christophe Leroy wrote:
> This series applies on top of my series "Allocate module text and data separately" v5.
> 
> It does some cleanup around the settling of modules's layout page flags:
> - Make module_enable_x() independent of CONFIG_ARCH_HAS_STRICT_MODULE_RWX
> - Reunify everything into strict_rwx.c
> - Change big hammer BUG_ON()s into WARN_ON()s
> - Change misleading debug_align() to strict_align()
> 
> Changes in v2/v3:
> - Rebased on top of my series "Allocate module text and data separately" v5
> - Moved the Kconfig patch out of this series, it is an independent change
> 
> Sorry for the mess in v2.

Thanks for all this work! Any chance you can actually submit this prior
to your allocate module series? This and the patch, "module: Move
module's Kconfig item in kernel/module/". Because *iff* we get enough
testing out of Aaron's changes and your cleanups, perhaps those might
be candidates for the next merge window. Then we can save all the new
functional changes for the other merge window.

  Luis
