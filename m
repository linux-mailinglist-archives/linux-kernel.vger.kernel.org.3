Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A398558508E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiG2NL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiG2NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0A45F77;
        Fri, 29 Jul 2022 06:10:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ12Mrfz4xG8;
        Fri, 29 Jul 2022 23:10:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     deller@gmx.de, mrochs@linux.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        ukrishn@linux.ibm.com, manoj@linux.ibm.com, tzimmermann@suse.de,
        Nicholas Piggin <npiggin@gmail.com>,
        martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
In-Reply-To: <f75b383673663e27f6b57e50b4abfb9fe3780b00.1657264228.git.christophe.leroy@csgroup.eu>
References: <f75b383673663e27f6b57e50b4abfb9fe3780b00.1657264228.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/4] video: fbdev: offb: Include missing linux/platform_device.h
Message-Id: <165909976850.253830.18083403914079325529.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 09:11:05 +0200, Christophe Leroy wrote:
> A lot of drivers were getting platform and of headers
> indirectly via headers like asm/pci.h or asm/prom.h
> 
> Most of them were fixed during 5.19 cycle but a newissue was
> introduced by commit 52b1b46c39ae ("of: Create platform devices
> for OF framebuffers")
> 
> [...]

Applied to powerpc/next.

[1/4] video: fbdev: offb: Include missing linux/platform_device.h
      https://git.kernel.org/powerpc/c/ebef8abc963b9e537c0a0d619dd8faf1b8f2b183
[2/4] scsi: cxlflash: Include missing linux/irqdomain.h
      https://git.kernel.org/powerpc/c/61657dcd528b75cd196adaf56890124c13953c8d
[3/4] powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h
      https://git.kernel.org/powerpc/c/4d5c5bad51935482437528f7fa4dffdcb3330d8b
[4/4] powerpc: Finally remove unnecessary headers from asm/prom.h
      https://git.kernel.org/powerpc/c/36afe68714d45edf34430d28e3dc787425ad8b22

cheers
