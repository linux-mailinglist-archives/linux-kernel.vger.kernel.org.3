Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8BB5A0CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiHYJfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbiHYJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E83A98F9;
        Thu, 25 Aug 2022 02:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C8D61BDF;
        Thu, 25 Aug 2022 09:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710DFC433D7;
        Thu, 25 Aug 2022 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420133;
        bh=Dg64EwaRLm4x48UpJhKVaByDrVi2BCHtsShXWFbqr9c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rLP1mER6US22rl5xIabqAeY18c6r2qoE1W3KkvLZYXVn1aBKIYYdKhln3j9apNUQR
         DXdqScmePeMIcQKTMJecLp6Ig2HrALmwJYN98su90zC+KJ/mzHDYDhWrxVpwBJj/ow
         uauo1qsn7MuCX3uOeY/wXvcAyOq1Khls/r3ObvSMDX5Fkr+UYy+9dUDv9y67OojUxo
         hgo7GGSYq4lrNWm9aHkgK6X3Slt2ynWSTMNljyxO4FhCvj4M3UlPSdJrzkF5uJ5nku
         9T+vqM7kQtxOovUmNhHITRundDxnmjFqsRFlXzw9IVd6i1MyFozoogbuiua2Vmwgd0
         KeSpDvC5u5xTA==
Date:   Thu, 25 Aug 2022 11:35:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ishtp-hid-clientHID: ishtp-hid-client: Fix comment
 typo
In-Reply-To: <20220804005814.5444-1-wangborong@cdjrlc.com>
Message-ID: <nycvar.YFH.7.76.2208251135240.19850@cbobk.fhfr.pm>
References: <20220804005814.5444-1-wangborong@cdjrlc.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022, Jason Wang wrote:

> The double `like' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
> index 6a5cc11aefd8..35dddc5015b3 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.h
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
> @@ -105,7 +105,7 @@ struct report_list {
>   * @multi_packet_cnt:	Count of fragmented packet count
>   *
>   * This structure is used to store completion flags and per client data like
> - * like report description, number of HID devices etc.
> + * report description, number of HID devices etc.
>   */

Applied.

-- 
Jiri Kosina
SUSE Labs

