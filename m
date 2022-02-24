Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F34C33EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiBXRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiBXRoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:44:06 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27921278CBA;
        Thu, 24 Feb 2022 09:43:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC9E42E0;
        Thu, 24 Feb 2022 17:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC9E42E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645724615; bh=YNoCcbHo5RP0qTSuddjXc7BFatiUuDPt00SVhf+2L4s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k7Jcy+57LjWGjnVPmiVpkytDk/IIPI4ELtIiU7OhgmoZpmKaE708/patBad9R4Knl
         VumIXUv1fDXqFLZN4RaZ/lMnADkFbVp9JNvM1WJHjFeWwR94JZwg0jsNpzjMRs9H4N
         X02AmMlW5xwOyeF3WyqTDn1jQrmDvWiQUUdpJ5k0kXCuJyxSaNoCWkfUdMAW5kVS/Q
         yDBjSdRgGsbZXYgpMKcL6m8ZcMKlwSNrNilsIZ1oBQvwTEHGwQc3dWW8rIdsdESGMx
         udYyPVijLbfpUh2dP53w2E1i0ddAPE42juVP8M6v/OjK3mImN3srOW6Raf6TbKn1bM
         3y+3eVPnbEu1g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Oscar Shiang <oscar0225@livemail.tw>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove duplicated words in trace/osnoise-tracer
In-Reply-To: <20220223223448.61dcdb3e@rorschach.local.home>
References: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
 <9531b09c-6dc2-f551-d699-29b0c8cc2aeb@kernel.org>
 <20220223223448.61dcdb3e@rorschach.local.home>
Date:   Thu, 24 Feb 2022 10:43:35 -0700
Message-ID: <87k0dkma7s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Sun, 20 Feb 2022 21:43:29 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
>
>> On 2/20/22 13:12, Oscar Shiang wrote:
>> > There are 2 duplicated words found in osnoise tracer documentation.
>> > This patch removes them.
>> > 
>> > Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>  
>> 
>> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Jon, want to take this through your tree?

Sure, applied, thanks.

jon
