Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A555A8AF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiFYJiD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Jun 2022 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiFYJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:38:01 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E96343
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:37:59 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 4879D602A3;
        Sat, 25 Jun 2022 09:37:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 5D37020013;
        Sat, 25 Jun 2022 09:37:56 +0000 (UTC)
Message-ID: <1a35d3bdf6adde4f21e7c1401f3a2aba64367eb0.camel@perches.com>
Subject: Re: [PATCH 3/3] staging: Thunderbolt: ctl.c: Fixed comment coding
 style issues
From:   Joe Perches <joe@perches.com>
To:     Gabriel Viso Carrera <gabriel@gvisoc.com>, andreas.noever@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 25 Jun 2022 02:37:54 -0700
In-Reply-To: <20220625084913.603556-4-gabriel@gvisoc.com>
References: <20220625084913.603556-1-gabriel@gvisoc.com>
         <20220625084913.603556-4-gabriel@gvisoc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: cadce61gy87epicgpcnxk4uyk16i6br6
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5D37020013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/qRBMMKsrDRTv8po7b2EkokCBtOlc91is=
X-HE-Tag: 1656149876-587466
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-25 at 18:49 +1000, Gabriel Viso Carrera wrote:
> Fixed a couple of comment aligment & formatting coding style issues.

trivia:

> diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
[]
> @@ -402,11 +403,11 @@ static bool tb_ctl_handle_event(struct tb_ctl *ctl, enum tb_cfg_pkg_type type,
>  static void tb_ctl_rx_submit(struct ctl_pkg *pkg)
>  {
>  	tb_ring_rx(pkg->ctl->rx, &pkg->frame); /*
> -					     * We ignore failures during stop.
> -					     * All rx packets are referenced
> -					     * from ctl->rx_packets, so we do
> -					     * not loose them.
> -					     */
> +						* We ignore failures during stop.
> +						* All rx packets are referenced
> +						* from ctl->rx_packets, so we do
> +						* not loose them.
> +						*/

I'd indent this only 1 level and put it before the call
(and fix the loose/lose typo)

{
	/* We ignore failures during stop.
	 * All rx packets are referenced from ctl->rx_packets,
	 * so we do not lose them.
	 */
	tb_ring_rx(pkg->ctl->rx, &pkg->frame);
}

