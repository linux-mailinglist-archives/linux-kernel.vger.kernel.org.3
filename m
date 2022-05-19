Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4252D98D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbiESP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbiESP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA754BF1;
        Thu, 19 May 2022 08:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC55E61B71;
        Thu, 19 May 2022 15:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A71C385AA;
        Thu, 19 May 2022 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652975795;
        bh=HB0SywbMvt2xHizeVdOfaikETzpcXvZJJzSNtapX5kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfOpM0Q8nxBLGFQ6UzEuZ5Q7PEMclqOAQJEXU/xV4jB+EfKLN2B3x7gCUKUE6UlCg
         xiMkT+shxKPz2daPz2Mg83Xqc0P2TZjhG8Z+ZapOyQBZVS9ZjkRr+rtsoTT3F1W6Fm
         zg2MknPLGE83TKPK6c4W8D954el8Ws/p0P14EMKs=
Date:   Thu, 19 May 2022 17:56:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>, linux-aspeed@lists.ozlabs.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 0/3] add Aspeed udc driver for ast2600
Message-ID: <YoZosLk5GhTsP841@kroah.com>
References: <20220518062043.1075360-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518062043.1075360-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:20:40PM +0800, Neal Liu wrote:
> This patch series aim to add Aspeed USB 2.0 Device Controller (udc)
> driver, including driver itself, device tree node and documentation.
> 
> Change since v2:
> - Rename device tree nodes.
> - Fix unusual indentation.
> 
> Change since v1:
> - Fix build test warning reported by kernel test robot.
> - Rename proper name for dt-bindings document.
> 
> *** BLURB HERE ***

No blurb?

