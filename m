Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C957D3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiGUTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiGUTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:17:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4F88CC1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E21B82643
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A16C3411E;
        Thu, 21 Jul 2022 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658431016;
        bh=8e9CNfH+8m+ZNfFbI/5jclv5hzKBm6mFHMfm+bGmD64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXtjJGn4LdIS0uky6qjA/qscCFFD7i0Go4tcQAptpzSFIWb/52hEr+mI69rnIq+sG
         G7kG+tN9DBq6TMPWxHe9/t1GoO3DUESoR34yyNptOOLTjBix200wLaAMhu/pFl2rbF
         QzA75YbalX2aARaizQQxeisr+IIG+kbKdVYjq0fs=
Date:   Thu, 21 Jul 2022 21:16:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: misc: intel_sysid: Add the system id
 binding for Altera(Intel) FPGA platform
Message-ID: <YtmmJawYXeO0uxLU@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123216.416696-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123216.416696-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:32:17PM +0800, kah.jing.lee@intel.com wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,socfpga-sysid.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022, Intel Corporation.
> +# Copyright (C) 2013-2015, Altera Corporation.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/intel,socfpga-sysid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera(Intel) Sysid IP core driver
> +
> +maintainers:
> +  - Arnd Bergmann <arnd@arndb.de>
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>

You want me to maintain an Intel-only file?   Great, where do I send my
billing rates to?  :)

thanks,

greg k-h
