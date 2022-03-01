Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB704C7F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiCAAWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCAAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:22:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B4245A1;
        Mon, 28 Feb 2022 16:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yXndaB8z3eG6YNhJ5eZFobssgMdzDctXQPYklrHtNbc=; b=VuwoJhL3wgTaLNw7MkN4bhfn8A
        JQYxjKbgUItAmbCDW38bzGDEHwwkpy0OAIhyFKsvHL6ubV80U8SAuE+4JWwT5rkTNUxvM8v+U8vKw
        V3NwNA4I/QjmS3dv2J89GggDT6x03uohywam1vAldQFixyoBK7rFhPzKhOlTvL7P3mfAQuoqhUmel
        o96OaK/yasRAItDa+XR3N1WjpSjcCBxln8sz8v3yWTfxkjWMlSmm7Xhyt1qjjDncK9+46yw6egVxs
        VhDHWrxzN5Cak5mX9LwCATu0AvfVZ0Ucwn4G1SlvWl6TaH7HacufmVO+9VpeFRo/8qO6tlu7Zfl+/
        1WanZbHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOqGw-00ETq0-JY; Tue, 01 Mar 2022 00:21:46 +0000
Date:   Mon, 28 Feb 2022 16:21:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     christophe.leroy@csgroup.eu, pmladek@suse.com, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: Re: [PATCH v9 00/14] module: core code clean up
Message-ID: <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
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

On Mon, Feb 28, 2022 at 11:43:08PM +0000, Aaron Tomlin wrote:
> Hi Luis,
> 
> As per your suggestion [1], this is an attempt to refactor and split
> optional code out of core module support code into separate components.
> This version is based on Linus' commit 7993e65fdd0f ("Merge tag
> 'mtd/fixes-for-5.17-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").
> 
> Petr,
> 
> I decided to use preempt_disable() instead to remain consistent with the
> rest of the file. Unfortunately, I did not make time to boot test etc.

Aaron, thanks so much for doing this!

Since no boot tests are performed yet, I just pushed this to modules-testing
for now, after we get some boot test results I'll push to modules-next.

We should run kmod tests as well.

  Luis
