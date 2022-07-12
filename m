Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B535725A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiGLTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiGLTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:33:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DF8245B;
        Tue, 12 Jul 2022 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mz3uiLBDPsOt1VzIpjwZMOerOHNzoGUVpwp83xBphr8=; b=z1dg9AinunEfgUZNUkIFL/epIL
        4xaEXeEdg7IWggJ8gQposn9zp1vzaBN8rzAc/hjcHy8CEkT7Q/C9l9G891JER8qzTyeFfFMOrUBQr
        GoGHU5nat5gxjZJfQREzq3aBMGZJQqFo2o5TmWZhxZEoabRKoJj2VaXIIAm5f73RhgXn5iOyZrAxw
        5YWbXalgWKbeLr/OyOnUTnXVnhblHLe3AaoC6B8wjJNLQ18ez9a7OJuAVA0AdqkN6nTh5o9suqHKM
        R7TDIGn3FxmjD3/bPvp7gKpYErqaBEPqj2hE0l8OcTpwkv1pNXdBrsMUBC0joXABW0WWJniyVr+vi
        B+fcCmbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBLFi-00E56D-OI; Tue, 12 Jul 2022 19:08:58 +0000
Date:   Tue, 12 Jul 2022 12:08:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Move module's Kconfig items in kernel/module/
Message-ID: <Ys3GyoTcW1b0gQuF@bombadil.infradead.org>
References: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:52:33AM +0200, Christophe Leroy wrote:
> In init/Kconfig, the part dedicated to modules is quite large.
> 
> Move it into a dedicated Kconfig in kernel/module/
> 
> MODULES_TREE_LOOKUP was outside of the 'if MODULES', but as it is
> only used when MODULES are set, move it in with everything else to
> avoid confusion.
> 
> MODULE_SIG_FORMAT is left in init/Kconfig because this configuration
> item is not used in kernel/modules/ but in kernel/ and can be
> selected independently from CONFIG_MODULES. It is for instance
> selected from security/integrity/ima/Kconfig.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks, rapplied and pushed! This should be in linux-next soon.

  Luis
