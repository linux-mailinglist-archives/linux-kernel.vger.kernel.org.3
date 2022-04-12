Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4674FE3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356254AbiDLO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiDLO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:26:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D3B1E2;
        Tue, 12 Apr 2022 07:24:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D038B210E5;
        Tue, 12 Apr 2022 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649773467;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Z9+hhZ/fGDkb3HZ7krEOEuYawa9iKoF641ksqlogCI=;
        b=dHaIgAMYR2EAfTYO6A0R2+fU5tRIUF4i6UTwR1QREWZpTqcFsy/GYcoTeKGVQSNonQFsVq
        uI9e3L7Yj3Shb6YE4IOZ4bP2gICflIDB51DsJ+fXT6LQ9KrpHSOVWQJ4xAJyBrNXMBnXGe
        DIE5EX/OR4X4/PyZpf8m7Q0nldnLWEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649773467;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Z9+hhZ/fGDkb3HZ7krEOEuYawa9iKoF641ksqlogCI=;
        b=dl+ZCfHznKNbvexa716PqmbZNk9TyHwqCrEEKRyLjeBz1PnLNpPxL8mYz4QCwdWTStMqip
        niCTbXlwsfpWdvDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 150F9A3B82;
        Tue, 12 Apr 2022 14:24:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 562F7DA7B0; Tue, 12 Apr 2022 16:20:21 +0200 (CEST)
Date:   Tue, 12 Apr 2022 16:20:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
Message-ID: <20220412142021.GX15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <CA+G9fYvXn1tgpESouPBwZgKnoeUNjM3CV1nzDWac6PjHqTskog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvXn1tgpESouPBwZgKnoeUNjM3CV1nzDWac6PjHqTskog@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 05:28:08PM +0530, Naresh Kamboju wrote:
> Linux next-20220412 arm and i386 build failed due to below errors
> with kselftest merge configs.
> 
>    - build-arm-gcc-kselftest
>    - build-i386-gcc-kselftest
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=i386
> CROSS_COMPILE=i686-linux-gnu- 'CC=sccache i686-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
> 
> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
> modules-only.symvers] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The fixed patches are on the way and will appear in the next for-next
branch snapshot. Thanks.
