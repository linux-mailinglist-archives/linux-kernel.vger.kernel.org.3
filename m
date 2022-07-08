Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7056B9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiGHMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiGHMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0CF7C1A6;
        Fri,  8 Jul 2022 05:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2794A62670;
        Fri,  8 Jul 2022 12:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BE3C341C0;
        Fri,  8 Jul 2022 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657283846;
        bh=eNihv0F7MFMwaop158fl3pXPeakFGIEIg+iQYKZ+GXk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PhnE48Va8v6QpUePwOznwwbSgvIsXR5uvxKboGqE6xAPq16esFa7SW3tmvi92abNz
         s/rFFj7KyeD2+tgITYk5Denjy8FfjFMUzUgAU//Cezf+/2M+BcQgTMrSMPh2Jc6POE
         nrNZueJ3I2r+Xe60SOS1BYUtmPfHbFd6i+sAWTM7cqp4OdL6zPrA1yDsN8I3m9pfFo
         hU+mFJ14SjlUnYPvbt7gOwkoBCST0jV0OAWaYsiReEjkwCwmP9H+4JwQ7PlnPjwv2W
         qaL08124NRpmeCs+gZuukCvn9c4xlr2bPlXJtCh8EINtXOLMJW2aegltGs5bpTfMXW
         oHUSbpoWtRdLA==
Message-ID: <43855674-0f0f-bdf9-4f52-72bb4bf7e863@kernel.org>
Date:   Fri, 8 Jul 2022 14:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] rtla/utils: Use calloc and check the potential memory
 allocation failure
Content-Language: en-US
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>, rostedt@goodmis.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615073348.6891-1-jianchunfu@cmss.chinamobile.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220615073348.6891-1-jianchunfu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 09:33, jianchunfu wrote:
> Replace malloc with calloc and add memory allocating check
> of mon_cpus before used.
> 
> Fixes: 7d0dc9576dc3 ("rtla/timerlat: Add --dma-latency option")
> Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
