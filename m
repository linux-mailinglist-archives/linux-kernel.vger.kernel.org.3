Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF7E4B3E68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiBMX3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiBMX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:29:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C035133B;
        Sun, 13 Feb 2022 15:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3FoNdbZVjJP5lcX0q3ReMO6GWYXBCpciynOb6Vt0iBY=; b=f8lqDkdQkzlpC0nUVHl0bN2acH
        EDZP0K5RnsHOB/wOVjGfhtmGV+ApMCZU05RlKRhXaxC139VkkmVB96Kgs7a7UDauXZEb7b9Qzs9au
        d9iQSl6vIWgMxRjCzy979NgLS9Sn/3dcl1XH31dmV4NqXT3azbXficfSVryH3BltQQ6qQlysvXM+6
        TClC+B4uswcwmZi15p4drH+r+PZn7N1ezxGfmggPSYVXhOL8nxIZflzBzOEskoI6F+sc1mQPcEXEi
        13lEQ7jJWzxeishwV7DDKnr7LRoWGRHHlrzgarnegV+FvKrCinZhU+71rTykeKoiXv95zv6/xt8Q/
        Fu5Fb/iQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJOIr-00CM1o-8i; Sun, 13 Feb 2022 23:29:13 +0000
Message-ID: <89df0da1-c867-43ad-096c-a1fdd1588a99@infradead.org>
Date:   Sun, 13 Feb 2022 15:29:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bcma: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, zajec5@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220213213121.2806376-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220213213121.2806376-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/22 13:31, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'info'.
> Replacements
> 'adventages' with 'advantages'
> 'strenth' with 'strength'
> 'atleast' with 'at least'
> 'thr'u'' with 'through'
> 'capabilty' with 'capability'
> 'controll' with 'control'
> 'ourself' with 'ourselves'
> 'noone' with 'no one'
> 'cores' to 'core's' and 'core'
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
> v2: change per Randy's suggestions
> 
>  drivers/bcma/driver_chipcommon.c     | 2 +-
>  drivers/bcma/driver_chipcommon_pmu.c | 6 +++---
>  drivers/bcma/driver_pci_host.c       | 6 +++---
>  drivers/bcma/main.c                  | 4 ++--
>  drivers/bcma/sprom.c                 | 4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)


-- 
~Randy
