Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720C4ECFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbiC3XKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiC3XKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:10:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C5C48E68
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:09:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648681744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/7UN74HEjwfw/Q9Mwx42O1C/nUpPup935T7lYNs3IQ=;
        b=qcVPU9lsBv8ZIH5YKqM3y2DL49H+uMw/u1oK8ao+fdmKNHKy3xO0wynZJlEnVPytbVnqjf
        IYTY5I8HOI8C5H/Z+pWSXM7nBvfwmJc0XKySiB0stJ93rGkygKluktdtVSQGvVIkE70LCN
        F2iQQcBeMjOvzmXGulxJyiU1vOoHTOlcC2QWAV201NJxioWWOzauqMSbuovr9aIzTDF/+b
        J1bi22W0JpDIOXGYTjF3fxYJODDBY2SGo5Vsr3a7bse2hITao00Cks35KT3ZiHNwrH1+lh
        XVam2aqdbCfdJbQvVq6CqHy0OK+o2i7Y/ybLT7OaWFW6YTYhWk2m6BFv+VOwkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648681744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/7UN74HEjwfw/Q9Mwx42O1C/nUpPup935T7lYNs3IQ=;
        b=ayYrO2AloHuC7vJ6eN2CM5uYFOBgNMzF1Z0NRt8luczEHTucL5mpo/j9JYrMnWLQsrFbwP
        0tHJcUT4X33gZpCA==
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v3] irq: consider cpus on nodes are unbalanced
In-Reply-To: <20220330044254.15712-1-yamamoto.rei@jp.fujitsu.com>
References: <YgSQKvv7rL6MFPRr@T590>
 <20220330044254.15712-1-yamamoto.rei@jp.fujitsu.com>
Date:   Thu, 31 Mar 2022 01:09:03 +0200
Message-ID: <87zgl7m41c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30 2022 at 13:42, Rei Yamamoto wrote:
> On Thu, Feb 10, 2022 at 12:10:18PM +0800, Ming Lei wrote:
>> On Thu, Feb 10, 2022 at 12:10:53PM +0900, Rei Yamamoto wrote:
>
> Could you pick this patch up?

Which patch? Whatever that patch is, it did neither arrive in my inbox
nor in a public archive:

    https://lore.kernel.org/all/20220210031053.5352-1-yamamoto.rei@jp.fujitsu.com/

Thanks,

        tglx
