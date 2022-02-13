Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF744B3D17
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 20:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiBMTNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 14:13:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiBMTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:13:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACEF5F8DA;
        Sun, 13 Feb 2022 11:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eUPuZhGrIC+7mQR6M8wT4w7vMWwnwvrJ/Ap6Tdqeifw=; b=WrOvp7aBK+9C7NfEzGSeNlAOyv
        EtbqagYvn5vG40EmwdyXknjAo6UeyS/tHpcFDmBGAX1IzMGr/C89bZ0CGYhGOQD9ohbUqVqbQn8to
        72EPupBvgj9rtS2UgkUkrUmAqlO+ugWfu5z+uoRcR/vnQ9FjbmgWKVC8H1JYjMX88mHdnzR6pm13V
        qBXugwTLCCI15fcKAIUur3Lrb155D+XHW8YMdMMfMdZiLVwcV14QDicOfA3D7FZo/FsuRnKiYnKLG
        lzbYvolWfjBh7GYnG+uQ6+fhuUe7mAVbk6XTpnA/zd7OHXqcL52NIwtv9xx5SYs3WJZ6G3V22TSrI
        y4tk/dsA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJKJP-00CDc1-9e; Sun, 13 Feb 2022 19:13:31 +0000
Message-ID: <41a2b113-116c-f181-29a4-32735d5809b0@infradead.org>
Date:   Sun, 13 Feb 2022 11:13:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bcma: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, zajec5@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220213172023.2786642-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220213172023.2786642-1-trix@redhat.com>
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

Hi--

On 2/13/22 09:20, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'info'.
ack

> Replacements
> 'adventages' with 'advantages'
ack

> 'strenth' with 'strength'
ack

> 'atleast' with 'at least'
ack

> 'thr'u'' with 'through'
ack, or even "thru" is acceptable.

> 'capabilty' with 'capability'
ack

> 'controll' with 'control'
ack

> 'ourself' with 'our self'
I don't think so.

> 'noone' with 'no one'
ack

More below:

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/bcma/driver_chipcommon.c     | 2 +-
>  drivers/bcma/driver_chipcommon_pmu.c | 6 +++---
>  drivers/bcma/driver_pci_host.c       | 6 +++---
>  drivers/bcma/main.c                  | 4 ++--
>  drivers/bcma/sprom.c                 | 4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
> index 62f5bfa5065d..fd91a39f02c7 100644
> --- a/drivers/bcma/driver_chipcommon.c
> +++ b/drivers/bcma/driver_chipcommon.c



> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
> index 8e7ca3e4c8c4..bf6efe3caf68 100644
> --- a/drivers/bcma/main.c
> +++ b/drivers/bcma/main.c
> @@ -293,7 +293,7 @@ static int bcma_register_devices(struct bcma_bus *bus)
>  	int err;
>  
>  	list_for_each_entry(core, &bus->cores, list) {
> -		/* We support that cores ourself */
> +		/* We support that cores our self */

I would s/cores/core/.

From my $search_engine doodling, it looks like "ourself"
or "ourselves" would be OK.

>  		switch (core->id.id) {
>  		case BCMA_CORE_4706_CHIPCOMMON:
>  		case BCMA_CORE_CHIPCOMMON:

> diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
> index bd2c923a6586..fb2789827e83 100644
> --- a/drivers/bcma/sprom.c
> +++ b/drivers/bcma/sprom.c

> @@ -281,7 +281,7 @@ static void bcma_sprom_extract_r8(struct bcma_bus *bus, const u16 *sprom)
>  	SPEX(alpha2[0], SSB_SPROM8_CCODE, 0xff00, 8);
>  	SPEX(alpha2[1], SSB_SPROM8_CCODE, 0x00ff, 0);
>  
> -	/* Extract cores power info info */
> +	/* Extract cores power info */

or	           each core's power info */

>  	for (i = 0; i < ARRAY_SIZE(pwr_info_offset); i++) {
>  		o = pwr_info_offset[i];
>  		SPEX(core_pwr_info[i].itssi_2g, o + SSB_SROM8_2G_MAXP_ITSSI,

-- 
~Randy
