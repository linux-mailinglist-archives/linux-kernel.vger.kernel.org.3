Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77269516FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385102AbiEBMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiEBMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:54:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2163BC2F;
        Mon,  2 May 2022 05:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BD43B8167D;
        Mon,  2 May 2022 12:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F83C385A4;
        Mon,  2 May 2022 12:51:23 +0000 (UTC)
Message-ID: <7bf0c90b-c5f3-104d-6653-d4e4aba8a38e@linux-m68k.org>
Date:   Mon, 2 May 2022 22:51:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] m68k: fix typos in comments
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220430191122.8667-4-Julia.Lawall@inria.fr>
 <CAMuHMdVnbbURooc7bePQX4E0FZVPO+eiKd8kYW2cz0mx3r82ZA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdVnbbURooc7bePQX4E0FZVPO+eiKd8kYW2cz0mx3r82ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On 2/5/22 18:38, Geert Uytterhoeven wrote:
> On Sat, Apr 30, 2022 at 9:11 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>> Various spelling mistakes in comments.
>> Detected with the help of Coccinelle.
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for the patch. I will add to the m68knommu git tree
(for-next branch).

Regards
Greg

