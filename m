Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2D551D182
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380076AbiEFGjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382873AbiEFGi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6365439;
        Thu,  5 May 2022 23:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB6761F4F;
        Fri,  6 May 2022 06:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F4C385AC;
        Fri,  6 May 2022 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651818912;
        bh=pf6ZIr6YjtbwscBjl1NsVH6yuujUzzRNMvatlF+n6/s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ne6ULEpad9yavPWrQPN2c6sNnzXIJpI1YEOVsZrBu1C2gaidOr8ze4OQQBNLkW4em
         9wGbss3w34/hDnXAfW+SbTeje2PbSWEt6lf8rpt7A7H/8WBE3wEaKEdqY02zH5ad7/
         fQb4X7YafLXoii92bbmNgiE0dRbBrn04PsFSsnorSQbvI88W5LTn7lmWA/bcfTlwKz
         1uLAKHY/ryFoaQfrqdauVMsYzxxhcUppAi2XR6DgywfHpHW0v//0vGeXU6vWiyiuqj
         MCgKwpU7bbBiomCpRPHNxJMUpEOGm8ccji+e97W/epm3QNWEsm22Z5RgQKpUzxWkNP
         oMlWrOvWhUNKw==
Date:   Fri, 6 May 2022 08:35:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.19/uclogic 0/5] DIGImend patches, part V
In-Reply-To: <20220421175052.911446-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2205060834580.28985@cbobk.fhfr.pm>
References: <20220421175052.911446-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022, José Expósito wrote:

> Hi everyone,
> 
> This series is a follow up to [1], [2], [3] and [4] upstreaming 5 more
> patches authored by Nikolai from the DIGImend project.
> 
> Patches 1 and 2 are documentation improvements.
> 
> Patch 3 allows to create a keyboard interface to the tablets that have
> a "Usage (Keyboard)" in their descriptor, like for example the Huion
> HS611, which has media keys [5].
> 
> However, some of the tablets that have a keyboard usage, also have an
> invalid pen usage, creating an invalid pen interface. Patches 4 and 5
> allow to disable it.
> 
> As always, many thanks to Jiří and Nikolai for their work :D
> 
> José Expósito
> 
> [1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
> [2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/
> [3] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204111653000.30217@cbobk.fhfr.pm/T/
> [4] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2204211005520.30217@cbobk.fhfr.pm/T/
> [5] https://www.huion.com/es/pen_tablet/HS/huion-hs611.html
> 
> Nikolai Kondrashov (5):
>   HID: uclogic: Clarify params desc_size description
>   HID: uclogic: Clarify pen/frame desc_ptr description
>   HID: uclogic: Pass keyboard reports as is
>   HID: uclogic: Support disabling pen usage
>   HID: uclogic: Disable pen usage for Huion keyboard interfaces
> 
>  drivers/hid/hid-uclogic-core.c   | 19 +++++++++++++++++++
>  drivers/hid/hid-uclogic-params.c |  9 +++++++--
>  drivers/hid/hid-uclogic-params.h | 17 ++++++++++++-----
>  3 files changed, 38 insertions(+), 7 deletions(-)

Now in hid.git#for-5.19/uclogic

Thanks,

-- 
Jiri Kosina
SUSE Labs

