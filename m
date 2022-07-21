Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861F57C84C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiGUJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiGUJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A025EA6;
        Thu, 21 Jul 2022 02:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A3561F67;
        Thu, 21 Jul 2022 09:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E38C3411E;
        Thu, 21 Jul 2022 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658397397;
        bh=vAstcB6EnQW5FIp47JVSi9NTuUpabnfZIv25B+vTDnk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uD0bev0L+pp++3rqPR+JC/tPP5xbITHVDQu3nixVp3aASui0zTqfKTxmRug+yr3iM
         uC68oMd8Ndl2+AE1znLV2twulXzbQcd4BO2wtqBT8FzOqYJ0+Cqf6Dq+1jUxghGW8m
         rqAOsmt83DQt4hsvjICKVhDJVsVKS81ajqUN1/khE9cqX6Db6iY37CmNPxEpPrYMT8
         MM9up/K3jIqPJu1g8DbXThPutKLZ8bPGoGxk09NIc/oZe9fLCcCtOl3ld29lEWSAI5
         2t0o0o45a1nbjIjJvjKZakCisL62zZtLILuRlPWXCki7ESgZf3EK78FORBmm8HoOvk
         lFx39IZuo5wVg==
Date:   Thu, 21 Jul 2022 11:56:34 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ID: intel-ish-hid: hid-client: drop unexpected word
 "the" in the comments
In-Reply-To: <20220621122751.117143-1-jiangjian@cdjrlc.com>
Message-ID: <nycvar.YFH.7.76.2207211156280.19850@cbobk.fhfr.pm>
References: <20220621122751.117143-1-jiangjian@cdjrlc.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022, Jiang Jian wrote:

> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/hid/intel-ish-hid/ishtp-hid-client.c
> line: 331
>  * @device: Pointer to the the ishtp client device for which this message
> changed to
>  * @device: Pointer to the ishtp client device for which this message
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 4338c9b68a43..e3d70c5460e9 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -328,7 +328,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
>  
>  /**
>   * ish_cl_event_cb() - bus driver callback for incoming message/packet
> - * @device:	Pointer to the the ishtp client device for which this message
> + * @device:	Pointer to the ishtp client device for which this message
>   *		is targeted
>   *

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

