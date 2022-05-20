Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ADA52EA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348378AbiETLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348369AbiETLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:08:22 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7367A830
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:08:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B5EB292009D; Fri, 20 May 2022 13:08:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B279192009B;
        Fri, 20 May 2022 12:08:20 +0100 (BST)
Date:   Fri, 20 May 2022 12:08:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH] RISC-V: PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2205200429300.52080@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Maciej W. Rozycki wrote:

> Therefore avoid handing out address 0, by bumping the lowest address 
> available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM up by 4 and 16 
> respectively, which is the minimum allocation size for I/O and memory 
> BARs.

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk/>

  Maciej
