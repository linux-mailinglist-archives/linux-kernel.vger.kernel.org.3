Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4504B2B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351970AbiBKRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiBKRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:12:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B838DBD6;
        Fri, 11 Feb 2022 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=IAJVndvC2D0wZes8TKvqkXkv156AHKT6iLNSSoGjHCM=; b=IBcTNrW3dnUQdfHlL1i4TFT2FK
        ZzM4dp4CkSwhVVCIctn7UWQjm5pdv9cIfUSyg0EQvE7zsrj2NVImDvYrymK6ZBMhpzYLa5V+5A29Q
        T+rjHzYt64BjaVY2UqPZLru6D06FMatJz0hVRUnd1M1EiHNKPk9u7+5wbt9tWRbcEHFBZHAFfLYn0
        fg9XyyrDPOLDVNgRPk8afJnWNfgWS39QzcTD2X7nD4APdUJbqKNskDZVptut1a5NJhV8vhnooQsd9
        UoLAFlG94O7uOi/9eKrciA2l4KkJzk/Frz1MkO5ojeamnBdAnVEtZqYStrop2H4HC1QF0A6l3VEoo
        N3Fax3Qg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIZT4-00AaM7-GV; Fri, 11 Feb 2022 17:12:22 +0000
Message-ID: <376dd5c9-199c-25af-d431-d1f0541f08c0@infradead.org>
Date:   Fri, 11 Feb 2022 09:12:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] PM: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220211161027.2516447-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220211161027.2516447-1-trix@redhat.com>
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



On 2/11/22 08:10, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'the'.
> Replace the second 'of' with 'the'.
> Replace 'couter' with 'counter'.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/base/power/wakeirq.c | 2 +-
>  drivers/base/power/wakeup.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 0004db4a9d3b..d487a6bac630 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -289,7 +289,7 @@ EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
>   *
>   * Enables wakeirq conditionally. We need to enable wake-up interrupt
>   * lazily on the first rpm_suspend(). This is needed as the consumer device
> - * starts in RPM_SUSPENDED state, and the the first pm_runtime_get() would
> + * starts in RPM_SUSPENDED state, and the first pm_runtime_get() would
>   * otherwise try to disable already disabled wakeirq. The wake-up interrupt
>   * starts disabled with IRQ_NOAUTOEN set.
>   *
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 8666590201c9..a57d469676ca 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -587,7 +587,7 @@ static bool wakeup_source_not_registered(struct wakeup_source *ws)
>   * @ws: Wakeup source to handle.
>   *
>   * Update the @ws' statistics and, if @ws has just been activated, notify the PM
> - * core of the event by incrementing the counter of of wakeup events being
> + * core of the event by incrementing the counter of the wakeup events being
>   * processed.
>   */
>  static void wakeup_source_activate(struct wakeup_source *ws)
> @@ -733,7 +733,7 @@ static void wakeup_source_deactivate(struct wakeup_source *ws)
>  
>  	/*
>  	 * Increment the counter of registered wakeup events and decrement the
> -	 * couter of wakeup events in progress simultaneously.
> +	 * counter of wakeup events in progress simultaneously.
>  	 */
>  	cec = atomic_add_return(MAX_IN_PROGRESS, &combined_event_count);
>  	trace_wakeup_source_deactivate(ws->name, cec);

-- 
~Randy
