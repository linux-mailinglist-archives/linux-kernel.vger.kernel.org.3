Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2534B5A5442
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiH2S6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2S6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:58:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3C79A7F;
        Mon, 29 Aug 2022 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UfXwlVSd9EucvRTINPmg+Nml3ochWNbxQHvsL4Ct3yw=; b=TrBfmeqKVRnF8a9ehAUguspS2y
        6R6yD/VAm6RJr7iWbzROKDf7OkiH2tP6Uc+zC6neY23VzfzhbHhTemFJcjSq3y+hSiHXSdIJCkMSU
        8+wmS1lbCkLgUjsU29fuJnHo4zJ/BZcM9AjyC9xVS9wUpDjYA1NombofghdH6QChFJgdgapOhuwIs
        fFnOsPWNUJtbd7MrDaik38UknXnD2/g+BJRFPVZQyi5n4pXeO4tkVp1gVVrIhzBSi1QFjtnMduiFg
        I7Qji2dQ1Dn1+ns15GsdFoUgPWRQIOL/HVyp+iemByPxSb18uaIYacihaxc1dw6IkABhi7JHMh6ey
        6Dno+i0Q==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSjy3-00CNpm-NX; Mon, 29 Aug 2022 18:58:39 +0000
Message-ID: <a733a193-7709-db91-4783-8c09ff41b30f@infradead.org>
Date:   Mon, 29 Aug 2022 11:58:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v5] Remove duplicated words across the whole documentation
Content-Language: en-US
To:     Jules Maselbas <jmaselbas@kalray.eu>, linux-kernel@vger.kernel.org
Cc:     Conor.Dooley@microchip.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org
References: <20220826165634.5617-1-jmaselbas@kalray.eu>
 <20220829092910.12267-1-jmaselbas@kalray.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220829092910.12267-1-jmaselbas@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/22 02:29, Jules Maselbas wrote:
> Remove duplicated words (the, at, be ...) across the whole documentation.
> In some cases the duplicated words are replaced by something that makes
> more sense, for instance: "be be" is replaced by "can be" when possible.
> 
> There are likely more duplicated words.
> 
> CC: Conor.Dooley@microchip.com
> CC: Randy Dunlap <rdunlap@infradead.org>
> CC: Bagas Sanjaya <bagasdotme@gmail.com>
> CC: linux-doc@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> in v5:
>  - remove spurious changes reported by Randy Dunlap
> in v4:
>  - remove spurious changes reported by Conor Dooley
> in v3:
>  as suggested by Randy Dunlap:
>  - remove duplicated 'The the '
>  - remove duplicated 'at at ' (some are replaced by 'at a ')
>  - remove duplicated be, is, to, we, on ...
> in v2:
>  - also remove the second 'the' in one sentence as suggested by
>    Bagas Sanjaya
> ---
>  Documentation/RCU/checklist.rst                               | 2 +-
>  Documentation/admin-guide/kdump/vmcoreinfo.rst                | 2 +-
>  Documentation/bpf/instruction-set.rst                         | 2 +-
>  Documentation/bpf/map_cgroup_storage.rst                      | 4 ++--
>  Documentation/core-api/cpu_hotplug.rst                        | 3 +--
>  Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml  | 4 ++--
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt      | 2 +-
>  Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt     | 2 +-
>  Documentation/devicetree/bindings/fpga/fpga-region.txt        | 4 ++--
>  Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml      | 2 +-
>  Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml      | 2 +-
>  Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml      | 2 +-
>  .../devicetree/bindings/net/amlogic,meson-dwmac.yaml          | 2 +-
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml      | 2 +-
>  Documentation/driver-api/isa.rst                              | 2 +-
>  Documentation/filesystems/caching/backend-api.rst             | 2 +-
>  Documentation/filesystems/journalling.rst                     | 2 +-
>  Documentation/hwmon/f71882fg.rst                              | 2 +-
>  Documentation/locking/seqlock.rst                             | 2 +-
>  Documentation/sphinx/cdomain.py                               | 2 +-
>  Documentation/trace/histogram.rst                             | 2 +-
>  Documentation/userspace-api/media/dvb/dmx-reqbufs.rst         | 2 +-
>  Documentation/userspace-api/media/dvb/frontend_f_open.rst     | 2 +-
>  23 files changed, 26 insertions(+), 27 deletions(-)


-- 
~Randy
