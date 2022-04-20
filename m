Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67A3507F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359174AbiDTDRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349010AbiDTDRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:17:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF8F2197;
        Tue, 19 Apr 2022 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/uKk4JyTFptzbr0H6+VytA6g1HEyjC1oN1fpsbq5uXM=; b=GNWGR1lDWTL8cRwT85bG5ZUkm6
        kMPWuP6k3F4ozmM3WdfGp9WV289PghTJg/mLjfEUCthlbZPsamxnfozoeVmlUiBpmcFjMrX0jfPzJ
        LCDbOdWlJF7Q5lNDenIzlAzbiW4SUmROcG2OFrOy8vj1/tm1fm2NOns32yNHDXjWxT7ETgswqMWIj
        6UKVXh2AqXlQLpvYAlOvrqWNBx1pGAMlCjZsy4A1wdhcUuUtmpsYZofSLWaP0hnephD+p6j8kOpdx
        2cNVlI7mdCxnAgwHy9gbMxoLrPpCm/MYk/P3jXlnDQevqzHo/SShTmo445pHZ0ufPROfpz6iAjLG2
        Ew2YMV+w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh0nm-006zzd-M8; Wed, 20 Apr 2022 03:14:47 +0000
Message-ID: <3b603913-3db7-f243-5821-d39e62480ab6@infradead.org>
Date:   Tue, 19 Apr 2022 20:14:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] x86: Make XDBC work
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20220304151953.830111479@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220304151953.830111479@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/4/22 07:19, Peter Zijlstra wrote:
> Hi!
> 
> These are the patches I needed to make XDBC go on my tigerlake NUC.
> 

I finally tested these patches (in mainline).
It's working well for me.  Thanks.

-- 
~Randy
