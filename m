Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B126A51DE4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444165AbiEFRZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiEFRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:25:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84551C108;
        Fri,  6 May 2022 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=43kcznkYN7qQFRn/kPo5/kdRJTMc0RSw2xjGrooZhmk=;
        t=1651857680; x=1653067280; b=Ry/QahONelDt6m7dk9iRwsNCrRt12H8P7a95fCj+Pt/KgmE
        IFWE4EPlxTxTLjn0zfqMURCYt5MjrLvW1EZE6+PWoLp5n+stRApgQweOZ/hCcZdk7aBCEeJj/dQx8
        ubKGFwv3GaLzoNzZqNeS/ZreaEfHFPy3YL2rsIGI/NXR1VdNyFgcX6rETT4wdp4SJzAPtzW0kOZQc
        7L6tdQVfBZoR2gDlHTMkF7ABYNGdF15jXVNJaS+kOQv84b1HLK+bjz8t1VwzwY9Q7c1xes24oV+Ny
        1+dhPtXL6f0DXikpbhsPo0wdFCH5hLwB7iJu/6ew2CLoLGYY8QruGi+DOfQ1eGAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nn1dh-004JpF-8j;
        Fri, 06 May 2022 19:21:13 +0200
Message-ID: <c66b3c0ba5d6076b00718f6df53f37ec8b099a04.camel@sipsolutions.net>
Subject: Re: [PATCH] rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE ioctl request
 definition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 06 May 2022 19:21:11 +0200
In-Reply-To: <20220506171534.99509-1-glebfm@altlinux.org>
References: <20220506171534.99509-1-glebfm@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-06 at 17:15 +0000, Gleb Fotengauer-Malinovskiy wrote:
> Fixes: 54f586a91532 ("rfkill: make new event layout opt-in")
> ---
>  include/uapi/linux/rfkill.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/rfkill.h b/include/uapi/linux/rfkill.h
> index 283c5a7b3f2c..db6c8588c1d0 100644
> --- a/include/uapi/linux/rfkill.h
> +++ b/include/uapi/linux/rfkill.h
> @@ -184,7 +184,7 @@ struct rfkill_event_ext {
>  #define RFKILL_IOC_NOINPUT	1
>  #define RFKILL_IOCTL_NOINPUT	_IO(RFKILL_IOC_MAGIC, RFKILL_IOC_NOINPUT)
>  #define RFKILL_IOC_MAX_SIZE	2
> -#define RFKILL_IOCTL_MAX_SIZE	_IOW(RFKILL_IOC_MAGIC, RFKILL_IOC_EXT_SIZE, __u32)
> +#define RFKILL_IOCTL_MAX_SIZE	_IOW(RFKILL_IOC_MAGIC, RFKILL_IOC_MAX_SIZE, __u32)
> 

Oops. But I still need your Signed-off-by (see the documentation), and a
commit message would be nice :)

johannes
