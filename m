Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4018251B7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiEEGLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiEEGK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:10:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E837BC0;
        Wed,  4 May 2022 23:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Qpucw3oLv2CRbRUcWob5k8MPLSfidQ+h1vDMyl/0sg=; b=wAME08WBqMGroIuoojj2vANlMm
        nzWTwW0VDOPHh9E70noMJvBFAtyB6Qi08bFjbBQ8Nw0Ro8InFvuJs7dHqHPbHdQevLJFDLfg2G9G8
        wWAU9D5KurOawNpsLcGlJg2c6RcxIyFb1/3ea2yYXiLbSMDfbhjrA4ykx53CLHLV/MwlZy681CbNw
        H2mMLfeEsaMa2bPYZsoKPnQFdv8efdQ5tnRRUAfk3R9+67JPG8IEoAGN3E7jVi8DkSMgMw+SL5BUk
        na+QvMVdrUmK83xemQwmR+/7n+7NfSVZ9fRVYJIhssXE9V2LbGtf494wNwW9n4jsdCMgtN/Hz9TWR
        ntz6wTXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmUe0-00E8uy-8A; Thu, 05 May 2022 06:07:20 +0000
Date:   Wed, 4 May 2022 23:07:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] module: trivial cleanups for symbol search
Message-ID: <YnNpmGmDD0xnC06j@bombadil.infradead.org>
References: <20220505035212.1130858-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505035212.1130858-1-masahiroy@kernel.org>
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

On Thu, May 05, 2022 at 12:52:09PM +0900, Masahiro Yamada wrote:
> V2: rebase on module-next.

Thanks! Pushed onto modules-testing, if there are no issues reported
I'll move to modules-next.

  Luis
