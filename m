Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC4509A46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386470AbiDUIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386454AbiDUIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3171E3EB;
        Thu, 21 Apr 2022 01:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8958161B74;
        Thu, 21 Apr 2022 08:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADED1C385A9;
        Thu, 21 Apr 2022 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528570;
        bh=DQ86qqtCvZ8IVc+4aPzahAmv6PvNblsdJPMIqyHWYHk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=k9zQKUlc26dB9ESl05BeitdclWMpOAHRx3hk68/Z9M0uZeIqnQndJ0VN56+7GWFnr
         0DCo/L4Mijp+AdxI7k2De5mKIXuO+JJXQmKzUXkJWacAomWfp+CpG9rV5LwCqlOlk1
         R4xiKNacCTHYSOG7BOz7Ijx4E4AIDb1qY1NGwZIsLH0Xl02CiDJnBGpDFcRFet3RjV
         dkXl514IBWULaivKFMSuwHSLoRug2DWNGfTQvMMuaU+bTDWXcn5PvfpuTE4mhA46Fz
         Rfbah4fRI9t048gt1M5ZmwO07/66rVl7TNTPwNaog2bVyB5WN5fIX9yEw9IQ+tBGYZ
         74dI3asJDiD+A==
Date:   Thu, 21 Apr 2022 10:09:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.19/uclogic 0/4] DIGImend patches, part IV
In-Reply-To: <20220414110936.146378-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2204211005520.30217@cbobk.fhfr.pm>
References: <20220414110936.146378-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, José Expósito wrote:

> Hi everyone,
> 
> This series is a follow up to [1], [2] and [3] and upstreams 4 more
> patches authored by Nikolai from the DIGImend project.
> 
> Patches 1 and 2 are simple code clean up.
> 
> Patch 3 adds support for "bitmap dials". This kind of dials send 01
> and 10 binary values rather than the usual 1 and -1.
> 
> The last patch adds support for the Huion Q620M drawing tablet, which
> has a bitmap dial.
> 
> Thank you very much in advance to Jiří for his work reviewing all the
> patches I have sent so far,
> José Expósito
> 
> [1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
> [2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/
> [3] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204111653000.30217@cbobk.fhfr.pm/T/
> 
> Nikolai Kondrashov (4):
>   HID: uclogic: Compress params format string
>   HID: uclogic: Reduce indent for params format str/args
>   HID: uclogic: Add support for bitmap dials
>   HID: uclogic: Add support for Huion Q620M

This is now in hid.git#for-5.19/uclogic

Thanks,

-- 
Jiri Kosina
SUSE Labs

