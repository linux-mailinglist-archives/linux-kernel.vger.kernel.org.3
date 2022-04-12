Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864CD4FE654
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357873AbiDLQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiDLQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:54:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC82574A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=vNCCOpYQH0vzjBgMNfNuyid5ryqUFOZ7U9dBWd0Rvbs=; b=hG5LgtEbRW6Jd7UfBudIS62Hpv
        43P+/n1FACUCP+zPX3ZeyS3aH3E2HMQPVj0uief0hUFDc4aKp9bsKgd2G+4KAWiF8M4WKz0tNcYr+
        WUkJinbR8oSCQA0Kx1wlsJRzw/7MLZcRzsi2XkujS1h5uMZMSkn5NlRsSH0YQpiZevjZCOA6oDLj3
        guXIFHtt2nIvHiUogB0mr72bqRZYNy5MKZXBwQ+LPpuRzv3pYW1A+1+9sQwDPlBq6Fz5oE0S7bNjr
        ysSpSRRuy3Bn0wybnD2iocu2/bKn6cAYPKyE1eGf03aEVW1pvlsg3IqhDEad368Cwukp44zkMbBIj
        IIx3m/yQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neJkA-00DWhi-Jc; Tue, 12 Apr 2022 16:51:54 +0000
Message-ID: <1dd4c336-d281-6da3-ba37-d13bbf7c2537@infradead.org>
Date:   Tue, 12 Apr 2022 09:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 -next] scripts: add compare-config utility
Content-Language: en-US
To:     Chen Lifu <chenlifu@huawei.com>, linux-kernel@vger.kernel.org
References: <20220412083057.4101246-1-chenlifu@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220412083057.4101246-1-chenlifu@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/12/22 01:30, Chen Lifu wrote:
> This is an alternative utility to compare two .config files. Unlike
> existing utilities "diffconfig" in the kernel tree, it prints detailed
> results in table style, and support config name prefix so that it can be
> used elsewhere. It is useful sometimes, for example, to analyze .config files
> through tables, or to compare Buildroot .config.
> 
> With grep and awk, it can print similar results like "diffconfg" as well.
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>

Is your goal to have this merged into the kernel source tree?
If so, you should also send the patch the the kconfig maintainer and
mailing list.

The output is quite verbose in its default mode (no options specified).
To get something useful, I use -C -O -N.

For my uses and preferences, I would like to see a -D (e.g.) which
is just a combination of -CON. And it would be nice if that was the
default mode also. :)

> ---
> Changes in v2:
> - Add config name prefix support
> 
>  scripts/compare-config | 201 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100755 scripts/compare-config

thanks.
-- 
~Randy
