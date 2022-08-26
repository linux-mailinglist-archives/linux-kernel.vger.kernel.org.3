Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C965A2B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbiHZPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbiHZPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:48:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95656C04F7;
        Fri, 26 Aug 2022 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VcIl7KQfuQkkxC9BZ5lEzx4FxsUIlpYy2j1e5QVKu60=; b=cfUSeIA4zNWEefBK2xhtgjN5/G
        4E8RGuIHaCOJUiAygz3NdigpgChFDP2LmKdPlS6U1Dm3YhUQE42YdV6l7kvmFGxncnmsdr/wpfHG/
        +iYyxq35+xHiGwewsyNeEKEQYRd3Bp71sfKlIT8zS7mm5wxWxIKkPIawOiej3yKRtF2bqD3zIXD1k
        SWuR68CPk68BG+4w8ZYC3y3D4mMz/+yRgONe79ireVPREQoqUWxnSdUkg0645gKl996tKTy8L+YHx
        w/+RKYAIw8EJeZfpfG/SgDcVxpMl0bppf9xkjdPHwHHTPXIrYAHhCBtGq3rYSTMZDNkW2zEh0MTGS
        cztnNPsQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRbYh-007CdF-MX; Fri, 26 Aug 2022 15:47:47 +0000
Message-ID: <3d65fcd8-3010-d132-85d0-249b30ebf50d@infradead.org>
Date:   Fri, 26 Aug 2022 08:47:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] Remove duplicated 'the' across the whole documentation
Content-Language: en-US
To:     Jules Maselbas <jmaselbas@kalray.eu>, linux-kernel@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220826095321.21548-1-jmaselbas@kalray.eu>
 <20220826143300.6794-1-jmaselbas@kalray.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826143300.6794-1-jmaselbas@kalray.eu>
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

On 8/26/22 07:33, Jules Maselbas wrote:
> Remove duplicated 'the' across the whole documentation
> 
> CC: Bagas Sanjaya <bagasdotme@gmail.com>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: linux-doc@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>

These all look good to me.
You could also do the 2 occurrences of "The the"...

and the other several hundred occurrences of other duplicated words
in Documentation/.

Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> in v2:
>  - also remove the second 'the' in one sentence as suggested by
>    Bagas Sanjaya
> 
>  Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
>  Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
>  Documentation/core-api/cpu_hotplug.rst            | 3 +--
>  Documentation/driver-api/isa.rst                  | 2 +-
>  Documentation/filesystems/caching/backend-api.rst | 2 +-
>  Documentation/locking/seqlock.rst                 | 2 +-
>  Documentation/sphinx/cdomain.py                   | 2 +-
>  7 files changed, 8 insertions(+), 9 deletions(-)


-- 
~Randy
