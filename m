Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5F4B8387
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiBPJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:01:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiBPJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:01:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144872ABD24
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:01:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F30441F44EFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645002078;
        bh=X2RSF8nlGHgZC/av+xkMAvK6BU0k3B8IvR+gExmjA4I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C8Q1KBKzMbRAJstRnuuwEE6GSKnqrpORZb5qs3v0VsCcnVy3RmpQG6Mc5qWV/PzaA
         ANU3BbLYPooCRGhOelA/037Mij+ojH6F+mK+0QWYj03FoiXvL/nkwSmVIRjz6XJDJ+
         RQOSW4wPfP3UGMzz2SgGetDBdVb0SPfp202guea3GbS9952gSZ7okSVwoy51DK2vdP
         DDoHSWK2lpLRD9vHOX835RDSqO/e9DA2ATt7lDbeU/O1zHAGWY1WgXeTogUZxDqkCy
         2erbLZ6t2Ad1cwgN/CnmmKgsk6rnDCGVU0IIuMY22/9NFWc7oj3T5aMRq09dgtVZYT
         pZ9Lv7cjIOnKg==
Message-ID: <2cb4a1b6-1028-a1df-b7ff-9be7a57dd141@collabora.com>
Date:   Wed, 16 Feb 2022 10:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/panfrost: Dynamically allocate pm_domains
Content-Language: en-US
To:     Alyssa Rosenzweig <alyssa@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
 <CAL_JsqKdb0_N252hR=iv3Lpi6T9+iCRBwzBQhS7UQGFNhM5k=A@mail.gmail.com>
 <Ygwp+LDliCnbkMZQ@maud>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Ygwp+LDliCnbkMZQ@maud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/22 23:32, Alyssa Rosenzweig ha scritto:
>> I'd do the oneliner changing it to 5 and be done with it. That being
>> said, we have plenty of examples of doing this both ways, so whatever
>> makes people happy.
> 
> Excellent, that's the patch I wrote originally :-)
> 
> Dropping this patch, unless Angelo (or someone else) strongly objects.


Concretely measuring would be great, but I have no strong objections about
perhaps delaying this research to another (near or far) moment.
Let's drop this for now.
