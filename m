Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1B509A32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386308AbiDUIDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiDUIDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:03:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDF26F5;
        Thu, 21 Apr 2022 01:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1626FB82299;
        Thu, 21 Apr 2022 08:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A50AC385A9;
        Thu, 21 Apr 2022 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528010;
        bh=XTeZWXaWKDzhiIEt4f9i25B5IZSE67l5ja2wFkIbVxQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kVIC2Cw6FAil+rrevneX3mTxEyb1siLjlSLT/IJYVExBpqbkA1wgrJd+pXCqBDODW
         rtvx7sY66KfUR02cEqJKryF5HMxQUxMLXmmY+SdBz4OkiNhCTqtRKofarQFalRZPjL
         oUd8bwzRVCzle6qUsFhCdjux/1KHmvSPjHv1lDhVmMvLJHw9r1JEqg+TSRkm8wULgK
         JlVRPhssi0ZeGiyCstoZ8V6PjMqHjadj6uxjI3S9s9Ku22Smt2SI76FO7riXi0Q5tk
         Y4byQq+csVw7AEVzv3JLWJP+03zqBMLKaWQOeeE3TmpIF2p2HpvMaEziKDO1QDN9sR
         3COV4wxShkjCw==
Date:   Thu, 21 Apr 2022 10:00:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jason Gerecke <killertofu@gmail.com>
cc:     Bastien Nocera <hadess@hadess.net>,
        Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
In-Reply-To: <CANRwn3SVcqFtv0BTTtqpM7M4WRN4sMKVo7_-9t5M8itt-rEttQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2204210959560.30217@cbobk.fhfr.pm>
References: <20220407115406.115112-1-hadess@hadess.net> <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm> <CANRwn3SVcqFtv0BTTtqpM7M4WRN4sMKVo7_-9t5M8itt-rEttQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Jason Gerecke wrote:

> Following up on my previous comment. I've been able to test this patch
> with both flavors of wireless interface. Both Bluetooth (Intuos Pro)
> and dongle-based (Intuos5) appear to have mostly-correct behavior
> while charging and discharging, even when the battery level gradually
> drops to zero. The misbehaviors I see appear to be limited to upower
> mis-categorizing the devices as an e.g. keyboard or generic battery
> rather than as a tablet. This leads to some slightly confusing UI
> issues (e.g. GNOME and KDE referring to the device incorrectly), but
> nothing too annoying. If upower is taught to recognize tablets under
> more circumstances those issues should disappear.
> 
> Ping tells me you may have an Intuos4 Wireless, Bastien? Any
> additional testing you can do with that device would be appreciated,
> though even without it I'm personally comfortable enough to provide an
> ack:
> 
> Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Thanks Jason, now applied.

-- 
Jiri Kosina
SUSE Labs

