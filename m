Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9A5003A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiDNB1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbiDNB1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:27:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F224BC2;
        Wed, 13 Apr 2022 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=HXx6rYkI3GUyiug6Zr/czunsgd9I1Y4p0thwJCUsgGg=; b=pN2p/A5bjZtmbORFj5YdUpdlm6
        8qULReEUe7+5rc0asKPqy2rTYpsPkNtwUqmUBjSMeM45ZtJY7E+0DoSxiRn1rXmJq9ajC//OXje0m
        EP6iLedYIC1gZUSy8Ives4j8mKq96Ncij176MeU+diN18QwrBKNxjIwfaofincjoh4wEo64ann9yj
        3UiO5eiq6OEO70dVm2Uy325DQgKK4fmebMY8Vip8O4pyMCi770LJowD/bUmWyzpUwLVdIB4jaHVv1
        /MVCja7XvoF1Q5ouq8hYwODNDi0jKCZCtDcu1A0XO9oLYgH+tBOMlkAfVQWYIwr6I2fNl9mAgm7oH
        5tJcx+QA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neoE6-004qgd-3C; Thu, 14 Apr 2022 01:24:51 +0000
Message-ID: <787eefd6-1478-b83c-be60-2e71d65ca41c@infradead.org>
Date:   Wed, 13 Apr 2022 18:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 -next] scripts: add compare-config utility
Content-Language: en-US
To:     Chen Lifu <chenlifu@huawei.com>, masahiroy@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220413092331.203284-1-chenlifu@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220413092331.203284-1-chenlifu@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 02:23, Chen Lifu wrote:
> This is an alternative utility to compare two .config files. Unlike
> existing utilities "diffconfig" in the kernel tree, it prints detailed
> results in table style, and support config name prefix so that it can be
> used elsewhere. It is useful sometimes, for example, to analyze .config
> files through tables, or to compare Buildroot .config.
> 
> With grep and awk, it can print similar results like "diffconfg" as well.
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v3:
> - Add -D option, a combination of -C -O -N, and set it as default mode
> 
> Changes in v2:
> - Add config name prefix support
> 
>  scripts/compare-config | 203 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100755 scripts/compare-config


-- 
~Randy
