Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4955DD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiF0IbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiF0IbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:31:11 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5118662E5;
        Mon, 27 Jun 2022 01:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1656318667; x=1687854667;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=td4GgFcrPcicNZdVmsBqCGlV8LfL8rJTX7ejW0KrpEs=;
  b=FqXRqr8scOq1rr4fzTN2r+5v6L9tULy+W+V4za6USz4Qp5DIt8RjTYf+
   L0q9rtoJ5xzJ6afVpsdfoqkG9BxBKBl6UHp5LkyU4om9EsI05N/7kQ1h0
   CPf/aUDTWhjBMjUk0RyMhge2VUxkNnyNMh2BlsUrSdIHGzSSmzHA5CSFw
   K8GRoWUnyAiBhKJzdrdDIX8JTRrf0sPXd8kaR7vuAZpzPQQDetuvo2S7w
   GM7iM+9m3EmtqVqJkELWJPFQty2lTryFgxLxsBemnRi9KCPapB8Djwx23
   SNOl2u7F31Uz23COi18plc13F6iu0zOPnDPuWDrJLYHC41whlAh+sgx2Q
   w==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650924000"; 
   d="scan'208";a="24684140"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Jun 2022 10:31:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 27 Jun 2022 10:31:05 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 27 Jun 2022 10:31:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1656318665; x=1687854665;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=td4GgFcrPcicNZdVmsBqCGlV8LfL8rJTX7ejW0KrpEs=;
  b=aKbeb4woljGvTfaFerkDhi3e/xG8fwRMDjVjX7EF2ivMBC03H/+Ki/Lu
   xA9kG8rKyAu+4UuRGAdsIBOkfItS8lH4NoW/0p/KrZiiVU6AAxFQe/Nhr
   dZIq0999Whc1ihqz95YyhRvwSekI2wCj8DLoWqsArC5MoPG5mehg2VO3V
   JCkRHVxCtlvJr/iGVIEMIKyQbasGoo1LpDBpb1O9+7Fn0jrbRZrZW+YKU
   2qJ5IgUwOnCIGq6StT2D2Q4IULC+EsNMYQoErLbAEgwz0m9OmE0zVWZDI
   R5q4lEcYV8EE07uNFqh63bMXBd/jPwvcjZ6nUbYSgQPA4RiY6X4UW3NG5
   w==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650924000"; 
   d="scan'208";a="24684139"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Jun 2022 10:31:05 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 00BA1280071;
        Mon, 27 Jun 2022 10:31:04 +0200 (CEST)
Message-ID: <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jun 2022 10:31:02 +0200
In-Reply-To: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 14:47 +0200, Matthias Schiffer wrote:
> This fixes the firmware update function with bootloader v8, allows to
> recover from interrupted updates with v7/v8, and does some code cleanup.
> 
> I believe that the code that allows to recover from a broken partition
> table is also necessary to make flashing a different partition table
> work at all, but I wasn't able to verify that, as I don't have any firmware
> images with different partition tables to test with. In any case, I'm
> pretty sure that it is working correctly now, as recovery from a mostly
> empty flash without partition table has been tested successfully.
> 
> I have only tested the new code with bootloader v8, and I don't have the
> documentation / interfacing guide for v7, so it would be great if anyone
> could check that I didn't break updates for v7.

Hi everyone,

any news regarding this patch series?


Kind regards,
Matthias



> 
> 
> Matthias Schiffer (9):
>   Input: synaptics-rmi4 - fix firmware update operations with bootloader
>     v8
>   Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status()
>     helper
>   Input: synaptics-rmi4 - fix command completion check for bootloader
>     v7/v8
>   Input: synaptics-rmi4 - rewrite partition table unconditionally
>   Input: synaptics-rmi4 - reset after writing partition table
>   Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all"
>     command
>   Input: synaptics-rmi4 - remove unneeded struct register_offset
>   Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
>   Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()
> 
>  drivers/input/rmi4/rmi_f34.c   |  16 +-
>  drivers/input/rmi4/rmi_f34.h   |  17 --
>  drivers/input/rmi4/rmi_f34v7.c | 349 +++++++--------------------------
>  3 files changed, 81 insertions(+), 301 deletions(-)
> 

