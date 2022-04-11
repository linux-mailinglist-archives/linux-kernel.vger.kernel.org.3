Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F74FBFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbiDKOzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbiDKOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:55:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A365393E4;
        Mon, 11 Apr 2022 07:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35DC6B81648;
        Mon, 11 Apr 2022 14:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C330FC385A4;
        Mon, 11 Apr 2022 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649688801;
        bh=z+iaqACZOMYq+KfwoqlZ14jVOrSAnBe4zNrk5E5x3tM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=C5lom0tFugZ7uy9aV8pAZBrEsPg7YO8nZHDxTJ9TFovoa7EEpnfwtVZKyz/NQVD2H
         2O+y9qksscikk11jWxTrBh0NaVILUZOCvtk2XDTCrMGCioQBFVwiDinf2ANCHinDHB
         N1Ktvdqd6CzsCOlL8LIAMVLB8pMTHnTNm67V4qsK6kzLP6t4vHJvj/fgWRrhREGr17
         DY2ghU2WEo7WbYL/ajiXNhq/WUNVtDpo2HrsTVApY8/Dst805wyvPKDH3XHmkB8DMy
         utxpAK9J0SGSlukpE6uwBbmU7cL4KQ0WMkPtZmxdWhEYryRFHj5HFA12WbxZkuD0gw
         HTs7PFCWv/o0g==
Date:   Mon, 11 Apr 2022 16:53:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.18/uclogic 0/4] DIGImend patches, part III
In-Reply-To: <20220303074734.7235-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2204111653000.30217@cbobk.fhfr.pm>
References: <20220303074734.7235-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022, José Expósito wrote:

> Hi everyone,
> 
> This series is a follow up to [1] and [2], kindly reviewed and applied
> by Jiří in hid.git#for-5.18/uclogic.
> 
> It adds support for touch rings in order handle the Huion HS610 tablet.
> 
> Thank you very much to Nikolai for the patches a to the maintaners for
> the quick reviews,
> José Expósito
> 
> [1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
> [2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/
> 
> Nikolai Kondrashov (4):
>   HID: uclogic: Add support for touch ring reports
>   HID: uclogic: Support custom device suffix for frames
>   HID: uclogic: Allow three frame parameter sets
>   HID: uclogic: Add support for Huion touch ring reports
> 
>  drivers/hid/hid-uclogic-core.c   | 83 +++++++++++++++++++++--------
>  drivers/hid/hid-uclogic-params.c | 40 +++++++++++---
>  drivers/hid/hid-uclogic-params.h | 90 +++++++++++++++++++++++++++++---
>  drivers/hid/hid-uclogic-rdesc.c  | 65 ++++++++++++++++++++---
>  drivers/hid/hid-uclogic-rdesc.h  | 20 +++++--
>  5 files changed, 250 insertions(+), 48 deletions(-)

Now in hid.git#for-5.19/uclogic. Thanks,

-- 
Jiri Kosina
SUSE Labs

