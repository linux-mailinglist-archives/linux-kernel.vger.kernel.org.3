Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D02530468
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiEVQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiEVQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:18:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256233983D;
        Sun, 22 May 2022 09:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43D07B80CA9;
        Sun, 22 May 2022 16:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F46C385AA;
        Sun, 22 May 2022 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653236322;
        bh=pYSFeemrT0C1YzK9cc5ubWYn839pI3mgfE62d/TWJGQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=jhWUoECn2IgweSYvD9ud/S6HEt7pV3unegslasC03D/usrtvR+NwWbJ/4XaOBtDJ0
         Ixc92ZyFU+XTOOyTBua3Rlrl2yOZATR3XLUOXJQkjqKa+50F6QXtaubl3fXTp/MdPA
         XaSiJRu55tIPOrhcppF/5zgDP6/hbRLBZBlALv62RYV76jZs6xcq9ahAcL/LneWz+w
         DdV+O+87Gp+RmH+e++t5kS/mCIz3aEh5wUYw+qi4YXdBRjJ4221BK3tH17wtdkfe6V
         mhbANfsBbUNxRr46J1XnRwLFmG7ifMaSeAqppXzcnq7bEtha0FsVXUwnwz2qIHW7J1
         e6/XdAeWPi/Fg==
Message-ID: <9d13e27e-4b51-eaa1-81af-20851d3a9fe4@kernel.org>
Date:   Sun, 22 May 2022 11:18:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 0/3] Add device tree for Intel n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220520143208.1160506-1-matthew.gerlach@linux.intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220520143208.1160506-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 5/20/22 09:32, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> This patch set adds a device tree for the Hard Processor System (HPS)
> on an Agilex based Intel n6000 board.
> 
> Patch 1 defines the device tree binding for the HPS Copy Engine IP
> used to copy a bootable image from host memory to HPS DDR.
> 
> Patch 2 defines the binding for the Intel n6000 board itself.
> 
> Patch 3 adds the device tree for the n6000 board.
> 
> Changelog v5 -> v6:
>    - move copy engine binding from soc/intel to dma directory
>    - remove unnecessary parent device tree node from copy engine example
> 

I didn't see any pending comments for V5 so I've already queued it up 
for V5.19.

You can make this change in -rc if you want.

Dinh
