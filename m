Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A284B8EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiBPQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:59:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBPQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:59:04 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574AA2A5206
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:58:51 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 032EF1214F5;
        Wed, 16 Feb 2022 16:58:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 5043380014;
        Wed, 16 Feb 2022 16:58:21 +0000 (UTC)
Message-ID: <e5ad05f9744439a75978d4d453549e65fcfe317f.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Feb 2022 08:58:48 -0800
In-Reply-To: <20220216152343.105546-1-colin.i.king@gmail.com>
References: <20220216152343.105546-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uzn4q74z8bpsq6egyysaqcmorhywty1p
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5043380014
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX195J1Jnj4V3/mxZRqRzspY0lvcD1whVomI=
X-HE-Tag: 1645030701-998022
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 15:23 +0000, Colin Ian King wrote:
> Some of the more common spelling mistakes and typos that I've found
> while fixing up spelling mistakes in the kernel in the past four months.

thanks.

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  scripts/spelling.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index 0c8b79cfb1bb..8435b99452b6 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -180,6 +180,7 @@ asuming||assuming
>  asycronous||asynchronous
>  asychronous||asynchronous
>  asynchnous||asynchronous
> +asynchronus||asynchronous
>  asynchromous||asynchronous
>  asymetric||asymmetric
>  asymmeric||asymmetric
> @@ -231,6 +232,7 @@ baloons||balloons
>  bandwith||bandwidth
>  banlance||balance
>  batery||battery
> +battey||battery
>  beacuse||because
>  becasue||because
>  becomming||becoming
> @@ -333,6 +335,7 @@ commoditiy||commodity
>  comsume||consume
>  comsumer||consumer
>  comsuming||consuming
> +comaptible||compatible
>  compability||compatibility
>  compaibility||compatibility
>  comparsion||comparison
> @@ -353,7 +356,9 @@ compoment||component
>  comppatible||compatible
>  compres||compress
>  compresion||compression
> +compresser||compressor
>  comression||compression
> +comsumed||consumed
>  comunicate||communicate
>  comunication||communication
>  conbination||combination
> @@ -530,6 +535,7 @@ dissconect||disconnect
>  distiction||distinction
>  divisable||divisible
>  divsiors||divisors
> +dsiabled||disabled
>  docuentation||documentation
>  documantation||documentation
>  documentaion||documentation
> @@ -677,6 +683,7 @@ frequence||frequency
>  frequncy||frequency
>  frequancy||frequency
>  frome||from
> +fronend||frontend
>  fucntion||function
>  fuction||function
>  fuctions||functions
> @@ -761,6 +768,7 @@ implmentation||implementation
>  implmenting||implementing
>  incative||inactive
>  incomming||incoming
> +incompaitiblity||incompatibility
>  incompatabilities||incompatibilities
>  incompatable||incompatible
>  incompatble||incompatible
> @@ -942,6 +950,7 @@ metdata||metadata
>  micropone||microphone
>  microprocesspr||microprocessor
>  migrateable||migratable
> +millenium||millennium
>  milliseonds||milliseconds
>  minium||minimum
>  minimam||minimum
> @@ -1007,6 +1016,7 @@ notity||notify
>  nubmer||number
>  numebr||number
>  numner||number
> +nunber||number
>  obtaion||obtain
>  obusing||abusing
>  occassionally||occasionally
> @@ -1136,6 +1146,7 @@ preprare||prepare
>  pressre||pressure
>  presuambly||presumably
>  previosuly||previously
> +previsously||previously
>  primative||primitive
>  princliple||principle
>  priorty||priority
> @@ -1297,6 +1308,7 @@ routins||routines
>  rquest||request
>  runing||running
>  runned||ran
> +runnnig||running
>  runnning||running
>  runtine||runtime
>  sacrifying||sacrificing
> @@ -1353,6 +1365,7 @@ similiar||similar
>  simlar||similar
>  simliar||similar
>  simpified||simplified
> +simultanous||simultaneous
>  singaled||signaled
>  singal||signal
>  singed||signed
> @@ -1461,6 +1474,7 @@ syste||system
>  sytem||system
>  sythesis||synthesis
>  taht||that
> +tained||tainted
>  tansmit||transmit
>  targetted||targeted
>  targetting||targeting
> @@ -1489,6 +1503,7 @@ timout||timeout
>  tmis||this
>  toogle||toggle
>  torerable||tolerable
> +torlence||tolerance
>  traget||target
>  traking||tracking
>  tramsmitted||transmitted
> @@ -1503,6 +1518,7 @@ transferd||transferred
>  transfered||transferred
>  transfering||transferring
>  transision||transition
> +transistioned||transitioned
>  transmittd||transmitted
>  transormed||transformed
>  trasfer||transfer


