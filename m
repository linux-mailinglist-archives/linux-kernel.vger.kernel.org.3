Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0A49BB51
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiAYSan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:30:43 -0500
Received: from relay031.a.hostedemail.com ([64.99.140.31]:6481 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232106AbiAYSae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:30:34 -0500
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 9AD4A226B4;
        Tue, 25 Jan 2022 18:30:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 574912C;
        Tue, 25 Jan 2022 18:30:19 +0000 (UTC)
Message-ID: <441d593f4c55e15913cd72710d0b196361484ce0.camel@perches.com>
Subject: Re: [PATCH] ieee80211: cleanup double word in comment
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 10:30:29 -0800
In-Reply-To: <20220125180735.1123792-1-trix@redhat.com>
References: <20220125180735.1123792-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: o1mzd7azf9cda1mezhfzqchf85nohee6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 574912C
X-Spam-Status: No, score=-2.34
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18883t7exCCLi83JazV8w71U3Q3offl+l4=
X-HE-Tag: 1643135419-543975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-25 at 10:07 -0800, trix@redhat.com wrote:
> Remove the second 'that'.
[]
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
[]
> @@ -467,7 +467,7 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
>  static inline bool ieee80211_is_data_present(__le16 fc)
>  {
>  	/*
> -	 * mask with 0x40 and test that that bit is clear to only return true
> +	 * mask with 0x40 and test that bit is clear to only return true

This is likely a false positive...

"that that" is  frequently correct usage.
"that the" might be acceptable here instead.

Not sure about the "only" use though.
Maybe fix the substypes typo too.

---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c6449384..0d9864adf9911 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -467,8 +467,8 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
 static inline bool ieee80211_is_data_present(__le16 fc)
 {
 	/*
-	 * mask with 0x40 and test that that bit is clear to only return true
-	 * for the data-containing substypes.
+	 * mask with 0x40 and test that the bit is clear to return true
+	 * only for the data-containing subtypes.
 	 */
 	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE | 0x40)) ==
 	       cpu_to_le16(IEEE80211_FTYPE_DATA);


