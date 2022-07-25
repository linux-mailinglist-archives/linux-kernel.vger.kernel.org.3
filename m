Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF557F80C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiGYBtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiGYBtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:49:05 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A76352BED
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:49:04 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26P1hYYi023169;
        Sun, 24 Jul 2022 20:43:35 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26P1hX9Z023168;
        Sun, 24 Jul 2022 20:43:33 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 24 Jul 2022 20:43:33 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV:fix repeated words in comments
Message-ID: <20220725014333.GR25951@gate.crashing.org>
References: <20220724054137.58504-1-wangjianli@cdjrlc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724054137.58504-1-wangjianli@cdjrlc.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 01:41:37PM +0800, wangjianli wrote:
> From: Jianli Wang <wangjianli@cdjrlc.com>
> 
> Delete the redundant word 'do'.

> -	/* invalidate the entry (what do do on error from the above ?) */
> +	/* invalidate the entry (what do on error from the above ?) */

Probably "what to do" was meant here?


Segher
