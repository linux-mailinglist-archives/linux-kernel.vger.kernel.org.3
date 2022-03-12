Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE34D710D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiCLVpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiCLVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:45:03 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C643EDE;
        Sat, 12 Mar 2022 13:43:55 -0800 (PST)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 9E35F23501;
        Sat, 12 Mar 2022 21:43:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 5FE732002B;
        Sat, 12 Mar 2022 21:43:53 +0000 (UTC)
Message-ID: <2422fcc6d9a1e03e4dde90ea91327764ab5ee4b5.camel@perches.com>
Subject: Re: [PATCH 3/6] ALSA: seq: oss: use kzalloc
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Mar 2022 13:43:52 -0800
In-Reply-To: <20220312102705.71413-4-Julia.Lawall@inria.fr>
References: <20220312102705.71413-1-Julia.Lawall@inria.fr>
         <20220312102705.71413-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5FE732002B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: rmt9obkyouuykyseiymery8o93ewmsek
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wmoUH95/RP/dF0B8Uoo7RJ+6BRXnnwI0=
X-HE-Tag: 1647121433-91170
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-12 at 11:27 +0100, Julia Lawall wrote:
> Use kzalloc instead of kmalloc + memset.
[]
> diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
[]
> @@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
>  	system_client = rc;
>  
>  	/* create annoucement receiver port */

unrelated trivia: typo of announcement above

> -	memset(port, 0, sizeof(*port));
>  	strcpy(port->name, "Receiver");
>  	port->addr.client = system_client;
>  	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */
> 


