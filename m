Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DAA55FFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiF2MRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiF2MQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:16:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8935256
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:16:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LY0n43QKLz4xZY;
        Wed, 29 Jun 2022 22:16:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     arnd@arndb.de, fbarrat@linux.ibm.com,
        Jiang Jian <jiangjian@cdjrlc.com>, ajd@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621125321.122280-1-jiangjian@cdjrlc.com>
References: <20220621125321.122280-1-jiangjian@cdjrlc.com>
Subject: Re: [PATCH] cxl: drop unexpected word "the" in the comments
Message-Id: <165650492410.3004956.4938254521446368740.b4-ty@ellerman.id.au>
Date:   Wed, 29 Jun 2022 22:15:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 20:53:21 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/misc/cxl/cxl.h
> line: 1107
> +/* check if the given pci_dev is on the the cxl vphb bus */
> changed to
> +/* check if the given pci_dev is on the cxl vphb bus */
> 
> [...]

Applied to powerpc/next.

[1/1] cxl: drop unexpected word "the" in the comments
      https://git.kernel.org/powerpc/c/882c835b71e22ca82361dab3b60b85b557abd72f

cheers
