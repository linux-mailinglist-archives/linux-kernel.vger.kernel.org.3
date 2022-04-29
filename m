Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07595155F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380820AbiD2Unm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbiD2Ung (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:43:36 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDFB811A39;
        Fri, 29 Apr 2022 13:40:15 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4C33192009C; Fri, 29 Apr 2022 22:40:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 44D6692009B;
        Fri, 29 Apr 2022 21:40:13 +0100 (BST)
Date:   Fri, 29 Apr 2022 21:40:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: sifive: Correct/improve baud base handling
Message-ID: <alpine.DEB.2.21.2204281344190.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 While fiddling with other serial port devices with the use of my HiFive
Unmatched board I have noticed we do not correctly report the baud base 
value for the SiFive FU740-C000 SOC's on-chip UARTs.  This small patch 
set fixes the initialisation of the baud base value and then simplifies 
handling by removing now redundant duplicate port parameter.

 See individual change descriptions for details.  This patch set has been 
verified with the HiFive Unmatched board.  Please apply.

  Maciej
