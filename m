Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BB4B8C71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiBPPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:30:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:30:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE425A94C;
        Wed, 16 Feb 2022 07:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 487BDB81F21;
        Wed, 16 Feb 2022 15:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE45C004E1;
        Wed, 16 Feb 2022 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645025437;
        bh=jgVEEH3eNg0tOO+7PuDSL8BiWihVKmlQ7WkA5FiJu0w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dg3sua0KUzO571dyptHOqjuqrFYjizmZzSMGR/6M6f9vj/KXQrhv0MhOZF0ZNsdQA
         uAYDOtWhVFkEm5MxQDlB48+a++0Tdm3J0i0O9kaoUIwg4xdeFhXB9tNZ15oE1wFPOd
         sRrbPwwGSS3GwfbC3tjHtAAKgVR34ME46Zc6tpHRs1mgITeKEviiZdG0GoL6u1lA20
         q9KOyM15ToCJWfBw+Rv20HzCxK4FNaNf/gjC8uvzOPaerDiOkQfyzRvtthPv/juoZZ
         63zeNwbaabz+w4uQPkd6xbFVVtNSv7hxvRwlziYTfvZSTB4dwoB4UQzcvwERK8coEV
         jnQ8YTTS/pSVg==
Date:   Wed, 16 Feb 2022 16:30:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] HID: i2c-hid: remove unneeded semicolon
In-Reply-To: <20220216015042.113021-1-yang.lee@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2202161630200.11721@cbobk.fhfr.pm>
References: <20220216015042.113021-1-yang.lee@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022, Yang Li wrote:

> Eliminate the following coccicheck warning:
> ./drivers/hid/i2c-hid/i2c-hid-core.c:357:56-57: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 91b2fa0d33c7..c078f09a2318 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -354,7 +354,7 @@ static int i2c_hid_set_or_send_report(struct i2c_hid *ihid,
>  		 * With simple "send report" all data goes into the output
>  		 * register.
>  		 */
> -		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wOutputRegister;;
> +		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wOutputRegister;
>  		length += sizeof(__le16);
>  	}

Thanks, that was me fat-fingering the fixup in the original patch. 
Applied.

-- 
Jiri Kosina
SUSE Labs

