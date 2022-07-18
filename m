Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0EE577AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiGRGHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGRGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:07:42 -0400
Received: from relay5.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE611A26
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:07:40 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 8879B20A35;
        Mon, 18 Jul 2022 06:07:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 2947F2000D;
        Mon, 18 Jul 2022 06:07:36 +0000 (UTC)
Message-ID: <c040cd03d04fb861b85b4f56cd04b473bb778ebd.camel@perches.com>
Subject: Re: [PATCH 1/7] staging: vt6655: Rename dwData to reg_value in four
 macros
From:   Joe Perches <joe@perches.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sun, 17 Jul 2022 23:07:35 -0700
In-Reply-To: <b54577316eebdbb54e478fc51473eeba9d7eacae.1658094708.git.philipp.g.hortmann@gmail.com>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
         <b54577316eebdbb54e478fc51473eeba9d7eacae.1658094708.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 1nzdm7u5mdnptkhpsa7c5w3ybkr1w7sw
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2947F2000D
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18IL2DdOvR2UNADo9wPLSQRJQPWvAn0vFY=
X-HE-Tag: 1658124456-435354
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 00:20 +0200, Philipp Hortmann wrote:
> Fix name of a variable in four macros that use CamelCase which is not
> accepted by checkpatch.pl
[] 
> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
[]
> @@ -539,9 +539,9 @@
>  
>  #define MACvReceive0(iobase)						\
>  do {									\
> -	unsigned long dwData;						\
> -	dwData = ioread32(iobase + MAC_REG_RXDMACTL0);			\
> -	if (dwData & DMACTL_RUN)					\
> +	unsigned long reg_value;					\
> +	reg_value = ioread32(iobase + MAC_REG_RXDMACTL0);		\
> +	if (reg_value & DMACTL_RUN)					\
>  		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL0);	\
>  	else								\
>  		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL0);	\
> @@ -549,9 +549,9 @@ do {									\
>  
>  #define MACvReceive1(iobase)						\
>  do {									\
> -	unsigned long dwData;						\
> -	dwData = ioread32(iobase + MAC_REG_RXDMACTL1);			\
> -	if (dwData & DMACTL_RUN)					\
> +	unsigned long reg_value;					\
> +	reg_value = ioread32(iobase + MAC_REG_RXDMACTL1);		\
> +	if (reg_value & DMACTL_RUN)					\
>  		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
>  	else								\
>  		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
> @@ -559,9 +559,9 @@ do {									\
>  
>  #define MACvTransmit0(iobase)						\
>  do {									\
> -	unsignedc long dwData;						\
> -	dwData = ioread32(iobase + MAC_REG_TXDMACTL0);			\
> -	if (dwData & DMACTL_RUN)					\
> +	unsigned long reg_value;					\
> +	reg_value = ioread32(iobase + MAC_REG_TXDMACTL0);		\
> +	if (reg_value & DMACTL_RUN)					\
>  		iowrite32(DMACTL_WAKE, iobase + MAC_REG_TXDMACTL0);	\
>  	else								\
>  		iowrite32(DMACTL_RUN, iobase + MAC_REG_TXDMACTL0);	\
> @@ -569,9 +569,9 @@ do {									\
>  
>  #define MACvTransmitAC0(iobase)					\
>  do {									\
> -	unsigned long dwData;						\
> -	dwData = ioread32(iobase + MAC_REG_AC0DMACTL);			\
> -	if (dwData & DMACTL_RUN)					\
> +	unsigned long reg_value;					\
> +	reg_value = ioread32(iobase + MAC_REG_AC0DMACTL);		\
> +	if (reg_value & DMACTL_RUN)					\
>  		iowrite32(DMACTL_WAKE, iobase + MAC_REG_AC0DMACTL);	\
>  	else								\
>  		iowrite32(DMACTL_RUN, iobase + MAC_REG_AC0DMACTL);	\

Please remember that checkpatch is a stupid little scripted tool
and the actual goal is to have readable code.

Look a bit beyond the code and see if and how you could make the
code better.

All of these macros have the same form and logic.

Perhaps it'd be better to use another indirect macro and define
all of these with that new macro.

Something like:

#define mac_v(iobase, reg)						\
do {									\
	void __iomem *addr = (iobase) + (reg);				\
	iowrite32(ioread32(addr) & DMACTL_RUN ? DMACTL_WAKE : DMACTL_RUN,\
		  addr);						\
} while (0)

#define MACvReceive0(iobase)	mac_v(iobase, MAC_REG_RXDMACTL0)
#define MACvReceive1(iobase)	mac_v(iobase, MAC_REG_RXDMACTL1)
#define MACvTransmit0(iobase)	mac_v(iobase, MAC_REG_TXDMACTL0)
#define MACvTransmitAC0(iobase)	mac_v(iobase, MAC_REG_AC0DMACTL)

