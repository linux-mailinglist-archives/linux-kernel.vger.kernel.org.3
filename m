Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0495A396A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiH0SOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0SOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:14:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EBDF8FE8;
        Sat, 27 Aug 2022 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=sUguMGpeELC51NsqY2/REHqyVfAcxO10QryURvNRxvA=; b=wIffhsHYLYcLNZloUpBt13xXHP
        T4G/Emj3HSQ8DUtYa2yOsXJMv+psMjGTS2lzt11aCJwFdlcmbHN8+t8P9KSEtmoJgaY2se++hXBoN
        +uMnksKSY1P5xb4FwYhYEUe+jZeaB0c7RAidT8HBhXlvTWNcXUXBLw0OzXxD8FGhb05LiA1BYK/KW
        +21/wptqiyadsXygcPistYKuaNKVTBDaHEjKCSxbzZXkKkpm9jtRQtd00RtTyZQSzg7w8f6Kh32HJ
        dxM0EeUZ4bt6H/6TnJ22fxfMyDqILFolE4DbR/Uzomeanvy6NQFVEtTBaF4eqRcpQVAHvBWLy7hEO
        +wr8jNvg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.152])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oS0Jr-00Gje1-1f; Sat, 27 Aug 2022 18:14:07 +0000
Message-ID: <e552d98b-f458-05d0-7a2e-b8bc8454f932@infradead.org>
Date:   Sat, 27 Aug 2022 11:14:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] Remove duplicate words inside documentation
Content-Language: en-US
To:     Akhil Raj <lf32.dev@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220827145359.32599-1-lf32.dev@gmail.com>
Cc:     Jules Maselbas <jmaselbas@kalray.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220827145359.32599-1-lf32.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/27/22 07:53, Akhil Raj wrote:
> I have removed repeated `the` inside the documentation
> 
> Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
>  Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
>  Documentation/core-api/cpu_hotplug.rst            | 2 +-
>  Documentation/driver-api/isa.rst                  | 2 +-
>  Documentation/filesystems/caching/backend-api.rst | 2 +-
>  Documentation/locking/seqlock.rst                 | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Looks good, although parts of it seem to be duplicates of another
similar patch.
https://lore.kernel.org/linux-doc/d785f8aa-5a41-006d-394c-2bba64047cb4@infradead.org/T/#me8fa863e9f8c00fbbf4d11af8412c3bd8df5cfc5


And there are duplicated words other that "the" that could be
cleaned up.
E.g.:
  we trace guest of when and should to in send that is on as can at
  this are

-- 
~Randy
