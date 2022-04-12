Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76D4FE02F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348305AbiDLMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbiDLM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:27:22 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 04:34:08 PDT
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A931200;
        Tue, 12 Apr 2022 04:34:08 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Kd3KT2lSTzvjfn; Tue, 12 Apr 2022 13:24:45 +0200 (CEST)
Date:   Tue, 12 Apr 2022 13:24:45 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty: serial: altera: use altera_jtaguart_stop_tx()
Message-ID: <20220412112444.ovep2442cybue5nu@distanz.ch>
References: <20220411104506.8990-1-jslaby@suse.cz>
 <20220411104506.8990-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411104506.8990-4-jslaby@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-11 at 12:45:06 +0200, Jiri Slaby <jslaby@suse.cz> wrote:
> altera_jtaguart_tx_chars() duplicates what altera_jtaguart_stop_tx()
> already does. So instead of the duplication, call the helper instead.
> 
> Not only it makes the code cleaner, but it also says what the "if"
> really does.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
