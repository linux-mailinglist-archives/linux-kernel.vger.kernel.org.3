Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35474F4F65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837890AbiDFAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452191AbiDEPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06971D3077;
        Tue,  5 Apr 2022 07:50:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:0:2f5a:2277:ba57:a2c0:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 626051F44FBD;
        Tue,  5 Apr 2022 15:50:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649170224;
        bh=aUWjMFcKdA/ahzvcq6qNxNOe4FMWkYYbLu73Qvpgl0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+MGghngzjg05eWaLvwMsCBeWsVxk8Z5QWXjbrXvZkApCZU55ktgvN58ekEgDUBOs
         Svvlhaa+vCXBfzpmkKdhxGBfu1h4SGk1lCodM/zrTrEc+6XB+qoXaVYhVZtdCO0TA3
         Wl2p4r5KItJwaiT5T0BJhAw+k0dhSg8L0dApr7cZ3F0QTF9L1SwP5oPIL6a8J6CL+B
         iH4dF0/9fvlECQ5hGngEpr0F0xx20+9UKhPnpEx1SKR6AkOCU8elAiLKFOZNicD4Ip
         sFw5fQWkq58nAABH2RyrooFIsZDZp3TiTlfPVdFbXHAoOpZXGF+BW8lbaMuWS/4bTW
         kkkkxz3gKn6gQ==
Date:   Tue, 5 Apr 2022 16:50:20 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>
Subject: Re: Corrupted function tracer in 5.17.0-rc1
Message-ID: <20220405145020.55nopur6ccjyndnr@basti-XPS-13-9310>
References: <20220404125212.tuby556kara5t56c@basti-XPS-13-9310>
 <20220404102607.5c9cb515@gandalf.local.home>
 <YksG6LXUCwIZhK8k@FVFF77S0Q05N>
 <20220404110633.1b246d55@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220404110633.1b246d55@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steven & Mark,

On 04.04.2022 11:06, Steven Rostedt wrote:
>On Mon, 4 Apr 2022 15:55:36 +0100
>Mark Rutland <mark.rutland@arm.com> wrote:
>
>> From the title, this is v5.17-rc1, which is known broken due to the mcount sort
>> issue that was subsequently fixed in commit:
>
>Ah, yes. I was thinking of 5.18-rc1 (which has just been released)
>
>>
>>   4ed308c445a1e3ab ("ftrace: Have architectures opt-in for mcount build time sorting")
>>
>> Is it possible to try with the final v5.17? Or at least try with that patch
>> cherry-picked?
>
>Right, 5.17-rc1 is known broken. Please try the latest, 5.17 and let us
>know if it is still an issue.

Using 5.18-rc1 it works well, thanks for the quick help.
>
>Thanks,
>
>-- Steve

Greetings,
Sebastian
